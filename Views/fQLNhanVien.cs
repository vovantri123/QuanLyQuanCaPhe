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
    public partial class fQLNhanVien : Form
    {
        public fQLNhanVien()
        {
            InitializeComponent();
        }

        private void LoadDGVHienThi()
        {
            dgvHienThi.DataSource = DBConnection.LoadTableVaView("v_DanhSachNhanVien");
        }



        private void dgvHienThi_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0 && e.ColumnIndex >= 0)
            {
                DataGridViewRow row = dgvHienThi.Rows[e.RowIndex];
                txtMaNV.Text = row.Cells["MaNV"].Value.ToString();
                txtHoTen.Text = row.Cells["HoTenNV"].Value.ToString();
                txtSoDienThoai.Text = row.Cells["SoDienThoai"].Value.ToString();
                txtNamSinh.Text = row.Cells["NamSinh"].Value.ToString();
                cboGioiTinh.Text = row.Cells["GioiTinh"].Value.ToString();
                txtDiaChi.Text = row.Cells["DiaChi"].Value.ToString();
                txtbTenDangNhap.Text = row.Cells["TenDangNhap"].Value.ToString();
                txtMatKhau.Text = row.Cells["MatKhau"].Value.ToString();
                string luongCoDinh = row.Cells["LuongCoDinh"].Value.ToString();
                if (String.IsNullOrEmpty(luongCoDinh))
                {
                    cboLoaiNV.Text = "Bán thời gian";
                    txtSoGio.Text = row.Cells["SoGio"].Value.ToString();
                    txtLuong.Text = row.Cells["LuongTheoGio"].Value.ToString();
                }
                else
                {
                    cboLoaiNV.Text = "Toàn thời gian";
                    txtLuong.Text = luongCoDinh;
                }
            }


        }

        private void fQLNhanVien_Load(object sender, EventArgs e)
        {
            LoadDGVHienThi();
        }

        private void dgvHienThi_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DGV.ChinhSizeCotTuDong(dgvHienThi);
        }

        private void txtTimTenNV_TextChanged(object sender, EventArgs e)
        {
            string ten = txtTimTenNV.Text;
            if (String.IsNullOrEmpty(ten))
            {
                LoadDGVHienThi();
            }
            else
            {
                dgvHienThi.DataSource = NhanVienDAO.timKiemNhanVienTheoTen(ten);

            }

        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            try
            {
                string maNV = txtMaNV.Text;
                string loaiNV = cboLoaiNV.Text;

                if (loaiNV.Equals("Toàn thời gian"))
                {
                    NhanVienToanThoiGianDAO.Xoa(maNV);
                }
                else
                {
                    NhanVienBanThoiGianDAO.Xoa(maNV);
                }
                NhanVienDAO.Xoa(maNV);
                ThucHienDAO.Xoa(maNV);
            }
            catch(Exception ex) 
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                LoadDGVHienThi();
            }
            


        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            string hoTen = txtHoTen.Text;
            string sdt = txtSoDienThoai.Text;
            string namSinh = txtNamSinh.Text;
            string gioiTinh = cboGioiTinh.Text;
            string diaChi = txtDiaChi.Text;
            string tenDangNhap = txtbTenDangNhap.Text;
            string matKhau = txtMatKhau.Text;
            string loaiNV = cboLoaiNV.Text;
            NhanVien nv = new NhanVien("", hoTen, sdt, Convert.ToInt32(namSinh), gioiTinh, diaChi, tenDangNhap, matKhau);
            NhanVienDAO.Them(nv, loaiNV);
            LoadDGVHienThi();
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            try
            {
                string maNV = txtMaNV.Text;
                string hoTen = txtHoTen.Text;
                string sdt = txtSoDienThoai.Text;
                string namSinh = txtNamSinh.Text;
                int year = Convert.ToInt32(namSinh);
                string gioiTinh = cboGioiTinh.Text;
                string diaChi = txtDiaChi.Text;
                string tenDangNhap = txtbTenDangNhap.Text;
                string matKhau = txtMatKhau.Text;
                string loaiNV = cboLoaiNV.Text;
                string luongCoDinh = txtLuong.Text;
                string gio = txtSoGio.Text;
                int soGio = Convert.ToInt32(gio);
                double luong = Convert.ToDouble(luongCoDinh);
                if (loaiNV.Equals("Toàn thời gian"))
                {
                    NhanVien nv = new NhanVien(maNV, hoTen, sdt, Convert.ToInt32(namSinh), gioiTinh, diaChi, tenDangNhap, matKhau);
                    NhanVienToanThoiGian nvToanTG = new NhanVienToanThoiGian(maNV, hoTen, sdt, year, gioiTinh, diaChi, tenDangNhap, matKhau, luong);
                    NhanVienToanThoiGianDAO.Sua(nvToanTG);
                    NhanVienDAO.Sua(nv);
                }
                else
                {
                    NhanVien nv = new NhanVien(maNV, hoTen, sdt, Convert.ToInt32(namSinh), gioiTinh, diaChi, tenDangNhap, matKhau);
                    NhanVienBanThoiGian nvBanTG = new NhanVienBanThoiGian(maNV, hoTen, sdt, year, gioiTinh, diaChi, tenDangNhap, matKhau, luong, soGio);
                    NhanVienBanThoiGianDAO.Sua(nvBanTG);
                    NhanVienDAO.Sua(nv);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi"+ex);
            }
            finally
            {
                
                LoadDGVHienThi();
            }

        }

       
    }
}
