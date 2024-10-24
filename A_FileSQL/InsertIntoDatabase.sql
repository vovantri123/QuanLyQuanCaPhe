USE QuanLyQuanCaPhe

GO

--BEGIN TRANSACTION --Insert có lỗi thì chạy lệnh rollback bên dưới, chèn được hết thì nhớ commit

-- Bảng Công Việc
INSERT INTO CongViec (MaCV, TenCV) VALUES 
('CV01', N'Phục vụ'),
('CV02', N'Pha chế'),
('CV03', N'Quản lý'),
('CV04', N'Bảo vệ'),
('CV05', N'Thu ngân');

-- Bảng Nhân Viên
INSERT INTO NhanVien (MaNV, HoTenNV, SoDienThoai, NamSinh, GioiTinh, DiaChi, TenDangNhap, MatKhau) VALUES
('NV01', N'Nguyễn Hoàng Anh Khoa', '0934567893', 2004, 'Nam', 'Nha Trang', 'nv01', 'nv01'),
('NV02', N'Võ Văn Trí', '0934567891', 2004, 'Nam', 'Nha Trang', 'nv02', 'nv02'),
('NV03', N'Nguyễn Lý Hùng', '0926081451', 2004, 'Nam', 'Hồ Chí Minh', 'nv03', 'nv03'),
('NV04', N'Trương Hồng Hạnh', '0839907328', 2004, 'Nữ', 'Tiền Giang', 'nv04', 'nv04'),
('NV05', N'Lê Thị Khánh Ngọc', '0585850481', 2003, 'Nữ', 'Hà Nội', 'nv05', 'nv05'),
('NV06', N'Hoàng Thị Thu Trang', '0876525505', 2006, 'Nữ', 'Đồng Nai', 'nv06', 'nv06'),
('NV07', N'Phạm Ngọc Huy', '0977801301', 2000, 'Nam', 'Bến Tre', 'nv07', 'nv07'),
('NV08', N'Trần Nhật Minh', '0843255905', 2001, 'Nam', 'Hồ Chí Minh', 'nv08', 'nv08');

-- Bảng Nhân Viên Toàn Thời Gian
INSERT INTO NhanVienToanThoiGian (MaNV, LuongCoDinh) VALUES
('NV01', 10000000),
('NV02', 8000000),
('NV03', 8000000),
('NV04', 8000000);

-- Bảng Nhân Viên Bán Thời Gian
INSERT INTO NhanVienBanThoiGian (MaNV, LuongTheoGio, SoGio) VALUES
('NV05', 25000, 40),
('NV06', 25000, 40),
('NV07', 25000, 30),
('NV08', 25000, 35);

-- Bảng Ca Làm Việc
INSERT INTO CaLamViec (MaCa, TenCa, Ngay, GioBatDau, GioKetThuc) VALUES
('CA01', N'Sáng', '2024-09-01', '06:00', '11:00'),
('CA02', N'Chiều', '2024-09-01', '13:00', '18:00'),
('CA03', N'Tối', '2024-09-01', '18:00', '23:00'),
('CA04', N'Sáng', '2024-09-02', '06:00', '12:00'),
('CA05', N'Chiều', '2024-09-02', '12:00', '18:00');

-- Bảng thực hiện
INSERT INTO ThucHien (MaNV, MaCV, MaCa) VALUES
('NV01', 'CV01', 'CA01'),
('NV02', 'CV02', 'CA02'),
('NV03', 'CV03', 'CA03'),
('NV04', 'CV04', 'CA04'),
('NV05', 'CV05', 'CA05')

-- Bảng Khách Hàng
INSERT INTO KhachHang (MaKH, TenKH, SoDienThoai, SoDiemTichLuy) VALUES
('KH01', N'Nguyễn Phúc Bảo', '0981234567', 400),
('KH02', N'Nguyễn Ngọc Doanh Doanh', '0987654321', 250),
('KH03', N'Lê Quang Tùng', '0934567891', 0),
('KH04', N'Lê Nguyễn Gia Bảo', '0862553374', 0),
('KH05', N'Nguyễn Tuấn Khang', '0989363831', 0),
('KH06', N'Nguyễn Quang Thành', '0981545322', 0),
('KH07', N'Đào Thanh Hiếu', '0915587477', 0),
('KH08', N'Lê Phương Anh', '0889503356', 0),
('KH09', N'Vũ Quốc Huy', '0913674476', 0),
('KH10', N'Nguyễn Thị Ngọc Trâm', '0925801790', 0),
('KH11', N'Lê Minh Ngọc', '0877401236', 0),
('KH12', N'Trịnh Thị Thu Giang', '0344970438', 0),
('KH13', N'Bùi Văn Phúc', '0917261992', 0),
('KH14', N'Nguyễn Thanh Thúy', '0830711637', 0),
('KH15', N'Phạm Gia Kỳ', '0834876402', 0),
('KH16', N'Trần Tuấn Kha', '0362482883', 0),
('KH17', N'Lê Thị Mỹ Linh', '0808777241', 0),
('KH18', N'Nguyễn Tiến Phát', '0965377812', 0),
('KH19', N'Đỗ Minh Trí', '0901234568', 0)

-- Bảng Đơn Hàng 

INSERT INTO DonHang (MaDH, MaKH, MaNV, NgayMua, GiaTriDon, TrangThai) VALUES
('DH01', 'KH01', 'NV01', '2024-09-30', 40000, N'Đã thanh toán'),
('DH02', 'KH02', 'NV04', '2024-10-01', 25000, N'Đã thanh toán');

-- Bảng Loại Sản Phẩm
INSERT INTO LoaiSanPham (MaLoaiSP, TenLoaiSP) VALUES
('LSP01', N'Cà phê'),
('LSP02', N'Trà'),
('LSP03', N'Sinh tố'),
('LSP04', N'Kem'),
('LSP05', N'Bánh kem'),
('LSP06', N'Bánh');

-- Bảng Sản Phẩm
INSERT INTO SanPham (MaSP, TenSP, Gia, AnhSP, MaLoaiSP) VALUES
('SP01', N'Cà phê đen đá', 20000, 'caphedenda.jpg', 'LSP01'),
('SP02', N'Cà phê sữa đá', 25000, 'caphesuada.jpg', 'LSP01'),
('SP03', N'Bạc xỉu', 25000, 'bacxiu.jpg', 'LSP01'),
('SP04', N'Đường đen sữa đá', 30000, 'duongdensuada.jpg', 'LSP01'),
('SP05', N'Latte đá', 35000, 'latteda.jpg', 'LSP01'),
('SP06', N'Latte nóng', 35000, 'lattenong.jpg', 'LSP01'),
('SP07', N'Cappuccino đá', 35000, 'cappuccinoda.jpg', 'LSP01'),
('SP08', N'Cappuccino nóng', 35000, 'cappuccinonong.jpg', 'LSP01'),
('SP09', N'Trà đào', 30000, 'tradao.jpg', 'LSP02'),
('SP10', N'Trà đào cam sả', 40000, 'tradaocamsa.jpg', 'LSP02'),
('SP11', N'Trà vải', 30000, 'travai.jpg', 'LSP02'),
('SP12', N'Trà sen', 30000, 'trasen.jpg', 'LSP02'),
('SP13', N'Sinh tố bơ', 35000, 'sinhtobo.jpg', 'LSP03'),
('SP14', N'Sinh tố dâu', 35000, 'sinhtodau.jpg', 'LSP03'),
('SP15', N'Sinh tố mãng cầu', 30000, 'sinhtomangcau.jpg', 'LSP03'),
('SP16', N'Sinh tố nho', 30000, 'sinhtonho.jpg', 'LSP03'),
('SP17', N'Kem socola', 12000, 'kemsocola.jpg', 'LSP04'),
('SP18', N'Kem dâu', 12000, 'kemdau.jpg', 'LSP04'),
('SP19', N'Kem matcha', 12000, 'kemmatcha.jpg', 'LSP04'),
('SP20', N'Kem cà phê', 12000, 'kemcaphe.jpg', 'LSP04'),
('SP21', N'Bánh kem cheese', 35000, 'banhkemcheese.jpg', 'LSP05'),
('SP22', N'Bánh kem dâu', 35000, 'banhkemdau.jpg', 'LSP05'),
('SP23', N'Bánh kem socola', 35000, 'banhkemsocola.jpg', 'LSP05'),
('SP24', N'Bánh kem matcha', 35000, 'banhkemmatcha.jpg', 'LSP05'),
('SP25', N'Bánh tiramisu', 38000, 'tiramisu.jpg', 'LSP06'),
('SP26', N'Bánh chà bông phô mai', 27000, 'chabongphomai.jpg', 'LSP06'),
('SP27', N'Bánh croissant', 22000, 'croissant.jpg', 'LSP06'),
('SP28', N'Bánh chaud', 22000, 'chaud.jpg', 'LSP06');

-- Bảng Nguyên liệu
INSERT INTO NguyenLieu (MaNL, TenNL, SoLuongTonKho, DonVi) VALUES
('NL01', N'Đá', 10000, N'gam'),
('NL02', N'Đường', 5000, N'gam'),
('NL03', N'Sữa tươi', 2000, N'lít'),
('NL04', N'Muối', 5000, N'gam'),
('NL05', N'Cà phê hạt', 2000, N'gam'),
('NL06', N'Cà phê gói', 2000, N'gói'),
('NL07', N'Bơ', 500, N'gam'),
('NL08', N'Dâu', 500, N'gam'),
('NL09', N'Nho', 200, N'gam'),
('NL10', N'Cam', 200, N'gam'),
('NL11', N'Vải', 200, N'gam'),
('NL12', N'Đào', 300, N'gam'),
('NL13', N'Mãng cầu', 250, N'gam'),
('NL14', N'Trà', 2000, N'gói'),
('NL15', N'Sữa đặc', 1500, N'lon'),
('NL16', N'Trứng', 350, N'quả'),
('NL17', N'Gelatin', 400, N'gói'),
('NL18', N'Kem tươi', 500, N'lít'),
('NL19', N'Socola', 550, N'gam'),
('NL20', N'Phô mai', 550, N'gam'),
('NL21', N'Bột ca cao', 500, N'gói'),
('NL22', N'Bột trà xanh', 500, N'gói');

-- Bảng Pha Chế (Liên kết sản phẩm và nguyên liệu)
INSERT INTO PhaChe (MaSP, MaNL, SoLuong) VALUES
('SP01', 'NL01', 1)


-- Bảng Chi Tiết Hóa Đơn
INSERT INTO ChiTietHoaDon (MaDH, MaSP, SoLuong, TongTien) VALUES
('DH01', 'SP01', 2, 40000),
('DH02', 'SP02', 1, 25000);


--ROLLBACK TRANSACTION

--COMMIT TRANSACTION