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
            
            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("ThemLoaiSanPham", DBConnection.parameters);
        }

        public static void Xoa(string id)
        { 
            DBConnection.parameters = new List<KeyValuePair<string, object>>
            {
                new KeyValuePair<string, object>("@MaLoaiSP", id), 
            };

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("XoaLoaiSanPham", DBConnection.parameters);
        }

        public static void Sua(LoaiSanPham lsp)
        {
            DBConnection.parameters = new List<KeyValuePair<string, object>>
            {
                new KeyValuePair<string, object>("@TenLoai", lsp.MaLoaiSP),
                new KeyValuePair<string, object>("@TenLoaiSP", lsp.TenLoaiSP)
            };

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("SuaLoaiSanPham", DBConnection.parameters);
        }

        public static DataTable TimKiem(string ten)
        { 

            DBConnection.parameters = new List<KeyValuePair<string, object>>
            { 
                new KeyValuePair<string, object>("@TenLoaiSP", ten)
            };
            return DBConnection.ThucThiFunction_InlineVaMultiStatement("TimKiemTheoTenLoaiSanPham_Inline", DBConnection.parameters); 
        }
    }
}
