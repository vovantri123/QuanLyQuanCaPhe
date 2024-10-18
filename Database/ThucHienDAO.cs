using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QuanLyQuanCaPhe.Models;
using System.Data.Common;
using System.Data.Odbc;
using System.Windows.Forms;

namespace QuanLyQuanCaPhe.Database
{
    public class ThucHienDAO
    {

        public static int chieuRong = 80;
        public static int chieuCao = 90;

        //public List<string> TimNguoiThucHien(string shiftName, string currentDate)
        //{
        //    List<string> employeeNames = new List<string>(); // Tạo danh sách để lưu tên nhân viên
        //    DBConnection.moKetNoi(); // Mở kết nối

        //    using (SqlCommand cmd = new SqlCommand("NguoiThucHienCa", DBConnection.conn))
        //    {
        //        cmd.CommandType = CommandType.StoredProcedure; // Chỉ định đây là một stored procedure

        //        // Thêm tham số cho stored procedure
        //        cmd.Parameters.Add(new SqlParameter("@shiftCa", SqlDbType.NVarChar, 50)).Value = shiftName;
        //        cmd.Parameters.Add(new SqlParameter("@currentDate", SqlDbType.NVarChar, 10)).Value = currentDate;

        //        using (SqlDataReader reader = cmd.ExecuteReader())
        //        {
        //            while (reader.Read()) // Lặp qua từng kết quả
        //            {
        //                employeeNames.Add(reader["HoTenNV"].ToString()); // Thêm từng tên nhân viên vào danh sách
        //            }
        //        }
        //    }

        //    DBConnection.dongKetNoi(); // Đóng kết nối
        //    return employeeNames; // Trả về danh sách nhân viên
        //}
        public List<string> TimNguoiThucHien(string shiftName, string currentDate)
        {
            List<string> employeeNames = new List<string>(); // Tạo danh sách để lưu tên nhân viên

            DBConnection.ClearParameters();
            DBConnection.AddParameters("@shiftCa", shiftName);
            DBConnection.AddParameters("@currentDate", currentDate);

            SqlDataReader layTen = null;

            try
            {
                // Gọi hàm với tham số traVeReader = true để trả về SqlDataReader
                layTen = DBConnection.ThucThiProc_CoReader("Proc_TimNguoiThucHienCa_vNguoiThucHienCa", DBConnection.parameters, true);
                if (layTen != null)
                {
                    while (layTen.Read()) // Lặp qua từng kết quả
                    {
                        employeeNames.Add(layTen["HoTenNV"].ToString()); // Thêm từng tên nhân viên vào danh sách
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message, "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                layTen?.Close(); // Đảm bảo đóng reader sau khi sử dụng
            }

            return employeeNames; // Trả về danh sách nhân viên
        }


        public static void Them(ThucHien th)
        {
            DBConnection.ClearParameters();

            DBConnection.AddParameters("@MaNV", th.MaNV);
            DBConnection.AddParameters("@MaCa", th.MaCa);
            DBConnection.AddParameters("@MaCV", th.MaCV);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("Proc_ThemKhoaChinhThucHien_ThucHien", DBConnection.parameters);
        }
    }
}
