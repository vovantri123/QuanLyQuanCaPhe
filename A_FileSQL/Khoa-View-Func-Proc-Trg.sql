USE QuanLyQuanCaPhe

GO

-- Thêm nhân viên
CREATE TRIGGER trg_TuDongTaoMaNV_NhanVien
ON NhanVien
INSTEAD OF INSERT
AS
BEGIN
	BEGIN TRANSACTION
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

		INSERT INTO NhanVien (MaNV, HoTenNV, SoDienThoai, NamSinh, GioiTinh, DiaChi,TenDangNhap,MatKhau)
		SELECT @newMaNV, HoTenNV, SoDienThoai, NamSinh, GioiTinh, DiaChi, TenDangNhap, MatKhau
		FROM inserted;
		
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO
CREATE PROCEDURE proc_ThemNhanVien
    @HoTenNV nvarchar(50),
    @SoDienThoai nvarchar(50),
    @NamSinh int,
    @GioiTinh nvarchar(50),
    @DiaChi nvarchar(200),
    @TenDangNhap nvarchar(50),
    @MatKhau nvarchar(50),
    @LoaiNhanVien nvarchar(20)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		INSERT INTO NhanVien (HoTenNV, SoDienThoai, NamSinh, GioiTinh, DiaChi, TenDangNhap, MatKhau)
		VALUES (@HoTenNV, @SoDienThoai, @NamSinh, @GioiTinh, @DiaChi, @TenDangNhap, @MatKhau);

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
CREATE PROCEDURE proc_XoaNhanVien
	@MaNV nvarchar(50)
AS
BEGIN
	BEGIN TRANSACTION;
    BEGIN TRY
		DELETE FROM NhanVien
		WHERE MaNV = @MaNV
		COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END

GO
CREATE PROCEDURE proc_SuaNhanVien
    @MaNV NVARCHAR(50),
    @HoTenNV nvarchar(50),
    @SoDienThoai nvarchar(50),
    @NamSinh int,
    @GioiTinh nvarchar(50),
    @DiaChi nvarchar(200),
    @TenDangNhap nvarchar(50),
    @MatKhau nvarchar(50)
AS
BEGIN
	BEGIN TRANSACTION;
    BEGIN TRY
		UPDATE NhanVien  
		SET HoTenNV = @HoTenNV,
			SoDienThoai = @SoDienThoai,
			NamSinh = @NamSinh,
			GioiTinh = @GioiTinh,
			DiaChi = @DiaChi,
			TenDangNhap = @TenDangNhap,
			MatKhau = @MatKhau
		WHERE MaNV = @MaNV
		COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
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
    TenDangNhap NVARCHAR(50),
	MatKhau NVARCHAR(50),
	LuongCoDinh FLOAT,
	SoGio INT,
	LuongTheoGio FLOAT
)
AS
BEGIN
    INSERT INTO @KetQua
    SELECT MaNV, HoTenNV, SoDienThoai, NamSinh, GioiTinh, DiaChi, TenDangNhap, MatKhau, LuongCoDinh, SoGio, LuongTheoGio
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




