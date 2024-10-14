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
    public partial class fKhoHang : Form
    {
        public fKhoHang()
        {
            InitializeComponent();
        }

        private void LoadDGVHienThi()
        {
            dgvHienThi.DataSource = DBConnection.LoadTableVaView("NguyenLieu");
        }

        private void fKhoHang_Load(object sender, EventArgs e)
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
