using QuanLyQuanCaPhe.Database;
using QuanLyQuanCaPhe.Models;
using QuanLyQuanCaPhe.Views;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanCaPhe
{
    public partial class fDangNhap : Form
    {
        public fDangNhap()
        {
            InitializeComponent();
        }

        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            string tenDangNhap = txtTenDangNhap.Text.Trim(); // TextBox chứa tên đăng nhập
            string matKhau = txtMatKhau.Text.Trim(); // TextBox chứa mật khẩu

             
            if (NhanVienDAO.CheckLogin(tenDangNhap, matKhau) >= 1)
            {
                NhanVien nv = NhanVienDAO.timKiemNhanVienTheoTaiKhoan(tenDangNhap, matKhau);
                fTrangChu f = new fTrangChu(nv);
                f.Show();  
                this.Hide(); // Ẩn form đăng nhập
            }
            else
            {
                MessageBox.Show("Tên đăng nhập hoặc mật khẩu không đúng!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnDangKy_Click(object sender, EventArgs e)
        {
            fDangKy f = new fDangKy();
            f.ShowDialog();
        }

        private void llblQuenMatKhau_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            fQuenMatKhau f = new fQuenMatKhau();
            f.ShowDialog();
        }

        private void fDangNhap_Load(object sender, EventArgs e)
        {

        }
    }
}
