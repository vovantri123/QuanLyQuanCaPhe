namespace QuanLyQuanCaPhe.Views
{
    partial class fQLPhanCa
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnDangKi = new Guna.UI2.WinForms.Guna2Button();
            this.cbbChonca = new Guna.UI2.WinForms.Guna2ComboBox();
            this.txtMaCa = new Guna.UI2.WinForms.Guna2TextBox();
            this.txtHoTen = new Guna.UI2.WinForms.Guna2TextBox();
            this.dtpkNgayLam = new Guna.UI2.WinForms.Guna2DateTimePicker();
            this.flpNgay = new System.Windows.Forms.FlowLayoutPanel();
            this.btnChieu = new Guna.UI2.WinForms.Guna2Button();
            this.btnToi = new Guna.UI2.WinForms.Guna2Button();
            this.guna2Button1 = new Guna.UI2.WinForms.Guna2Button();
            this.btnSang = new Guna.UI2.WinForms.Guna2Button();
            this.flpCa = new System.Windows.Forms.FlowLayoutPanel();
            this.txtMaNV = new Guna.UI2.WinForms.Guna2TextBox();
            this.cbbCongViec = new Guna.UI2.WinForms.Guna2ComboBox();
            this.guna2TextBox1 = new Guna.UI2.WinForms.Guna2TextBox();
            this.guna2Button2 = new Guna.UI2.WinForms.Guna2Button();
            this.guna2Shapes1 = new Guna.UI2.WinForms.Guna2Shapes();
            this.SuspendLayout();
            // 
            // btnDangKi
            // 
            this.btnDangKi.BorderColor = System.Drawing.Color.Gainsboro;
            this.btnDangKi.BorderRadius = 20;
            this.btnDangKi.BorderThickness = 3;
            this.btnDangKi.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnDangKi.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnDangKi.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnDangKi.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnDangKi.FillColor = System.Drawing.Color.Tan;
            this.btnDangKi.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnDangKi.ForeColor = System.Drawing.Color.White;
            this.btnDangKi.Location = new System.Drawing.Point(1382, 810);
            this.btnDangKi.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnDangKi.Name = "btnDangKi";
            this.btnDangKi.Size = new System.Drawing.Size(204, 59);
            this.btnDangKi.TabIndex = 28;
            this.btnDangKi.Text = "Đăng Kí";
            this.btnDangKi.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAlias;
            this.btnDangKi.TextTransform = Guna.UI2.WinForms.Enums.TextTransform.UpperCase;
            this.btnDangKi.Tile = true;
            this.btnDangKi.Click += new System.EventHandler(this.btnDangKi_Click);
            // 
            // cbbChonca
            // 
            this.cbbChonca.AutoRoundedCorners = true;
            this.cbbChonca.BackColor = System.Drawing.Color.Transparent;
            this.cbbChonca.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(192)))), ((int)(((byte)(0)))));
            this.cbbChonca.BorderRadius = 17;
            this.cbbChonca.BorderStyle = System.Drawing.Drawing2D.DashStyle.DashDot;
            this.cbbChonca.BorderThickness = 5;
            this.cbbChonca.DrawMode = System.Windows.Forms.DrawMode.OwnerDrawFixed;
            this.cbbChonca.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbbChonca.FocusedColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.cbbChonca.FocusedState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.cbbChonca.Font = new System.Drawing.Font("Segoe UI Semibold", 10.2F, System.Drawing.FontStyle.Bold);
            this.cbbChonca.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(68)))), ((int)(((byte)(88)))), ((int)(((byte)(112)))));
            this.cbbChonca.ItemHeight = 30;
            this.cbbChonca.Items.AddRange(new object[] {
            "Chọn ca:",
            "Sáng",
            "Chiều",
            "Tối",
            "FulltimeAM",
            "FulltimePM"});
            this.cbbChonca.Location = new System.Drawing.Point(1340, 615);
            this.cbbChonca.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cbbChonca.Name = "cbbChonca";
            this.cbbChonca.Size = new System.Drawing.Size(265, 36);
            this.cbbChonca.StartIndex = 0;
            this.cbbChonca.Style = Guna.UI2.WinForms.Enums.TextBoxStyle.Material;
            this.cbbChonca.TabIndex = 27;
            // 
            // txtMaCa
            // 
            this.txtMaCa.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(192)))), ((int)(((byte)(0)))));
            this.txtMaCa.BorderThickness = 5;
            this.txtMaCa.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.txtMaCa.DefaultText = "";
            this.txtMaCa.DisabledState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(208)))), ((int)(((byte)(208)))), ((int)(((byte)(208)))));
            this.txtMaCa.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(226)))), ((int)(((byte)(226)))));
            this.txtMaCa.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.txtMaCa.DisabledState.PlaceholderForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.txtMaCa.FocusedState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.txtMaCa.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.txtMaCa.ForeColor = System.Drawing.Color.Olive;
            this.txtMaCa.HoverState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.txtMaCa.Location = new System.Drawing.Point(1339, 448);
            this.txtMaCa.Margin = new System.Windows.Forms.Padding(3, 5, 3, 5);
            this.txtMaCa.Name = "txtMaCa";
            this.txtMaCa.PasswordChar = '\0';
            this.txtMaCa.PlaceholderText = "Mã ca";
            this.txtMaCa.SelectedText = "";
            this.txtMaCa.Size = new System.Drawing.Size(266, 56);
            this.txtMaCa.Style = Guna.UI2.WinForms.Enums.TextBoxStyle.Material;
            this.txtMaCa.TabIndex = 26;
            // 
            // txtHoTen
            // 
            this.txtHoTen.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(192)))), ((int)(((byte)(0)))));
            this.txtHoTen.BorderThickness = 5;
            this.txtHoTen.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.txtHoTen.DefaultText = "";
            this.txtHoTen.DisabledState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(208)))), ((int)(((byte)(208)))), ((int)(((byte)(208)))));
            this.txtHoTen.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(226)))), ((int)(((byte)(226)))));
            this.txtHoTen.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.txtHoTen.DisabledState.PlaceholderForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.txtHoTen.FocusedState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.txtHoTen.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.txtHoTen.ForeColor = System.Drawing.Color.Olive;
            this.txtHoTen.HoverState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.txtHoTen.Location = new System.Drawing.Point(1340, 372);
            this.txtHoTen.Margin = new System.Windows.Forms.Padding(3, 5, 3, 5);
            this.txtHoTen.Name = "txtHoTen";
            this.txtHoTen.PasswordChar = '\0';
            this.txtHoTen.PlaceholderText = "Họ và tên";
            this.txtHoTen.SelectedText = "";
            this.txtHoTen.Size = new System.Drawing.Size(266, 56);
            this.txtHoTen.Style = Guna.UI2.WinForms.Enums.TextBoxStyle.Material;
            this.txtHoTen.TabIndex = 25;
            // 
            // dtpkNgayLam
            // 
            this.dtpkNgayLam.BorderRadius = 10;
            this.dtpkNgayLam.Checked = true;
            this.dtpkNgayLam.FillColor = System.Drawing.Color.PeachPuff;
            this.dtpkNgayLam.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.dtpkNgayLam.Format = System.Windows.Forms.DateTimePickerFormat.Long;
            this.dtpkNgayLam.Location = new System.Drawing.Point(1340, 708);
            this.dtpkNgayLam.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dtpkNgayLam.MaxDate = new System.DateTime(9998, 12, 31, 0, 0, 0, 0);
            this.dtpkNgayLam.MinDate = new System.DateTime(1753, 1, 1, 0, 0, 0, 0);
            this.dtpkNgayLam.Name = "dtpkNgayLam";
            this.dtpkNgayLam.Size = new System.Drawing.Size(274, 50);
            this.dtpkNgayLam.TabIndex = 24;
            this.dtpkNgayLam.Value = new System.DateTime(2024, 10, 24, 0, 0, 0, 0);
            // 
            // flpNgay
            // 
            this.flpNgay.Location = new System.Drawing.Point(184, 139);
            this.flpNgay.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.flpNgay.Name = "flpNgay";
            this.flpNgay.Size = new System.Drawing.Size(1053, 99);
            this.flpNgay.TabIndex = 23;
            // 
            // btnChieu
            // 
            this.btnChieu.BackColor = System.Drawing.SystemColors.InactiveCaption;
            this.btnChieu.BorderRadius = 10;
            this.btnChieu.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnChieu.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnChieu.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnChieu.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnChieu.FillColor = System.Drawing.Color.Wheat;
            this.btnChieu.Font = new System.Drawing.Font("Palatino Linotype", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnChieu.ForeColor = System.Drawing.Color.Black;
            this.btnChieu.Location = new System.Drawing.Point(61, 448);
            this.btnChieu.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnChieu.Name = "btnChieu";
            this.btnChieu.Size = new System.Drawing.Size(112, 75);
            this.btnChieu.TabIndex = 22;
            this.btnChieu.Text = "Chiều";
            // 
            // btnToi
            // 
            this.btnToi.BackColor = System.Drawing.SystemColors.InactiveCaption;
            this.btnToi.BorderRadius = 10;
            this.btnToi.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnToi.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnToi.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnToi.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnToi.FillColor = System.Drawing.Color.Wheat;
            this.btnToi.Font = new System.Drawing.Font("Palatino Linotype", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnToi.ForeColor = System.Drawing.Color.Black;
            this.btnToi.Location = new System.Drawing.Point(61, 615);
            this.btnToi.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnToi.Name = "btnToi";
            this.btnToi.Size = new System.Drawing.Size(112, 75);
            this.btnToi.TabIndex = 21;
            this.btnToi.Text = "Tối";
            // 
            // guna2Button1
            // 
            this.guna2Button1.BackColor = System.Drawing.SystemColors.InactiveCaption;
            this.guna2Button1.BorderRadius = 10;
            this.guna2Button1.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.guna2Button1.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.guna2Button1.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.guna2Button1.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.guna2Button1.FillColor = System.Drawing.Color.Wheat;
            this.guna2Button1.Font = new System.Drawing.Font("Palatino Linotype", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.guna2Button1.ForeColor = System.Drawing.Color.Black;
            this.guna2Button1.Location = new System.Drawing.Point(61, 784);
            this.guna2Button1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.guna2Button1.Name = "guna2Button1";
            this.guna2Button1.Size = new System.Drawing.Size(112, 74);
            this.guna2Button1.TabIndex = 20;
            this.guna2Button1.Text = "FulltimeAM";
            // 
            // btnSang
            // 
            this.btnSang.BackColor = System.Drawing.SystemColors.InactiveCaption;
            this.btnSang.BorderRadius = 10;
            this.btnSang.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnSang.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnSang.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnSang.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnSang.FillColor = System.Drawing.Color.Wheat;
            this.btnSang.Font = new System.Drawing.Font("Palatino Linotype", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSang.ForeColor = System.Drawing.Color.Black;
            this.btnSang.Location = new System.Drawing.Point(61, 302);
            this.btnSang.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnSang.Name = "btnSang";
            this.btnSang.Size = new System.Drawing.Size(112, 66);
            this.btnSang.TabIndex = 19;
            this.btnSang.Text = "Sáng";
            // 
            // flpCa
            // 
            this.flpCa.Location = new System.Drawing.Point(184, 245);
            this.flpCa.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.flpCa.Name = "flpCa";
            this.flpCa.Size = new System.Drawing.Size(1053, 821);
            this.flpCa.TabIndex = 18;
            // 
            // txtMaNV
            // 
            this.txtMaNV.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(192)))), ((int)(((byte)(0)))));
            this.txtMaNV.BorderThickness = 5;
            this.txtMaNV.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.txtMaNV.DefaultText = "";
            this.txtMaNV.DisabledState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(208)))), ((int)(((byte)(208)))), ((int)(((byte)(208)))));
            this.txtMaNV.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(226)))), ((int)(((byte)(226)))));
            this.txtMaNV.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.txtMaNV.DisabledState.PlaceholderForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.txtMaNV.FocusedState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.txtMaNV.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.txtMaNV.ForeColor = System.Drawing.Color.Olive;
            this.txtMaNV.HoverState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.txtMaNV.Location = new System.Drawing.Point(1340, 306);
            this.txtMaNV.Margin = new System.Windows.Forms.Padding(3, 5, 3, 5);
            this.txtMaNV.Name = "txtMaNV";
            this.txtMaNV.PasswordChar = '\0';
            this.txtMaNV.PlaceholderText = "Mã nhân viên";
            this.txtMaNV.SelectedText = "";
            this.txtMaNV.Size = new System.Drawing.Size(266, 56);
            this.txtMaNV.Style = Guna.UI2.WinForms.Enums.TextBoxStyle.Material;
            this.txtMaNV.TabIndex = 29;
            // 
            // cbbCongViec
            // 
            this.cbbCongViec.AutoRoundedCorners = true;
            this.cbbCongViec.BackColor = System.Drawing.Color.Transparent;
            this.cbbCongViec.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(192)))), ((int)(((byte)(0)))));
            this.cbbCongViec.BorderRadius = 17;
            this.cbbCongViec.BorderStyle = System.Drawing.Drawing2D.DashStyle.DashDot;
            this.cbbCongViec.BorderThickness = 5;
            this.cbbCongViec.DrawMode = System.Windows.Forms.DrawMode.OwnerDrawFixed;
            this.cbbCongViec.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbbCongViec.FocusedColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.cbbCongViec.FocusedState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.cbbCongViec.Font = new System.Drawing.Font("Segoe UI Semibold", 10.2F, System.Drawing.FontStyle.Bold);
            this.cbbCongViec.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(68)))), ((int)(((byte)(88)))), ((int)(((byte)(112)))));
            this.cbbCongViec.ItemHeight = 30;
            this.cbbCongViec.Items.AddRange(new object[] {
            "Chọn công việc:",
            "Phục vụ",
            "Thu ngân",
            "Pha chế",
            "Quản lí",
            "Bảo vệ"});
            this.cbbCongViec.Location = new System.Drawing.Point(1340, 521);
            this.cbbCongViec.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cbbCongViec.Name = "cbbCongViec";
            this.cbbCongViec.Size = new System.Drawing.Size(265, 36);
            this.cbbCongViec.StartIndex = 0;
            this.cbbCongViec.Style = Guna.UI2.WinForms.Enums.TextBoxStyle.Material;
            this.cbbCongViec.TabIndex = 31;
            // 
            // guna2TextBox1
            // 
            this.guna2TextBox1.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(192)))), ((int)(((byte)(0)))));
            this.guna2TextBox1.BorderThickness = 5;
            this.guna2TextBox1.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.guna2TextBox1.DefaultText = "CALENDAR SCHEDULE";
            this.guna2TextBox1.DisabledState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(208)))), ((int)(((byte)(208)))), ((int)(((byte)(208)))));
            this.guna2TextBox1.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(226)))), ((int)(((byte)(226)))));
            this.guna2TextBox1.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.guna2TextBox1.DisabledState.PlaceholderForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.guna2TextBox1.FillColor = System.Drawing.Color.Linen;
            this.guna2TextBox1.FocusedState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.guna2TextBox1.Font = new System.Drawing.Font("Arial Rounded MT Bold", 25.8F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.guna2TextBox1.ForeColor = System.Drawing.Color.Peru;
            this.guna2TextBox1.HoverState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.guna2TextBox1.Location = new System.Drawing.Point(364, 31);
            this.guna2TextBox1.Margin = new System.Windows.Forms.Padding(7, 9, 7, 9);
            this.guna2TextBox1.Name = "guna2TextBox1";
            this.guna2TextBox1.PasswordChar = '\0';
            this.guna2TextBox1.PlaceholderText = "";
            this.guna2TextBox1.SelectedText = "";
            this.guna2TextBox1.Size = new System.Drawing.Size(659, 95);
            this.guna2TextBox1.Style = Guna.UI2.WinForms.Enums.TextBoxStyle.Material;
            this.guna2TextBox1.TabIndex = 32;
            // 
            // guna2Button2
            // 
            this.guna2Button2.BackColor = System.Drawing.SystemColors.InactiveCaption;
            this.guna2Button2.BorderRadius = 10;
            this.guna2Button2.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.guna2Button2.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.guna2Button2.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.guna2Button2.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.guna2Button2.FillColor = System.Drawing.Color.Wheat;
            this.guna2Button2.Font = new System.Drawing.Font("Palatino Linotype", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.guna2Button2.ForeColor = System.Drawing.Color.Black;
            this.guna2Button2.Location = new System.Drawing.Point(61, 939);
            this.guna2Button2.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.guna2Button2.Name = "guna2Button2";
            this.guna2Button2.Size = new System.Drawing.Size(112, 74);
            this.guna2Button2.TabIndex = 33;
            this.guna2Button2.Text = "Fulltime PM";
            // 
            // guna2Shapes1
            // 
            this.guna2Shapes1.BorderColor = System.Drawing.Color.RosyBrown;
            this.guna2Shapes1.FillColor = System.Drawing.Color.Linen;
            this.guna2Shapes1.Location = new System.Drawing.Point(1244, 189);
            this.guna2Shapes1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.guna2Shapes1.Name = "guna2Shapes1";
            this.guna2Shapes1.PolygonSkip = 1;
            this.guna2Shapes1.Rotate = 0F;
            this.guna2Shapes1.Shape = Guna.UI2.WinForms.Enums.ShapeType.Rounded;
            this.guna2Shapes1.Size = new System.Drawing.Size(451, 810);
            this.guna2Shapes1.TabIndex = 34;
            this.guna2Shapes1.Text = "guna2Shapes1";
            this.guna2Shapes1.Zoom = 80;
            // 
            // fPhanCa
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.BackColor = System.Drawing.Color.Linen;
            this.ClientSize = new System.Drawing.Size(1668, 1164);
            this.Controls.Add(this.guna2Button2);
            this.Controls.Add(this.guna2TextBox1);
            this.Controls.Add(this.cbbCongViec);
            this.Controls.Add(this.txtMaNV);
            this.Controls.Add(this.btnDangKi);
            this.Controls.Add(this.cbbChonca);
            this.Controls.Add(this.txtMaCa);
            this.Controls.Add(this.txtHoTen);
            this.Controls.Add(this.dtpkNgayLam);
            this.Controls.Add(this.flpNgay);
            this.Controls.Add(this.btnChieu);
            this.Controls.Add(this.btnToi);
            this.Controls.Add(this.guna2Button1);
            this.Controls.Add(this.btnSang);
            this.Controls.Add(this.flpCa);
            this.Controls.Add(this.guna2Shapes1);
            this.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.Name = "fPhanCa";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "fPhanCa";
            this.TransparencyKey = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.Load += new System.EventHandler(this.fPhanCa_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private Guna.UI2.WinForms.Guna2Button btnDangKi;
        private Guna.UI2.WinForms.Guna2ComboBox cbbChonca;
        private Guna.UI2.WinForms.Guna2TextBox txtMaCa;
        private Guna.UI2.WinForms.Guna2TextBox txtHoTen;
        private Guna.UI2.WinForms.Guna2DateTimePicker dtpkNgayLam;
        private System.Windows.Forms.FlowLayoutPanel flpNgay;
        private Guna.UI2.WinForms.Guna2Button btnChieu;
        private Guna.UI2.WinForms.Guna2Button btnToi;
        private Guna.UI2.WinForms.Guna2Button guna2Button1;
        private Guna.UI2.WinForms.Guna2Button btnSang;
        private System.Windows.Forms.FlowLayoutPanel flpCa;
        private Guna.UI2.WinForms.Guna2TextBox txtMaNV;
        private Guna.UI2.WinForms.Guna2ComboBox cbbCongViec;
        private Guna.UI2.WinForms.Guna2TextBox guna2TextBox1;
        private Guna.UI2.WinForms.Guna2Button guna2Button2;
        private Guna.UI2.WinForms.Guna2Shapes guna2Shapes1;
    }
}