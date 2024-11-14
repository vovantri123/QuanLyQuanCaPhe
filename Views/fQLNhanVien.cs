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
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace QuanLyQuanCaPhe.Views
{
    public partial class fQLNhanVien : Form
    {
        private string vaiTro;
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
            txtLuong.Clear();
            txtSoGio.Clear();
            if (e.RowIndex >= 0 && e.ColumnIndex >= 0)
            {
                DataGridViewRow row = dgvHienThi.Rows[e.RowIndex];
                txtMaNV.Text = row.Cells["MaNV"].Value.ToString();
                txtHoTen.Text = row.Cells["HoTenNV"].Value.ToString();
                txtSoDienThoai.Text = row.Cells["SoDienThoai"].Value.ToString();
                txtNamSinh.Text = row.Cells["NamSinh"].Value.ToString();
                cboGioiTinh.Text = row.Cells["GioiTinh"].Value.ToString();
                txtEmail.Text = row.Cells["Email"].Value.ToString();
                txtDiaChi.Text = row.Cells["DiaChi"].Value.ToString();
                txtbTenDangNhap.Text = row.Cells["TenDangNhap"].Value.ToString();
                txtMatKhau.Text = row.Cells["MatKhau"].Value.ToString();
                string luongCoDinh = row.Cells["LuongCoDinh"].Value?.ToString();
                
                if (string.IsNullOrEmpty(luongCoDinh))
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
            //bool co = false;
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
                //co = true;
            }
            catch(Exception ex) 
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                LoadDGVHienThi();
                //if (co)
                    //MessageBox.Show("Thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            


        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            //bool co = false;
            try
            {
                string hoTen = txtHoTen.Text;
                string sdt = txtSoDienThoai.Text;
                string namSinh = txtNamSinh.Text;
                string gioiTinh = cboGioiTinh.Text;
                string diaChi = txtDiaChi.Text;
                string email = txtEmail.Text;
                string tenDangNhap = txtbTenDangNhap.Text;
                string matKhau = txtMatKhau.Text;
                string loaiNV = cboLoaiNV.Text;
                NhanVien nv = new NhanVien("NV00", hoTen, sdt, Convert.ToInt32(namSinh), gioiTinh, diaChi, email,tenDangNhap, matKhau);
                NhanVienDAO.Them(nv, loaiNV);
                //co = true;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                LoadDGVHienThi();
                //if(co)
                //    MessageBox.Show("Thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            //bool co = false;
            try
            {
                string maNV = txtMaNV.Text;
                string hoTen = txtHoTen.Text;
                string sdt = txtSoDienThoai.Text;
                string namSinh = txtNamSinh.Text;
                int year = Convert.ToInt32(namSinh);
                string gioiTinh = cboGioiTinh.Text;
                string diaChi = txtDiaChi.Text;
                string email = txtEmail.Text;
                string tenDangNhap = txtbTenDangNhap.Text;
                string matKhau = txtMatKhau.Text;
                string loaiNV = cboLoaiNV.Text;
                string luongCoDinh = txtLuong.Text;
                
                double luong = Convert.ToDouble(luongCoDinh);
                if (loaiNV=="Toàn thời gian")
                {
                    NhanVien nv = new NhanVien(maNV, hoTen, sdt, Convert.ToInt32(namSinh), gioiTinh, diaChi, email, tenDangNhap, matKhau);
                    NhanVienToanThoiGian nvToanTG = new NhanVienToanThoiGian(maNV, hoTen, sdt, year, gioiTinh, diaChi, email,tenDangNhap, matKhau, luong);
                    NhanVienToanThoiGianDAO.Sua(nvToanTG);
                    NhanVienDAO.Sua(nv);
                    
                   
                }
                else
                {
                    string gio = txtSoGio.Text;
                    int soGio = Convert.ToInt32(gio);
                    NhanVien nv = new NhanVien(maNV, hoTen, sdt, Convert.ToInt32(namSinh), gioiTinh, diaChi, email, tenDangNhap, matKhau);
                    NhanVienBanThoiGian nvBanTG = new NhanVienBanThoiGian(maNV, hoTen, sdt, year, gioiTinh, diaChi, email,tenDangNhap, matKhau, luong, soGio);
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
                //if (co)
                //{
                //    MessageBox.Show("Thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                //}
            }

        }

        private void btnPhatLuong_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime selectedDate = dtpNgayPhatLuong.Value;
                string maNV = txtMaNV.Text;
                int month = selectedDate.Month;
                int year = selectedDate.Year;


                string hoTen = txtHoTen.Text;
                string sdt = txtSoDienThoai.Text;
                string namSinh = txtNamSinh.Text;
                int nam = Convert.ToInt32(namSinh);
                string gioiTinh = cboGioiTinh.Text;
                string diaChi = txtDiaChi.Text;
                string email = txtEmail.Text;
                string tenDangNhap = txtbTenDangNhap.Text;
                string matKhau = txtMatKhau.Text;
                string loaiNV = cboLoaiNV.Text;
                string luongCoDinh = txtLuong.Text;
                double luongTruoc = Convert.ToDouble(txtLuong.Text);


                double Luong = Convert.ToDouble(NhanVienDAO.tinhLuongNV(maNV, month, year));
                NhanVienDAO.guiMail(maNV, month, year, Luong);
                if (cboLoaiNV.Text.Equals("Bán thời gian"))
                {
                    NhanVienBanThoiGian nvBanTG = new NhanVienBanThoiGian(maNV, hoTen, sdt, nam, gioiTinh, diaChi, email, tenDangNhap, matKhau, luongTruoc, 0);
                    NhanVienBanThoiGianDAO.Sua(nvBanTG);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi "+ex.Message);
            }
            finally
            {
                LoadDGVHienThi();
            }
           
        }

        private void cboLoaiNV_SelectedIndexChanged(object sender, EventArgs e)
        {
            string loaiNV = cboLoaiNV.SelectedItem.ToString();
            if (loaiNV.Equals("Toàn thời gian"))
            {
                txtSoGio.Clear();
                txtSoGio.Enabled = false;
                txtLuong.Enabled = true;
            }
            else
            {
                txtSoGio.Enabled = true;
                txtLuong.Enabled = true;
            }
        }
    }
}
