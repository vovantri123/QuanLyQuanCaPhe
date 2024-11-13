USE QuanLyQuanCaPhe

GO

-----------------------------------------------------------------View--------------------------------------------------------------------

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
INNER JOIN ThanhToan tt ON dh.MaDH = tt.MaDH
INNER JOIN NhanVien nv ON tt.MaNV = nv.MaNV
INNER JOIN KhachHang kh ON tt.MaKH = kh.MaKH
WHERE dh.TrangThai = N'Đã thanh toán'

GO 

CREATE VIEW v_SoLuongSanPhamDaBanTheoTungSanPham AS
SELECT sp.MaSP, sp.TenSP, SUM(cthd.SoLuong) SoLuong, SUM(cthd.TongTien) AS TongTien
FROM ChiTietHoaDon cthd
INNER JOIN SanPham sp ON cthd.MaSP = sp.MaSP
GROUP BY sp.MaSP, sp.TenSP

GO

----------------------------------------------------------------Proc và Func--------------------------------------------------------------
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

CREATE FUNCTION func_LayMaDHChuaThanhToan_DonHang()
RETURNS NVARCHAR(50)
AS
BEGIN 
	DECLARE @MaDH NVARCHAR(50)

    SELECT @MaDH = MaDH
    FROM DonHang
    WHERE TrangThai = N'Chưa thanh toán';

    RETURN @MaDH;
END;

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
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @maxMaKH NVARCHAR(50);
		DECLARE @newMaKH NVARCHAR(50);
		DECLARE @numPart INT;
 
		IF EXISTS (SELECT 1 FROM KhachHang WHERE SoDienThoai = @SoDienThoai)
		BEGIN
			COMMIT TRANSACTION -- Bắt buột commit hoặc rollback trước khi return
			RETURN;
		END
		  
		SELECT @maxMaKH = MAX(MaKH) 
		FROM KhachHang
		WHERE MaKH LIKE 'KH%';
		 
		IF @maxMaKH IS NOT NULL
		BEGIN
			SET @numPart = CAST(SUBSTRING(@maxMaKH, 3, LEN(@maxMaKH) - 2) AS INT) + 1;
		END
		ELSE
		BEGIN 
			SET @numPart = 1;
		END

		-- Tạo giá trị mới cho MaKH, với định dạng KHxx (2 số)
		SET @newMaKH = 'KH' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);
		 
		INSERT INTO KhachHang(MaKH, TenKH, SoDienThoai, SoDiemTichLuy)
		VALUES(@newMaKH, N'Chưa nhập tên', @SoDienThoai, 0)

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION; 
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
		RAISERROR (@ErrorMessage, 16, 1);
	END CATCH

	
END

GO

CREATE PROCEDURE proc_Them_DonHang 
	@SoDienThoai NVARCHAR(50),
	@MaNV NVARCHAR(50)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @MaKH NVARCHAR(50); 

		DECLARE @maxMaDH NVARCHAR(50);
		DECLARE @newMaDH NVARCHAR(50);
		DECLARE @numPart INT;
	  

		SELECT @MaKH = MaKH
		FROM KhachHang
		WHERE SoDienThoai = @SoDienThoai
	  
		SELECT @maxMaDH = MAX(maDH) 
		FROM DonHang
		WHERE maDH LIKE 'DH%';
		 
		IF @maxMaDH IS NOT NULL
		BEGIN
			SET @numPart = CAST(SUBSTRING(@maxMaDH, 3, LEN(@maxMaDH) - 2) AS INT) + 1;
		END
		ELSE
		BEGIN 
			SET @numPart = 1;
		END

		-- Tạo giá trị mới cho maDH, với định dạng DHxx (2 số)
		SET @newMaDH = 'DH' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);
	 
		INSERT INTO DonHang(MaDH, NgayMua, GiaTriDon, TrangThai)
		VALUES (@newMaDH, GETDATE(), 1, N'Chưa thanh toán') 
	  
		INSERT INTO ThanhToan(MaDH, MaNV, MaKH)
		VALUES (@newMaDH, @MaNV, @MaKH)

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END

GO

CREATE PROCEDURE proc_Xoa_KhachHangChuaNhapTen_DonHangChuaThanhToan
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @MaDH NVARCHAR(50),
				@MaNV NVARCHAR(50),
				@MaKH NVARCHAR(50),
				@DonHangCount INT;
	 
		SELECT @MaDH = dh.MaDH, @MaKH = kh.MaKH, @MaNV = nv.MaNV
		FROM DonHang dh
		INNER JOIN ThanhToan tt ON dh.MaDH = tt.MaDH
		INNER JOIN NhanVien nv ON tt.MaNV = nv.MaNV
		INNER JOIN KhachHang kh ON tt.MaKH = kh.MaKH
		WHERE TrangThai =  N'Chưa thanh toán'

		-- Đếm số đơn hàng còn lại của khách hàng trong bảng DonHang
		SELECT @DonHangCount = COUNT(*)
		FROM DonHang dh
		INNER JOIN ThanhToan tt ON dh.MaDH = tt.MaDH
		INNER JOIN KhachHang kh ON tt.MaKH = kh.MaKH
		WHERE kh.MaKH = @MaKH; 

		DELETE FROM ThanhToan
		WHERE MaDH = @MaDH AND MaNV = @MaNV AND MaKH = @MaKH  
	 
		DELETE FROM ChiTietHoaDon
		WHERE MaDH = @MaDH
	 
		DELETE FROM DonHang 
		WHERE TrangThai = N'Chưa thanh toán'
	 
		--Nếu KH chỉ có 1 đơn (đơn chưa thanh toán) hoặc 0 có đơn nào thì mới được xóa
		IF @DonHangCount <= 1
		BEGIN
			DELETE FROM KhachHang
			WHERE MaKH = @MaKH;
		END

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END


GO

CREATE PROCEDURE  proc_Them_ChiTietDonHang 
	@MaSP NVARCHAR(50)
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @MaDH NVARCHAR(50) 

		SELECT @MaDH = MaDH 
		FROM DonHang
		WHERE TrangThai =  N'Chưa thanh toán'
	
		INSERT INTO ChiTietHoaDon(MaDH, MaSP, SoLuong, TongTien)
		VALUES (@MaDH, @MaSP, 1, (SELECT Gia*1 FROM SanPham WHERE MaSP = @maSP))

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END

GO

CREATE PROCEDURE  proc_CapNhatGiaTriDon_DonHang 
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @MaDH NVARCHAR(50) 

		SELECT @MaDH = MaDH 
		FROM DonHang
		WHERE TrangThai =  N'Chưa thanh toán'
	
		UPDATE DonHang 
		SET GiaTriDon = (SELECT SUM(TongTien) FROM ChiTietHoaDon WHERE MaDH = @MaDH)
		WHERE TrangThai =  N'Chưa thanh toán'  

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
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
	 
	SELECT @Tong = SUM(TongTien)
	FROM ChiTietHoaDon
	WHERE MaDH = @MaDH

	RETURN @Tong  
END;

GO

CREATE PROCEDURE  proc_XacNhanThanhToan_DonHangVaKhachHang
AS
BEGIN  
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @GiaTriDon FLOAT
		DECLARE @SoDiemTichLuy FLOAT 
		DECLARE @MaKH NVARCHAR(50)

		DECLARE @maDHChuaThanhToan NVARCHAR(50)

		SELECT @maDHChuaThanhToan = MaDH 
		FROM DonHang
		WHERE TrangThai =  N'Chưa thanh toán' 

		SELECT @GiaTriDon = dh.GiaTriDon, @MaKH = kh.MaKH
		FROM DonHang dh
		INNER JOIN ThanhToan tt ON dh.MaDH = tt.MaDH
		INNER JOIN KhachHang kh ON tt.MaKH = kh.MaKH
		WHERE dh.MaDH = @maDHChuaThanhToan

		SELECT @SoDiemTichLuy = SoDiemTichLuy 
		FROM KhachHang
		WHERE MaKH = @MaKH
    
		IF @GiaTriDon > @SoDiemTichLuy
		BEGIN
			SET @GiaTriDon = @GiaTriDon - @SoDiemTichLuy
			SET @SoDiemTichLuy = 0 + 0.01 * @GiaTriDon  -- Đã dùng hết điểm tích lũy
		END
		ELSE
		BEGIN 
			SET @SoDiemTichLuy = (@SoDiemTichLuy - @GiaTriDon) + 0.01 * @GiaTriDon  
			SET @GiaTriDon = 0 -- Đơn đã được thanh toán hết
		END
		 

		UPDATE DonHang 
		SET GiaTriDon = @GiaTriDon
		WHERE MaDH = @maDHChuaThanhToan; 
	 
		UPDATE KhachHang 
		SET SoDiemTichLuy = @SoDiemTichLuy
		WHERE MaKH =  @MaKH  
	 
		UPDATE DonHang 
		SET TrangThai = N'Đã thanh toán'  
		WHERE MaDH =  @maDHChuaThanhToan
	 
		UPDATE nl
		SET nl.SoLuongTonKho = nl.SoLuongTonKho - (cthd.SoLuong * pc.SoLuong)
		FROM ChiTietHoaDon cthd
		LEFT OUTER JOIN PhaChe pc ON cthd.MaSP = pc.MaSP
		LEFT OUTER JOIN NguyenLieu nl ON pc.MaNL = nl.maNL
		WHERE cthd.MaDH = @maDHChuaThanhToan AND pc.SoLuong IS NOT NULL;
		
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
	 
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

GO

CREATE FUNCTION func_KiemTraDangNhap_NhanVien
(
    @TenDangNhap NVARCHAR(50), 
    @MatKhau NVARCHAR(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
	 
    SELECT @Count = COUNT(*) 
    FROM NhanVien 
    WHERE TenDangNhap = @TenDangNhap AND MatKhau = @MatKhau;
	 
    RETURN @Count;
END

GO

CREATE FUNCTION func_LayMatKhau_NhanVien
(
	@TenDangNhap NVARCHAR(50),
    @SoDienThoai NVARCHAR(50)
)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @MatKhau NVARCHAR(50);
	 
    SELECT @MatKhau = MatKhau
    FROM NhanVien
    WHERE TenDangNhap = @TenDangNhap AND SoDienThoai = @SoDienThoai;
	 
    RETURN @MatKhau;
END

GO

CREATE PROCEDURE proc_Them_NguyenLieu 
    @MaNL NVARCHAR(50),
    @TenNL NVARCHAR(50),
	@SoLuongTonKho INT
AS
BEGIN
    INSERT INTO NguyenLieu(MaNL, TenNL, SoLuongTonKho)
    VALUES (@MaNL, @TenNL, @SoLuongTonKho)
END

GO

CREATE PROCEDURE proc_Xoa_NguyenLieu 
    @MaNL NVARCHAR(50)
AS
BEGIN
    DELETE FROM NguyenLieu  
    WHERE MaNL = @MaNL
END

GO

CREATE PROCEDURE proc_Sua_NguyenLieu 
    @MaNL NVARCHAR(50),
    @TenNL NVARCHAR(50),
	@SoLuongTonKho INT
AS
BEGIN
    UPDATE NguyenLieu  
	SET TenNL = @TenNL,
		SoLuongTonKho = @SoLuongTonKho
    WHERE MaNL = @MaNL
END

GO

CREATE FUNCTION func_TimKiemTheoTen_NguyenLieu
(
	@TenNguyenLieu NVARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM NguyenLieu
    WHERE TenNL LIKE N'%' + @TenNguyenLieu + '%'
)

GO 
 
   



-----------------------------------------------------------Trigger-------------------------------------------------------------------
 
CREATE TRIGGER trg_TuDongTaoMaNL_NguyenLieu
ON NguyenLieu
INSTEAD OF INSERT
AS
BEGIN 
	BEGIN TRY
		DECLARE @maxMaNL NVARCHAR(50);
		DECLARE @newMaNL NVARCHAR(50);
		DECLARE @numPart INT;
		 
		SELECT @maxMaNL = MAX(maNL) 
		FROM NguyenLieu
		WHERE maNL LIKE 'NL%';
		 
		IF @maxMaNL IS NOT NULL
		BEGIN
			SET @numPart = CAST(SUBSTRING(@maxMaNL, 3, LEN(@maxMaNL) - 2) AS INT) + 1;
		END
		ELSE
		BEGIN 
			SET @numPart = 1;
		END

		-- Tạo giá trị mới cho maNL, với định dạng NLxx (2 số)
		SET @newMaNL = 'NL' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);
		 
		INSERT INTO NguyenLieu(MaNL, TenNL, SoLuongTonKho)
		SELECT @newMaNL, TenNL, SoLuongTonKho
		FROM inserted;
		 
	END TRY
	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END;

GO
  
CREATE TRIGGER trg_TuDongTaoMaLoaiSanPham_LoaiSanPham
ON LoaiSanPham
INSTEAD OF INSERT
AS
BEGIN 
	BEGIN TRY

		DECLARE @maxMaLoaiSP NVARCHAR(50);
		DECLARE @newMaLoaiSP NVARCHAR(50);
		DECLARE @numPart INT;
		 
		SELECT @maxMaLoaiSP = MAX(MaLoaiSP) 
		FROM LoaiSanPham
		WHERE MaLoaiSP LIKE 'LSP%';
		 
		IF @maxMaLoaiSP IS NOT NULL
		BEGIN
			SET @numPart = CAST(SUBSTRING(@maxMaLoaiSP, 4, LEN(@maxMaLoaiSP) - 2) AS INT)+1;
		END
		ELSE
		BEGIN 
			SET @numPart = 1;
		END

		-- Tạo giá trị mới cho maLoaiSP, với định dạng LSPxx (2 số)
		SET @newMaLoaiSP = 'LSP' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);
		 
		INSERT INTO LoaiSanPham(MaLoaiSP, TenLoaiSP)
		SELECT @newMaLoaiSP, TenLoaiSP
		FROM inserted; 
	END TRY
	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END;

GO

CREATE TRIGGER trg_TuDongTaoMaSP_SanPham
ON SanPham
INSTEAD OF INSERT
AS
BEGIN 
	BEGIN TRY

		DECLARE @maxMaSP NVARCHAR(50);
		DECLARE @newMaSP NVARCHAR(50);
		DECLARE @numPart INT;
		 
		SELECT @maxMaSP = MAX(MaSP)
		FROM SanPham
		WHERE MaSP LIKE 'SP%';
		 
		IF @maxMaSP IS NOT NULL
		BEGIN
			SET @numPart = CAST(SUBSTRING(@maxMaSP, 3, LEN(@maxMaSP) - 2) AS INT) + 1;
		END
		ELSE
		BEGIN 
			SET @numPart = 1;
		END

		-- Tạo giá trị mới cho maSP, với định dạng SPxx (2 số)
		SET @newMaSP = 'SP' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);
		 
		INSERT INTO SanPham (MaSP, TenSP, Gia, AnhSP, MaLoaiSP)
		SELECT @newMaSP, TenSP, Gia, AnhSP, MaLoaiSP
		FROM inserted;   
	END TRY
	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        RAISERROR (@ErrorMessage, 16, 1);
	END CATCH

END;

GO
 

CREATE TRIGGER trg_KiemTraSoLuongTruocKhiThem_ChiTietHoaDon
ON ChiTietHoaDon
INSTEAD OF INSERT
AS
BEGIN 
	BEGIN TRY
		DECLARE @maDH NVARCHAR(50);
		DECLARE @maSP NVARCHAR(50);
		DECLARE @soLuong INT;
		DECLARE @soLuongTonKho INT; 
		DECLARE @tongNL INT;
		DECLARE @TenNL NVARCHAR(50);
		  
		SELECT @maDH = MaDH, @maSP = MaSP
		FROM inserted;

		-- Kiểm tra sản phẩm đã tồn tại chưa 
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
			SET TongTien = (SELECT Gia * @soLuong FROM SanPham WHERE MaSP = @maSP)
			WHERE MaDH = @maDH AND MaSP = @maSP;
		END
		ELSE
		BEGIN
			-- Nếu chưa tồn tại thì thêm sản phẩm mới
			INSERT INTO ChiTietHoaDon (MaDH, MaSP, SoLuong, TongTien)
			VALUES (@maDH, @maSP, 1, (SELECT Gia * 1 FROM SanPham WHERE MaSP = @maSP));  
		END

		-- Kiểm tra số lượng nguyên liệu tồn kho sau khi insert (hoặc update)
		-- Tạo con trỏ để duyệt qua các dòng trả về từ truy vấn
		DECLARE cur CURSOR FOR 
		SELECT cthd.SoLuong * pc.SoLuong AS TongNL, nl.SoLuongTonKho AS SoLuongTonKho, nl.TenNL AS TenNL
		FROM ChiTietHoaDon cthd
		LEFT OUTER JOIN PhaChe pc ON cthd.MaSP = pc.MaSP
		LEFT OUTER JOIN NguyenLieu nl ON pc.MaNL = nl.maNL
		WHERE MaDH = @maDH AND pc.SoLuong IS NOT NULL;

		OPEN cur;
		FETCH NEXT FROM cur INTO @tongNL, @soLuongTonKho, @TenNL;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Kiểm tra nếu tổng nguyên liệu cần lớn hơn số lượng tồn kho
			IF @tongNL > @soLuongTonKho
			BEGIN 
				CLOSE cur;
				DEALLOCATE cur; 
				RAISERROR(N'%s không đủ để pha chế', 16, 1, @TenNL); --Khi RAISERROR thì SQL server sẽ tự động rollback trigger  
			END;

			FETCH NEXT FROM cur INTO @tongNL, @soLuongTonKho, @TenNL;
		END;

		CLOSE cur;
		DEALLOCATE cur; 
		 
	END TRY
	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END;

 
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
    DECLARE @Luong FLOAT;
    DECLARE @LuongCoDinh FLOAT;
    DECLARE @LuongTheoGio FLOAT;
    DECLARE @SoGio INT;
    DECLARE @TongGiaTriDon FLOAT;
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
		SET @TongGiaTriDon = ISNULL(@TongGiaTriDon, 0);
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

/*
SELECT * 
FROM msdb.dbo.sysmail_event_log 
ORDER BY log_date DESC;
*/


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

USE QuanLyQuanCaPhe

GO

----------------------------------------------------------------Proc và Func--------------------------------------------------------------

CREATE PROCEDURE Proc_TimNguoiThucHienCa 
    @shiftCa NVARCHAR(50),
    @currentDate NVARCHAR(10)  
AS
BEGIN
    SELECT HoTenNV 
	FROM CaLamViec CLV
	JOIN ThucHien TH ON CLV.MaCa = TH.MaCa
	JOIN NhanVien NV ON TH.MaNV = NV.MaNV
    WHERE TenCa = @shiftCa 
      AND CONVERT(NVARCHAR, Ngay, 23) = @currentDate;  
END

GO
 
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

GO
 
CREATE PROCEDURE Proc_ThemKhoaChinhThucHien_ThucHien
    @MaCa NVARCHAR(50),
    @MaNV NVARCHAR(50),
    @MaCV NVARCHAR(50)
AS
BEGIN
    INSERT INTO ThucHien (MaCa, MaNV, MaCV)
    VALUES (@MaCa, @MaNV, @MaCV);
END

GO
 
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

GO
 
CREATE PROCEDURE Proc_XoaKhachHang_KhachHang
    @MaKH NVARCHAR(50)
AS
BEGIN
    DELETE FROM KhachHang  
    WHERE MaKH = @MaKH;
END

GO

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

GO

CREATE FUNCTION Func_TimKiemTheoSoDienThoai_KhachHang(@SoDienThoai NVARCHAR(10))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM KhachHang
    WHERE SoDienThoai LIKE '%' + @SoDienThoai + '%'
);

GO

CREATE TRIGGER trg_TuDongTaoMaKH_KhachHang
ON KhachHang
INSTEAD OF INSERT
AS
BEGIN 
	BEGIN TRY
		DECLARE @maxMaKH NVARCHAR(50);
		DECLARE @newMaKH NVARCHAR(50);
		DECLARE @numPart INT;
		 
		SELECT @maxMaKH = MAX(MaKH)
		FROM KhachHang
		WHERE MaKH LIKE 'KH%';
		 
		IF @maxMaKH IS NOT NULL
		BEGIN
			SET @numPart = CAST(SUBSTRING(@maxMaKH, 3, LEN(@maxMaKH) - 2) AS INT) + 1;
		END
		ELSE
		BEGIN 
			SET @numPart = 1;
		END

		-- Tạo giá trị mới cho maKH, với định dạng KHxx (2 số)
		SET @newMaKH = 'KH' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);
		 
		INSERT INTO KhachHang (MaKH, TenKH, SoDienThoai, SoDiemTichLuy)
		SELECT @newMaKH, TenKH, SoDienThoai, SoDiemTichLuy
		FROM inserted;   
		 
	END TRY
	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END;

GO 

CREATE FUNCTION func_LayMaCaMoiDeDangKy_CaLamViec()
RETURNS NVARCHAR(50)
AS
BEGIN   
	DECLARE @maxMaCa NVARCHAR(50);
	DECLARE @newMaCa NVARCHAR(50);
	DECLARE @numPart INT;
	 
    SELECT @maxMaCa = MAX(MaCa) 
    FROM CaLamViec
    WHERE MaCa LIKE 'CA%';
	 
    IF @maxMaCa IS NOT NULL
    BEGIN
        SET @numPart = CAST(SUBSTRING(@maxMaCa, 3, LEN(@maxMaCa) - 2) AS INT) + 1;
    END
    ELSE
    BEGIN 
        SET @numPart = 1;
    END

    -- Tạo giá trị mới cho MaCa, với định dạng CAxx (2 số)
    SET @newMaCa = 'CA' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);

    RETURN @newMaCa;  
END;

GO

---------------------------------------------------------Trigger-----------------------------------------------------------------

CREATE TRIGGER Trg_LuatPhanCa_PhanCa
ON ThucHien
AFTER INSERT
AS
BEGIN 
	BEGIN TRY
		DECLARE @MaNV nvarchar(50), @Ngay DATE, @MaCa nvarchar(50), @TenCa nvarchar(50);

		-- Lấy thông tin nhân viên và ca làm việc mới thêm vào
		SELECT @MaNV = MaNV, @MaCa = MaCa FROM inserted;
    
		-- Lấy ngày làm việc từ bảng CaLamViec dựa trên MaCa
		SELECT @Ngay = Ngay, @TenCa = TenCa FROM CaLamViec WHERE MaCa = @MaCa;

		-- Nhân viên không  được làm quá 2 ca trong cùng 1 ngày
		IF (SELECT COUNT(*) 
			FROM ThucHien TH 
			JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
			WHERE TH.MaNV = @MaNV AND CLV.Ngay = @Ngay) > 2
		BEGIN
			RAISERROR (N'Nhân viên này không được làm quá 2 ca trong 1 ngày. Vui lòng kiểm tra lại.', 16, 1); 
		END

		-- Kiểm tra nhân viên không được làm trùng ca làm việc (tức ca đó nhân viên đã làm rồi mà lại đăng kí nữa)
		IF (SELECT COUNT(*) 
			FROM ThucHien TH
			JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
			WHERE MaNV = @MaNV AND TenCa = @TenCa AND Ngay = @Ngay) > 1
		BEGIN
			RAISERROR (N'Ca làm việc bị trùng lặp cho nhân viên này trong ngày. Vui lòng kiểm tra lại.', 16, 1); 
		END

		-- Làm fulltimeAM thì ko làm ca khác ngoại trừ ca Tối
		IF (@TenCa = N'Sáng'  OR @TenCa = N'FulltimePM')  
		BEGIN
			
			IF (EXISTS (SELECT 1 FROM ThucHien TH
						JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
						WHERE TH.MaNV = @MaNV 
						AND CLV.TenCa = N'FulltimeAM' -- Kiểm tra nếu nhân viên đã làm FulltimeAM trong cùng ngày
						AND CLV.Ngay = @Ngay))
			BEGIN
				RAISERROR (N'Nhân viên đã làm FulltimeAM, không được làm ca Sáng, Chiều và FulltimePM .', 16, 1);  
			END
		END

		-- Làm fulltimePM thì ko làm ca khác ngoại trừ ca Sáng
		ELSE IF ( @TenCa = N'Tối' OR @TenCa = N'FulltimeAM')
		BEGIN
			IF (EXISTS (SELECT 1 FROM ThucHien TH
						JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
						WHERE TH.MaNV = @MaNV 
						AND CLV.TenCa = N'FulltimePM' 
						AND CLV.Ngay = @Ngay))
			BEGIN
				RAISERROR (N'Nhân viên đã làm FulltimePM, không được làm ca Chiều, Tối và FulltimeAM.', 16, 1);  
			END
		END

		--Làm FulltimeAM or FulltimePM thì không đk ca Chiều (do ca Chiều là giao thoa nên không để chung với 2 ĐK trên)
		ELSE IF (@TenCa = N'Chiều' )  
		BEGIN
			IF (EXISTS (SELECT 1 FROM ThucHien TH
						JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
						WHERE TH.MaNV = @MaNV 
						AND (CLV.TenCa = N'FulltimeAM' OR CLV.TenCa = N'FulltimePM')  
						AND CLV.Ngay = @Ngay))
			BEGIN
				RAISERROR (N'Nhân viên đã làm FulltimeAM hoặc FulltimePM , không được làm ca Chiều .', 16, 1);  
			END
		END
		-------------------------------------
		--Làm Sáng hoặc Chiều thì ko làm fulltimeAM nữa 
	    IF (@TenCa = N'FulltimeAM' )  
		BEGIN
			IF (EXISTS (SELECT 1 FROM ThucHien TH
						JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
						WHERE TH.MaNV = @MaNV 
						AND (CLV.TenCa = N'Sáng' OR CLV.TenCa = N'Chiều')  
						AND CLV.Ngay = @Ngay))
			BEGIN
				RAISERROR (N'Nhân viên đã làm ca Sáng hoặc Chiều không thể đăng ki ca FulltimeAM .', 16, 1);  
			END
		END
				
		--Làm Tối hoặc Chiều thì ko làm fulltimePM nữa 
		IF (@TenCa = N'FulltimePM' )  
		BEGIN
			IF (EXISTS (SELECT 1 FROM ThucHien TH
						JOIN CaLamViec CLV ON TH.MaCa = CLV.MaCa
						WHERE TH.MaNV = @MaNV 
						AND (CLV.TenCa = N'Chiều' OR CLV.TenCa = N'Tối')  
						AND CLV.Ngay = @Ngay))
			BEGIN
				RAISERROR (N'Nhân viên đã làm ca Chiều hoặc Tối không thể đăng ki ca FulltimePM .', 16, 1);  
			END
		END
		 
	END TRY
	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END;



 



