using Guna.UI2.WinForms;
using QuanLyQuanCaPhe.Database;
using QuanLyQuanCaPhe.Models;
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
    public partial class fQLPhanCa : Form
    {
        ThucHienDAO nguoiThucHienCaDao = new ThucHienDAO();
        private TimeSpan gioBatDau = new TimeSpan(0, 0, 0);
        private TimeSpan gioKetThuc = new TimeSpan(0, 0, 0);
        private string maNgheNghiep;
        private NhanVien nhanVien = null;

        public fQLPhanCa()
        {
            InitializeComponent();
        }

        public fQLPhanCa(NhanVien nv)
        {
            nhanVien = nv;
            InitializeComponent();
        }

        public void LoadCa()
        {
            txtMaNV.Text = nhanVien.MaNV;

            txtHoTen.Text = nhanVien.HoTenNV;
            DateTime today = DateTime.Today;
            //DateTime monday = today.AddDays(-(int)today.DayOfWeek + 1); // Bắt đầu từ thứ Hai
            DateTime monday = today.AddDays(-(int)today.DayOfWeek + (today.DayOfWeek == DayOfWeek.Sunday ? -6 : 1));

            string[] shifts = { "Sáng", "Chiều", "Tối", "FulltimeAM", "FulltimePM" }; // Các ca làm việc

            // Vòng lặp qua các ca làm việc (Sáng, Chiều, Tối)
            foreach (string shiftCa in shifts)
            {
                for (int i = 0; i < 7; i++)
                {
                    DateTime currentDay = monday.AddDays(i); // Lấy ngày hiện tại
                    string currentDateString = currentDay.ToString("yyyy-MM-dd"); // Định dạng tháng-ngày

                    // Tìm ca làm việc nào khớp với ngày và ca trong database
                    List<string> employeeNames = nguoiThucHienCaDao.TimNguoiThucHien(shiftCa, currentDateString);

                    // Hiển thị danh sách tên nhân viên trên nút, nếu có nhiều nhân viên
                    string employeeNamesText = employeeNames.Count > 0 ? string.Join(", ", employeeNames) : "Ca trống";

                    Guna2Button btn = new Guna2Button()
                    {
                        Width = ThucHienDAO.chieuRong,
                        Height = ThucHienDAO.chieuCao,
                        Text = employeeNamesText, // Hiển thị tên nhân viên nếu tìm thấy
                        Tag = null, // Không lưu thông tin ca làm việc ở đây

                        // Tùy chỉnh giao diện của button
                        BorderRadius = 10,
                        FillColor = Color.White,
                        ForeColor = Color.Black,
                        BorderColor = Color.Gray,
                        BorderThickness = 2,
                        TextAlign = HorizontalAlignment.Center,
                        Margin = new Padding(8)
                    };

                    // Xử lý sự kiện Click cho từng button
                    btn.Click += (s, e) =>
                    {
                        MessageBox.Show($"Ca làm việc: {shiftCa}\nNhân viên: {employeeNamesText}");
                    };

                    // Thêm button vào flow layout panel
                    flpCa.Controls.Add(btn);
                }
            }
            txtMaCa.Text = CaLamViecDAO.LayMaCaMoiDeDangKy();


        }
        public void BayNgayTrongTuan()
        {
            // Lấy ngày hiện tại
            DateTime today = DateTime.Now;

            // Tính ngày đầu tuần (thứ 2)
            // Nếu hôm nay không phải thứ 2, ta sẽ lùi lại số ngày cần thiết để đến thứ 2
            int daysUntilMonday = ((int)today.DayOfWeek - 1 + 7) % 7; // Số ngày cần lùi để đến thứ 2
            DateTime monday = today.AddDays(-daysUntilMonday);

            // Danh sách tên các ngày trong tuần
            List<string> daysOfWeek = new List<string>
                                        {
                                        "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7", "Chủ nhật"
                                        };
            // Duyệt qua từng ngày và tạo nút tương ứng
            for (int i = 0; i < daysOfWeek.Count; i++)
            {
                DateTime currentDate = monday.AddDays(i); // Tính ngày cho mỗi ngày trong tuần

                Guna2Button btn = new Guna2Button()
                {
                    Width = 80, // Chiều rộng của nút
                    Height = 50, // Chiều cao của nút
                    Text = $"{daysOfWeek[i]} ({currentDate.ToString("dd/MM")})", // Gán tên thứ và ngày
                    Tag = currentDate, // Lưu ngày làm Tag để truy xuất sau này

                    // Tùy chỉnh giao diện nút
                    BorderRadius = 10, // Bo góc 10px
                    FillColor = Color.Wheat, // Nền trắng
                    ForeColor = Color.Black, // Chữ đen
                    BorderColor = Color.Gray, // Màu viền xám
                    BorderThickness = 2, // Độ dày viền 2px
                    TextAlign = HorizontalAlignment.Center, // Căn giữa chữ
                    Margin = new Padding(8) // Khoảng cách giữa các nút
                };

                // Xử lý sự kiện Click cho từng button
                btn.Click += (s, e) =>
                {
                    DateTime clickedDate = (DateTime)(s as Guna2Button).Tag;
                    MessageBox.Show($"Đang xem thông tin cho ngày {clickedDate.ToString("dd/MM/yyyy")}");

                    // Load danh sách người thực hiện ca cho ngày được chọn
                };

                // Thêm nút vào FlowLayoutPanel (flpNgay)
                flpNgay.Controls.Add(btn);
            }
        }

        private void fPhanCa_Load(object sender, EventArgs e)
        {
            txtMaCa.Text = CaLamViecDAO.LayMaCaMoiDeDangKy();
            LoadCa();
            BayNgayTrongTuan();
            dtpkNgayLam.Value = DateTime.Now;

        }

        private void btnDangKi_Click(object sender, EventArgs e)
        {
            try
            {
                string dinhDangNgayLam = dtpkNgayLam.Value.ToString("yyyy-MM-dd");
                cbbCongViec_SelectedIndexChanged(sender, e);
                cbbChonca_SelectedIndexChanged(sender, e);

                CaLamViec clv = new CaLamViec(txtMaCa.Text, cbbChonca.Text, dinhDangNgayLam, gioBatDau, gioKetThuc); //Ca00 thêm cho nó k dính check null, chứ Trigger nó tự tạo mã ca rồi
                CaLamViecDAO.Them(clv);

                ThucHien th = new ThucHien(txtMaCa.Text, txtMaNV.Text, maNgheNghiep);
                ThucHienDAO.Them(th);

                flpCa.Controls.Clear();  // Xóa các button cũ trong FlowLayoutPanel trước khi tải lại
                LoadCa(); // Gọi lại phương thức để tải ca làm việc mới nhất
            }
            catch(Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            } 
            
            
        }

        private void SetWorkingHours(string selectedShift)
        {
            // Gán giá trị giờ bắt đầu và giờ kết thúc theo ca làm
            switch (selectedShift)
            {
                case "Sáng":
                    gioBatDau = new TimeSpan(6, 0, 0); // 6h
                    gioKetThuc = new TimeSpan(11, 0, 0); // 12h
                    break;
                case "Chiều":
                    gioBatDau = new TimeSpan(11, 0, 0); // 12h
                    gioKetThuc = new TimeSpan(16, 0, 0); // 18h
                    break;
                case "Tối":
                    gioBatDau = new TimeSpan(16, 0, 0); // 18h
                    gioKetThuc = new TimeSpan(21, 0, 0); // 22h
                    break;
                case "FulltimeAM":
                    gioBatDau = new TimeSpan(6, 0, 0); 
                    gioKetThuc = new TimeSpan(16, 0, 0); 
                    break;
                case "FulltimePM":
                    gioBatDau = new TimeSpan(11, 0, 0);
                    gioKetThuc = new TimeSpan(21, 0, 0);
                    break;
                default:
                    // Xử lý trường hợp không hợp lệ (có thể gán giá trị mặc định hoặc ném ngoại lệ )
                    throw new ArgumentException("Ca làm không hợp lệ.");

            }
        }
        private void cbbChonca_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedShift = cbbChonca.SelectedItem.ToString(); // Lấy giá trị được chọn
            SetWorkingHours(selectedShift); // Gọi hàm để thiết lập giờ làm
        }
        private void ChonCongViec(string congViec)
        {
            // Gán giá trị giờ bắt đầu và giờ kết thúc theo ca làm
            switch (congViec)
            {
                case "Phục vụ":
                    maNgheNghiep = "CV01";
                    break;
                case "Thu ngân":
                    maNgheNghiep = "CV02";

                    break;
                case "Pha chế":
                    maNgheNghiep = "CV03";

                    break;
                case "Quản lí":
                    maNgheNghiep = "CV04";

                    break;
                case "Bảo vệ":
                    maNgheNghiep = "CV05";
                    break;
                default:
                    // Xử lý trường hợp không hợp lệ (có thể gán giá trị mặc định hoặc ném ngoại lệ)
                    throw new ArgumentException("Công việc không hợp lệ.");
            }
        }
        private void cbbCongViec_SelectedIndexChanged(object sender, EventArgs e)
        {
            string maCongViec = cbbCongViec.SelectedItem.ToString(); // Lấy giá trị được chọn
            ChonCongViec(maCongViec); // Gọi hàm để thiết lập giờ làm
        }


        private void guna2HtmlLabel1_Click(object sender, EventArgs e)
        {

        }
    }
}
