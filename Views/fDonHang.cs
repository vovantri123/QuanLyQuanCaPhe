using QuanLyQuanCaPhe.Database;
using QuanLyQuanCaPhe.Utilities;
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
    public partial class fDonHang : Form
    {
        public fDonHang()
        {
            InitializeComponent();
        }

        private void LoadDGVHienThi()
        {
            dgvHienThi.DataSource = DBConnection.LoadTableVaView("V_DanhSachSanPhamDaChon");
        }

        private void ThanhToan_Load(object sender, EventArgs e)
        {
            LoadDGVHienThi();
        }

        private void dgvHienThi_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dgvHienThi_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DGV.ChinhSizeCotTuDong(dgvHienThi);
        }
    }
}
