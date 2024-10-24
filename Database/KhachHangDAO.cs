using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic; 
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace QuanLyQuanCaPhe.Database
{
    public  class KhachHangDAO
    {
        public static void Them(KhachHang kh)
        {
            DBConnection.ClearParameters();

            DBConnection.AddParameters("@MaKH", kh.MaKH);
            DBConnection.AddParameters("@TenKH", kh.TenKH);
            DBConnection.AddParameters("@SoDienThoai", kh.SoDienThoai);
            DBConnection.AddParameters("@SoDiemTichLuy", kh.SoDiemTichLuy);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("Proc_ThemKhachHang_KhachHang", DBConnection.parameters);
        }

        public static void Them(string SoDienThoai)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@SoDienThoai", SoDienThoai);
            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Them_KhachHang", DBConnection.parameters);
        }

        public static void Xoa(KhachHang kh)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaKH", kh.MaKH);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("Proc_XoaKhachHang_KhachHang", DBConnection.parameters);
        }

        public static void Sua(KhachHang kh)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaKH", kh.MaKH);
            DBConnection.AddParameters("@TenKH", kh.TenKH);
            DBConnection.AddParameters("@SoDienThoai", kh.SoDienThoai);
            DBConnection.AddParameters("@SoDiemTichLuy", kh.SoDiemTichLuy);
           
            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("Proc_SuaThongTinKhachhang_KhachHang", DBConnection.parameters);
        }

        public static void SuaTenVaSoDienThoai(string ten, string soDienThoaiCu, string soDienThoaiMoi)
        {
            DBConnection.ClearParameters(); 
            DBConnection.AddParameters("@TenKH", ten);
            DBConnection.AddParameters("@SoDienThoaiCu", soDienThoaiCu); 
            DBConnection.AddParameters("@SoDienThoaiMoi", soDienThoaiMoi); 

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Sua_KhachHang", DBConnection.parameters);
            MessageBox.Show("Sửa thành công");
        }


        public static DataTable TimKiem(string sdt)
        {

            DBConnection.parameters = new List<KeyValuePair<string, object>>
            {
                new KeyValuePair<string, object>("@SoDienThoai", sdt)
            };
            return DBConnection.ThucThiFunction_InlineVaMultiStatement("Func_TimKiemTheoSoDienThoai_KhachHang", DBConnection.parameters);
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

        public static double TongSoLuongKH()
        {
            DBConnection.ClearParameters();
            object tongSLKH = DBConnection.ThucThiFunction_Scalar("func_TongSoLuongKhachHang_KhachHang", DBConnection.parameters);
            if (tongSLKH is DBNull || tongSLKH == null)
                return 0;
            return Convert.ToDouble(tongSLKH);
        }
    }
}
