namespace QuanLyQuanCaPhe.Views
{
    partial class fTrangChu
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(fTrangChu));
            this.cboSapXep = new System.Windows.Forms.ComboBox();
            this.label9 = new System.Windows.Forms.Label();
            this.flowPnlSanPham = new System.Windows.Forms.FlowLayoutPanel();
            this.panel3 = new System.Windows.Forms.Panel();
            this.txtTimKiemTheoTenSP = new Guna.UI2.WinForms.Guna2TextBox();
            this.lblTenCuaBan = new System.Windows.Forms.Label();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.lblTieuDeTrang = new System.Windows.Forms.Label();
            this.cpbAnhDaiDien = new Guna.UI2.WinForms.Guna2CirclePictureBox();
            this.label5 = new System.Windows.Forms.Label();
            this.cpbAnhQuanCaPhe = new Guna.UI2.WinForms.Guna2CirclePictureBox();
            this.btnDangXuat = new Guna.UI2.WinForms.Guna2Button();
            this.btnTrangChu = new Guna.UI2.WinForms.Guna2Button();
            this.btnQLSanPham = new Guna.UI2.WinForms.Guna2Button();
            this.btnQLKhoHang = new Guna.UI2.WinForms.Guna2Button();
            this.panel2 = new System.Windows.Forms.Panel();
            this.guna2Panel1 = new Guna.UI2.WinForms.Guna2Panel();
            this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
            this.btnQLHoaDon = new Guna.UI2.WinForms.Guna2Button();
            this.btnQLPhanCa = new Guna.UI2.WinForms.Guna2Button();
            this.btnQLNhanVien = new Guna.UI2.WinForms.Guna2Button();
            this.btnQLKhachHang = new Guna.UI2.WinForms.Guna2Button();
            this.btnQLLoaiSanPham = new Guna.UI2.WinForms.Guna2Button();
            this.btnThongKe = new Guna.UI2.WinForms.Guna2Button();
            this.panel1 = new System.Windows.Forms.Panel();
            this.btnNewOrder = new Guna.UI2.WinForms.Guna2GradientButton();
            this.btnThanhToan = new Guna.UI2.WinForms.Guna2Button();
            this.btnXoaChonTatCa = new Guna.UI2.WinForms.Guna2Button();
            this.txtSoDienThoai = new Guna.UI2.WinForms.Guna2TextBox();
            this.dgvHienThi = new System.Windows.Forms.DataGridView();
            this.lblVND = new System.Windows.Forms.Label();
            this.lblTongTien = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.lblNgayMua = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.panel3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cpbAnhDaiDien)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cpbAnhQuanCaPhe)).BeginInit();
            this.panel2.SuspendLayout();
            this.guna2Panel1.SuspendLayout();
            this.flowLayoutPanel1.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvHienThi)).BeginInit();
            this.SuspendLayout();
            // 
            // cboSapXep
            // 
            this.cboSapXep.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cboSapXep.FormattingEnabled = true;
            this.cboSapXep.Items.AddRange(new object[] {
            "Giá: Thấp -> Cao",
            "Giá: Cao -> Thấp",
            "Tên: A -> Z",
            "Tên: Z -> A"});
            this.cboSapXep.Location = new System.Drawing.Point(17, 50);
            this.cboSapXep.Name = "cboSapXep";
            this.cboSapXep.Size = new System.Drawing.Size(141, 28);
            this.cboSapXep.TabIndex = 4;
            this.cboSapXep.SelectedIndexChanged += new System.EventHandler(this.cboSapXep_SelectedIndexChanged);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(44, 15);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(67, 20);
            this.label9.TabIndex = 2;
            this.label9.Text = "Sắp xếp";
            // 
            // flowPnlSanPham
            // 
            this.flowPnlSanPham.AutoScroll = true;
            this.flowPnlSanPham.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.flowPnlSanPham.Location = new System.Drawing.Point(0, 84);
            this.flowPnlSanPham.Name = "flowPnlSanPham";
            this.flowPnlSanPham.Size = new System.Drawing.Size(889, 475);
            this.flowPnlSanPham.TabIndex = 1;
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.cboSapXep);
            this.panel3.Controls.Add(this.label9);
            this.panel3.Controls.Add(this.txtTimKiemTheoTenSP);
            this.panel3.Controls.Add(this.flowPnlSanPham);
            this.panel3.Location = new System.Drawing.Point(297, 148);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(889, 559);
            this.panel3.TabIndex = 8;
            // 
            // txtTimKiemTheoTenSP
            // 
            this.txtTimKiemTheoTenSP.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.txtTimKiemTheoTenSP.DefaultText = "";
            this.txtTimKiemTheoTenSP.DisabledState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(208)))), ((int)(((byte)(208)))), ((int)(((byte)(208)))));
            this.txtTimKiemTheoTenSP.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(226)))), ((int)(((byte)(226)))));
            this.txtTimKiemTheoTenSP.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.txtTimKiemTheoTenSP.DisabledState.PlaceholderForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.txtTimKiemTheoTenSP.FocusedState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.txtTimKiemTheoTenSP.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.txtTimKiemTheoTenSP.HoverState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.txtTimKiemTheoTenSP.Location = new System.Drawing.Point(577, 15);
            this.txtTimKiemTheoTenSP.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.txtTimKiemTheoTenSP.Name = "txtTimKiemTheoTenSP";
            this.txtTimKiemTheoTenSP.PasswordChar = '\0';
            this.txtTimKiemTheoTenSP.PlaceholderText = "Tìm kiếm tên sản phẩm";
            this.txtTimKiemTheoTenSP.SelectedText = "";
            this.txtTimKiemTheoTenSP.Size = new System.Drawing.Size(286, 60);
            this.txtTimKiemTheoTenSP.TabIndex = 1;
            this.txtTimKiemTheoTenSP.TextChanged += new System.EventHandler(this.txtTimKiemTheoTenSP_TextChanged);
            // 
            // lblTenCuaBan
            // 
            this.lblTenCuaBan.AutoSize = true;
            this.lblTenCuaBan.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.lblTenCuaBan.Location = new System.Drawing.Point(1127, 51);
            this.lblTenCuaBan.Name = "lblTenCuaBan";
            this.lblTenCuaBan.Size = new System.Drawing.Size(129, 29);
            this.lblTenCuaBan.TabIndex = 2;
            this.lblTenCuaBan.Text = "YourName";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(969, 33);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(48, 47);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox1.TabIndex = 1;
            this.pictureBox1.TabStop = false;
            // 
            // lblTieuDeTrang
            // 
            this.lblTieuDeTrang.AutoSize = true;
            this.lblTieuDeTrang.Font = new System.Drawing.Font("Microsoft Sans Serif", 22F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.lblTieuDeTrang.Location = new System.Drawing.Point(18, 24);
            this.lblTieuDeTrang.Name = "lblTieuDeTrang";
            this.lblTieuDeTrang.Size = new System.Drawing.Size(218, 52);
            this.lblTieuDeTrang.TabIndex = 0;
            this.lblTieuDeTrang.Text = "Trang chủ";
            // 
            // cpbAnhDaiDien
            // 
            this.cpbAnhDaiDien.Image = ((System.Drawing.Image)(resources.GetObject("cpbAnhDaiDien.Image")));
            this.cpbAnhDaiDien.ImageRotate = 0F;
            this.cpbAnhDaiDien.Location = new System.Drawing.Point(1043, 24);
            this.cpbAnhDaiDien.Name = "cpbAnhDaiDien";
            this.cpbAnhDaiDien.ShadowDecoration.Mode = Guna.UI2.WinForms.Enums.ShadowMode.Circle;
            this.cpbAnhDaiDien.Size = new System.Drawing.Size(77, 76);
            this.cpbAnhDaiDien.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.cpbAnhDaiDien.TabIndex = 0;
            this.cpbAnhDaiDien.TabStop = false;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.label5.Location = new System.Drawing.Point(35, 284);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(186, 32);
            this.label5.TabIndex = 1;
            this.label5.Text = "DBMS Coffee";
            // 
            // cpbAnhQuanCaPhe
            // 
            this.cpbAnhQuanCaPhe.Image = ((System.Drawing.Image)(resources.GetObject("cpbAnhQuanCaPhe.Image")));
            this.cpbAnhQuanCaPhe.ImageRotate = 0F;
            this.cpbAnhQuanCaPhe.Location = new System.Drawing.Point(12, 36);
            this.cpbAnhQuanCaPhe.Name = "cpbAnhQuanCaPhe";
            this.cpbAnhQuanCaPhe.ShadowDecoration.Mode = Guna.UI2.WinForms.Enums.ShadowMode.Circle;
            this.cpbAnhQuanCaPhe.Size = new System.Drawing.Size(230, 227);
            this.cpbAnhQuanCaPhe.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.cpbAnhQuanCaPhe.TabIndex = 0;
            this.cpbAnhQuanCaPhe.TabStop = false;
            // 
            // btnDangXuat
            // 
            this.btnDangXuat.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnDangXuat.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnDangXuat.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnDangXuat.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnDangXuat.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnDangXuat.ForeColor = System.Drawing.Color.White;
            this.btnDangXuat.Image = ((System.Drawing.Image)(resources.GetObject("btnDangXuat.Image")));
            this.btnDangXuat.ImageAlign = System.Windows.Forms.HorizontalAlignment.Left;
            this.btnDangXuat.ImageSize = new System.Drawing.Size(25, 25);
            this.btnDangXuat.Location = new System.Drawing.Point(30, 861);
            this.btnDangXuat.Margin = new System.Windows.Forms.Padding(2, 0, 2, 2);
            this.btnDangXuat.Name = "btnDangXuat";
            this.btnDangXuat.PressedColor = System.Drawing.Color.White;
            this.btnDangXuat.Size = new System.Drawing.Size(180, 45);
            this.btnDangXuat.TabIndex = 3;
            this.btnDangXuat.Text = "Đăng xuất";
            this.btnDangXuat.Click += new System.EventHandler(this.btnDangXuat_Click);
            // 
            // btnTrangChu
            // 
            this.btnTrangChu.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnTrangChu.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnTrangChu.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnTrangChu.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnTrangChu.Enabled = false;
            this.btnTrangChu.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnTrangChu.ForeColor = System.Drawing.Color.White;
            this.btnTrangChu.Location = new System.Drawing.Point(2, 0);
            this.btnTrangChu.Margin = new System.Windows.Forms.Padding(2, 0, 2, 2);
            this.btnTrangChu.Name = "btnTrangChu";
            this.btnTrangChu.Size = new System.Drawing.Size(180, 45);
            this.btnTrangChu.TabIndex = 3;
            this.btnTrangChu.Text = "Trang chủ";
            // 
            // btnQLSanPham
            // 
            this.btnQLSanPham.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnQLSanPham.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnQLSanPham.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnQLSanPham.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnQLSanPham.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnQLSanPham.ForeColor = System.Drawing.Color.White;
            this.btnQLSanPham.Location = new System.Drawing.Point(2, 47);
            this.btnQLSanPham.Margin = new System.Windows.Forms.Padding(2, 0, 2, 2);
            this.btnQLSanPham.Name = "btnQLSanPham";
            this.btnQLSanPham.Size = new System.Drawing.Size(180, 45);
            this.btnQLSanPham.TabIndex = 3;
            this.btnQLSanPham.Text = "QL Sản phẩm";
            this.btnQLSanPham.Click += new System.EventHandler(this.btnQLSanPham_Click);
            // 
            // btnQLKhoHang
            // 
            this.btnQLKhoHang.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnQLKhoHang.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnQLKhoHang.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnQLKhoHang.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnQLKhoHang.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnQLKhoHang.ForeColor = System.Drawing.Color.White;
            this.btnQLKhoHang.Location = new System.Drawing.Point(2, 94);
            this.btnQLKhoHang.Margin = new System.Windows.Forms.Padding(2, 0, 2, 2);
            this.btnQLKhoHang.Name = "btnQLKhoHang";
            this.btnQLKhoHang.Size = new System.Drawing.Size(180, 45);
            this.btnQLKhoHang.TabIndex = 3;
            this.btnQLKhoHang.Text = "QL Kho hàng";
            this.btnQLKhoHang.Click += new System.EventHandler(this.btnQLKhoHang_Click);
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.lblTenCuaBan);
            this.panel2.Controls.Add(this.pictureBox1);
            this.panel2.Controls.Add(this.lblTieuDeTrang);
            this.panel2.Controls.Add(this.cpbAnhDaiDien);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel2.Location = new System.Drawing.Point(270, 0);
            this.panel2.Margin = new System.Windows.Forms.Padding(2);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(1658, 116);
            this.panel2.TabIndex = 7;
            // 
            // guna2Panel1
            // 
            this.guna2Panel1.Controls.Add(this.flowLayoutPanel1);
            this.guna2Panel1.Controls.Add(this.label5);
            this.guna2Panel1.Controls.Add(this.cpbAnhQuanCaPhe);
            this.guna2Panel1.Controls.Add(this.btnDangXuat);
            this.guna2Panel1.Dock = System.Windows.Forms.DockStyle.Left;
            this.guna2Panel1.Location = new System.Drawing.Point(0, 0);
            this.guna2Panel1.Name = "guna2Panel1";
            this.guna2Panel1.Size = new System.Drawing.Size(270, 917);
            this.guna2Panel1.TabIndex = 6;
            // 
            // flowLayoutPanel1
            // 
            this.flowLayoutPanel1.Controls.Add(this.btnTrangChu);
            this.flowLayoutPanel1.Controls.Add(this.btnQLSanPham);
            this.flowLayoutPanel1.Controls.Add(this.btnQLKhoHang);
            this.flowLayoutPanel1.Controls.Add(this.btnQLHoaDon);
            this.flowLayoutPanel1.Controls.Add(this.btnQLPhanCa);
            this.flowLayoutPanel1.Controls.Add(this.btnQLNhanVien);
            this.flowLayoutPanel1.Controls.Add(this.btnQLKhachHang);
            this.flowLayoutPanel1.Controls.Add(this.btnQLLoaiSanPham);
            this.flowLayoutPanel1.Controls.Add(this.btnThongKe);
            this.flowLayoutPanel1.Location = new System.Drawing.Point(30, 343);
            this.flowLayoutPanel1.Name = "flowLayoutPanel1";
            this.flowLayoutPanel1.Size = new System.Drawing.Size(212, 483);
            this.flowLayoutPanel1.TabIndex = 4;
            // 
            // btnQLHoaDon
            // 
            this.btnQLHoaDon.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnQLHoaDon.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnQLHoaDon.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnQLHoaDon.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnQLHoaDon.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnQLHoaDon.ForeColor = System.Drawing.Color.White;
            this.btnQLHoaDon.Location = new System.Drawing.Point(2, 141);
            this.btnQLHoaDon.Margin = new System.Windows.Forms.Padding(2, 0, 2, 2);
            this.btnQLHoaDon.Name = "btnQLHoaDon";
            this.btnQLHoaDon.Size = new System.Drawing.Size(180, 45);
            this.btnQLHoaDon.TabIndex = 3;
            this.btnQLHoaDon.Text = "QL Hóa đơn";
            this.btnQLHoaDon.Click += new System.EventHandler(this.btnHoaDon_Click);
            // 
            // btnQLPhanCa
            // 
            this.btnQLPhanCa.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnQLPhanCa.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnQLPhanCa.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnQLPhanCa.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnQLPhanCa.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnQLPhanCa.ForeColor = System.Drawing.Color.White;
            this.btnQLPhanCa.Location = new System.Drawing.Point(2, 188);
            this.btnQLPhanCa.Margin = new System.Windows.Forms.Padding(2, 0, 2, 2);
            this.btnQLPhanCa.Name = "btnQLPhanCa";
            this.btnQLPhanCa.Size = new System.Drawing.Size(180, 45);
            this.btnQLPhanCa.TabIndex = 3;
            this.btnQLPhanCa.Text = "QL Phân ca";
            this.btnQLPhanCa.Click += new System.EventHandler(this.btnQLPhanCa_Click);
            // 
            // btnQLNhanVien
            // 
            this.btnQLNhanVien.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnQLNhanVien.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnQLNhanVien.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnQLNhanVien.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnQLNhanVien.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnQLNhanVien.ForeColor = System.Drawing.Color.White;
            this.btnQLNhanVien.Location = new System.Drawing.Point(2, 235);
            this.btnQLNhanVien.Margin = new System.Windows.Forms.Padding(2, 0, 2, 2);
            this.btnQLNhanVien.Name = "btnQLNhanVien";
            this.btnQLNhanVien.Size = new System.Drawing.Size(180, 45);
            this.btnQLNhanVien.TabIndex = 3;
            this.btnQLNhanVien.Text = "QL nhân viên";
            this.btnQLNhanVien.Click += new System.EventHandler(this.btnQLNhanVien_Click);
            // 
            // btnQLKhachHang
            // 
            this.btnQLKhachHang.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnQLKhachHang.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnQLKhachHang.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnQLKhachHang.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnQLKhachHang.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnQLKhachHang.ForeColor = System.Drawing.Color.White;
            this.btnQLKhachHang.Location = new System.Drawing.Point(2, 282);
            this.btnQLKhachHang.Margin = new System.Windows.Forms.Padding(2, 0, 2, 2);
            this.btnQLKhachHang.Name = "btnQLKhachHang";
            this.btnQLKhachHang.Size = new System.Drawing.Size(180, 45);
            this.btnQLKhachHang.TabIndex = 4;
            this.btnQLKhachHang.Text = "QL Khách hàng";
            this.btnQLKhachHang.Click += new System.EventHandler(this.btnQLKhachHang_Click);
            // 
            // btnQLLoaiSanPham
            // 
            this.btnQLLoaiSanPham.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnQLLoaiSanPham.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnQLLoaiSanPham.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnQLLoaiSanPham.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnQLLoaiSanPham.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnQLLoaiSanPham.ForeColor = System.Drawing.Color.White;
            this.btnQLLoaiSanPham.Location = new System.Drawing.Point(2, 329);
            this.btnQLLoaiSanPham.Margin = new System.Windows.Forms.Padding(2, 0, 2, 2);
            this.btnQLLoaiSanPham.Name = "btnQLLoaiSanPham";
            this.btnQLLoaiSanPham.Size = new System.Drawing.Size(180, 45);
            this.btnQLLoaiSanPham.TabIndex = 3;
            this.btnQLLoaiSanPham.Text = "QL loại sản phẩm";
            this.btnQLLoaiSanPham.Click += new System.EventHandler(this.btnQLLoaiSanPham_Click);
            // 
            // btnThongKe
            // 
            this.btnThongKe.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnThongKe.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnThongKe.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnThongKe.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnThongKe.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnThongKe.ForeColor = System.Drawing.Color.White;
            this.btnThongKe.Location = new System.Drawing.Point(2, 376);
            this.btnThongKe.Margin = new System.Windows.Forms.Padding(2, 0, 2, 2);
            this.btnThongKe.Name = "btnThongKe";
            this.btnThongKe.Size = new System.Drawing.Size(180, 45);
            this.btnThongKe.TabIndex = 4;
            this.btnThongKe.Text = "Thống kê";
            this.btnThongKe.Click += new System.EventHandler(this.btnThongKe_Click);
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.btnNewOrder);
            this.panel1.Controls.Add(this.btnThanhToan);
            this.panel1.Controls.Add(this.btnXoaChonTatCa);
            this.panel1.Controls.Add(this.txtSoDienThoai);
            this.panel1.Controls.Add(this.dgvHienThi);
            this.panel1.Controls.Add(this.lblVND);
            this.panel1.Controls.Add(this.lblTongTien);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Controls.Add(this.lblNgayMua);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Location = new System.Drawing.Point(1205, 148);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(711, 559);
            this.panel1.TabIndex = 5;
            // 
            // btnNewOrder
            // 
            this.btnNewOrder.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnNewOrder.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnNewOrder.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnNewOrder.DisabledState.FillColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnNewOrder.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnNewOrder.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnNewOrder.ForeColor = System.Drawing.Color.White;
            this.btnNewOrder.Location = new System.Drawing.Point(28, 9);
            this.btnNewOrder.Name = "btnNewOrder";
            this.btnNewOrder.Size = new System.Drawing.Size(128, 38);
            this.btnNewOrder.TabIndex = 4;
            this.btnNewOrder.Text = "New Order";
            this.btnNewOrder.Click += new System.EventHandler(this.btnNewOrder_Click);
            // 
            // btnThanhToan
            // 
            this.btnThanhToan.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnThanhToan.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnThanhToan.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnThanhToan.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnThanhToan.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnThanhToan.ForeColor = System.Drawing.Color.White;
            this.btnThanhToan.Location = new System.Drawing.Point(298, 507);
            this.btnThanhToan.Name = "btnThanhToan";
            this.btnThanhToan.Size = new System.Drawing.Size(180, 45);
            this.btnThanhToan.TabIndex = 3;
            this.btnThanhToan.Text = "Thanh toán";
            this.btnThanhToan.Click += new System.EventHandler(this.btnThanhToan_Click);
            // 
            // btnXoaChonTatCa
            // 
            this.btnXoaChonTatCa.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnXoaChonTatCa.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnXoaChonTatCa.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnXoaChonTatCa.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnXoaChonTatCa.Enabled = false;
            this.btnXoaChonTatCa.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnXoaChonTatCa.ForeColor = System.Drawing.Color.White;
            this.btnXoaChonTatCa.Location = new System.Drawing.Point(59, 507);
            this.btnXoaChonTatCa.Name = "btnXoaChonTatCa";
            this.btnXoaChonTatCa.Size = new System.Drawing.Size(180, 45);
            this.btnXoaChonTatCa.TabIndex = 3;
            this.btnXoaChonTatCa.Text = "Xóa chọn tất cả";
            this.btnXoaChonTatCa.Click += new System.EventHandler(this.btnXoaChonTatCa_Click);
            // 
            // txtSoDienThoai
            // 
            this.txtSoDienThoai.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.txtSoDienThoai.DefaultText = "0123456789";
            this.txtSoDienThoai.DisabledState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(208)))), ((int)(((byte)(208)))), ((int)(((byte)(208)))));
            this.txtSoDienThoai.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(226)))), ((int)(((byte)(226)))));
            this.txtSoDienThoai.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.txtSoDienThoai.DisabledState.PlaceholderForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.txtSoDienThoai.FocusedState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.txtSoDienThoai.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.txtSoDienThoai.HoverState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.txtSoDienThoai.Location = new System.Drawing.Point(328, 10);
            this.txtSoDienThoai.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.txtSoDienThoai.Name = "txtSoDienThoai";
            this.txtSoDienThoai.PasswordChar = '\0';
            this.txtSoDienThoai.PlaceholderText = "Nhập SĐT khách hàng";
            this.txtSoDienThoai.SelectedText = "";
            this.txtSoDienThoai.Size = new System.Drawing.Size(286, 60);
            this.txtSoDienThoai.TabIndex = 1;
            // 
            // dgvHienThi
            // 
            this.dgvHienThi.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvHienThi.Location = new System.Drawing.Point(29, 84);
            this.dgvHienThi.Name = "dgvHienThi";
            this.dgvHienThi.RowHeadersWidth = 62;
            this.dgvHienThi.RowTemplate.Height = 28;
            this.dgvHienThi.Size = new System.Drawing.Size(668, 373);
            this.dgvHienThi.TabIndex = 2;
            this.dgvHienThi.Visible = false;
            this.dgvHienThi.DataBindingComplete += new System.Windows.Forms.DataGridViewBindingCompleteEventHandler(this.dgvHienThi_DataBindingComplete);
            // 
            // lblVND
            // 
            this.lblVND.AutoSize = true;
            this.lblVND.Location = new System.Drawing.Point(435, 464);
            this.lblVND.Name = "lblVND";
            this.lblVND.Size = new System.Drawing.Size(43, 20);
            this.lblVND.TabIndex = 0;
            this.lblVND.Text = "VND";
            // 
            // lblTongTien
            // 
            this.lblTongTien.AutoSize = true;
            this.lblTongTien.Location = new System.Drawing.Point(362, 464);
            this.lblTongTien.Name = "lblTongTien";
            this.lblTongTien.Size = new System.Drawing.Size(18, 20);
            this.lblTongTien.TabIndex = 0;
            this.lblTongTien.Text = "0";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(25, 50);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(45, 20);
            this.label3.TabIndex = 0;
            this.label3.Text = "Ngày";
            // 
            // lblNgayMua
            // 
            this.lblNgayMua.AutoSize = true;
            this.lblNgayMua.Location = new System.Drawing.Point(67, 51);
            this.lblNgayMua.Name = "lblNgayMua";
            this.lblNgayMua.Size = new System.Drawing.Size(89, 20);
            this.lblNgayMua.TabIndex = 0;
            this.lblNgayMua.Text = "04/10/2024";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(25, 464);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(45, 20);
            this.label1.TabIndex = 0;
            this.label1.Text = "Tổng";
            // 
            // fTrangChu
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.BackColor = System.Drawing.SystemColors.Control;
            this.ClientSize = new System.Drawing.Size(1928, 917);
            this.Controls.Add(this.panel3);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.guna2Panel1);
            this.Controls.Add(this.panel1);
            this.Name = "fTrangChu";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "TrangChu";
            this.Load += new System.EventHandler(this.fTrangChu_Load);
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cpbAnhDaiDien)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cpbAnhQuanCaPhe)).EndInit();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.guna2Panel1.ResumeLayout(false);
            this.guna2Panel1.PerformLayout();
            this.flowLayoutPanel1.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvHienThi)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.ComboBox cboSapXep;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.FlowLayoutPanel flowPnlSanPham;
        private System.Windows.Forms.Panel panel3;
        private Guna.UI2.WinForms.Guna2TextBox txtTimKiemTheoTenSP;
        private System.Windows.Forms.Label lblTenCuaBan;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label lblTieuDeTrang;
        private Guna.UI2.WinForms.Guna2CirclePictureBox cpbAnhDaiDien;
        private System.Windows.Forms.Label label5;
        private Guna.UI2.WinForms.Guna2CirclePictureBox cpbAnhQuanCaPhe;
        private Guna.UI2.WinForms.Guna2Button btnDangXuat;
        private Guna.UI2.WinForms.Guna2Button btnTrangChu;
        private Guna.UI2.WinForms.Guna2Button btnQLSanPham;
        private Guna.UI2.WinForms.Guna2Button btnQLKhoHang;
        private System.Windows.Forms.Panel panel2;
        private Guna.UI2.WinForms.Guna2Panel guna2Panel1;
        private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel1;
        private Guna.UI2.WinForms.Guna2Button btnQLNhanVien;
        private Guna.UI2.WinForms.Guna2Button btnQLHoaDon;
        private Guna.UI2.WinForms.Guna2Button btnQLPhanCa;
        private Guna.UI2.WinForms.Guna2Button btnQLLoaiSanPham;
        private System.Windows.Forms.Panel panel1;
        private Guna.UI2.WinForms.Guna2Button btnThanhToan;
        private Guna.UI2.WinForms.Guna2Button btnXoaChonTatCa;
        private System.Windows.Forms.DataGridView dgvHienThi;
        private System.Windows.Forms.Label lblVND;
        private System.Windows.Forms.Label lblTongTien;
        private System.Windows.Forms.Label lblNgayMua;
        private System.Windows.Forms.Label label1;
        private Guna.UI2.WinForms.Guna2Button btnThongKe;
        private Guna.UI2.WinForms.Guna2Button btnQLKhachHang;
        private Guna.UI2.WinForms.Guna2TextBox txtSoDienThoai;
        private System.Windows.Forms.Label label3;
        private Guna.UI2.WinForms.Guna2GradientButton btnNewOrder;
    }
}