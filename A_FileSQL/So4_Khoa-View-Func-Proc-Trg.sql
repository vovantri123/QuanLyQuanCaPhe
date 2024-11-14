USE QuanLyQuanCaPhe

GO

--------------------------------------------------------------Func và Proc--------------------------------------------------------------
CREATE PROCEDURE proc_ThemNhanVien
    @HoTenNV nvarchar(50),
    @SoDienThoai nvarchar(50),
    @NamSinh int,
    @GioiTinh nvarchar(50),
    @DiaChi nvarchar(200),
	@Email nvarchar(50),
    @TenDangNhap nvarchar(50),
    @MatKhau nvarchar(50),
    @LoaiNhanVien nvarchar(20)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO NhanVien (HoTenNV, SoDienThoai, NamSinh, GioiTinh, DiaChi, Email,TenDangNhap, MatKhau)
		VALUES (@HoTenNV, @SoDienThoai, @NamSinh, @GioiTinh, @DiaChi, @Email, @TenDangNhap, @MatKhau);

		DECLARE @mNV nvarchar(50);
		SELECT @mNV = MaNV
		FROM NhanVien
		WHERE SoDienThoai = @SoDienThoai;

		IF @LoaiNhanVien = N'Toàn thời gian'
		BEGIN
			INSERT INTO NhanVienToanThoiGian (MaNV, LuongCoDinh)
			VALUES (@mNV, 0);
		END
		ELSE IF @LoaiNhanVien = N'Bán thời gian'
		BEGIN
			INSERT INTO NhanVienBanThoiGian (MaNV, LuongTheoGio, SoGio)
			VALUES (@mNV, 0, 0);
		END
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;

		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH

END;

GO
-- Proc xóa nhân viên

CREATE PROCEDURE proc_XoaNhanVien
@MaNV nvarchar(50)
AS
BEGIN
	DECLARE @username nvarchar(50);
	SELECT @username = NhanVien.TenDangNhap FROM NhanVien WHERE NhanVien.MaNV = @MaNV;
	DECLARE @sqlString nvarchar(50);

	BEGIN TRANSACTION
	BEGIN TRY
		SET @sqlString = 'DROP USER '+ @username;
		EXEC(@sqlString)
		--
		SET @sqlString = 'DROP LOGIN '+ @username;
		EXEC(@sqlString)
		
		DELETE FROM NhanVien WHERE NhanVien.MaNV = @MaNV;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        ROLLBACK TRANSACTION; 
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END
GO

CREATE PROCEDURE proc_XoaNhanVienToanThoiGian
	@MaNV nvarchar(50)
AS
BEGIN
	DELETE FROM NhanVienToanThoiGian
	WHERE MaNV = @MaNV
END

GO

CREATE PROCEDURE proc_XoaNhanVienBanThoiGian
	@MaNV nvarchar(50)
AS
BEGIN
	DELETE FROM NhanVienBanThoiGian
	WHERE MaNV = @MaNV
END

GO
  
CREATE PROCEDURE proc_SuaNhanVien
    @MaNV NVARCHAR(50),
    @HoTenNV nvarchar(50),
    @SoDienThoai nvarchar(50),
    @NamSinh int,
    @GioiTinh nvarchar(50),
    @DiaChi nvarchar(200),
	@Email nvarchar(50),
    @TenDangNhap nvarchar(50),
    @MatKhau nvarchar(50)
AS
BEGIN 
	UPDATE NhanVien  
	SET HoTenNV = @HoTenNV,
		SoDienThoai = @SoDienThoai,
		NamSinh = @NamSinh,
		GioiTinh = @GioiTinh,
		DiaChi = @DiaChi,
		Email = @Email,
		TenDangNhap = @TenDangNhap,
		MatKhau = @MatKhau
	WHERE MaNV = @MaNV 
END

GO

CREATE PROCEDURE proc_SuaNhanVienToanThoiGian
    @MaNV NVARCHAR(50),
    @LuongCoDinh FLOAT
AS
BEGIN
    UPDATE NhanVienToanThoiGian
	SET LuongCoDinh = @LuongCoDinh
    WHERE MaNV = @MaNV
END

GO

CREATE PROCEDURE proc_SuaNhanVienBanThoiGian
    @MaNV NVARCHAR(50),
	@SoGio INT,
    @LuongTheoGio FLOAT
AS
BEGIN
    UPDATE NhanVienBanThoiGian
	SET SoGio = @SoGio,
		LuongTheoGio = @LuongTheoGio
    WHERE MaNV = @MaNV
END

GO

CREATE FUNCTION func_timKiemTrenViewNhanVien (@HoTenNV NVARCHAR(50))
RETURNS @KetQua TABLE (
    MaNV NVARCHAR(50),
    HoTenNV NVARCHAR(50),
    SoDienThoai NVARCHAR(50),
    NamSinh INT,
    GioiTinh NVARCHAR(50),
    DiaChi NVARCHAR(200),
	Email NVARCHAR(50),
    TenDangNhap NVARCHAR(50),
	MatKhau NVARCHAR(50),
	LuongCoDinh FLOAT,
	SoGio INT,
	LuongTheoGio FLOAT
)
AS
BEGIN
    INSERT INTO @KetQua
    SELECT MaNV, HoTenNV, SoDienThoai, NamSinh, GioiTinh, DiaChi, Email, TenDangNhap, MatKhau, LuongCoDinh, SoGio, LuongTheoGio
    FROM v_DanhSachNhanVien
    WHERE HoTenNV LIKE '%' + @HoTenNV + '%'; 

    RETURN;
END;

GO

CREATE PROCEDURE proc_XoaThucHienCongViec
	@MaNV nvarchar(50)
AS
BEGIN
	DELETE FROM ThucHien
	WHERE MaNV = @MaNV
END

GO

CREATE PROCEDURE proc_timNhanVienTheoTaiKhoan
    @TenDangNhap nvarchar(50), 
    @MatKhau nvarchar(50),
    @HoTenNV nvarchar(50) OUTPUT,
    @SoDienThoai nvarchar(50) OUTPUT,
    @NamSinh int OUTPUT,
    @GioiTinh nvarchar(50) OUTPUT,
    @DiaChi nvarchar(50) OUTPUT,
	@Email nvarchar(50) OUTPUT,
    @MaNV nvarchar(50) OUTPUT,
    @LuongCoDinh float OUTPUT,
    @LuongTheoGio float OUTPUT,
    @SoGio int OUTPUT
AS
BEGIN
    SELECT 
        @HoTenNV = NhanVien.HoTenNV,
        @SoDienThoai = NhanVien.SoDienThoai,
        @NamSinh = NhanVien.NamSinh,
        @GioiTinh = NhanVien.GioiTinh,
        @DiaChi = NhanVien.DiaChi,
		@Email = NhanVien.Email,
        @MaNV = NhanVien.MaNV,
        @LuongCoDinh = NhanVienToanThoiGian.LuongCoDinh,
        @LuongTheoGio = NhanVienBanThoiGian.LuongTheoGio,
        @SoGio = NhanVienBanThoiGian.SoGio
    FROM 
        NhanVien 
        LEFT OUTER JOIN NhanVienToanThoiGian ON NhanVien.MaNV = NhanVienToanThoiGian.MaNV
        LEFT OUTER JOIN NhanVienBanThoiGian ON NhanVien.MaNV = NhanVienBanThoiGian.MaNV
    WHERE 
        NhanVien.TenDangNhap = @TenDangNhap 
        AND NhanVien.MatKhau = @MatKhau;
END;

GO

CREATE FUNCTION func_TinhLuong(@MaNV nvarchar(50), @Thang int, @Nam int)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Luong FLOAT = 0;
    DECLARE @LuongCoDinh FLOAT = 0;
    DECLARE @LuongTheoGio FLOAT = 0;
    DECLARE @SoGio INT = 0;
    DECLARE @TongGiaTriDon FLOAT = 0;
    DECLARE @Thuong FLOAT = 0;

    -- Kiểm tra xem nhân viên là toàn thời gian hay bán thời gian
    IF EXISTS (SELECT * FROM NhanVienToanThoiGian WHERE MaNV = @MaNV)
    BEGIN
        -- Tính lương cho nhân viên toàn thời gian
        SELECT @LuongCoDinh = LuongCoDinh FROM NhanVienToanThoiGian WHERE MaNV = @MaNV;
        SET @Luong = @LuongCoDinh;
    END
    ELSE IF EXISTS (SELECT * FROM NhanVienBanThoiGian WHERE MaNV = @MaNV)
    BEGIN
        -- Tính lương cho nhân viên bán thời gian
        SELECT @LuongTheoGio = LuongTheoGio, @SoGio = SoGio 
        FROM NhanVienBanThoiGian 
        WHERE MaNV = @MaNV;
        SET @Luong = @LuongTheoGio * @SoGio;
    END
	-- Kiểm tra số ca làm việc của nhân viên
	 IF EXISTS (
        SELECT 1 
        FROM ThanhToan
		INNER JOIN DonHang ON ThanhToan.MaDH = DonHang.MaDH
        WHERE ThanhToan.MaNV = @MaNV AND DonHang.GiaTriDon > 200000 AND MONTH(DonHang.NgayMua) = @Thang AND YEAR(DonHang.NgayMua) = @Nam
        GROUP BY MaNV
        HAVING COUNT(DonHang.MaDH) > 5 -- Ví dụ: thưởng nếu làm trong tháng đó có xuất được 5 đơn trị giá >200k
    )
	BEGIN
		SELECT @TongGiaTriDon = SUM(GiaTriDon) -- Tìm thưởng tính bằng tổng giá trị đơn hàng mà nhân viên đó bán trong 1 tháng vừa rồi
		FROM DonHang INNER JOIN ThanhToan ON DonHang.MaDH = ThanhToan.MaDH WHERE ThanhToan.MaNV = @MaNV 
		AND MONTH(DonHang.NgayMua) = @Thang 
		AND YEAR(DonHang.NgayMua) = @Nam;

		-- Nếu không có đơn hàng nào thì tổng giá trị đơn sẽ là 0
		SET @Thuong = @TongGiaTriDon * 0.01;
	END

	-- Tính lương cuối cùng bao gồm cả thưởng
	SET @Luong = @Luong + @Thuong;
	RETURN @Luong;
END

GO
CREATE PROCEDURE proc_guiThongBaoLuongThang
    @MaNV NVARCHAR(50),
    @Thang INT,
    @Nam INT,
	@LuongNV FLOAT
AS
BEGIN
    DECLARE @HoTen nvarchar(50);
    DECLARE @Email nvarchar(50);
    DECLARE @Luong FLOAT;
	DECLARE @LuongFormatted nvarchar(50);
    DECLARE @NoiDung nvarchar(MAX);
	DECLARE @TieuDe nvarchar(MAX);

    -- Lấy thông tin nhân viên và lương
    SELECT @HoTen = HoTenNV, @Email = Email FROM NhanVien WHERE MaNV = @MaNV;
    SET @Luong = @LuongNV;

	SET @LuongFormatted = FORMAT(@Luong, 'N0', 'vi-VN');

    -- Nội dung email
    SET @NoiDung = 
        N'Chào ' + @HoTen + N',<br/><br/>' +
        N'Chúng tôi xin thông báo lương tháng ' + CAST(@Thang AS nvarchar) + N' năm ' + CAST(@Nam AS nvarchar) + N' của bạn là: ' +
        @LuongFormatted + N'.<br/><br/>' +
        N'Cảm ơn bạn đã làm việc chăm chỉ!<br/>' +
        N'Thân ái,<br/>Quản lý';
	-- Tiêu đề
	SET @TieuDe = N'Thông báo lương tháng ' + CAST(@Thang AS nvarchar) + N'/' + CAST(@Nam AS nvarchar);
    -- Gửi email
    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'MailProfile', -- Tên profile cấu hình trong Database Mail
        @recipients = @Email,
        @subject = @TieuDe,
        @body = @NoiDung,
        @body_format = 'HTML';
END

GO

CREATE FUNCTION func_KiemTraLoaiNV (@MaNV NVARCHAR(50))
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @LoaiNV NVARCHAR(20);

    -- Kiểm tra nếu tồn tại trong bảng NhanVienToanThoiGian
    IF EXISTS (SELECT 1 FROM NhanVienToanThoiGian WHERE MaNV = @MaNV)
        SET @LoaiNV = N'Toàn thời gian';
    -- Nếu không, kiểm tra trong bảng NhanVienBanThoiGian
    ELSE IF EXISTS (SELECT 1 FROM NhanVienBanThoiGian WHERE MaNV = @MaNV)
        SET @LoaiNV = N'Bán thời gian';
    ELSE
        SET @LoaiNV = N'Không xác định'; -- Trường hợp không có trong cả hai bảng

    RETURN @LoaiNV;
END;

/*
SELECT * 
FROM msdb.dbo.sysmail_event_log 
ORDER BY log_date DESC;
*/

GO
----------------------------------------------------------------Trigger----------------------------------------------------------------
CREATE TRIGGER trg_TuDongTaoMaNV_NhanVien
ON NhanVien
INSTEAD OF INSERT
AS
BEGIN	   
	BEGIN TRY
		DECLARE @maxMaNV NVARCHAR(50);
		DECLARE @newMaNV NVARCHAR(50);
		DECLARE @numPart INT;

		SELECT @maxMaNV = MAX(MaNV) 
		FROM NhanVien
		WHERE MaNV LIKE 'NV%';

		IF @maxMaNV IS NOT NULL
		BEGIN
			SET @numPart = CAST(SUBSTRING(@maxMaNV, 3, LEN(@maxMaNV) - 2) AS INT) + 1;
		END
		ELSE
		BEGIN
			SET @numPart = 1;
		END

		SET @newMaNV = 'NV' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);

		INSERT INTO NhanVien (MaNV, HoTenNV, SoDienThoai, NamSinh, GioiTinh, DiaChi, Email, TenDangNhap, MatKhau)
		SELECT @newMaNV, HoTenNV, SoDienThoai, NamSinh, GioiTinh, DiaChi, Email,TenDangNhap, MatKhau
		FROM inserted; 
	END TRY
	BEGIN CATCH
	 
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR (@ErrorMessage, 16, 1);

    END CATCH
END;

GO