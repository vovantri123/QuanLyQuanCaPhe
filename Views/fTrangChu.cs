using QuanLyQuanCaPhe.Database;
using QuanLyQuanCaPhe.Models;
using QuanLyQuanCaPhe.Utilities;
using QuanLyQuanCaPhe.Views.UserControls;
using System;
using System.Collections;
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
        List<ucSanPham> listUCSanPham  = new List<ucSanPham>(); //Tạo List dùng cho việc sắp xếp
        NhanVien nhanVien;
        public fTrangChu()
        {
            InitializeComponent();
        }

        public fTrangChu(NhanVien nv)
        {
            this.nhanVien = nv;
            InitializeComponent();
        }
        private void fTrangChu_Load(object sender, EventArgs e)
        {
            LoadDGVHienThi();
            LoadFlowPnlSanPham();

            LoadTongTien();

            btnXoaChonTatCa_Click(sender, e); //Để clear dữ liệu chưa thanh toán hoặc khi form bị tắt đột ngột

            lblNgayMua.Text = Ngay.NgayHienTai();
            cboSapXep.SelectedItem = "Tên: A -> Z";
            lblTenCuaBan.Text = nhanVien.HoTenNV;
        }
        
        private void ThemListUCVaoFlowPnlSanPham()
        {
            flowPnlSanPham.Controls.Clear();
            foreach (ucSanPham uc in listUCSanPham)
            {
                flowPnlSanPham.Controls.Add(uc);
            }    
        }

        private void LoadTongTien()
        {
            lblTongTien.Text = ChiTietHoaDonDAO.TinhTongTien().ToString();
        }

        private void LoadDGVHienThi()  
        {
            dgvHienThi.DataSource = DBConnection.LoadTableVaView("v_DanhSachSanPhamDaChon");
        }

        


        private void LoadFlowPnlSanPham() //Mặc định, dùng để tạo listUCSanPham và thêm vào flowPnlSanPham
        { 
            flowPnlSanPham.Controls.Clear();
            DataTable dataTable = DBConnection.LoadTableVaView("SanPham");
            ucSanPham sanPham;
             
            foreach (DataRow row in dataTable.Rows)
            {
                sanPham = new ucSanPham();
                sanPham.lblTenSP.Text = row["TenSP"].ToString(); // Lấy giá trị của cột TenSP
                sanPham.lblGia.Text = Tien.DinhDangTien(row["Gia"].ToString());  
                sanPham.pbSanPham.Image =  XyLyAnh.GetImage(row["AnhSP"].ToString());
                sanPham.lblMaSP.Text = row["MaSP"].ToString();
                sanPham.SuKienGoiFormChaTuFormCon += UCSanPhamGoiFTrangChu;

                listUCSanPham.Add(sanPham); 
            }

            ThemListUCVaoFlowPnlSanPham();
        }

        private void UCSanPhamGoiFTrangChu(object sender, ucSanPham.ThamSoThayDoi e)
        {
            LoadDGVHienThi();
            LoadTongTien();
        }

        private void cboSapXep_SelectedIndexChanged(object sender, EventArgs e) //Sắp xếp ListUC rồi thêm vào flowPnlSanPham
        {
            string dieuKienSapXep = cboSapXep.SelectedItem.ToString();
            if (dieuKienSapXep == "Giá: Thấp -> Cao")
                listUCSanPham.Sort((x, y) => Double.Parse(x.lblGia.Text).CompareTo(Double.Parse(y.lblGia.Text)));
            else if (dieuKienSapXep == "Giá: Cao -> Thấp")
                listUCSanPham.Sort((x, y) => Double.Parse(y.lblGia.Text).CompareTo(Double.Parse(x.lblGia.Text)));
            else if (dieuKienSapXep == "Tên: Z -> A")
                listUCSanPham.Sort((x, y) => y.lblTenSP.Text.CompareTo(x.lblTenSP.Text));
            else
                listUCSanPham.Sort((x, y) => x.lblTenSP.Text.CompareTo(y.lblTenSP.Text));

            ThemListUCVaoFlowPnlSanPham();
        }

        private void btnQLSanPham_Click(object sender, EventArgs e)
        {
            fQLSanPham f = new fQLSanPham();
            f.ShowDialog();
        }

        private void btnQLKhoHang_Click(object sender, EventArgs e)
        {
            fQLKhoHang f = new fQLKhoHang();
            f.ShowDialog();
        }

        private void btnThanhToan_Click(object sender, EventArgs e)
        {
            DonHangDAO.CapNhatGiaTriDonHangChuaThanhToan();
            fDonHang f = new fDonHang(nhanVien, txtSoDienThoai.Text); 
            f.ShowDialog();
        }

        private void btnHoaDon_Click(object sender, EventArgs e)
        {
            fQLHoaDon f = new fQLHoaDon();
            f.ShowDialog();
        }

        private void btnQLNhanVien_Click(object sender, EventArgs e)
        {
            fQLNhanVien f = new fQLNhanVien();
            f.ShowDialog();
        }

        private void btnQLPhanCa_Click(object sender, EventArgs e)
        {
            fQLPhanCa f = new fQLPhanCa(nhanVien);
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
            fQLKhachHang f = new fQLKhachHang();
            f.ShowDialog();
        }

        private void dgvHienThi_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DGV.ChinhSizeCotTuDong(dgvHienThi);
        }

        private void txtTimKiemTheoTenSP_TextChanged(object sender, EventArgs e) //K có thao tác gì trên ListUCSanPham, mà gán thẳng vô flowPnlSanPham
        {
            if (txtTimKiemTheoTenSP.Text.Length > 0)
            {

                flowPnlSanPham.Controls.Clear();
                DataTable dataTable = SanPhamDAO.TimKiem(txtTimKiemTheoTenSP.Text.Trim());
                ucSanPham sanPham;
                foreach (DataRow row in dataTable.Rows)
                {
                    sanPham = new ucSanPham();
                    sanPham.lblTenSP.Text = row["TenSP"].ToString();
                    sanPham.lblGia.Text = Tien.DinhDangTien(row["Gia"].ToString());
                    sanPham.pbSanPham.Image = XyLyAnh.GetImage(row["AnhSP"].ToString());
                    sanPham.lblMaSP.Text = row["MaSP"].ToString();

                    sanPham.SuKienGoiFormChaTuFormCon += UCSanPhamGoiFTrangChu;

                    flowPnlSanPham.Controls.Add(sanPham);
                }
            }
            else
            {
                cboSapXep_SelectedIndexChanged(sender, e);
            }    
                
        }

        private void btnNewOrder_Click(object sender, EventArgs e)
        {   
                KhachHangDAO.Them(txtSoDienThoai.Text);
                DonHangDAO.Them(txtSoDienThoai.Text, nhanVien.MaNV);

                btnXoaChonTatCa.Enabled = true;
                dgvHienThi.Visible = true;
                btnNewOrder.Enabled = false;
                btnThanhToan.Enabled = true;

                LoadDGVHienThi(); 
        }

        private void btnXoaChonTatCa_Click(object sender, EventArgs e)
        { 
            DonHangDAO.XoaDonChuaThanhToan();

            btnXoaChonTatCa.Enabled = false;
            dgvHienThi.Visible = false;
            btnNewOrder.Enabled = true;
            btnThanhToan.Enabled = false;

            LoadTongTien();
        }

        private void btnDangXuat_Click(object sender, EventArgs e)
        {
            DialogResult result = MessageBox.Show("Bạn có chắc chắn muốn đăng xuất?", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question);

            if (result == DialogResult.Yes)
            {
                this.Close(); // Đóng fTrangChu, sẽ tự động hiển thị lại form đăng nhập
            }
        }
    }
}
