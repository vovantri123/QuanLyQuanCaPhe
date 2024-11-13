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

 
