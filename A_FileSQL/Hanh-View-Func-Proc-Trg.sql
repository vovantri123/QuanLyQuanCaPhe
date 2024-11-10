USE QuanLyQuanCaPhe

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

    -- Đếm số lượng nhân viên với TenDangNhap và MatKhau khớp
    SELECT @Count = COUNT(*) 
    FROM NhanVien 
    WHERE TenDangNhap = @TenDangNhap AND MatKhau = @MatKhau;

    -- Trả về kết quả đếm
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






CREATE TRIGGER trg_TuDongTaoMaNL_NguyenLieu
ON NguyenLieu
INSTEAD OF INSERT
AS
BEGIN 
	BEGIN TRY
		DECLARE @maxMaNL NVARCHAR(50);
		DECLARE @newMaNL NVARCHAR(50);
		DECLARE @numPart INT;

		-- Tìm giá trị maNL lớn nhất hiện có
		SELECT @maxMaNL = MAX(maNL) 
		FROM NguyenLieu
		WHERE maNL LIKE 'NL%';

		-- Lấy phần số từ maNL (bỏ phần 'NL' phía trước) và convert sang kiểu INT
		IF @maxMaNL IS NOT NULL
		BEGIN
			SET @numPart = CAST(SUBSTRING(@maxMaNL, 3, LEN(@maxMaNL) - 2) AS INT) + 1;
		END
		ELSE
		BEGIN
			-- Nếu chưa có maNL nào, bắt đầu từ 1
			SET @numPart = 1;
		END

		-- Tạo giá trị mới cho maNL, với định dạng NLxx (2 số)
		SET @newMaNL = 'NL' + RIGHT('00' + CAST(@numPart AS NVARCHAR), 2);

		-- Thực hiện chèn bản ghi với maNL mới
		INSERT INTO NguyenLieu(MaNL, TenNL, SoLuongTonKho)
		SELECT @newMaNL, TenNL, SoLuongTonKho
		FROM inserted;
		 
	END TRY
	BEGIN CATCH 
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
        RAISERROR (@ErrorMessage, 16, 1);
	END CATCH
END;

