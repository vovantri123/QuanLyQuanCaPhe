USE QuanLyQuanCaPhe

GO

-- Tạo VIEW để lấy thông tin người thực hiện ca
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

-- Thủ tục tìm người thực hiện ca
CREATE PROCEDURE Proc_TimNguoiThucHienCa_vNguoiThucHienCa
    @shiftCa NVARCHAR(50),
    @currentDate NVARCHAR(10) -- Nên đổi kiểu tham số từ NVARCHAR sang DATE
AS
BEGIN
    SELECT HoTenNV
    FROM vNguoiThucHienCa
    WHERE TenCa = @shiftCa 
      AND CONVERT(NVARCHAR, Ngay, 23) = @currentDate; -- So sánh bằng cách ép DATE sang NVARCHAR
END

GO

-- Thủ tục thêm ca làm việc

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

-- Thủ tục thêm thông tin thực hiện
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

-- Thủ tục thêm khách hàng
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

-- Thủ tục xóa khách hàng
CREATE PROCEDURE Proc_XoaKhachHang_KhachHang
    @MaKH NVARCHAR(50)
AS
BEGIN
    DELETE FROM KhachHang  
    WHERE MaKH = @MaKH;
END

GO

-- Thủ tục sửa thông tin khách hàng
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

-- Hàm tìm kiếm khách hàng theo số điện thoại
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
    DECLARE @maxMaKH NVARCHAR(50);
    DECLARE @newMaKH NVARCHAR(50);
    DECLARE @numPart INT;

    -- Tìm giá trị MaKH lớn nhất hiện có
    SELECT @maxMaKH = MAX(MaKH)
    FROM KhachHang
    WHERE MaKH LIKE 'KH%';

    -- Lấy phần số từ MaKH (bỏ phần 'KH' phía trước) và chuyển sang kiểu INT
    IF @maxMaKH IS NOT NULL
    BEGIN
        SET @numPart = CAST(SUBSTRING(@maxMaKH, 3, LEN(@maxMaKH) - 2) AS INT) + 1;
    END
    ELSE
    BEGIN
        -- Nếu chưa có MaKH nào, bắt đầu từ 1
        SET @numPart = 1;
    END

    -- Tạo mã khách hàng mới
    SET @newMaKH = 'KH' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);

    -- Chèn bản ghi mới vào bảng KhachHang với mã khách hàng mới
    INSERT INTO KhachHang (MaKH, TenKH, SoDienThoai, SoDiemTichLuy)
    SELECT @newMaKH, TenKH, SoDienThoai, SoDiemTichLuy
    FROM inserted;  -- Bảng tạm chứa các bản ghi được chèn
END;

GO
CREATE TRIGGER Trg_LuatPhanCa_PhanCa
ON ThucHien
AFTER INSERT
AS
BEGIN
    DECLARE @MaNV nvarchar(50), @Ngay DATE, @MaCa nvarchar(50), @TenCa nvarchar(50);

    -- Lấy thông tin nhân viên và ca làm việc mới thêm vào
    SELECT @MaNV = MaNV, @MaCa = MaCa FROM inserted;
    
    -- Lấy ngày làm việc từ bảng CaLamViec dựa trên MaCa
    SELECT @Ngay = Ngay, @TenCa = TenCa FROM CaLamViec WHERE MaCa = @MaCa;

    -- Kiểm tra nếu nhân viên làm việc quá 2 ca trong cùng ngày
    IF (SELECT COUNT(*) 
        FROM ThucHien TH 
        JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
        WHERE TH.MaNV = @MaNV AND CLV.Ngay = @Ngay) > 2
    BEGIN
        RAISERROR (N'Nhân viên này không được làm quá 2 ca trong 1 ngày. Vui lòng kiểm tra lại.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Kiểm tra ca làm việc có bị trùng lặp cho cùng một nhân viên trong ngày không
    IF (SELECT COUNT(*) 
        FROM ThucHien TH
		JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
        WHERE MaNV = @MaNV AND TenCa = @TenCa AND Ngay = @Ngay) > 1
    BEGIN
        RAISERROR (N'Ca làm việc bị trùng lặp cho nhân viên này trong ngày. Vui lòng kiểm tra lại.', 16, 1);
        ROLLBACK TRANSACTION;
    END

	 -- Kiểm tra ca làm việc theo quy định: Nếu nhân viên làm FulltimeAM thì không được làm sáng và chiều
    -- Nếu nhân viên làm FulltimePM thì không được làm chiều và tối
    IF (@TenCa = N'Sáng'  OR @TenCa = N'FulltimePM')  -- Kiểm tra ca muốn chèn vào là Sáng, Chiều, hoặc Tối
BEGIN
    -- Kiểm tra nếu nhân viên đã làm FulltimeAM trong cùng ngày
    IF (EXISTS (SELECT 1 FROM ThucHien TH
                JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
                WHERE TH.MaNV = @MaNV 
                AND CLV.TenCa = N'FulltimeAM'  -- Kiểm tra xem nhân viên đã làm FulltimeAM chưa
                AND CLV.Ngay = @Ngay))
    BEGIN
        RAISERROR (N'Nhân viên đã làm FulltimeAM, không được làm ca Sáng, Chiều .', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END

    ELSE IF ( @TenCa = N'Tối' OR @TenCa = N'FulltimeAM')
BEGIN
    -- Kiểm tra nếu nhân viên đã làm FulltimePM trong cùng ngày
    IF (EXISTS (SELECT 1 FROM ThucHien TH
                JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
                WHERE TH.MaNV = @MaNV 
                AND CLV.TenCa = N'FulltimePM'  -- Kiểm tra FulltimePM
                AND CLV.Ngay = @Ngay))
    BEGIN
        RAISERROR (N'Nhân viên đã làm FulltimePM, không được làm ca Chiều, Tối và FulltimeAM.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END


 ELSE IF (@TenCa = N'Chiều' )  -- Kiểm tra ca muốn chèn vào là Sáng, Chiều, hoặc Tối
BEGIN
    -- Kiểm tra nếu nhân viên đã làm FulltimeAM trong cùng ngày
    IF (EXISTS (SELECT 1 FROM ThucHien TH
                JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
                WHERE TH.MaNV = @MaNV 
                AND (CLV.TenCa = N'FulltimeAM' OR CLV.TenCa = N'FulltimePM')  -- Kiểm tra xem nhân viên đã làm FulltimeAM chưa
                AND CLV.Ngay = @Ngay))
    BEGIN
        RAISERROR (N'Nhân viên đã làm FulltimeAM hoặc FulltimePM , không được làm ca Chiều .', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
END;




