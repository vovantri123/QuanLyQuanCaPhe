using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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

        public static DataTable TimKiem(string sdt)
        {

            DBConnection.parameters = new List<KeyValuePair<string, object>>
            {
                new KeyValuePair<string, object>("@SoDienThoai", sdt)
            };
            return DBConnection.ThucThiFunction_InlineVaMultiStatement("Func_TimKiemTheoSoDienThoai_KhachHang", DBConnection.parameters);
        }
    }
}
