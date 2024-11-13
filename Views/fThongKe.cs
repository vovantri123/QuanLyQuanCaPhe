using QuanLyQuanCaPhe.Database;
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
using ZedGraph;

namespace QuanLyQuanCaPhe.Views
{
    public partial class fThongKe : Form
    {
        public fThongKe()
        {
            InitializeComponent();
        }


        private void LoadDoThiSoLuongDaBanTheoTungSanPham()
        {
            DataTable dt = DBConnection.LoadTableVaView("v_SoLuongSanPhamDaBanTheoTungSanPham");

            // Kiểm tra DataTable có null hoặc rỗng không
            if (dt == null || dt.Rows.Count == 0)
            {
                MessageBox.Show("Không có dữ liệu để hiển thị đồ thị.");
                return;  
            }

            // Lấy dữ liệu từ DataTable và vẽ đồ thị
            GraphPane myPane = zgcSoLuongDaBanTheoTungSanPham.GraphPane;
            myPane.Title.Text = ""; 
            myPane.XAxis.Title.Text = "Tên Sản phẩm";
            myPane.YAxis.Title.Text = "Số Lượng";

            // Thiết lập trục X về kiểu Text
            myPane.XAxis.Type = AxisType.Text;

            // Khởi tạo PointPairList cho các cột
            PointPairList points = new PointPairList();

            // Khởi tạo mảng string[] cho TextLabels
            string[] textLabels = new string[dt.Rows.Count];  // Tạo mảng với số phần tử là số lượng dòng trong DataTable

            int index = 0;  // Biến index để quản lý chỉ số của trục X

            foreach (DataRow row in dt.Rows)
            {
                // Kiểm tra nếu cột có dữ liệu hợp lệ
                string tenSP = row["TenSP"].ToString();
                double soLuong = 0;
                if (row["SoLuong"] != DBNull.Value)
                {
                    soLuong = Convert.ToDouble(row["SoLuong"]);
                }

                // Sử dụng chỉ số index làm giá trị trục X
                points.Add(index, soLuong);  // Chỉ số index dùng làm giá trị trục X

                // Thêm tên sản phẩm vào mảng textLabels cho trục X
                textLabels[index] = tenSP;

                index++;
            }

            // Thiết lập TextLabels vào trục X, cần chỉ rõ các nhãn và chỉ số của trục X
            myPane.XAxis.Scale.TextLabels = textLabels;


            // Thiết lập độ rộng cột
            myPane.BarSettings.Type = BarType.Cluster;  // Đảm bảo sử dụng Cluster để các cột không chồng lên nhau

            // Thêm biểu đồ cột vào đồ thị
            BarItem myBar = myPane.AddBar("Số Lượng", points, System.Drawing.Color.Blue);

            // Thiết lập xoay tên trục X nếu các tên sản phẩm quá dài
            myPane.XAxis.Scale.FontSpec.Angle = 0;  // Xoay tên sản phẩm 45 độ nếu cần

            // Cập nhật đồ thị
            zgcSoLuongDaBanTheoTungSanPham.AxisChange();
            zgcSoLuongDaBanTheoTungSanPham.Invalidate();
        }

        private void LoadDGVHienThi()
        {
            dgvHienThi.DataSource = DBConnection.LoadTableVaView("v_SoLuongSanPhamDaBanTheoTungSanPham");
        } 

        private void fThongKe_Load(object sender, EventArgs e)
        {
            LoadDoThiSoLuongDaBanTheoTungSanPham();
            LoadDGVHienThi();
            lblTongDoanhThu.Text = ChiTietHoaDonDAO.TongDoanhThuTatCaDonHang().ToString();
            lblSoLuongSPDaBan.Text = ChiTietHoaDonDAO.TongSoLuongSPDaBan().ToString();
            lblSoLuongKH.Text = KhachHangDAO.TongSoLuongKH().ToString();
        }

        private void dgvHienThi_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DGV.ChinhSizeCotTuDong(dgvHienThi);
        }
    }
}
