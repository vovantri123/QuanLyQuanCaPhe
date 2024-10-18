using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Database
{
    public class PhaCheDAO
    {
        public static void Them(PhaChe pc)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaSP", pc.MaSP);
            DBConnection.AddParameters("@MaNL", pc.MaNL);
            DBConnection.AddParameters("@SoLuong", pc.SoLuong);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Them_PhaChe", DBConnection.parameters);
        }

        public static void Xoa(string maSP, string maNL)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaSP", maSP);
            DBConnection.AddParameters("@MaNL", maNL); 

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Xoa_PhaChe", DBConnection.parameters);
        }

        public static DataTable LoadDSNguyenLieuTheoMaSanPham(string maSP)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaSP", maSP); 

            return DBConnection.ThucThiFunction_InlineVaMultiStatement("func_LoadDanhSachNguyenLieuTheoMaSP", DBConnection.parameters);
        }
    }
}
