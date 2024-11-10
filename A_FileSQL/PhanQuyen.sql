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

CREATE TRIGGER trg_taoTaiKhoan ON NhanVien
AFTER INSERT
AS 
DECLARE @username nvarchar(50), @password nvarchar(50), @manv nvarchar(50)
SELECT @username=nl.TenDangNhap, @password=nl.MatKhau, @manv=nl.maNV
FROM inserted nl
BEGIN
	DECLARE @sqlString nvarchar(2000), @macv nvarchar(50)
	SET @sqlString= 'CREATE LOGIN [' + @userName +'] WITH PASSWORD='''+ @passWord +''', DEFAULT_DATABASE=[QUANLYQUANCOFFEE_Cur], 
	CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF'
	EXEC (@sqlString)

	SET @sqlString= 'CREATE USER ' + @userName +' FOR LOGIN '+ @userName
	EXEC (@sqlString)

	SELECT @macv = MaCV
	FROM NhanVien INNER JOIN ThucHien ON NhanVien.MaNV = ThucHien.MaNV
	WHERE NhanVien.MaNV = @manv
	if (@macv = 'CV03')
		SET @sqlString = 'ALTER SERVER ROLE sysadmin' + ' ADD MEMBER ' + @userName;
	else
		SET @sqlString = 'ALTER ROLE Staff ADD MEMBER ' + @userName;
	EXEC (@sqlString)
END
