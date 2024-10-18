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
    public partial class fKhachHang : Form
    {
        public fKhachHang()
        {
            InitializeComponent();
        }

        private void LoadDGVHienThi()
        {
            dgvHienThi.DataSource = DBConnection.LoadTableVaView("KhachHang");
        }
         
        private void fKhachHang_Load(object sender, EventArgs e)
        {
            LoadDGVHienThi();
        }

        private void dgvHienThi_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            // Kiểm tra nếu click vào cell hợp lệ (không phải header)
            if (e.RowIndex >= 0 && e.ColumnIndex >= 0)
            {
                // Lấy dòng dữ liệu tương ứng
                DataGridViewRow row = dgvHienThi.Rows[e.RowIndex];

                // Gán dữ liệu từ dòng đã chọn vào các textbox
                txtMaKH.Text = row.Cells["MaKH"].Value.ToString();
                txtTenKH.Text = row.Cells["TenKH"].Value.ToString();
                txtSoDienThoai.Text = row.Cells["SoDienThoai"].Value.ToString();
                txtSoDiemTichLuy.Text = row.Cells["SoDiemTichLuy"].Value.ToString();
            }
        }

        private void dgvHienThi_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DGV.ChinhSizeCotTuDong(dgvHienThi);
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            double diemTichLuy = double.Parse(txtSoDiemTichLuy.Text);
            KhachHang kh = new KhachHang(txtMaKH.Text, txtTenKH.Text, txtSoDienThoai.Text, diemTichLuy);
            KhachHangDAO.Them(kh);
            fKhachHang_Load(sender,e); // Gọi lại phương thức để tải ca làm việc mới nhất
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            double diemTichLuy = double.Parse(txtSoDiemTichLuy.Text);
            KhachHang kh = new KhachHang(txtMaKH.Text, txtTenKH.Text, txtSoDienThoai.Text, diemTichLuy);
            KhachHangDAO.Sua(kh);
            fKhachHang_Load(sender, e); // Gọi lại phương thức để tải ca làm việc mới nhất
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            KhachHang kh = new KhachHang(txtMaKH.Text);
            KhachHangDAO.Xoa(kh);
            fKhachHang_Load(sender, e); // Gọi lại phương thức để tải ca làm việc mới nhất
        }

        private void txtTimKiemSDT_TextChanged(object sender, EventArgs e)
        {
            dgvHienThi.DataSource = KhachHangDAO.TimKiem(txtTimKiemSDT.Text.Trim());
        }

        private void label8_Click(object sender, EventArgs e)
        {

        }

        private void guna2Shapes2_Click(object sender, EventArgs e)
        {
                    
        }
    }
}
