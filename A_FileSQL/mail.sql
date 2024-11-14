EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Database Mail XPs', 1;
RECONFIGURE;
EXEC sp_configure 'Agent XPs', 1;
GO

EXEC msdb.dbo.sysmail_add_profile_sp
    @profile_name = 'MailProfile', 
    @description = 'Profile to send emails';

EXEC msdb.dbo.sysmail_add_account_sp
    @account_name = 'GmailAccount1',
    @description = 'Gmail account for sending emails',
    @email_address = 'anhkhoadevtool21@gmail.com', --- đổi
    @display_name = 'AnhKhoa',
    @mailserver_name = 'smtp.gmail.com',
    @port = 587,
    @username = 'anhkhoadevtool21@gmail.com',--- đổi
    @password = 'igdp hkyt ahrb ozkn',--- đổi
	@enable_ssl = 1;  -- Đảm bảo bật SSL để sử dụng STARTTLS

EXEC msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'MailProfile',
    @account_name = 'GmailAccount1',
    @sequence_number = 1;  -- Chỉ định thứ tự của tài khoản nếu có nhiều tài khoản

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'MailProfile',  -- Thay thế bằng tên profile của bạn
    @recipients = 'anhkhoaxn11@gmail.com',  -- Địa chỉ email nhận
    @subject = 'Test Email',
    @body = N'Đây là email thử nghiệm từ SQL Server Database Mail. Do Khoa gửi',
    @body_format = 'TEXT';  -- Hoặc bạn có thể sử dụng 'HTML' nếu muốn email có định dạng HTML

SELECT * 
FROM msdb.dbo.sysmail_allitems
ORDER BY send_request_date DESC;


SELECT * 
FROM msdb.dbo.sysmail_event_log 
ORDER BY log_date DESC;
