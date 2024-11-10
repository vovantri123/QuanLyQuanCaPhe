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

        public static NhanVien timKiemNhanVienTheoTaiKhoan(string tenDangNhap, string matKhau)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@TenDangNhap", tenDangNhap);
            DBConnection.AddParameters("@MatKhau", matKhau);

            List<SqlParameter> outputParameters = new List<SqlParameter>
            {
                new SqlParameter("@HoTenNV", SqlDbType.NVarChar, 50) { Direction = ParameterDirection.Output },
                new SqlParameter("@SoDienThoai", SqlDbType.NVarChar, 50) { Direction = ParameterDirection.Output },
                new SqlParameter("@NamSinh", SqlDbType.Int) { Direction = ParameterDirection.Output },
                new SqlParameter("@GioiTinh", SqlDbType.NVarChar,50) { Direction = ParameterDirection.Output },
                new SqlParameter("@DiaChi", SqlDbType.NVarChar,200) { Direction = ParameterDirection.Output },
                new SqlParameter("@MaNV", SqlDbType.NVarChar,50) { Direction = ParameterDirection.Output },
                new SqlParameter("@LuongCoDinh", SqlDbType.Float) { Direction = ParameterDirection.Output },
                new SqlParameter("@LuongTheoGio", SqlDbType.Float) { Direction = ParameterDirection.Output },
                new SqlParameter("@SoGio", SqlDbType.Float) { Direction = ParameterDirection.Output },

            };

            Dictionary<string, object> result = DBConnection.ThucThiProc_CoThamSoOutput("proc_timNhanVienTheoTaiKhoan", DBConnection.parameters, outputParameters);

            if (result != null)
            {
                NhanVien nv = new NhanVien();
                nv.MaNV = result["@MaNV"].ToString();
                MessageBox.Show(nv.MaNV);
                nv.HoTenNV = result["@HoTenNV"].ToString();
                nv.SoDienThoai = result["@SoDienThoai"].ToString();
                nv.NamSinh = Convert.ToInt32(result["@NamSinh"].ToString());
                nv.GioiTinh = result["@GioiTinh"].ToString();
                nv.DiaChi = result["@DiaChi"].ToString();
                nv.MaNV = result["@MaNV"].ToString();
                nv.TenDangNhap = tenDangNhap;
                nv.MatKhau = matKhau;

                return nv;
            }
            else
            {
                return null;
            }

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
