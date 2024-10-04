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
            MessageBox.Show("Đăng ký thành công!","Thông báo",MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
    }
}
