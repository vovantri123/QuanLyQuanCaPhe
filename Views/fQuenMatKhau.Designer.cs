﻿namespace QuanLyQuanCaPhe.Views
{
    partial class fQuenMatKhau
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
            this.label1 = new System.Windows.Forms.Label();
            this.txtSoDienThoai = new Guna.UI2.WinForms.Guna2TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.btnLayMatKhau = new Guna.UI2.WinForms.Guna2Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 22F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.label1.Location = new System.Drawing.Point(329, 41);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(319, 52);
            this.label1.TabIndex = 0;
            this.label1.Text = "Quên mật khẩu";
            // 
            // txtSoDienThoai
            // 
            this.txtSoDienThoai.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.txtSoDienThoai.DefaultText = "";
            this.txtSoDienThoai.DisabledState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(208)))), ((int)(((byte)(208)))), ((int)(((byte)(208)))));
            this.txtSoDienThoai.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(226)))), ((int)(((byte)(226)))), ((int)(((byte)(226)))));
            this.txtSoDienThoai.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.txtSoDienThoai.DisabledState.PlaceholderForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(138)))), ((int)(((byte)(138)))), ((int)(((byte)(138)))));
            this.txtSoDienThoai.FocusedState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.txtSoDienThoai.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.txtSoDienThoai.HoverState.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(94)))), ((int)(((byte)(148)))), ((int)(((byte)(255)))));
            this.txtSoDienThoai.Location = new System.Drawing.Point(338, 128);
            this.txtSoDienThoai.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.txtSoDienThoai.Name = "txtSoDienThoai";
            this.txtSoDienThoai.PasswordChar = '\0';
            this.txtSoDienThoai.PlaceholderText = "";
            this.txtSoDienThoai.SelectedText = "";
            this.txtSoDienThoai.Size = new System.Drawing.Size(286, 56);
            this.txtSoDienThoai.TabIndex = 1;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(163)));
            this.label2.Location = new System.Drawing.Point(121, 139);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(181, 32);
            this.label2.TabIndex = 2;
            this.label2.Text = "Số điện thoại";
            // 
            // btnLayMatKhau
            // 
            this.btnLayMatKhau.DisabledState.BorderColor = System.Drawing.Color.DarkGray;
            this.btnLayMatKhau.DisabledState.CustomBorderColor = System.Drawing.Color.DarkGray;
            this.btnLayMatKhau.DisabledState.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(169)))), ((int)(((byte)(169)))), ((int)(((byte)(169)))));
            this.btnLayMatKhau.DisabledState.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(141)))), ((int)(((byte)(141)))), ((int)(((byte)(141)))));
            this.btnLayMatKhau.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnLayMatKhau.ForeColor = System.Drawing.Color.White;
            this.btnLayMatKhau.Location = new System.Drawing.Point(690, 139);
            this.btnLayMatKhau.Name = "btnLayMatKhau";
            this.btnLayMatKhau.Size = new System.Drawing.Size(180, 45);
            this.btnLayMatKhau.TabIndex = 3;
            this.btnLayMatKhau.Text = "Lấy mật khẩu";
            this.btnLayMatKhau.Click += new System.EventHandler(this.btnLayMatKhau_Click);
            // 
            // fQuenMatKhau
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(919, 262);
            this.Controls.Add(this.btnLayMatKhau);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txtSoDienThoai);
            this.Controls.Add(this.label1);
            this.Name = "fQuenMatKhau";
            this.Text = "fQuenMatKhau";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private Guna.UI2.WinForms.Guna2TextBox txtSoDienThoai;
        private System.Windows.Forms.Label label2;
        private Guna.UI2.WinForms.Guna2Button btnLayMatKhau;
    }
}