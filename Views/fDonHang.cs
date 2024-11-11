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

        private void ThanhToan_Load(object sender, EventArgs e)
        {
            LoadDGVHienThi();
            LoadThongTinKhachHang();

            lblNgayMua.Text = Ngay.NgayHienTai(); 
            LoadThanhTien();
            lblMaHD.Text = DonHangDAO.LayMaDHChuaThanhToan();
        }

        private void tsDungDiemTichLuy_CheckedChanged(object sender, EventArgs e)
        {
            if (tsDungDiemTichLuy.Checked)
            {
                lblGiam.Text = txtSoDiemTichLuy.Text;
                LoadThanhTien();
            }
            else
            {
                lblGiam.Text = "0";
                LoadThanhTien();
            }
        }

        private void LoadThanhTien()
        {
            lblTongTien.Text = ChiTietHoaDonDAO.TinhTongTien().ToString();  
            lblThanhTien.Text = (Convert.ToDouble(lblTongTien.Text) - Convert.ToDouble(lblGiam.Text)).ToString();
        }

        private void LoadThongTinKhachHang()
        {  
            KhachHang kh = KhachHangDAO.LoadThongTinKhachHang(soDienThoai);
            txtTenKhachHang.Text = kh.TenKH;
            txtSoDienThoai.Text = soDienThoai;  
            txtSoDiemTichLuy.Text = kh.SoDiemTichLuy.ToString();
        }
           
        
        private void LoadDGVHienThi()
        {
            dgvHienThi.DataSource = DBConnection.LoadTableVaView("v_DanhSachSanPhamDaChon"); 
        }
          
        private void dgvHienThi_CellContentClick(object sender, DataGridViewCellEventArgs e)
        { 

           
        }

        private void dgvHienThi_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DGV.ChinhSizeCotTuDong(dgvHienThi);
        }

        private void btnXacNhanThanhToan_Click(object sender, EventArgs e)
        {
            DonHangDAO.XacNhanThanhToan();
            MessageBox.Show("Thanh toán thành công");
            this.Close();
        }

        private void btnSua_Click(object sender, EventArgs e)
        { 
            KhachHangDAO.SuaTenVaSoDienThoai(txtTenKhachHang.Text, soDienThoai, txtSoDienThoai.Text);
            soDienThoai = txtSoDienThoai.Text;
        }
    }
}
