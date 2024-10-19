using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Database
{
    public class ChiTietHoaDonDAO
    {
        public static void Them(ChiTietHoaDon cthd)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaSP", cthd.MaSP);
            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_Them_ChiTietDonHang",DBConnection.parameters);
        }
        public static double TinhTongTien()
        {
            DBConnection.ClearParameters();
            object tongTien = DBConnection.ThucThiFunction_Scalar("func_TongTien_ChiTietHoaDon", DBConnection.parameters);
            if (tongTien is DBNull || tongTien == null) 
                return 0;  
            return Convert.ToDouble(tongTien); 
        }

        public static double TongDoanhThuTatCaDonHang()
        {
            DBConnection.ClearParameters();
            object tongDoanhThu = DBConnection.ThucThiFunction_Scalar("func_TongDoanhThu_ChiTietHoaDon", DBConnection.parameters);
            if (tongDoanhThu is DBNull || tongDoanhThu == null)
                return 0;
            return Convert.ToDouble(tongDoanhThu);
        }
        
        public static double TongSoLuongSPDaBan()
        {
            DBConnection.ClearParameters();
            object tongSLSPDaBan = DBConnection.ThucThiFunction_Scalar("func_TongSoLuongSanPham_ChiTietHoaDon", DBConnection.parameters);
            if (tongSLSPDaBan is DBNull || tongSLSPDaBan == null)
                return 0;
            return Convert.ToDouble(tongSLSPDaBan);
        }

    }
}
