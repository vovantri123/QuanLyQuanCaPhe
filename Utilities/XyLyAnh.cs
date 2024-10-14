using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms; 
using System.Drawing;  
using System.IO; 

namespace QuanLyQuanCaPhe.Utilities
{
    public class XyLyAnh
    {
        public XyLyAnh() 
        { 
        
        }

        public static Image GetImage(string tenFileAnh)
        {    
            try
            { 
                // Tải hình ảnh từ đường dẫn
                return Image.FromFile(layDuongDanDayDuToiFileAnhSanPham(tenFileAnh)); // Trả về đối tượng Image
                
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi tải hình ảnh: " + ex.Message);
                return null; // Trả về null nếu có lỗi
            } 
        }

        public static string layDuongDanDayDuToiFileAnhSanPham(string tenFileAnh)
        {
            string thuMucHinhSanPham = layDuongDanToiThuMucHinhSanPham();
            return System.IO.Path.Combine(thuMucHinhSanPham, tenFileAnh);
        }

        public static string layDuongDanToiThuMucHinhSanPham()
        {
            string thuMucHienTai = AppDomain.CurrentDomain.BaseDirectory; // Debug
            string thuMucLui1 = System.IO.Path.GetDirectoryName(System.IO.Path.GetDirectoryName(thuMucHienTai)); //Bin
            string thuMucLui2 = System.IO.Path.GetDirectoryName(thuMucLui1); //TraoDoiDo
            string thuMucHinhSanPham = System.IO.Path.Combine(thuMucLui2, "MyResources", "Hinh", "HinhSanPham");
            return thuMucHinhSanPham;
        }

        public static void LuuAnhVaoThuMuc(string duongDanAnh, string tenThuMucMuonLuu) // truyền vào đường dẫn đầy đủ tới file ảnh vừa chọn, chủ yếu lấy tên file từ đường dẫn này, rồi lưu dô project
        {
            try
            {
                // Kiểm tra xem đường dẫn ảnh có tồn tại không
                if (!System.IO.File.Exists(duongDanAnh))
                {
                    MessageBox.Show("Không tìm thấy tệp ảnh.");
                    return;
                }
                 
                tenThuMucMuonLuu = layDuongDanToiThuMucHinhSanPham();

                // Kiểm tra xem thư mục có tồn tại không, nếu không thì tạo mới
                if (!System.IO.Directory.Exists(tenThuMucMuonLuu))
                {
                    System.IO.Directory.CreateDirectory(tenThuMucMuonLuu);
                }

                // Lấy tên tệp ảnh từ đường dẫn
                string tenFile = System.IO.Path.GetFileName(duongDanAnh);

                // Tạo đường dẫn mới cho tệp ảnh trong thư mục "HinhCuaToi"
                string duongDanMoi = System.IO.Path.Combine(tenThuMucMuonLuu, tenFile);

                // Kiểm tra xem tệp ảnh đã tồn tại trong thư mục chưa
                if (System.IO.File.Exists(duongDanMoi))
                {
                    //MessageBox.Show("Tệp ảnh đã tồn tại trong thư mục HinhSanPham.");
                    return;
                }

                // Sao chép tệp ảnh vào thư mục "HinhCuaToi"
                System.IO.File.Copy(duongDanAnh, duongDanMoi, true);

                //MessageBox.Show("Ảnh đã được lưu vào thư mục HinhSanPham.");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Đã xảy ra lỗi khi lưu ảnh: " + ex.Message);
            }
        }
    }
}
