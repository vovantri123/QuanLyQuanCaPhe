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

-- Truy vấn dữ liệu từ VIEW
SELECT * FROM vNguoiThucHienCa;

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

-- Thủ tục xóa khách hàng
CREATE PROCEDURE Proc_XoaKhachHang_KhachHang
    @MaKH NVARCHAR(50)
AS
BEGIN
    DELETE FROM KhachHang  
    WHERE MaKH = @MaKH;
END

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

