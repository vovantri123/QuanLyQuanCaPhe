using QuanLyQuanCaPhe.Views.UserControls;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using System.Windows.Forms;

namespace QuanLyQuanCaPhe
{
    public partial class fTrangChu : Form
    {
        private SanPhamUC[] danhSachSanPham = new SanPhamUC[100];
        public fTrangChu()
        {
            InitializeComponent();
        }

        private void fTrangChu_Load(object sender, EventArgs e)
        {
            LoadUserControls();
        }

        private void LoadUserControls()
        { 
            for (int i = 0; i < 10; i++)
            {
                danhSachSanPham[i] = new SanPhamUC(); 
                flowPnlSanPham.Controls.Add(danhSachSanPham[i]);
            }
        }

        private void guna2Button4_Click(object sender, EventArgs e)
        {

        }
    }
}
