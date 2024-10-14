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
    public partial class fQLSanPham : Form
    {
        public fQLSanPham()
        {
            InitializeComponent();
        }

        private void LoadDGVHienThi()
        {
            dgvDSSanPham.DataSource = DBConnection.LoadTableVaView("V_DanhSachSanPham");
            dgvDSNguyenLieuCuaSanPham.DataSource = DBConnection.LoadTableVaView("V_NguyenLieuDungDePhaCheSanPham");
        }

        private void fQLSanPham_Load(object sender, EventArgs e)
        {
            LoadDGVHienThi();


            // Thêm cột button Xóa vào DataGridView
            DataGridViewButtonColumn buttonColumn = new DataGridViewButtonColumn();
            buttonColumn.HeaderText = "Action"; // Tiêu đề cột
            buttonColumn.Text = "Xóa"; // Văn bản hiển thị trên nút
            buttonColumn.UseColumnTextForButtonValue = true; // Sử dụng văn bản cho tất cả các hàng
            dgvDSNguyenLieuCuaSanPham.Columns.Add(buttonColumn);
        }

        private void dgvDSSanPham_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dgvDSSanPham_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DGV.ChinhSizeCotTuDong(dgvDSSanPham);
        }

        private void dgvDSNguyenLieuCuaSanPham_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DGV.ChinhSizeCotTuDong(dgvDSNguyenLieuCuaSanPham);
        }
    }
}
