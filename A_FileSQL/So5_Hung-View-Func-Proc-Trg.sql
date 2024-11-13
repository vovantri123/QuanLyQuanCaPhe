USE QuanLyQuanCaPhe

GO

------------------------------------------------------------------View---------------------------------------------------------------

CREATE VIEW vNguoiThucHienCa AS
SELECT 
    CLV.MaCa,
    CLV.TenCa,
    CLV.Ngay,
    NV.HoTenNV
FROM 
    CaLamViec CLV
JOIN 
    ThucHien TH ON CLV.MaCa = TH.MaCa
JOIN 
    NhanVien NV ON TH.MaNV = NV.MaNV;
	
GO	
 
CREATE PROCEDURE Proc_TimNguoiThucHienCa_vNguoiThucHienCa
    @shiftCa NVARCHAR(50),
    @currentDate NVARCHAR(10)  
AS
BEGIN
    SELECT HoTenNV
    FROM vNguoiThucHienCa
    WHERE TenCa = @shiftCa 
      AND CONVERT(NVARCHAR, Ngay, 23) = @currentDate;  
END

GO
 
CREATE PROCEDURE Proc_ThemCaLamViec_CaLamViec
    @MaCa NVARCHAR(50),
    @TenCa NVARCHAR(50),
    @Ngay NVARCHAR(10),
    @GioBatDau TIME,
    @GioKetThuc TIME
AS
BEGIN
    INSERT INTO CaLamViec (MaCa, TenCa, Ngay, GioBatDau, GioKetThuc)
    VALUES (@MaCa, @TenCa, @Ngay, @GioBatDau, @GioKetThuc);
END

GO
 
CREATE PROCEDURE Proc_ThemKhoaChinhThucHien_ThucHien
    @MaCa NVARCHAR(50),
    @MaNV NVARCHAR(50),
    @MaCV NVARCHAR(50)
AS
BEGIN
    INSERT INTO ThucHien (MaCa, MaNV, MaCV)
    VALUES (@MaCa, @MaNV, @MaCV);
END

GO
 
CREATE PROCEDURE Proc_ThemKhachHang_KhachHang
    @MaKH NVARCHAR(50),
    @TenKH NVARCHAR(50),
    @SoDienThoai NVARCHAR(10),
    @SoDiemTichLuy FLOAT
AS
BEGIN
    INSERT INTO KhachHang (MaKH, TenKH, SoDienThoai, SoDiemTichLuy)
    VALUES (@MaKH, @TenKH, @SoDienThoai, @SoDiemTichLuy);
END

GO
 
CREATE PROCEDURE Proc_XoaKhachHang_KhachHang
    @MaKH NVARCHAR(50)
AS
BEGIN
    DELETE FROM KhachHang  
    WHERE MaKH = @MaKH;
END

GO

CREATE PROCEDURE Proc_SuaThongTinKhachhang_KhachHang
    @MaKH NVARCHAR(50),
    @TenKH NVARCHAR(50),
    @SoDienThoai NVARCHAR(10),
    @SoDiemTichLuy FLOAT
AS
BEGIN
    UPDATE KhachHang
    SET 
        TenKH = @TenKH,
        SoDienThoai = @SoDienThoai,
        SoDiemTichLuy = @SoDiemTichLuy
    WHERE 
        MaKH = @MaKH;
END

GO

CREATE FUNCTION Func_TimKiemTheoSoDienThoai_KhachHang(@SoDienThoai NVARCHAR(10))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM KhachHang
    WHERE SoDienThoai LIKE '%' + @SoDienThoai + '%'
);

GO

CREATE TRIGGER trg_TuDongTaoMaKH_KhachHang
ON KhachHang
INSTEAD OF INSERT
AS
BEGIN 
	BEGIN TRY
		DECLARE @maxMaKH NVARCHAR(50);
		DECLARE @newMaKH NVARCHAR(50);
		DECLARE @numPart INT;
		 
		SELECT @maxMaKH = MAX(MaKH)
		FROM KhachHang
		WHERE MaKH LIKE 'KH%';
		 
		IF @maxMaKH IS NOT NULL
		BEGIN
			SET @numPart = CAST(SUBSTRING(@maxMaKH, 3, LEN(@maxMaKH) - 2) AS INT) + 1;
		END
		ELSE
		BEGIN 
			SET @numPart = 1;
		END

		-- Tạo giá trị mới cho maKH, với định dạng KHxx (2 số)
		SET @newMaKH = 'KH' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);
		 
		INSERT INTO KhachHang (MaKH, TenKH, SoDienThoai, SoDiemTichLuy)
		SELECT @newMaKH, TenKH, SoDienThoai, SoDiemTichLuy
		FROM inserted;   
		 
	END TRY
	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END;

GO

CREATE TRIGGER Trg_LuatPhanCa_PhanCa
ON ThucHien
AFTER INSERT
AS
BEGIN 
	BEGIN TRY
		DECLARE @MaNV nvarchar(50), @Ngay DATE, @MaCa nvarchar(50), @TenCa nvarchar(50);

		-- Lấy thông tin nhân viên và ca làm việc mới thêm vào
		SELECT @MaNV = MaNV, @MaCa = MaCa FROM inserted;
    
		-- Lấy ngày làm việc từ bảng CaLamViec dựa trên MaCa
		SELECT @Ngay = Ngay, @TenCa = TenCa FROM CaLamViec WHERE MaCa = @MaCa;

		-- Nhân viên không  được làm quá 2 ca trong cùng 1 ngày
		IF (SELECT COUNT(*) 
			FROM ThucHien TH 
			JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
			WHERE TH.MaNV = @MaNV AND CLV.Ngay = @Ngay) > 2
		BEGIN
			RAISERROR (N'Nhân viên này không được làm quá 2 ca trong 1 ngày. Vui lòng kiểm tra lại.', 16, 1); 
			RETURN;
		END

		-- Kiểm tra nhân viên không được làm trùng ca làm việc (tức ca đó nhân viên đã làm rồi mà lại đăng kí nữa)
		IF (SELECT COUNT(*) 
			FROM ThucHien TH
			JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
			WHERE MaNV = @MaNV AND TenCa = @TenCa AND Ngay = @Ngay) > 1
		BEGIN
			RAISERROR (N'Ca làm việc bị trùng lặp cho nhân viên này trong ngày. Vui lòng kiểm tra lại.', 16, 1); 
		END

		-- Làm fulltimeAM thì ko làm ca khác ngoại trừ ca Tối
		IF (@TenCa = N'Sáng'  OR @TenCa = N'FulltimePM')  
		BEGIN
			
			IF (EXISTS (SELECT 1 FROM ThucHien TH
						JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
						WHERE TH.MaNV = @MaNV 
						AND CLV.TenCa = N'FulltimeAM' -- Kiểm tra nếu nhân viên đã làm FulltimeAM trong cùng ngày
						AND CLV.Ngay = @Ngay))
			BEGIN
				RAISERROR (N'Nhân viên đã làm FulltimeAM, không được làm ca Sáng, Chiều và FulltimePM .', 16, 1); 
				RETURN;
			END
		END

		-- Làm fulltimePM thì ko làm ca khác ngoại trừ ca Sáng
		ELSE IF ( @TenCa = N'Tối' OR @TenCa = N'FulltimeAM')
		BEGIN
			IF (EXISTS (SELECT 1 FROM ThucHien TH
						JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
						WHERE TH.MaNV = @MaNV 
						AND CLV.TenCa = N'FulltimePM' 
						AND CLV.Ngay = @Ngay))
			BEGIN
				RAISERROR (N'Nhân viên đã làm FulltimePM, không được làm ca Chiều, Tối và FulltimeAM.', 16, 1); 
				RETURN;
			END
		END

		--Làm FulltimeAM or FulltimePM thì không đk ca Chiều (do ca Chiều là giao thoa nên không để chung với 2 ĐK trên)
		ELSE IF (@TenCa = N'Chiều' )  
		BEGIN
			IF (EXISTS (SELECT 1 FROM ThucHien TH
						JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
						WHERE TH.MaNV = @MaNV 
						AND (CLV.TenCa = N'FulltimeAM' OR CLV.TenCa = N'FulltimePM')  
						AND CLV.Ngay = @Ngay))
			BEGIN
				RAISERROR (N'Nhân viên đã làm FulltimeAM hoặc FulltimePM , không được làm ca Chiều .', 16, 1); 
				RETURN;
			END
		END
		-------------------------------------
		--Làm Sáng hoặc Chiều thì ko làm fulltimeAM nữa 
	    IF (@TenCa = N'FulltimeAM' )  
		BEGIN
			IF (EXISTS (SELECT 1 FROM ThucHien TH
						JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
						WHERE TH.MaNV = @MaNV 
						AND (CLV.TenCa = N'Sáng' OR CLV.TenCa = N'Chiều')  
						AND CLV.Ngay = @Ngay))
			BEGIN
				RAISERROR (N'Nhân viên đã làm ca Sáng hoặc Chiều không thể đăng ki ca FulltimeAM .', 16, 1); 
				RETURN;
			END
		END
				
		--Làm Tối hoặc Chiều thì ko làm fulltimePM nữa 
		IF (@TenCa = N'FulltimePM' )  
		BEGIN
			IF (EXISTS (SELECT 1 FROM ThucHien TH
						JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
						WHERE TH.MaNV = @MaNV 
						AND (CLV.TenCa = N'Chiều' OR CLV.TenCa = N'Tối')  
						AND CLV.Ngay = @Ngay))
			BEGIN
				RAISERROR (N'Nhân viên đã làm ca Chiều hoặc Tối không thể đăng ki ca FulltimePM .', 16, 1); 
				RETURN;
			END
		END
		 
	END TRY
	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END;


GO

CREATE FUNCTION func_LayMaCaMoiDeDangKy_CaLamViec()
RETURNS NVARCHAR(50)
AS
BEGIN   
	DECLARE @maxMaCa NVARCHAR(50);
	DECLARE @newMaCa NVARCHAR(50);
	DECLARE @numPart INT;
	 
    SELECT @maxMaCa = MAX(MaCa) 
    FROM CaLamViec
    WHERE MaCa LIKE 'CA%';
	 
    IF @maxMaCa IS NOT NULL
    BEGIN
        SET @numPart = CAST(SUBSTRING(@maxMaCa, 3, LEN(@maxMaCa) - 2) AS INT) + 1;
    END
    ELSE
    BEGIN 
        SET @numPart = 1;
    END

    -- Tạo giá trị mới cho MaCa, với định dạng CAxx (2 số)
    SET @newMaCa = 'CA' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);

    RETURN @newMaCa;  
END;
 



