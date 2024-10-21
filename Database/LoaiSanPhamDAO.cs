using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks; 
using System.Windows.Forms;

namespace QuanLyQuanCaPhe.Database
{
    public class LoaiSanPhamDAO
    {
         
        public static void Them(LoaiSanPham lsp)
        {   
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaLoaiSP", lsp.MaLoaiSP);
            DBConnection.AddParameters("@TenLoaiSP", lsp.TenLoaiSP);
            
            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Them_LoaiSanPham", DBConnection.parameters);
        }

        public static void Xoa(string id)
        {  
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaLoaiSP", id); 

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Xoa_LoaiSanPham", DBConnection.parameters);
        }

        public static void Sua(LoaiSanPham lsp)
        { 
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaLoaiSP", lsp.MaLoaiSP);
            DBConnection.AddParameters("@TenLoaiSP", lsp.TenLoaiSP);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Sua_LoaiSanPham", DBConnection.parameters);
        }

        public static DataTable TimKiem(string ten)
        {   
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@TenLoaiSP", ten);
            return DBConnection.ThucThiFunction_InlineVaMultiStatement("func_TimKiemTheoTen_LoaiSanPham", DBConnection.parameters); 
        }
    }
}
