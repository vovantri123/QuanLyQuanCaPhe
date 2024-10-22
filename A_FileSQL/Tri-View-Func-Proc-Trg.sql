USE QuanLyQuanCaPhe

GO

-- View

CREATE VIEW v_DanhSachSanPhamDaChon AS
SELECT sp.MaSP, sp.TenSP, sp.Gia, cthd.SoLuong, cthd.TongTien 
FROM ChiTietHoaDon cthd  
INNER JOIN SanPham sp ON cthd.MaSP = sp.MaSP
INNER JOIN DonHang dh ON  cthd.MaDH = dh.MaDH
WHERE TrangThai = N'Chưa thanh toán'

GO

CREATE VIEW v_DanhSachSanPham AS
SELECT sp.MaSP, sp.TenSP, sp.Gia, lsp.TenLoaiSP, sp.AnhSP
FROM SanPham sp
INNER JOIN LoaiSanPham lsp ON sp.MaLoaiSP = lsp.MaLoaiSP


GO

CREATE VIEW v_NguyenLieuDungDePhaCheSanPham AS
SELECT nl.MaNL, nl.TenNL, pc.SoLuong, nl.SoLuongTonKho
FROM NguyenLieu nl
INNER JOIN PhaChe pc ON nl.MaNL = pc.MaNL
INNER JOIN SanPham sp ON pc.MaSP = sp.MaSP

GO

CREATE VIEW v_DanhSachNhanVien AS
SELECT nv.*, nvttg.LuongCoDinh, nvbtg.SoGio, LuongTheoGio
FROM NhanVien nv
FULL OUTER JOIN NhanVienToanThoiGian nvttg ON nv.MaNV = nvttg.MaNV
FULL OUTER JOIN NhanVienBanThoiGian nvbtg ON nv.MaNV = nvbtg.MaNV

GO

CREATE VIEW v_DanhSachHoaDon AS
SELECT dh.MaDH, dh.NgayMua, kh.SoDienThoai, kh.TenKH, dh.GiaTriDon
FROM DonHang dh 
INNER JOIN ChiTietHoaDon cthd ON dh.MaDH = cthd.MaDH
INNER JOIN NhanVien nv ON dh.MaNV = nv.MaNV
INNER JOIN KhachHang kh ON dh.MaKH = kh.MaKH
WHERE dh.TrangThai = N'Đã thanh toán'

GO 

CREATE VIEW v_SoLuongSanPhamDaBanTheoTungSanPham AS
SELECT sp.MaSP, sp.TenSP, SUM(cthd.SoLuong) SoLuong, SUM(cthd.TongTien) AS TongTien
FROM ChiTietHoaDon cthd
INNER JOIN SanPham sp ON cthd.MaSP = sp.MaSP
GROUP BY sp.MaSP, sp.TenSP

GO

--Proc và Func
CREATE PROCEDURE proc_Them_LoaiSanPham 
    @MaLoaiSP NVARCHAR(50),
    @TenLoaiSP NVARCHAR(50)
AS
BEGIN
    INSERT INTO LoaiSanPham (MaLoaiSP, TenLoaiSP)
    VALUES (@MaLoaiSP, @TenLoaiSP)
END

GO

CREATE PROCEDURE proc_Xoa_LoaiSanPham
    @MaLoaiSP NVARCHAR(50)
AS
BEGIN
    DELETE FROM LoaiSanPham  
    WHERE MaLoaiSP = @MaLoaiSP
END

GO

CREATE PROCEDURE proc_Sua_LoaiSanPham
    @MaLoaiSP NVARCHAR(50),
    @TenLoaiSP NVARCHAR(50)
AS
BEGIN
    UPDATE LoaiSanPham  
	SET TenLoaiSP = @TenLoaiSP
    WHERE MaLoaiSP = @MaLoaiSP
END

GO

CREATE FUNCTION func_TimKiemTheoTen_LoaiSanPham(@TenLoaiSP NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM LoaiSanPham
    WHERE TenLoaiSP LIKE N'%' + @TenLoaiSP + '%'
)

GO

CREATE FUNCTION func_TimKiemTheoSoDienThoai_DonHang(@SoDienThoai NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT MaDH, NgayMua, SoDienThoai, TenKH, GiaTriDon
    FROM v_DanhSachHoaDon 
    WHERE SoDienThoai LIKE N'%' + @SoDienThoai + '%'
)

GO

CREATE PROCEDURE proc_Them_SanPham
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

CREATE PROCEDURE proc_Xoa_SanPham 
	@MaSP NVARCHAR(50)
AS
BEGIN
	DELETE FROM SanPham  
	WHERE MaSP = @MaSP  
END

GO

CREATE PROCEDURE proc_Sua_SanPham
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

CREATE PROCEDURE proc_Them_PhaChe
    	@MaSP NVARCHAR(50),
	@MaNL NVARCHAR(50),
	@SoLuong INT
AS
BEGIN
	INSERT INTO PhaChe(MaSP, MaNL, SoLuong)
	VALUES (@MaSP, @MaNL, @SoLuong)
END

GO

CREATE PROCEDURE proc_Xoa_PhaChe
    @MaSP NVARCHAR(50),
	@MaNL NVARCHAR(50)
AS
BEGIN
	DELETE FROM PhaChe
	WHERE MaSP = @MaSP AND MaNL = @MaNL
END

GO

CREATE FUNCTION func_LoadDanhSachNguyenLieuTheoMaSP(@MaSP NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT nl.MaNL, nl.TenNL, pc.SoLuong, nl.SoLuongTonKho
	FROM NguyenLieu nl
	INNER JOIN PhaChe pc ON nl.MaNL = pc.MaNL
	INNER JOIN SanPham sp ON pc.MaSP = sp.MaSP
    WHERE sp.MaSP = @MaSP 
)

GO

CREATE FUNCTION func_TimKiemTheoTen_SanPham(@TenSP NVARCHAR(50))
RETURNS @KetQua TABLE
(
	MaSP NVARCHAR(50),
	TenSP NVARCHAR(50),
	Gia FLOAT,
	AnhSP NVARCHAR(50)
)
AS 
BEGIN
    INSERT INTO @KetQua
    SELECT MaSP, TenSP, Gia, AnhSP
    FROM SanPham
    WHERE TenSP LIKE N'%' + @TenSP + '%'

	RETURN
END

GO

CREATE PROCEDURE proc_Them_KhachHang 
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

CREATE PROCEDURE proc_Them_DonHang 
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

CREATE PROCEDURE proc_Xoa_KhachHangChuaNhapTen_DonHangChuaThanhToan
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

CREATE PROCEDURE  proc_Them_ChiTietDonHang 
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

CREATE PROCEDURE  proc_CapNhatGiaTriDon_DonHang 
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

CREATE FUNCTION func_TongTien_ChiTietHoaDon 
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

CREATE PROCEDURE  proc_CapNhatSoDiemTichLuy_CapTrangThaiDonHang  
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

CREATE PROCEDURE proc_LoadThongTin_KhachHang
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

CREATE PROCEDURE proc_Sua_KhachHang
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

CREATE FUNCTION func_TimMaDHChuaThanhToan_DonHang 
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

CREATE FUNCTION func_TongDoanhThu_ChiTietHoaDon 
(

)
RETURNS FLOAT  
AS
BEGIN 
    DECLARE @TongDoanhThu FLOAT = 0

	SELECT @TongDoanhThu = SUM(TongTien)
	FROM ChiTietHoaDon

    RETURN @TongDoanhThu 
END;

GO

CREATE FUNCTION func_TongSoLuongSanPham_ChiTietHoaDon 
(

)
RETURNS INT  
AS
BEGIN 
    DECLARE @TongSoLuong INT = 0

	SELECT @TongSoLuong = SUM(SoLuong)
	FROM ChiTietHoaDon

    RETURN @TongSoLuong 
END;

GO
 
CREATE FUNCTION func_TongSoLuongKhachHang_KhachHang
(

)
RETURNS INT  
AS
BEGIN 
    DECLARE @SoLuongKH INT = 0

	SELECT @SoLuongKH = COUNT(MaKH)
	FROM KhachHang

    RETURN @SoLuongKH 
END;

GO











  
-- Trigger
CREATE TRIGGER trg_TuDongTaoMaDH_DonHang
ON DonHang
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @maxMaDH NVARCHAR(50);
    DECLARE @newMaDH NVARCHAR(50);
    DECLARE @numPart INT;

    -- Tìm giá trị maDH lớn nhất hiện có
    SELECT @maxMaDH = MAX(maDH) 
    FROM DonHang
    WHERE maDH LIKE 'DH%';

    -- Lấy phần số từ maDH (bỏ phần 'DH' phía trước) và convert sang kiểu INT
    IF @maxMaDH IS NOT NULL
    BEGIN
        SET @numPart = CAST(SUBSTRING(@maxMaDH, 3, LEN(@maxMaDH) - 2) AS INT) + 1;
    END
    ELSE
    BEGIN
        -- Nếu chưa có maDH nào, bắt đầu từ 1
        SET @numPart = 1;
    END

    -- Tạo giá trị mới cho maDH, với định dạng DHxx (2 số)
    SET @newMaDH = 'DH' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);

    -- Thực hiện chèn bản ghi với maDH mới
    INSERT INTO DonHang (MaDH, MaKH, MaNV, NgayMua, GiaTriDon, TrangThai)
    SELECT @newMaDH, MaKH, MaNV, NgayMua, GiaTriDon, TrangThai
    FROM inserted;
END;

GO

CREATE TRIGGER trg_Them_ChiTietHoaDon
ON ChiTietHoaDon
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @maDH NVARCHAR(50);
    DECLARE @maSP NVARCHAR(50);
    DECLARE @soLuong INT;

    -- Lấy giá trị từ bảng inserted
    SELECT @maDH = MaDH, @maSP = MaSP
    FROM inserted;

    -- Kiểm tra xem bản ghi đã tồn tại chưa
    IF EXISTS (SELECT 1 FROM ChiTietHoaDon WHERE MaDH = @maDH AND MaSP = @maSP)
    BEGIN
        -- Nếu đã tồn tại, tăng số lượng lên 1 
        UPDATE ChiTietHoaDon
        SET SoLuong = SoLuong + 1
        WHERE MaDH = @maDH AND MaSP = @maSP;

	-- Cập nhật tổng tiền
	SELECT @soLuong = SoLuong
	FROM ChiTietHoaDon
	WHERE MaDH = @maDH AND MaSP = @maSP;

	UPDATE ChiTietHoaDon
	SET TongTien = (SELECT Gia*@soLuong FROM SanPham WHERE MaSP = @maSP)
	WHERE MaDH = @maDH AND MaSP = @maSP;
    END
    ELSE
    BEGIN
        -- Nếu chưa tồn tại, chèn bản ghi mới
        INSERT INTO ChiTietHoaDon (MaDH, MaSP, SoLuong, TongTien)
        VALUES (@maDH, @maSP, 1, (SELECT Gia*1 FROM SanPham WHERE MaSP = @maSP));  
    END
END;

GO

CREATE TRIGGER trg_TuDongTaoMaLoaiSanPham_LoaiSanPham
ON LoaiSanPham
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @maxMaLoaiSP NVARCHAR(50);
    DECLARE @newMaLoaiSP NVARCHAR(50);
    DECLARE @numPart INT;

    -- Tìm giá trị maLoaiSP lớn nhất hiện có
    SELECT @maxMaLoaiSP = MAX(MaLoaiSP) 
    FROM LoaiSanPham
    WHERE MaLoaiSP LIKE 'LSP%';

    -- Lấy phần số từ maLoaiSP (bỏ phần 'LSP' phía trước) và convert sang kiểu INT
    IF @maxMaLoaiSP IS NOT NULL
    BEGIN
        SET @numPart = CAST(SUBSTRING(@maxMaLoaiSP, 4, LEN(@maxMaLoaiSP) - 2) AS INT)+1;
    END
    ELSE
    BEGIN
        -- Nếu chưa có maSP nào, bắt đầu từ 1
        SET @numPart = 1;
    END

    -- Tạo giá trị mới cho maLoaiSP, với định dạng LSPxx (2 số)
    SET @newMaLoaiSP = 'LSP' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);

    -- Thực hiện chèn bản ghi với maLoaiSP mới
    INSERT INTO LoaiSanPham(MaLoaiSP, TenLoaiSP)
    SELECT @newMaLoaiSP, TenLoaiSP
    FROM inserted;
END;

GO
CREATE TRIGGER trg_TuDongTacMaSP_SanPham
ON SanPham
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @maxMaSP NVARCHAR(50);
    DECLARE @newMaSP NVARCHAR(50);
    DECLARE @numPart INT;

    -- Tìm giá trị MaSP lớn nhất hiện có
    SELECT @maxMaSP = MAX(MaSP)
    FROM SanPham
    WHERE MaSP LIKE 'SP%';

    -- Lấy phần số từ MaSP (bỏ phần 'SP' phía trước) và chuyển sang kiểu INT
    IF @maxMaSP IS NOT NULL
    BEGIN
        SET @numPart = CAST(SUBSTRING(@maxMaSP, 3, LEN(@maxMaSP) - 2) AS INT) + 1;
    END
    ELSE
    BEGIN
        -- Nếu chưa có MaSP nào, bắt đầu từ 1
        SET @numPart = 1;
    END

    -- Tạo mã sản phẩm mới
    SET @newMaSP = 'SP' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);

    -- Chèn bản ghi mới vào bảng SanPham với mã sản phẩm mới
    INSERT INTO SanPham (MaSP, TenSP, Gia, AnhSP, MaLoaiSP)
    SELECT @newMaSP, TenSP, Gia, AnhSP, MaLoaiSP
    FROM inserted;  -- Bảng tạm chứa các bản ghi được chèn

END;



--   ROLLBACK TRANSACTION

--   COMMIT TRANSACTION
