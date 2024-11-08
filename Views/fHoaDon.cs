using QuanLyQuanCaPhe.Database;
using QuanLyQuanCaPhe.Models;
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
    public partial class fHoaDon : Form
    {
        public fHoaDon()
        {
            InitializeComponent();
        }

        private void LoadDGVHienThi()
        {
            dgvHienThi.DataSource = DBConnection.LoadTableVaView("v_DanhSachHoaDon");
        }

        private void fHoaDon_Load(object sender, EventArgs e)
        {
            LoadDGVHienThi();
        }

        private void dgvHienThi_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DGV.ChinhSizeCotTuDong(dgvHienThi);
        }

        private void txtSoDienThoai_TextChanged(object sender, EventArgs e)
        {
            dgvHienThi.DataSource = DonHangDAO.TimKiemTheoSDT(txtSoDienThoai.Text.Trim());
        }
    }
}
