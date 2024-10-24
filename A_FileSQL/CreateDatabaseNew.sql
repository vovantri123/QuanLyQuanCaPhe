CREATE DATABASE QuanLyQuanCaPhe

GO

USE QuanLyQuanCaPhe

GO

CREATE TABLE CongViec(
	MaCV nvarchar(50) CONSTRAINT PK_CongViec PRIMARY KEY,
	TenCV nvarchar(50) NOT NULL
)
CREATE TABLE NhanVien(
	MaNV nvarchar(50) CONSTRAINT PK_NhanVien PRIMARY KEY,
	HoTenNV nvarchar(50) NOT NULL,
	SoDienThoai nvarchar(50) NOT NULL UNIQUE CHECK(LEN(SoDienThoai)=10),
	NamSinh int NOT NULL CHECK(YEAR(GETDATE())-NamSinh>=16),
	GioiTinh nvarchar(50) NOT NULL,
	DiaChi nvarchar(200) NOT NULL,
	TenDangNhap nvarchar(50) UNIQUE NOT NULL,
	MatKhau nvarchar(50) NOT NULL
)
CREATE TABLE NhanVienToanThoiGian(
	MaNV nvarchar(50) CONSTRAINT FK_NhanVien_ToanThoiGian FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
	LuongCoDinh float NOT NULL CHECK(LuongCoDinh>=0)
)
 
CREATE TABLE NhanVienBanThoiGian(
	MaNV nvarchar(50) CONSTRAINT FK_NhanVien_BanThoiGian FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
	LuongTheoGio float NOT NULL CHECK(LuongTheoGio>=0),
	SoGio int NOT NULL CHECK(SoGio>=0)
)
CREATE TABLE CaLamViec(
	MaCa nvarchar(50) CONSTRAINT PK_CaLamViec PRIMARY KEY,
	TenCa nvarchar(50) NOT NULL,
	Ngay date CHECK(DATEDIFF(day,Ngay,GETDATE())>=0),
	GioBatDau time(0),
	GioKetThuc time(0)
)
CREATE TABLE ThucHien (
	MaNV nvarchar(50) CONSTRAINT FK_ThucHien_NhanVien FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
	MaCV nvarchar(50) CONSTRAINT FK_ThucHien_CongViec FOREIGN KEY (MaCV) REFERENCES CongViec(MaCV),
	MaCa nvarchar(50) CONSTRAINT FK_ThucHien_CaLamViec FOREIGN KEY (MaCa) REFERENCES CaLamViec(MaCa)
)
CREATE TABLE KhachHang (
	MaKH nvarchar(50) CONSTRAINT PK_KhangHang PRIMARY KEY,
	TenKH nvarchar(50) NOT NULL,
	SoDienThoai nvarchar(50) CHECK (LEN(SoDienThoai) = 10),
	SoDiemTichLuy float CHECK (SoDiemTichLuy >= 0)
)

CREATE TABLE DonHang (
	MaDH nvarchar(50) CONSTRAINT PK_DonHang PRIMARY KEY,
	MaKH nvarchar(50) CONSTRAINT FP_DonHang_KhachHang FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
	MaNV nvarchar(50) CONSTRAINT FK_DonHang_NhanVien FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
	NgayMua date CHECK (DATEDIFF(day, NgayMua, GETDATE()) >= 0),
	GiaTriDon float CHECK (GiaTriDon > 0),
	TrangThai nvarchar(50)
)

CREATE TABLE LoaiSanPham(
	MaLoaiSP nvarchar(50) CONSTRAINT PK_LoaiSanPham PRIMARY KEY,
	TenLoaiSP nvarchar(50) NOT NULL
)

CREATE TABLE SanPham(
	MaSP nvarchar(50) CONSTRAINT PK_MaSP PRIMARY KEY,
	TenSP nvarchar(50) NOT NULL,
	Gia float NOT NULL CHECK (Gia > 0),
	AnhSP nvarchar(200) NOT NULL,
	MaLoaiSP nvarchar(50) CONSTRAINT FK_SanPham_LoaiSP FOREIGN KEY REFERENCES LoaiSanPham(MaLoaiSP)
)
CREATE TABLE NguyenLieu(
	MaNL nvarchar(50) CONSTRAINT PK_NguyenLieu PRIMARY KEY,
	TenNL nvarchar(50) NOT NULL,
	SoLuongTonKho int CHECK (SoLuongTonKho >= 0),
	DonVi nvarchar(50)
)

CREATE TABLE PhaChe (
    MaSP nvarchar(50) CONSTRAINT FK_PhaChe_SanPHam FOREIGN KEY REFERENCES SanPham(MaSP),      
    MaNL nvarchar(50) CONSTRAINT FK_PhaChe_NguyenLieu FOREIGN KEY REFERENCES NguyenLieu(MaNL),      
    SoLuong int check (SoLuong >=0),   

    CONSTRAINT PK_PhaChe PRIMARY KEY (MaSP, MaNL)  
)
CREATE TABLE ChiTietHoaDon (
	MaDH nvarchar(50) CONSTRAINT FK_ChiTietHoaDon_DonHang FOREIGN KEY REFERENCES DonHang(MaDH),
	MaSP nvarchar(50) CONSTRAINT FK_ChiTietHoaDon_SanPham FOREIGN KEY REFERENCES SanPham(MaSP),
	SoLuong int CHECK (SoLuong>0),
	TongTien float CHECK (TongTien>0),

	CONSTRAINT PK_ChiTietHoaDon PRIMARY KEY (MaDH, MaSP)
)
