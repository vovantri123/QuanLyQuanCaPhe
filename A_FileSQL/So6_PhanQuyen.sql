USE QuanLyQuanCaPhe

GO
---------------------------------------------------------------PHÂN QUYỀN-----------------------------------------------------------
 
GRANT EXECUTE TO Staff -- Cấp quyền thực thi cho "Staff" trên các func và proc trong QuanLyQuanCaPhe
GRANT SELECT TO Staff  -- Cấp quyền SELECT trên tất cả các bảng, view, func trong QuanLyQuanCaPhe

REVOKE INSERT, UPDATE, DELETE ON KhachHang TO Staff
REVOKE INSERT, UPDATE, DELETE ON DonHang TO Staff
REVOKE INSERT, UPDATE, DELETE ON ChiTietHoaDon TO Staff
REVOKE INSERT, UPDATE, DELETE ON PhaChe TO Staff
REVOKE INSERT, UPDATE, DELETE ON LoaiSanPham TO Staff
REVOKE INSERT, UPDATE, DELETE ON NguyenLieu TO Staff
REVOKE INSERT, UPDATE, DELETE ON NhanVien TO Staff
REVOKE INSERT, UPDATE, DELETE ON NhanVienBanThoiGian TO Staff
REVOKE INSERT, UPDATE, DELETE ON NhanVienToanThoiGian TO Staff 
REVOKE INSERT, UPDATE, DELETE ON SanPham TO Staff
REVOKE INSERT, UPDATE, DELETE ON ThucHien TO Staff
REVOKE INSERT, UPDATE, DELETE ON CongViec TO Staff
REVOKE INSERT, UPDATE, DELETE ON CaLamViec TO Staff

-- form QL loại sản phẩm
DENY EXECUTE ON proc_Them_LoaiSanPham TO Staff;
DENY EXECUTE ON proc_Sua_LoaiSanPham TO Staff;
DENY EXECUTE ON proc_Xoa_LoaiSanPham TO Staff; 

-- form QL sản phẩm
DENY EXECUTE ON proc_Them_SanPham TO Staff;
DENY EXECUTE ON proc_Sua_SanPham TO Staff;
DENY EXECUTE ON proc_Xoa_SanPham TO Staff;
DENY EXECUTE ON proc_Them_PhaChe TO Staff;
DENY EXECUTE ON proc_Xoa_PhaChe TO Staff;

-- form QL NhanVien
DENY EXECUTE ON proc_ThemNhanVien TO Staff;
DENY EXECUTE ON proc_SuaNhanVienToanThoiGian TO Staff;
DENY EXECUTE ON proc_SuaNhanVienBanThoiGian TO Staff;
DENY EXECUTE ON proc_SuaNhanVien TO Staff;
DENY EXECUTE ON proc_XoaNhanVienToanThoiGian TO Staff;
DENY EXECUTE ON proc_XoaNhanVienBanThoiGian TO Staff;
DENY EXECUTE ON proc_XoaNhanVien TO Staff;
DENY EXECUTE ON proc_XoaThucHienCongViec TO Staff;
DENY EXECUTE ON func_TinhLuong TO Staff;
DENY EXECUTE ON proc_guiThongBaoLuongThang TO Staff; 






 
 