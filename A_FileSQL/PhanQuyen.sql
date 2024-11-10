CREATE ROLE Staff
-- Gán các quyền trên table cho role Staff
GRANT SELECT, INSERT, DELETE,REFERENCES ON KhachHang TO Staff
GRANT SELECT, INSERT, DELETE,REFERENCES ON DonHang TO Staff
GRANT SELECT, INSERT,REFERENCES ON ChiTietHoaDon TO Staff
GRANT SELECT, INSERT,REFERENCES ON PhaChe TO Staff
GRANT SELECT, REFERENCES ON LoaiSanPham TO Staff
GRANT SELECT, REFERENCES ON NguyenLieu TO Staff
GRANT SELECT, REFERENCES ON NhanVien TO Staff
GRANT SELECT, REFERENCES ON NhanVienBanThoiGian TO Staff
GRANT SELECT, REFERENCES ON NhanVienToanThoiGian TO Staff
GRANT SELECT, REFERENCES ON ChiTietHoaDon TO Staff
GRANT SELECT, REFERENCES ON SanPham TO Staff
GRANT SELECT, REFERENCES ON ThucHien TO Staff
GRANT SELECT, REFERENCES ON CongViec TO Staff
GRANT SELECT, REFERENCES ON CaLamViec TO Staff
-- Gán quyền thực thi trên các procedure, function cho role Staff
GRANT EXECUTE TO Staff
GRANT SELECT TO Staff

DENY EXECUTE ON proc_ThemNhanVien to Staff;
DENY EXECUTE ON proc_XoaNhanVien to Staff;
DENY EXECUTE ON proc_XoaNhanVienBanThoiGian to Staff;
DENY EXECUTE ON proc_XoaNhanVienToanThoiGian to Staff;
DENY EXECUTE ON proc_SuaNhanVien to Staff;
DENY EXECUTE ON proc_SuaNhanVienBanThoiGian to Staff;
DENY EXECUTE ON proc_SuaNhanVienToanThoiGian to Staff;
DENY EXECUTE ON proc_Xoa_SanPham to Staff;
DENY EXECUTE ON proc_Sua_SanPham to Staff;
DENY EXECUTE ON proc_Sua_LoaiSanPham to Staff;
DENY EXECUTE ON proc_Them_LoaiSanPham to Staff;
DENY EXECUTE ON proc_Sua_NguyenLieu to Staff;
DENY EXECUTE ON proc_Xoa_NguyenLieu to Staff;
DENY EXECUTE ON proc_XoaThucHienCongViec to Staff;
GO
-- trigger tạo tài khoản khi thêm nhân viên

CREATE TRIGGER trg_taoTaiKhoan ON NhanVien
AFTER INSERT
AS 
BEGIN
	DECLARE @username nvarchar(50), @password nvarchar(50), @manv nvarchar(50)
	DECLARE @sqlString nvarchar(2000), @macv nvarchar(50)

	SELECT @username=i.TenDangNhap, @password=i.MatKhau, @manv=i.maNV
	FROM inserted i;

	SET @sqlString= 'CREATE LOGIN [' + @userName +'] WITH PASSWORD='''+ @passWord +''', DEFAULT_DATABASE=[QuanLyQuanCaPhe], 
	CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF'
	EXEC (@sqlString)
	----
	SET @sqlString= 'CREATE USER ' + @userName +' FOR LOGIN '+ @userName
	EXEC (@sqlString)
	----
	SET @sqlString = 'ALTER ROLE Staff ADD MEMBER ' + @userName;
	EXEC (@sqlString)
END

-- Procedure xóa nhân viên
GO
ALTER PROCEDURE proc_XoaNhanVien
@MaNV nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
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

-- Tạo Login và User cho nhân viên

GO
CREATE LOGIN [nv01] WITH PASSWORD='nv01', DEFAULT_DATABASE= QuanLyQuanCaPhe, CHECK_EXPIRATION = OFF, CHECK_POLICY = OFF;
GO
CREATE USER [nv01] FOR LOGIN [nv01];
GO
EXEC sp_addrolemember 'Staff', 'nv01'
GO

GO
CREATE LOGIN [nv02] WITH PASSWORD='nv02', DEFAULT_DATABASE= QuanLyQuanCaPhe, CHECK_EXPIRATION = OFF, CHECK_POLICY = OFF;
GO
CREATE USER [nv02] FOR LOGIN [nv02];
GO
EXEC sp_addrolemember 'Staff', 'nv02'
GO

GO
CREATE LOGIN [nv03] WITH PASSWORD='nv03', DEFAULT_DATABASE= QuanLyQuanCaPhe, CHECK_EXPIRATION = OFF, CHECK_POLICY = OFF;
GO
CREATE USER [nv03] FOR LOGIN [nv03];
GO
EXEC sp_addsrvrolemember 'nv03', 'sysadmin';
GO

GO
CREATE LOGIN [nv04] WITH PASSWORD='nv04', DEFAULT_DATABASE= QuanLyQuanCaPhe, CHECK_EXPIRATION = OFF, CHECK_POLICY = OFF;
GO
CREATE USER [nv04] FOR LOGIN [nv04];
GO
EXEC sp_addrolemember 'Staff', 'nv04'
GO

GO
CREATE LOGIN [nv05] WITH PASSWORD='nv05', DEFAULT_DATABASE= QuanLyQuanCaPhe, CHECK_EXPIRATION = OFF, CHECK_POLICY = OFF;
GO
CREATE USER [nv05] FOR LOGIN [nv05];
GO
EXEC sp_addrolemember 'Staff', 'nv05'
GO

GO
CREATE LOGIN [nv06] WITH PASSWORD='nv06', DEFAULT_DATABASE= QuanLyQuanCaPhe, CHECK_EXPIRATION = OFF, CHECK_POLICY = OFF;
GO
CREATE USER [nv06] FOR LOGIN [nv06];
GO
EXEC sp_addrolemember 'Staff', 'nv06'
GO

GO
CREATE LOGIN [nv07] WITH PASSWORD='nv07', DEFAULT_DATABASE= QuanLyQuanCaPhe, CHECK_EXPIRATION = OFF, CHECK_POLICY = OFF;
GO
CREATE USER [nv07] FOR LOGIN [nv07];
GO
EXEC sp_addrolemember 'Staff', 'nv07'
GO

GO
CREATE LOGIN [nv08] WITH PASSWORD='nv08', DEFAULT_DATABASE= QuanLyQuanCaPhe, CHECK_EXPIRATION = OFF, CHECK_POLICY = OFF;
GO
CREATE USER [nv08] FOR LOGIN [nv08];
GO
EXEC sp_addrolemember 'Staff', 'nv08'
GO

