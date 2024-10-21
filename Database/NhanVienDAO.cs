using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace QuanLyQuanCaPhe.Database
{
    public class NhanVienDAO
    {
        public static void Them(NhanVien lnv, string loaiNV)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@HoTenNV", lnv.HoTenNV);
            DBConnection.AddParameters("@SoDienThoai", lnv.SoDienThoai);
            DBConnection.AddParameters("@NamSinh", lnv.NamSinh);
            DBConnection.AddParameters("@GioiTinh", lnv.GioiTinh);
            DBConnection.AddParameters("@DiaChi", lnv.DiaChi);
            DBConnection.AddParameters("@TenDangNhap", lnv.TenDangNhap);
            DBConnection.AddParameters("@MatKhau", lnv.MatKhau);
            DBConnection.AddParameters("@LoaiNhanVien", loaiNV);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_ThemNhanVien", DBConnection.parameters);
        }

        public static void Xoa(string maNV)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaNV", maNV);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_XoaNhanVien", DBConnection.parameters);
        }

        public static void Sua(NhanVien lnv)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaNV", lnv.MaNV);
            DBConnection.AddParameters("@HoTenNV", lnv.HoTenNV);
            DBConnection.AddParameters("@SoDienThoai", lnv.SoDienThoai);
            DBConnection.AddParameters("@NamSinh", lnv.NamSinh);
            DBConnection.AddParameters("@GioiTinh", lnv.GioiTinh);
            DBConnection.AddParameters("@DiaChi", lnv.DiaChi);
            DBConnection.AddParameters("@TenDangNhap", lnv.TenDangNhap);
            DBConnection.AddParameters("@MatKhau", lnv.MatKhau);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_SuaNhanVien", DBConnection.parameters);
        }

        public static DataTable timKiemNhanVienTheoTen(string ten)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@HoTenNV", ten);

            return DBConnection.ThucThiFunction_InlineVaMultiStatement("func_timKiemTrenViewNhanVien", DBConnection.parameters);
        }

        public static int CheckLogin(string tenDangNhap, string matKhau)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@TenDangNhap", tenDangNhap);
            DBConnection.AddParameters("@MatKhau", matKhau);
            return Convert.ToInt32(DBConnection.ThucThiFunction_Scalar("func_KiemTraDangNhap_NhanVien", DBConnection.parameters)); 
 
        }

        public static string LayMatKhau(string tenDangNhap, string soDienThoai)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@TenDangNhap", tenDangNhap);
            DBConnection.AddParameters("@SoDienThoai", soDienThoai);

            return DBConnection.ThucThiFunction_Scalar("func_LayMatKhau_NhanVien", DBConnection.parameters).ToString(); 
        }
    }
}
