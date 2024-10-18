namespace QuanLyQuanCaPhe.Views.UserControls
{
    partial class ucSanPham
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.pbSanPham = new Guna.UI2.WinForms.Guna2PictureBox();
            this.lblTenSP = new System.Windows.Forms.Label();
            this.lblGia = new System.Windows.Forms.Label();
            this.btnDat = new Guna.UI2.WinForms.Guna2Button();
            this.label3 = new System.Windows.Forms.Label();
            this.lblMaSP = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.pbSanPham)).BeginInit();
            this.SuspendLayout();
            // 
            // pbSanPham
            // 
            this.pbSanPham.ImageRotate = 0F;
            this.pbSanPham.Location = new System.Drawing.Point(32, 20);
            this.pbSanPham.Name = "pbSanPham";
            this.pbSanPham.Size = new System.Drawing.Size(209, 200);
            this.pbSanPham.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pbSanPham.TabIndex = 0;
            this.pbSanPham.TabStop = false;
            // 
            // lblTenSP
            // 
            this.lblTenSP.AutoSize = true;
            this.lblTenSP.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.lblTenSP.Location = new System.Drawing.Point(31, 233);
            this.lblTenSP.Name = "lblTenSP";
            this.lblTenSP.Size = new System.Drawing.Size(210, 32);
            this.lblTenSP.TabIndex = 1;
            this.lblTenSP.Text = "Cà phê sữa đá";
            // 
            // lblGia
            // 
            this.lblGia.AutoSize = true;
            this.lblGia.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.lblGia.Location = new System.Drawing.Point(100, 277);
            this.lblGia.Name = "lblGia";
            this.lblGia.Size = new System.Drawing.Size(72, 25);
            this.lblGia.TabIndex = 2;
            this.lblGia.Text = "20.000";
            // 
            // btnDat
            // 
            this.btnDat.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnDat.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnDat.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnDat.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnDat.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.btnDat.ForeColor = System.Drawing.Color.White;
            this.btnDat.Location = new System.Drawing.Point(80, 314);
            this.btnDat.Name = "btnDat";
            this.btnDat.Size = new System.Drawing.Size(112, 44);
            this.btnDat.TabIndex = 3;
            this.btnDat.Text = "Đặt";
            this.btnDat.Click += new System.EventHandler(this.btnDat_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.label3.Location = new System.Drawing.Point(109, 277);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(54, 25);
            this.label3.TabIndex = 2;
            this.label3.Text = "VND";
            // 
            // lblMaSP
            // 
            this.lblMaSP.AutoSize = true;
            this.lblMaSP.BackColor = System.Drawing.Color.Transparent;
            this.lblMaSP.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.lblMaSP.ForeColor = System.Drawing.Color.Black;
            this.lblMaSP.Location = new System.Drawing.Point(47, 0);
            this.lblMaSP.Name = "lblMaSP";
            this.lblMaSP.Size = new System.Drawing.Size(195, 32);
            this.lblMaSP.TabIndex = 1;
            this.lblMaSP.Text = "Mã sản phẩm";
            this.lblMaSP.Visible = false;
            // 
            // ucSanPham
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.InactiveCaption;
            this.Controls.Add(this.lblGia);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btnDat);
            this.Controls.Add(this.lblMaSP);
            this.Controls.Add(this.lblTenSP);
            this.Controls.Add(this.pbSanPham);
            this.Name = "ucSanPham";
            this.Size = new System.Drawing.Size(269, 384);
            ((System.ComponentModel.ISupportInitialize)(this.pbSanPham)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        public Guna.UI2.WinForms.Guna2PictureBox pbSanPham;
        public System.Windows.Forms.Label lblTenSP;
        public System.Windows.Forms.Label lblGia;
        public Guna.UI2.WinForms.Guna2Button btnDat;
        public System.Windows.Forms.Label label3;
        public System.Windows.Forms.Label lblMaSP;
    }
}
