using QuanLyQuanCaPhe.Database;
using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanCaPhe.Views
{
    public partial class fDangKy : Form
    {
        public fDangKy()
        {
            InitializeComponent();
        }

        private void btnDangKy_Click(object sender, EventArgs e)
        {
            //Dung funct hoặc proc trả về số lượng dòng, rồi dùng nó làm id (hoặc dùng cách khác tự tạo ID)
            string hoTenNv = txtHoTen.Text;
            string sdt = txtSoDienThoai.Text;
            string namSinh = txtNamSinh.Text;
            int yearBirth = Convert.ToInt32(namSinh);
            string gioiTinh = cboGioiTinh.Text;
            string diaChi = txtDiaChi.Text;
            string email = txtEmail.Text;
            string tenDangNhap = txtTenDangNhap.Text;
            string matKhau = txtMatKhau.Text;
            string loaiNV = cboLoaiNV.Text;

            if (matKhau != txtNhapLaiMatKhau.Text)
            {
                MessageBox.Show("Vui lòng nhập lại mật khẩu");

            }
            else
            {
                NhanVien nv = new NhanVien("", hoTenNv, sdt, yearBirth, gioiTinh, diaChi, email, tenDangNhap, matKhau);
                NhanVienDAO.Them(nv, loaiNV);
            }
            
        }
    }
}
