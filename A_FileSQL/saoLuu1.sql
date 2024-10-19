USE [QuanLyQuanCaPhe]
GO
/****** Object:  UserDefinedFunction [dbo].[func_TimKiemTheoTen_SanPham]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[func_TimKiemTheoTen_SanPham](@TenSP NVARCHAR(50))
RETURNS @KetQua TABLE
(
	MaSP NVARCHAR(50),
	TenSP NVARCHAR(50),
	Gia FLOAT,
	TenLoaiSP NVARCHAR(50),
	AnhSP NVARCHAR(200)
)
AS 
BEGIN
    INSERT INTO @KetQua
    SELECT MaSP, TenSP, Gia, TenLoaiSP, AnhSP
    FROM v_DanhSachSanPham
    WHERE TenSP LIKE N'%' + @TenSP + '%'

	RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[func_TimMaDHChuaThanhToan_DonHang]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_TimMaDHChuaThanhToan_DonHang] 
(

)
RETURNS NVARCHAR(50)
AS
BEGIN  
    DECLARE @MaDH NVARCHAR(50)

    SELECT @MaDH = MaDH
    FROM DonHang
    WHERE TrangThai = N'Chưa thanh toán'

    RETURN @MaDH
END
GO
/****** Object:  UserDefinedFunction [dbo].[func_TongTien_ChiTietHoaDon]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_TongTien_ChiTietHoaDon] 
(

)
RETURNS FLOAT  
AS
BEGIN
	DECLARE @MaDH NVARCHAR(50)
    DECLARE @Tong FLOAT = 0

	SELECT @MaDH = MaDH
    FROM DonHang
    WHERE TrangThai = N'Chưa thanh toán'

    -- Tính tổng tiền
    SELECT @Tong = SUM(TongTien)
    FROM ChiTietHoaDon
    WHERE MaDH = @MaDH

    RETURN @Tong 
END;
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[MaDH] [nvarchar](50) NOT NULL,
	[MaKH] [nvarchar](50) NULL,
	[MaNV] [nvarchar](50) NULL,
	[NgayMua] [date] NULL,
	[GiaTriDon] [float] NULL,
	[TrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK_DonHang] PRIMARY KEY CLUSTERED 
(
	[MaDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSP] [nvarchar](50) NOT NULL,
	[TenSP] [nvarchar](50) NOT NULL,
	[Gia] [float] NOT NULL,
	[AnhSP] [nvarchar](200) NOT NULL,
	[MaLoaiSP] [nvarchar](50) NULL,
 CONSTRAINT [PK_MaSP] PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDon](
	[MaDH] [nvarchar](50) NOT NULL,
	[MaSP] [nvarchar](50) NOT NULL,
	[SoLuong] [int] NULL,
	[TongTien] [float] NULL,
 CONSTRAINT [PK_ChiTietHoaDon] PRIMARY KEY CLUSTERED 
(
	[MaDH] ASC,
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_DanhSachSanPhamDaChon]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_DanhSachSanPhamDaChon] AS
SELECT sp.MaSP, sp.TenSP, sp.Gia, cthd.SoLuong, cthd.TongTien 
FROM ChiTietHoaDon cthd  
INNER JOIN SanPham sp ON cthd.MaSP = sp.MaSP
INNER JOIN DonHang dh ON  cthd.MaDH = dh.MaDH
WHERE TrangThai = N'Chưa thanh toán'
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [nvarchar](50) NOT NULL,
	[HoTenNV] [nvarchar](50) NOT NULL,
	[SoDienThoai] [nvarchar](50) NOT NULL,
	[NamSinh] [int] NULL,
	[GioiTinh] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](200) NULL,
	[TenDangNhap] [nvarchar](50) NOT NULL,
	[MatKhau] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [nvarchar](50) NOT NULL,
	[TenKH] [nvarchar](50) NOT NULL,
	[SoDienThoai] [nvarchar](50) NULL,
	[SoDiemTichLuy] [float] NULL,
 CONSTRAINT [PK_KhangHang] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_DanhSachHoaDon]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_DanhSachHoaDon] AS
SELECT dh.MaDH, dh.NgayMua, kh.SoDienThoai, kh.TenKH, dh.GiaTriDon
FROM DonHang dh 
INNER JOIN ChiTietHoaDon cthd ON dh.MaDH = cthd.MaDH
INNER JOIN NhanVien nv ON dh.MaNV = nv.MaNV
INNER JOIN KhachHang kh ON dh.MaKH = kh.MaKH
WHERE dh.TrangThai = N'Đã thanh toán'
GO
/****** Object:  UserDefinedFunction [dbo].[func_TimKiemTheoSoDienThoai_DonHang]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_TimKiemTheoSoDienThoai_DonHang](@SoDienThoai NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT MaDH, NgayMua, SoDienThoai, TenKH, GiaTriDon
    FROM v_DanhSachHoaDon 
    WHERE SoDienThoai LIKE N'%' + @SoDienThoai + '%'
)
 
GO
/****** Object:  Table [dbo].[LoaiSanPham]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiSanPham](
	[MaLoaiSP] [nvarchar](50) NOT NULL,
	[TenLoaiSP] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_LoaiSanPham] PRIMARY KEY CLUSTERED 
(
	[MaLoaiSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_DanhSachSanPham]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_DanhSachSanPham] AS
SELECT sp.MaSP, sp.TenSP, sp.Gia, lsp.TenLoaiSP, sp.AnhSP
FROM SanPham sp
INNER JOIN LoaiSanPham lsp ON sp.MaLoaiSP = lsp.MaLoaiSP
GO
/****** Object:  Table [dbo].[NhanVienToanThoiGian]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVienToanThoiGian](
	[MaNV] [nvarchar](50) NULL,
	[LuongCoDinh] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVienBanThoiGian]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVienBanThoiGian](
	[MaNV] [nvarchar](50) NULL,
	[LuongTheoGio] [float] NULL,
	[SoGio] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_DanhSachNhanVien]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_DanhSachNhanVien] AS
SELECT nv.*, nvttg.LuongCoDinh, nvbtg.SoGio, LuongTheoGio
FROM NhanVien nv
FULL OUTER JOIN NhanVienToanThoiGian nvttg ON nv.MaNV = nvttg.MaNV
FULL OUTER JOIN NhanVienBanThoiGian nvbtg ON nv.MaNV = nvbtg.MaNV
GO
/****** Object:  Table [dbo].[NguyenLieu]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguyenLieu](
	[MaNL] [nvarchar](50) NOT NULL,
	[TenNL] [nvarchar](50) NOT NULL,
	[SoLuongTonKho] [int] NULL,
	[DonVi] [nvarchar](50) NULL,
 CONSTRAINT [PK_NguyenLieu] PRIMARY KEY CLUSTERED 
(
	[MaNL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhaChe]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhaChe](
	[MaSP] [nvarchar](50) NOT NULL,
	[MaNL] [nvarchar](50) NOT NULL,
	[SoLuong] [int] NULL,
 CONSTRAINT [PK_PhaChe] PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC,
	[MaNL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[func_LoadDanhSachNguyenLieuTheoMaSP]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_LoadDanhSachNguyenLieuTheoMaSP](@MaSP NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT nl.MaNL, nl.TenNL, pc.SoLuong, nl.SoLuongTonKho, nl.DonVi
	FROM NguyenLieu nl
	INNER JOIN PhaChe pc ON nl.MaNL = pc.MaNL
	INNER JOIN SanPham sp ON pc.MaSP = sp.MaSP
    WHERE sp.MaSP = @MaSP 
)
GO
/****** Object:  View [dbo].[v_NguyenLieuDungDePhaCheSanPham]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE VIEW [dbo].[v_NguyenLieuDungDePhaCheSanPham] AS
SELECT nl.MaNL, nl.TenNL, pc.SoLuong, nl.SoLuongTonKho, nl.DonVi
FROM NguyenLieu nl
INNER JOIN PhaChe pc ON nl.MaNL = pc.MaNL
INNER JOIN SanPham sp ON pc.MaSP = sp.MaSP
GO
/****** Object:  UserDefinedFunction [dbo].[func_TimKiemTheoTen_LoaiSanPham]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[func_TimKiemTheoTen_LoaiSanPham](@TenLoaiSP NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM LoaiSanPham
    WHERE TenLoaiSP LIKE N'%' + @TenLoaiSP + '%'
)
GO
/****** Object:  Table [dbo].[CaLamViec]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaLamViec](
	[MaCa] [nvarchar](50) NOT NULL,
	[TenCa] [nvarchar](50) NOT NULL,
	[Ngay] [date] NULL,
	[GioBatDau] [time](0) NULL,
	[GioKetThuc] [time](0) NULL,
 CONSTRAINT [PK_CaLamViec] PRIMARY KEY CLUSTERED 
(
	[MaCa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CongViec]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CongViec](
	[MaCV] [nvarchar](50) NOT NULL,
	[TenCV] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CongViec] PRIMARY KEY CLUSTERED 
(
	[MaCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThucHien]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThucHien](
	[MaNV] [nvarchar](50) NULL,
	[MaCV] [nvarchar](50) NULL,
	[MaCa] [nvarchar](50) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[CaLamViec] ([MaCa], [TenCa], [Ngay], [GioBatDau], [GioKetThuc]) VALUES (N'CA01', N'Sáng', CAST(N'2024-09-01' AS Date), CAST(N'06:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[CaLamViec] ([MaCa], [TenCa], [Ngay], [GioBatDau], [GioKetThuc]) VALUES (N'CA02', N'Chi?u', CAST(N'2024-09-01' AS Date), CAST(N'12:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[CaLamViec] ([MaCa], [TenCa], [Ngay], [GioBatDau], [GioKetThuc]) VALUES (N'CA03', N'T?i', CAST(N'2024-09-01' AS Date), CAST(N'18:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[CaLamViec] ([MaCa], [TenCa], [Ngay], [GioBatDau], [GioKetThuc]) VALUES (N'CA04', N'Sáng', CAST(N'2024-09-02' AS Date), CAST(N'06:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[CaLamViec] ([MaCa], [TenCa], [Ngay], [GioBatDau], [GioKetThuc]) VALUES (N'CA05', N'Chi?u', CAST(N'2024-09-02' AS Date), CAST(N'12:00:00' AS Time), CAST(N'18:00:00' AS Time))
GO
INSERT [dbo].[ChiTietHoaDon] ([MaDH], [MaSP], [SoLuong], [TongTien]) VALUES (N'DH01', N'SP01', 1, 90000)
INSERT [dbo].[ChiTietHoaDon] ([MaDH], [MaSP], [SoLuong], [TongTien]) VALUES (N'DH02', N'SP02', 1, 90000)
INSERT [dbo].[ChiTietHoaDon] ([MaDH], [MaSP], [SoLuong], [TongTien]) VALUES (N'DH03', N'SP03', 1, 90000)
INSERT [dbo].[ChiTietHoaDon] ([MaDH], [MaSP], [SoLuong], [TongTien]) VALUES (N'DH04', N'SP04', 1, 90000)
INSERT [dbo].[ChiTietHoaDon] ([MaDH], [MaSP], [SoLuong], [TongTien]) VALUES (N'DH05', N'SP05', 1, 90000)
GO
INSERT [dbo].[CongViec] ([MaCV], [TenCV]) VALUES (N'CV01', N'Ph?c v?')
INSERT [dbo].[CongViec] ([MaCV], [TenCV]) VALUES (N'CV02', N'Thu ngân')
INSERT [dbo].[CongViec] ([MaCV], [TenCV]) VALUES (N'CV03', N'Pha ch?')
INSERT [dbo].[CongViec] ([MaCV], [TenCV]) VALUES (N'CV04', N'Qu?n lý')
INSERT [dbo].[CongViec] ([MaCV], [TenCV]) VALUES (N'CV05', N'B?o v?')
GO
INSERT [dbo].[DonHang] ([MaDH], [MaKH], [MaNV], [NgayMua], [GiaTriDon], [TrangThai]) VALUES (N'DH01', N'KH01', N'NV01', CAST(N'2024-09-30' AS Date), 500000, N'Đã thanh toán')
INSERT [dbo].[DonHang] ([MaDH], [MaKH], [MaNV], [NgayMua], [GiaTriDon], [TrangThai]) VALUES (N'DH02', N'KH02', N'NV02', CAST(N'2024-09-30' AS Date), 300000, N'Đã thanh toán')
INSERT [dbo].[DonHang] ([MaDH], [MaKH], [MaNV], [NgayMua], [GiaTriDon], [TrangThai]) VALUES (N'DH03', N'KH03', N'NV03', CAST(N'2024-09-30' AS Date), 400000, N'Đã thanh toán')
INSERT [dbo].[DonHang] ([MaDH], [MaKH], [MaNV], [NgayMua], [GiaTriDon], [TrangThai]) VALUES (N'DH04', N'KH04', N'NV04', CAST(N'2024-10-01' AS Date), 200000, N'Đã thanh toán')
INSERT [dbo].[DonHang] ([MaDH], [MaKH], [MaNV], [NgayMua], [GiaTriDon], [TrangThai]) VALUES (N'DH05', N'KH05', N'NV05', CAST(N'2024-10-01' AS Date), 100000, N'Đã thanh toán')
GO
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [SoDienThoai], [SoDiemTichLuy]) VALUES (N'KH01', N'Võ Văn Trí', N'0981234567', 50)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [SoDienThoai], [SoDiemTichLuy]) VALUES (N'KH02', N'Tr?n Th? L', N'0987654321', 100)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [SoDienThoai], [SoDiemTichLuy]) VALUES (N'KH03', N'Lê Van M', N'0934567891', 70)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [SoDienThoai], [SoDiemTichLuy]) VALUES (N'KH04', N'Ph?m Th? N', N'0912345679', 80)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [SoDienThoai], [SoDiemTichLuy]) VALUES (N'KH05', N'Hoàng Van O', N'0901234568', 30)
GO
INSERT [dbo].[LoaiSanPham] ([MaLoaiSP], [TenLoaiSP]) VALUES (N'LSP01', N'Cà phê')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSP], [TenLoaiSP]) VALUES (N'LSP02', N'Trà')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSP], [TenLoaiSP]) VALUES (N'LSP03', N'Nước ép')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSP], [TenLoaiSP]) VALUES (N'LSP04', N'Sinh tố')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSP], [TenLoaiSP]) VALUES (N'LSP05', N'Bánh ngọt')
GO
INSERT [dbo].[NguyenLieu] ([MaNL], [TenNL], [SoLuongTonKho], [DonVi]) VALUES (N'NL01', N'Cà phê hạt', 100, N'gam')
INSERT [dbo].[NguyenLieu] ([MaNL], [TenNL], [SoLuongTonKho], [DonVi]) VALUES (N'NL02', N'Ðường', 200, N'gam')
INSERT [dbo].[NguyenLieu] ([MaNL], [TenNL], [SoLuongTonKho], [DonVi]) VALUES (N'NL03', N'Cam', 50, N'gam')
INSERT [dbo].[NguyenLieu] ([MaNL], [TenNL], [SoLuongTonKho], [DonVi]) VALUES (N'NL04', N'Sữa tuoi', 150, N'gam')
INSERT [dbo].[NguyenLieu] ([MaNL], [TenNL], [SoLuongTonKho], [DonVi]) VALUES (N'NL05', N'Xoài', 75, N'gam')
GO
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [SoDienThoai], [NamSinh], [GioiTinh], [DiaChi], [TenDangNhap], [MatKhau]) VALUES (N'NV01', N'Nguyễn Văn A', N'0987654321', 1995, N'Nam', N'Hà N?i', N'nv01', N'123456')
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [SoDienThoai], [NamSinh], [GioiTinh], [DiaChi], [TenDangNhap], [MatKhau]) VALUES (N'NV02', N'Trần Thị B', N'0912345678', 1998, N'N?', N'H? Chí Minh', N'nv02', N'abcdef')
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [SoDienThoai], [NamSinh], [GioiTinh], [DiaChi], [TenDangNhap], [MatKhau]) VALUES (N'NV03', N'Lê Văn C', N'0923456789', 1996, N'Nam', N'Ðà N?ng', N'nv03', N'qwerty')
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [SoDienThoai], [NamSinh], [GioiTinh], [DiaChi], [TenDangNhap], [MatKhau]) VALUES (N'NV04', N'Phạm Thị D', N'0909876543', 1997, N'N?', N'H?i Phòng', N'nv04', N'zxcvbn')
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [SoDienThoai], [NamSinh], [GioiTinh], [DiaChi], [TenDangNhap], [MatKhau]) VALUES (N'NV05', N'Hoàng Văn E', N'0934567890', 2000, N'Nam', N'Nha Trang', N'nv05', N'poiuyt')
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [SoDienThoai], [NamSinh], [GioiTinh], [DiaChi], [TenDangNhap], [MatKhau]) VALUES (N'NV06', N'Hoàng Văn Thụ', N'0934567892', 2000, N'Nam', N'Nha Trang', N'nv06', N'poiuyt')
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [SoDienThoai], [NamSinh], [GioiTinh], [DiaChi], [TenDangNhap], [MatKhau]) VALUES (N'NV07', N'Nguyễn Hoàng Anh Khoa', N'0934567893', 2000, N'Nam', N'Nha Trang', N'nv07', N'gfdree')
INSERT [dbo].[NhanVien] ([MaNV], [HoTenNV], [SoDienThoai], [NamSinh], [GioiTinh], [DiaChi], [TenDangNhap], [MatKhau]) VALUES (N'NV08', N'Võ Văn Trí', N'0934567891', 2000, N'Nam', N'Nha Trang', N'nv08', N'adfsfd')
GO
INSERT [dbo].[NhanVienBanThoiGian] ([MaNV], [LuongTheoGio], [SoGio]) VALUES (N'NV06', 50000, 40)
INSERT [dbo].[NhanVienBanThoiGian] ([MaNV], [LuongTheoGio], [SoGio]) VALUES (N'NV07', 60000, 30)
INSERT [dbo].[NhanVienBanThoiGian] ([MaNV], [LuongTheoGio], [SoGio]) VALUES (N'NV08', 70000, 35)
GO
INSERT [dbo].[NhanVienToanThoiGian] ([MaNV], [LuongCoDinh]) VALUES (N'NV01', 10000000)
INSERT [dbo].[NhanVienToanThoiGian] ([MaNV], [LuongCoDinh]) VALUES (N'NV02', 12000000)
INSERT [dbo].[NhanVienToanThoiGian] ([MaNV], [LuongCoDinh]) VALUES (N'NV03', 15000000)
INSERT [dbo].[NhanVienToanThoiGian] ([MaNV], [LuongCoDinh]) VALUES (N'NV04', 18000000)
INSERT [dbo].[NhanVienToanThoiGian] ([MaNV], [LuongCoDinh]) VALUES (N'NV05', 10000000)
GO
INSERT [dbo].[PhaChe] ([MaSP], [MaNL], [SoLuong]) VALUES (N'SP01', N'NL01', 10)
INSERT [dbo].[PhaChe] ([MaSP], [MaNL], [SoLuong]) VALUES (N'SP01', N'NL02', 5)
INSERT [dbo].[PhaChe] ([MaSP], [MaNL], [SoLuong]) VALUES (N'SP03', N'NL03', 20)
INSERT [dbo].[PhaChe] ([MaSP], [MaNL], [SoLuong]) VALUES (N'SP04', N'NL04', 15)
INSERT [dbo].[PhaChe] ([MaSP], [MaNL], [SoLuong]) VALUES (N'SP04', N'NL05', 10)
GO
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [Gia], [AnhSP], [MaLoaiSP]) VALUES (N'SP01', N'Cà phê sữa', 30000, N'img.jpg', N'LSP01')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [Gia], [AnhSP], [MaLoaiSP]) VALUES (N'SP02', N'Trà dào', 40000, N'img.jpg', N'LSP02')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [Gia], [AnhSP], [MaLoaiSP]) VALUES (N'SP03', N'Nu?c ép cam', 35000, N'img.jpg', N'LSP03')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [Gia], [AnhSP], [MaLoaiSP]) VALUES (N'SP04', N'Sinh t? xoài', 45000, N'img.jpg', N'LSP04')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [Gia], [AnhSP], [MaLoaiSP]) VALUES (N'SP05', N'Bánh mousse', 50000, N'img.jpg', N'LSP05')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [Gia], [AnhSP], [MaLoaiSP]) VALUES (N'SP06', N'nhap', 12000, N'camera.jpg', N'LSP02')
INSERT [dbo].[SanPham] ([MaSP], [TenSP], [Gia], [AnhSP], [MaLoaiSP]) VALUES (N'SP07', N'123123', 123123, N'camera.jpg', N'LSP03')
GO
INSERT [dbo].[ThucHien] ([MaNV], [MaCV], [MaCa]) VALUES (N'NV01', N'CV01', N'CA01')
INSERT [dbo].[ThucHien] ([MaNV], [MaCV], [MaCa]) VALUES (N'NV02', N'CV02', N'CA02')
INSERT [dbo].[ThucHien] ([MaNV], [MaCV], [MaCa]) VALUES (N'NV03', N'CV03', N'CA03')
INSERT [dbo].[ThucHien] ([MaNV], [MaCV], [MaCa]) VALUES (N'NV04', N'CV04', N'CA04')
INSERT [dbo].[ThucHien] ([MaNV], [MaCV], [MaCa]) VALUES (N'NV05', N'CV05', N'CA05')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__NhanVien__0389B7BDF42D2FBB]    Script Date: 10/18/2024 9:26:17 PM ******/
ALTER TABLE [dbo].[NhanVien] ADD UNIQUE NONCLUSTERED 
(
	[SoDienThoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__NhanVien__55F68FC0011E3CF5]    Script Date: 10/18/2024 9:26:17 PM ******/
ALTER TABLE [dbo].[NhanVien] ADD UNIQUE NONCLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDon_DonHang] FOREIGN KEY([MaDH])
REFERENCES [dbo].[DonHang] ([MaDH])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK_ChiTietHoaDon_DonHang]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDon_SanPham] FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK_ChiTietHoaDon_SanPham]
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [FK_DonHang_NhanVien]
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [FP_DonHang_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [FP_DonHang_KhachHang]
GO
ALTER TABLE [dbo].[NhanVienBanThoiGian]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_BanThoiGian] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[NhanVienBanThoiGian] CHECK CONSTRAINT [FK_NhanVien_BanThoiGian]
GO
ALTER TABLE [dbo].[NhanVienToanThoiGian]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_ToanThoiGian] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[NhanVienToanThoiGian] CHECK CONSTRAINT [FK_NhanVien_ToanThoiGian]
GO
ALTER TABLE [dbo].[PhaChe]  WITH CHECK ADD  CONSTRAINT [FK_PhaChe_NguyenLieu] FOREIGN KEY([MaNL])
REFERENCES [dbo].[NguyenLieu] ([MaNL])
GO
ALTER TABLE [dbo].[PhaChe] CHECK CONSTRAINT [FK_PhaChe_NguyenLieu]
GO
ALTER TABLE [dbo].[PhaChe]  WITH CHECK ADD  CONSTRAINT [FK_PhaChe_SanPHam] FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPham] ([MaSP])
GO
ALTER TABLE [dbo].[PhaChe] CHECK CONSTRAINT [FK_PhaChe_SanPHam]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_LoaiSP] FOREIGN KEY([MaLoaiSP])
REFERENCES [dbo].[LoaiSanPham] ([MaLoaiSP])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_LoaiSP]
GO
ALTER TABLE [dbo].[ThucHien]  WITH CHECK ADD  CONSTRAINT [FK_ThucHien_CaLamViec] FOREIGN KEY([MaCa])
REFERENCES [dbo].[CaLamViec] ([MaCa])
GO
ALTER TABLE [dbo].[ThucHien] CHECK CONSTRAINT [FK_ThucHien_CaLamViec]
GO
ALTER TABLE [dbo].[ThucHien]  WITH CHECK ADD  CONSTRAINT [FK_ThucHien_CongViec] FOREIGN KEY([MaCV])
REFERENCES [dbo].[CongViec] ([MaCV])
GO
ALTER TABLE [dbo].[ThucHien] CHECK CONSTRAINT [FK_ThucHien_CongViec]
GO
ALTER TABLE [dbo].[ThucHien]  WITH CHECK ADD  CONSTRAINT [FK_ThucHien_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[ThucHien] CHECK CONSTRAINT [FK_ThucHien_NhanVien]
GO
ALTER TABLE [dbo].[CaLamViec]  WITH CHECK ADD CHECK  ((datediff(day,[Ngay],getdate())>=(0)))
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD CHECK  (([SoLuong]>(0)))
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD CHECK  (([TongTien]>(0)))
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD CHECK  (([GiaTriDon]>(0)))
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD CHECK  ((datediff(day,[NgayMua],getdate())>=(0)))
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD CHECK  ((len([SoDienThoai])=(10)))
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD CHECK  (([SoDiemTichLuy]>=(0)))
GO
ALTER TABLE [dbo].[NguyenLieu]  WITH CHECK ADD CHECK  (([SoLuongTonKho]>=(0)))
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD CHECK  (((datepart(year,getdate())-[NamSinh])>=(16)))
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD CHECK  ((len([SoDienThoai])=(10)))
GO
ALTER TABLE [dbo].[NhanVienBanThoiGian]  WITH CHECK ADD CHECK  (([LuongTheoGio]>(0)))
GO
ALTER TABLE [dbo].[NhanVienBanThoiGian]  WITH CHECK ADD CHECK  (([SoGio]>(0)))
GO
ALTER TABLE [dbo].[NhanVienToanThoiGian]  WITH CHECK ADD CHECK  (([LuongCoDinh]>(0)))
GO
ALTER TABLE [dbo].[PhaChe]  WITH CHECK ADD CHECK  (([SoLuong]>=(0)))
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD CHECK  (([Gia]>(0)))
GO
/****** Object:  StoredProcedure [dbo].[proc_CapNhatGiaTriDon_DonHang]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[proc_CapNhatGiaTriDon_DonHang] 
AS
BEGIN
	DECLARE @MaDH NVARCHAR(50) 

	SELECT @MaDH = MaDH 
	FROM DonHang
	WHERE TrangThai =  N'Chưa thanh toán'
	
	UPDATE DonHang 
	SET GiaTriDon = (SELECT SUM(TongTien) FROM ChiTietHoaDon WHERE MaDH = @MaDH)
	WHERE TrangThai =  N'Chưa thanh toán'  
END
GO
/****** Object:  StoredProcedure [dbo].[proc_CapNhatSoDiemTichLuy_CapTrangThaiDonHang]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[proc_CapNhatSoDiemTichLuy_CapTrangThaiDonHang]  
AS
BEGIN  
	DECLARE @GiaTriDon FLOAT
	DECLARE @MaKH NVARCHAR(50)
	
    SELECT @GiaTriDon = GiaTriDon, @MaKH = MaKH
    FROM DonHang
    WHERE TrangThai = N'Chưa thanh toán'
	 
	UPDATE KhachHang 
	SET SoDiemTichLuy = SoDienThoai + @GiaTriDon * 0.01
	WHERE MaKH =  @MaKH  

	UPDATE DonHang 
	SET TrangThai = N'Đã thanh toán'  
	WHERE TrangThai =  N'Chưa thanh toán' 
END

GO
/****** Object:  StoredProcedure [dbo].[proc_LoadThongTin_KhachHang]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_LoadThongTin_KhachHang]
	@SoDienThoai NVARCHAR(50),
	@Ten NVARCHAR(50) OUTPUT,
	@SoDiemTichLuy FLOAT OUTPUT
AS
BEGIN 
	SELECT @Ten = kh.TenKH, @SoDiemTichLuy = kh.SoDiemTichLuy
	FROM KhachHang kh
	WHERE SoDienThoai = @SoDienThoai
END
GO
/****** Object:  StoredProcedure [dbo].[proc_Sua_KhachHang]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_Sua_KhachHang]
    @TenKH NVARCHAR(50),
    @SoDienThoaiCu NVARCHAR(50),  
    @SoDienThoaiMoi NVARCHAR(50) 
AS
BEGIN  
    UPDATE KhachHang 
    SET TenKH = @TenKH, SoDienThoai = @SoDienThoaiMoi
    WHERE SoDienThoai = @SoDienThoaiCu;
END
GO
/****** Object:  StoredProcedure [dbo].[proc_Sua_LoaiSanPham]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_Sua_LoaiSanPham]
    @MaLoaiSP NVARCHAR(50),
	@TenLoaiSP NVARCHAR(50)
AS
BEGIN
    UPDATE LoaiSanPham  
	SET TenLoaiSP = @TenLoaiSP
    WHERE MaLoaiSP = @MaLoaiSP
END
GO
/****** Object:  StoredProcedure [dbo].[proc_Sua_SanPham]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_Sua_SanPham]
    @MaSP NVARCHAR(50),
    @TenSP NVARCHAR(50),
	@Gia FLOAT,
	@AnhSP NVARCHAR(50),
	@MaLoaiSP NVARCHAR(50)
AS
BEGIN
	UPDATE SanPham 
	SET TenSP = @TenSP,
		Gia = @Gia,
		AnhSP = @AnhSP,
		MaLoaiSP = @MaLoaiSP
	WHERE MaSP = @MaSP  
END
GO
/****** Object:  StoredProcedure [dbo].[proc_Them_ChiTietDonHang]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[proc_Them_ChiTietDonHang] 
	@MaSP NVARCHAR(50)
AS
BEGIN
	DECLARE @MaDH NVARCHAR(50) 

	SELECT @MaDH = MaDH 
	FROM DonHang
	WHERE TrangThai =  N'Chưa thanh toán'
	
	INSERT INTO ChiTietHoaDon(MaDH, MaSP, SoLuong, TongTien)
	VALUES (@MaDH, @MaSP, 1, (SELECT Gia*1 FROM SanPham WHERE MaSP = @maSP))
END
GO
/****** Object:  StoredProcedure [dbo].[proc_Them_DonHang]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_Them_DonHang] 
	@SoDienThoai NVARCHAR(50),
	@MaNV NVARCHAR(50)
AS
BEGIN
	DECLARE @MaKH NVARCHAR(50)
	
	SELECT @MaKH = MaKH
	FROM KhachHang
	WHERE SoDienThoai = @SoDienThoai
	
	INSERT INTO DonHang(MaKH, MaNV, NgayMua, GiaTriDon, TrangThai)
	VALUES (@MaKH, @MaNV, GETDATE(), 1, N'Chưa thanh toán')
END
GO
/****** Object:  StoredProcedure [dbo].[proc_Them_KhachHang]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_Them_KhachHang] 
	@SoDienThoai NVARCHAR(50)
AS
BEGIN 
	DECLARE @maxMaKH NVARCHAR(50);
    DECLARE @newMaKH NVARCHAR(50); -- @newMaKH = @maxMaKH + 1
    DECLARE @numPart INT;

    -- Tìm giá trị MaKH lớn nhất hiện có
    SELECT @maxMaKH = MAX(MaKH) 
    FROM KhachHang
    WHERE MaKH LIKE 'KH%';

    -- Lấy phần số từ MaKH (bỏ phần 'KH' phía trước) và convert sang kiểu INT
    IF @maxMaKH IS NOT NULL
    BEGIN
        SET @numPart = CAST(SUBSTRING(@maxMaKH, 3, LEN(@maxMaKH) - 2) AS INT) + 1;
    END
    ELSE
    BEGIN
        -- Nếu chưa có MaKH nào, bắt đầu từ 1
        SET @numPart = 1;
    END

    -- Tạo giá trị mới cho MaKH, với định dạng KHxx (2 số)
    SET @newMaKH = 'KH' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);

    -- Thực hiện chèn bản ghi với maDH mới
    INSERT INTO KhachHang(MaKH, TenKH, SoDienThoai, SoDiemTichLuy)
    VALUES(@newMaKH, N'Chưa nhập tên', @SoDienThoai, 0)
END
GO
/****** Object:  StoredProcedure [dbo].[proc_Them_LoaiSanPham]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_Them_LoaiSanPham] 
	@MaLoaiSP NVARCHAR(50),
    @TenLoaiSP NVARCHAR(50)
AS
BEGIN
    INSERT INTO LoaiSanPham (MaLoaiSP, TenLoaiSP)
    VALUES (@MaLoaiSP, @TenLoaiSP)
END
GO
/****** Object:  StoredProcedure [dbo].[proc_Them_PhaChe]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_Them_PhaChe]
    @MaSP NVARCHAR(50),
	@MaNL NVARCHAR(50),
	@SoLuong INT
AS
BEGIN
	INSERT INTO PhaChe(MaSP, MaNL, SoLuong)
	VALUES (@MaSP, @MaNL, @SoLuong)
END
GO
/****** Object:  StoredProcedure [dbo].[proc_Them_SanPham]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_Them_SanPham]
    @MaSP NVARCHAR(50),
    @TenSP NVARCHAR(50),
	@Gia FLOAT,
	@AnhSP NVARCHAR(50),
	@MaLoaiSP NVARCHAR(50)
AS
BEGIN
    INSERT INTO SanPham(MaSP, TenSP, Gia, AnhSP, MaLoaiSP)
    VALUES (@MaSP, @TenSP, @Gia, @AnhSP, @MaLoaiSP)
END
GO
/****** Object:  StoredProcedure [dbo].[proc_Xoa_KhachHangChuaNhapTen_DonHangChuaThanhToan]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_Xoa_KhachHangChuaNhapTen_DonHangChuaThanhToan]
AS
BEGIN
	 

	DECLARE @MaDH NVARCHAR(50)

	SELECT @MaDH = MaDH 
	FROM DonHang
	WHERE TrangThai =  N'Chưa thanh toán'
	 
	DELETE FROM ChiTietHoaDon
	WHERE MaDH = @MaDH
	 
	DELETE FROM DonHang 
	WHERE TrangThai = N'Chưa thanh toán'

DELETE FROM KhachHang
	WHERE TenKH = N'Chưa nhập tên'


END
GO
/****** Object:  StoredProcedure [dbo].[proc_Xoa_LoaiSanPham]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_Xoa_LoaiSanPham]
    @MaLoaiSP NVARCHAR(50)
AS
BEGIN
    DELETE FROM LoaiSanPham  
    WHERE MaLoaiSP = @MaLoaiSP
END
GO
/****** Object:  StoredProcedure [dbo].[proc_Xoa_PhaChe]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_Xoa_PhaChe]
    @MaSP NVARCHAR(50),
	@MaNL NVARCHAR(50)
AS
BEGIN
	DELETE FROM PhaChe
	WHERE MaSP = @MaSP AND MaNL = @MaNL
END
GO
/****** Object:  StoredProcedure [dbo].[proc_Xoa_SanPham]    Script Date: 10/18/2024 9:26:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_Xoa_SanPham] 
	@MaSP NVARCHAR(50)
AS
BEGIN
	DELETE FROM SanPham  
	WHERE MaSP = @MaSP  
END
GO
