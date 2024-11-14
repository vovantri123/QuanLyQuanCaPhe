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
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace QuanLyQuanCaPhe.Views
{
    public partial class fQLSanPham : Form
    { 

        public fQLSanPham()
        {
            InitializeComponent();
        }

        private void fQLSanPham_Load(object sender, EventArgs e)
        {  
            LoadDgvDSSanPham();


            dgvDSNguyenLieuCuaSanPham.Columns.Clear();
            dgvDSNguyenLieuCuaSanPham.DataSource = DBConnection.LoadTableVaView("v_NguyenLieuDungDePhaCheSanPham"); //Chỉ dùng cái view này 1 lần lúc load
            // Thêm cột button Xóa vào DataGridView
            DataGridViewButtonColumn buttonColumn = new DataGridViewButtonColumn();
            buttonColumn.HeaderText = "Action"; // Tiêu đề cột
            buttonColumn.Text = "Xóa"; // Văn bản hiển thị trên nút
            buttonColumn.UseColumnTextForButtonValue = true; // Sử dụng văn bản cho tất cả các hàng 
            dgvDSNguyenLieuCuaSanPham.Columns.Add(buttonColumn);


            LoadComboBox();
        }


        private void LoadDgvDSSanPham()
        {
            dgvDSSanPham.DataSource = DBConnection.LoadTableVaView("v_DanhSachSanPham");
        }

        private void LoadDgvDSNguyenLieuCuaSanPham()
        {

            dgvDSNguyenLieuCuaSanPham.Columns.Clear();
            dgvDSNguyenLieuCuaSanPham.DataSource = PhaCheDAO.LoadDSNguyenLieuTheoMaSanPham(txtMaSP.Text);
            // Thêm cột button Xóa vào DataGridView
            DataGridViewButtonColumn buttonColumn = new DataGridViewButtonColumn();
            buttonColumn.HeaderText = "Action"; // Tiêu đề cột
            buttonColumn.Text = "Xóa"; // Văn bản hiển thị trên nút
            buttonColumn.UseColumnTextForButtonValue = true; // Sử dụng văn bản cho tất cả các hàng 
            dgvDSNguyenLieuCuaSanPham.Columns.Add(buttonColumn);
        }

        private void LoadDGVHienThi()
        {
            LoadDgvDSSanPham();
            LoadDgvDSNguyenLieuCuaSanPham();
        }

        private void LoadComboBox()
        {
            DataTable tableLoaiSanPham = DBConnection.LoadTableVaView("LoaiSanPham");  
            cboLoaiSP.DataSource = tableLoaiSanPham;
            cboLoaiSP.DisplayMember = "TenLoaiSP";  
            cboLoaiSP.ValueMember = "MaLoaiSP";    

            DataTable tableNguyenLieu = DBConnection.LoadTableVaView("NguyenLieu");  
            cboTenNL.DataSource = tableNguyenLieu; 
            cboTenNL.DisplayMember = "TenNL";  
            cboTenNL.ValueMember = "MaNL";
        }

        

       

        private string thongTinOThu_dgvDSSanPham(int i) //Các ô trên một hàng (chỉ số cột)
        {
            return dgvDSSanPham.CurrentRow.Cells[i].Value.ToString();
        }

        private void dgvDSSanPham_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            txtMaSP.Text = thongTinOThu_dgvDSSanPham(0);
            txtTenSP.Text = thongTinOThu_dgvDSSanPham(1);
            txtGia.Text = thongTinOThu_dgvDSSanPham(2);
            cboLoaiSP.Text = thongTinOThu_dgvDSSanPham(3);

            lblTenFileAnh.Text = thongTinOThu_dgvDSSanPham(4);
            lblDuongDanAnh.Text = XyLyAnh.layDuongDanDayDuToiFileAnhSanPham(lblTenFileAnh.Text);
            pbAnhSP.Image = new Bitmap(lblDuongDanAnh.Text);

            LoadDgvDSNguyenLieuCuaSanPham();
        }


        private string thongTinOThu_dgvDSNguyenLieuCuaSanPham(int i)  
        { 
            if (dgvDSNguyenLieuCuaSanPham.CurrentRow != null)
            { 
                return dgvDSNguyenLieuCuaSanPham.CurrentRow.Cells[i].Value.ToString();
            }
            return "0";
        }

        private void dgvDSNguyenLieuCuaSanPham_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            cboTenNL.SelectedValue = thongTinOThu_dgvDSNguyenLieuCuaSanPham(1); 
            nudSoLuong.Value = Convert.ToInt32(thongTinOThu_dgvDSNguyenLieuCuaSanPham(3));

        }

        private void dgvDSSanPham_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DGV.ChinhSizeCotTuDong(dgvDSSanPham);
        }

        private void dgvDSNguyenLieuCuaSanPham_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DGV.ChinhSizeCotTuDong(dgvDSNguyenLieuCuaSanPham);
        }

        private void btnChonAnh_Click(object sender, EventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.Filter = "Image files (*.jpg, *.jpeg, *.png) | *.jpg; *.jpeg; *.png";
            openFileDialog.InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);

            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                string selectedFileName = openFileDialog.FileName; //Chứa đường dần đầ đủ tới cái ảnh

                // Sử dụng Bitmap để hiển thị hình ảnh trong PictureBox
                pbAnhSP.Image = new Bitmap(selectedFileName);

                lblTenFileAnh.Text = System.IO.Path.GetFileName(selectedFileName); // Lưu tên file từ mục đã chọn
                lblDuongDanAnh.Text = selectedFileName;
            }
        }

        private void btnThemSP_Click(object sender, EventArgs e)
        {
            SanPham sp = new SanPham("SP00",txtTenSP.Text, Convert.ToDouble(txtGia.Text), lblTenFileAnh.Text, cboLoaiSP.SelectedValue.ToString());
            SanPhamDAO.Them(sp);

            XyLyAnh.LuuAnhVaoThuMuc(lblDuongDanAnh.Text, "HinhSanPham");

            LoadDGVHienThi();
        }

        private void btnXoaSP_Click(object sender, EventArgs e)
        { 
            SanPhamDAO.Xoa(txtMaSP.Text.Trim()); 
            LoadDGVHienThi();
        }

        private void btnSuaSP_Click(object sender, EventArgs e)
        {
            SanPham sp = new SanPham(txtMaSP.Text.Trim(), txtTenSP.Text, Convert.ToDouble(txtGia.Text), lblTenFileAnh.Text, cboLoaiSP.SelectedValue.ToString());
            SanPhamDAO.Sua(sp);

            XyLyAnh.LuuAnhVaoThuMuc(lblDuongDanAnh.Text, "HinhSanPham");

            LoadDGVHienThi();
        }

        private void txtTimKiemTheoTenSP_TextChanged(object sender, EventArgs e)
        {
            dgvDSSanPham.DataSource = SanPhamDAO.TimKiem(txtTimKiemTheoTenSP.Text.Trim());
        }

        private void btnThemNL_Click(object sender, EventArgs e)
        {
            PhaChe pc = new PhaChe(txtMaSP.Text,cboTenNL.SelectedValue.ToString(),Convert.ToInt32(nudSoLuong.Value));
            PhaCheDAO.Them(pc);
            LoadDgvDSNguyenLieuCuaSanPham();
        }

        private void dgvDSNguyenLieuCuaSanPham_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            // Kiểm tra nếu người dùng nhấn vào cột có nút "Xóa"
            if (e.ColumnIndex == dgvDSNguyenLieuCuaSanPham.Columns.Count - 1 && e.RowIndex >= 0)
            { 
                string maNguyenLieu = dgvDSNguyenLieuCuaSanPham.Rows[e.RowIndex].Cells[1].Value.ToString();
                 
                string maSanPham = txtMaSP.Text;

                // Xác nhận hành động xóa
                DialogResult result = MessageBox.Show("Bạn có chắc chắn muốn xóa nguyên liệu này khỏi sản phẩm?", "Xác nhận xóa", MessageBoxButtons.YesNo);
                if (result == DialogResult.Yes)
                { 
                    PhaCheDAO.Xoa(maSanPham, maNguyenLieu); 
                    LoadDgvDSNguyenLieuCuaSanPham();
                }
            }
        }
    }
}
