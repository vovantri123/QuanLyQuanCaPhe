using QuanLyQuanCaPhe.Database;
using QuanLyQuanCaPhe.Utilities;
using QuanLyQuanCaPhe.Views.UserControls;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.WebSockets;
using System.Windows.Forms; 

namespace QuanLyQuanCaPhe.Views
{
    public partial class fTrangChu : Form
    {
        ucSanPham[] danhSachSanPham = new ucSanPham[150];

        public fTrangChu()
        {
            InitializeComponent();
        }

        private void LoadDGVHienThi()
        {
            dgvHienThi.DataSource = DBConnection.LoadTableVaView("V_DanhSachSanPhamDaChon");
        }
        
        private void LoadFlowPnlSanPham()
        { 
            DataTable dataTable = DBConnection.LoadTableVaView("V_DanhSachSanPham");
            int i = 0;
            foreach (DataRow row in dataTable.Rows)
            { 
                danhSachSanPham[i] = new ucSanPham();
                danhSachSanPham[i].lblTenSP.Text = row["TenSP"].ToString(); // Lấy giá trị của cột TenSP
                danhSachSanPham[i].lblGia.Text = Tien.dinhDangTien(row["Gia"].ToString()); // Lấy giá trị của cột Gia
                flowPnlSanPham.Controls.Add(danhSachSanPham[i]);
                danhSachSanPham[i].pbSanPham.Image =  XyLyAnh.GetImage("img.jpg");
                i++;
            } 
        }
         
        private void fTrangChu_Load(object sender, EventArgs e)
        {
            LoadDGVHienThi();
            LoadFlowPnlSanPham();


        }

        private void btnSanPham_Click(object sender, EventArgs e)
        {
            fQLSanPham f = new fQLSanPham();
            f.ShowDialog();
        }

        private void btnKhoHang_Click(object sender, EventArgs e)
        {
            fKhoHang f = new fKhoHang();
            f.ShowDialog();
        }

        private void btnThanhToan_Click(object sender, EventArgs e)
        {
            fDonHang f = new fDonHang();
            f.ShowDialog();
        }

        private void btnHoaDon_Click(object sender, EventArgs e)
        {
            fHoaDon f = new fHoaDon();
            f.ShowDialog();
        }

        private void btnQLNhanVien_Click(object sender, EventArgs e)
        {
            fQLNhanVien f = new fQLNhanVien();
            f.ShowDialog();
        }

        private void btnPhanCa_Click(object sender, EventArgs e)
        {
            fPhanCa f = new fPhanCa();
            f.ShowDialog();
        }

        private void btnThongKe_Click(object sender, EventArgs e)
        {
            fThongKe f = new fThongKe();
            f.ShowDialog();
        }
         

        private void btnQLLoaiSanPham_Click(object sender, EventArgs e)
        {
            fQLLoaiSanPham f = new fQLLoaiSanPham();
            f.ShowDialog();
        }

        private void btnQLKhachHang_Click(object sender, EventArgs e)
        {
            fKhachHang f = new fKhachHang();
            f.ShowDialog();
        }

        private void dgvHienThi_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DGV.ChinhSizeCotTuDong(dgvHienThi);
        }
    }
}
