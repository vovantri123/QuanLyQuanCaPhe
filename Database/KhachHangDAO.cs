using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QuanLyQuanCaPhe.Models;

namespace QuanLyQuanCaPhe.Database
{
    public class KhachHangDAO
    {  
        public static void Them(string SoDienThoai)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@SoDienThoai",SoDienThoai); 
            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Them_KhachHang",DBConnection.parameters);
        }

        public static KhachHang LoadThongTinKhachHang(string soDienThoai)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@SoDienThoai", soDienThoai);
            
            
            // Danh sách tham số OUTPUT
            List<SqlParameter> outputParameters = new List<SqlParameter>
            {
                new SqlParameter("@Ten", SqlDbType.NVarChar, 50) { Direction = ParameterDirection.Output },
                new SqlParameter("@SoDiemTichLuy", SqlDbType.NVarChar, 50) { Direction = ParameterDirection.Output }
            };

            // Gọi stored procedure và nhận kết quả
            Dictionary<string, object> result = DBConnection.ThucThiProc_CoThamSoOutput("proc_LoadThongTin_KhachHang", DBConnection.parameters, outputParameters);

            // Kiểm tra kết quả và hiển thị thông tin
            if (result != null)
            {
                KhachHang kh = new KhachHang();
                kh.TenKH =  result["@Ten"].ToString();
                kh.SoDiemTichLuy = Convert.ToDouble(result["@SoDiemTichLuy"]);
                return kh; 
            } 
            else
            {
                return null;
            }    
             
        }
    }
}
