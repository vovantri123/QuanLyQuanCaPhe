using QuanLyQuanCaPhe.Database;
using QuanLyQuanCaPhe.Models;
using QuanLyQuanCaPhe.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Common;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanCaPhe.Views
{
    public partial class fQLLoaiSanPham : Form
    {
        public fQLLoaiSanPham()
        {
            InitializeComponent();
        }

        private void LoadDGVHienThi()
        {
            dgvHienThi.DataSource = DBConnection.LoadTableVaView("LoaiSanPham");
        }

        private void fQLLoaiSanPham_Load(object sender, EventArgs e)
        {
            LoadDGVHienThi();
        }

        private void btnThem_Click(object sender, EventArgs e)
        { 
            LoaiSanPham lsp = new LoaiSanPham("LSP00", txtTenLoaiSP.Text);
            LoaiSanPhamDAO.Them(lsp);
            LoadDGVHienThi();
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            LoaiSanPhamDAO.Xoa(txtMaSP.Text);
            LoadDGVHienThi();
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            LoaiSanPham lsp = new LoaiSanPham(txtMaSP.Text, txtTenLoaiSP.Text);
            LoaiSanPhamDAO.Sua(lsp);
            LoadDGVHienThi();
        }

        private string thongTinOThu(int i) //Các ô trên một hàng
        {
            return dgvHienThi.CurrentRow.Cells[i].Value.ToString();
        }

        private void dgvHienThi_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            txtMaSP.Text = thongTinOThu(0);
            txtTenLoaiSP.Text = thongTinOThu(1);
        }

        private void dgvHienThi_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)  
        {
            DGV.ChinhSizeCotTuDong(dgvHienThi);
        }

        private void txtTimKiemTheoTen_TextChanged(object sender, EventArgs e)
        {
            dgvHienThi.DataSource = LoaiSanPhamDAO.TimKiem(txtTimKiemThemTen.Text.Trim());   
        }
    }
}
