using QuanLyQuanCaPhe.Views.UserControls;
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
    public partial class fTrangChu : Form
    {
        ucSanPham[] danhSachSanPham = new ucSanPham[100];

        public fTrangChu()
        {
            InitializeComponent();
        }

        private void btnThanhToan_Click(object sender, EventArgs e)
        {
            fHoaDon f = new fHoaDon();
            f.ShowDialog();
        }

        private void fTrangChu_Load(object sender, EventArgs e)
        {
            for(int i=0; i<20; i++)
            {
                danhSachSanPham[i] = new ucSanPham();
                flowPnlSanPham.Controls.Add(danhSachSanPham[i]);
            }    
        }
    }
}
