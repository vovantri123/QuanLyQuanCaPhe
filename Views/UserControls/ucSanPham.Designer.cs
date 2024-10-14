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
            this.btnGia = new Guna.UI2.WinForms.Guna2Button();
            this.label3 = new System.Windows.Forms.Label();
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
            // btnGia
            // 
            this.btnGia.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnGia.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnGia.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnGia.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnGia.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.btnGia.ForeColor = System.Drawing.Color.White;
            this.btnGia.Location = new System.Drawing.Point(80, 314);
            this.btnGia.Name = "btnGia";
            this.btnGia.Size = new System.Drawing.Size(112, 44);
            this.btnGia.TabIndex = 3;
            this.btnGia.Text = "Đặt";
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
            // ucSanPham
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.InactiveCaption;
            this.Controls.Add(this.lblGia);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btnGia);
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
        public Guna.UI2.WinForms.Guna2Button btnGia;
        public System.Windows.Forms.Label label3;
    }
}
