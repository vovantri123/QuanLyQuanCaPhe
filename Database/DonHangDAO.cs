﻿using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanCaPhe.Database
{
    public class DonHangDAO
    {
        public static void Them(string soDienThoai, string maNV)
        {
            DBConnection.ClearParameters(); 
            DBConnection.AddParameters("@SoDienThoai", soDienThoai);
            DBConnection.AddParameters("@MaNV", maNV);
            MessageBox.Show(maNV + " số ĐT là "+ soDienThoai);
            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Them_DonHang", DBConnection.parameters);
            
        }   

        public static void XoaDonChuaThanhToan()
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

        public static void XacNhanThanhToan()
        {
            DBConnection.ClearParameters();
            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_XacNhanThanhToan_DonHangVaKhachHang", DBConnection.parameters);
        }
    }
}
