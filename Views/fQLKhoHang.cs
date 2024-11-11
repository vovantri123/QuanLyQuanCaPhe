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
    public partial class fQLKhoHang : Form
    {
        public fQLKhoHang()
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

        private string thongTinOThu_dgvDSSanPham(int i) //Các ô trên một hàng (chỉ số cột)
        {
            return dgvHienThi.CurrentRow.Cells[i].Value.ToString();
        }

        private void dgvHienThi_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            txtMaNguyenLieu.Text = thongTinOThu_dgvDSSanPham(0);
            txtTenNguyenLieu.Text = thongTinOThu_dgvDSSanPham(1);
            nudSoLuong.Value = Convert.ToInt32(thongTinOThu_dgvDSSanPham(2)); 
        }

        private void dgvHienThi_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DGV.ChinhSizeCotTuDong(dgvHienThi);
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            NguyenLieu nl = new NguyenLieu("NL00", txtTenNguyenLieu.Text, Convert.ToInt32(nudSoLuong.Value)); //"" do có trigger sinh MaNL tự động
            NguyenLieuDAO.Them(nl);
            LoadDGVHienThi();
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            NguyenLieuDAO.Xoa(txtMaNguyenLieu.Text);
            LoadDGVHienThi();
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            NguyenLieu nl = new NguyenLieu(txtMaNguyenLieu.Text, txtTenNguyenLieu.Text, Convert.ToInt32(nudSoLuong.Value));
            NguyenLieuDAO.Sua(nl);
            LoadDGVHienThi();
        }

        private void txtTimKiem_TextChanged(object sender, EventArgs e)
        {
            dgvHienThi.DataSource = NguyenLieuDAO.TimKiemTheoTenNguyenLieu(txtTimKiem.Text.Trim());
        }
    }
}
