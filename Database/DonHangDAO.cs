﻿using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Database
{
    public class DonHangDAO
    {
        public static void Them(string soDienThoai, string maNV)
        {
            DBConnection.ClearParameters(); 
            DBConnection.AddParameters("@SoDienThoai", soDienThoai);
            DBConnection.AddParameters("@MaNV", maNV);
            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Them_DonHang", DBConnection.parameters);
            
        }   

        public static void XoaDonChuaThanhToan(string soDienThoai, string maNV)
        {
            DBConnection.ClearParameters(); 
            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Xoa_KhachHangChuaNhapTen_DonHangChuaThanhToan ", DBConnection.parameters); 
        }


        public static void CapNhatGiaTriDonHangChuaThanhToan()
        {
            DBConnection.ClearParameters();
            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_CapNhatGiaTriDon_DonHang", DBConnection.parameters);
        }


        public static DataTable TimKiemTheoSDT(string soDienThoai)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@SoDienThoai", soDienThoai); 
            return DBConnection.ThucThiFunction_InlineVaMultiStatement("func_TimKiemTheoSoDienThoai_DonHang", DBConnection.parameters);
        }
    }
}
