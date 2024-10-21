using QuanLyQuanCaPhe.Database;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QuanLyQuanCaPhe.Views; 

namespace QuanLyQuanCaPhe.Views
{
    public partial class fQuenMatKhau : Form
    {
        public fQuenMatKhau()
        {
            InitializeComponent();
        }

        private void btnLayMatKhau_Click(object sender, EventArgs e)
        { 
            string matKhau = NhanVienDAO.LayMatKhau(txtTenDangNhap.Text.Trim(), txtSoDienThoai.Text.Trim());
            if (matKhau == null || matKhau.Trim() =="")
                MessageBox.Show("Tên đăng nhập hoặc số điện thoại không đúng" + matKhau, "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            else
                MessageBox.Show("Mật khẩu của bạn là: " + matKhau, "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }   

        private void fQuenMatKhau_Load(object sender, EventArgs e)
        {

        }
    }
}
