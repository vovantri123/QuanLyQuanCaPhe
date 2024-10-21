using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Database
{
    public class NguyenLieuDAO
    {
        public static void Them(NguyenLieu nl)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaNL", nl.MaNL);
            DBConnection.AddParameters("@TenNL", nl.TenNL);
            DBConnection.AddParameters("@SoLuongTonKho", nl.SoLuongTonKho);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Them_NguyenLieu", DBConnection.parameters);
        }

        public static void Xoa(string id)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaNL", id);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Xoa_NguyenLieu", DBConnection.parameters);
        }

        public static void Sua(NguyenLieu nl)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaNL",nl.MaNL);
            DBConnection.AddParameters("@TenNL", nl.TenNL);
            DBConnection.AddParameters("@SoLuongTonKho", nl.SoLuongTonKho);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Sua_NguyenLieu", DBConnection.parameters);
        }

        public static DataTable TimKiemTheoTenNguyenLieu(string ten)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@TenLoaiSP", ten);
            return DBConnection.ThucThiFunction_InlineVaMultiStatement("func_TimKiemTheoTen_NguyenLieu", DBConnection.parameters);
        }
    }
}
