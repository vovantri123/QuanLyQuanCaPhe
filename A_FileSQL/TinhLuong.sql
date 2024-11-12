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

SELECT * 
FROM msdb.dbo.sysmail_event_log 
ORDER BY log_date DESC;