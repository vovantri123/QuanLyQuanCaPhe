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
    public partial class fDonHang : Form
    {
        //được khởi tạo bên dưới
        KhachHang kh; 

        //Tham sô truyền giữa các form
        private string maNV;
        private string soDienThoai;

        public fDonHang()
        {
            InitializeComponent();
        }

        public fDonHang(string maNV, string soDienThoai) //xử lý đơn chưa thanh toán
        {
            this.maNV = maNV;
            this.soDienThoai = soDienThoai;
            InitializeComponent();
        }

        private void LoadThongTinKhachHang()
        {

            this.soDienThoai = "0981234567";
             kh = KhachHangDAO.LoadThongTinKhachHang(soDienThoai);
            txtTenKhachHang.Text = kh.TenKH;
            txtSoDienThoai.Text = soDienThoai;  
            txtSoDiemTichLuy.Text = kh.SoDiemTichLuy.ToString();
        }

        private void LoadDGVHienThi()
        {
            dgvHienThi.DataSource = DBConnection.LoadTableVaView("v_DanhSachSanPhamDaChon");
            LoadThongTinKhachHang();
        }

        private void ThanhToan_Load(object sender, EventArgs e)
        {
            LoadDGVHienThi();

            lblNgayMua.Text = Ngay.NgayHienTai();
        }

        private void dgvHienThi_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dgvHienThi_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DGV.ChinhSizeCotTuDong(dgvHienThi);
        }

        private void tsDungDiemTichLuy_CheckedChanged(object sender, EventArgs e)
        {
            if(tsDungDiemTichLuy.Checked)
            {  }
        }
    }
}
