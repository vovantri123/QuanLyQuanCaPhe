using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Database
{
    public class SanPhamDAO
    {
        public static void Them(SanPham sp)
        {
            DBConnection.ClearParameters(); 
            DBConnection.AddParameters("@MaSP", sp.MaSP);
            DBConnection.AddParameters("@TenSP", sp.TenSP);
            DBConnection.AddParameters("@Gia", sp.Gia);
            DBConnection.AddParameters("@AnhSP", sp.AnhSP);
            DBConnection.AddParameters("MaLoaiSP", sp.MaLoaiSP); 

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Them_SanPham", DBConnection.parameters);
        }

        public static void Xoa(string id)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaSP", id); 

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Xoa_SanPham", DBConnection.parameters);
        }

        public static void Sua(SanPham sp)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaSP", sp.MaSP);
            DBConnection.AddParameters("@TenSP", sp.TenSP);
            DBConnection.AddParameters("@Gia", sp.Gia);
            DBConnection.AddParameters("@AnhSP", sp.AnhSP);
            DBConnection.AddParameters("MaLoaiSP", sp.MaLoaiSP);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Sua_SanPham", DBConnection.parameters);
        }

        public static DataTable TimKiem(string ten)
        {  
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@TenSP", ten);
            return DBConnection.ThucThiFunction_InlineVaMultiStatement("func_TimKiemTheoTen_SanPham", DBConnection.parameters);
        }
    }
}
