using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Models
{
    public class ChiTietHoaDon
    {
        private string maDH;
        private string maSP;
        private int soLuong;
        private double tongTien;

        public ChiTietHoaDon()
        {

        }

        public ChiTietHoaDon(string maDH, string maSP, int soLuong)
        {
            this.maDH = maDH;
            this.maSP = maSP;
            this.soLuong = soLuong;
        }

        public string MaDH { get => maDH; set => maDH = value; }
        public string MaSP { get => maSP; set => maSP = value; }
        public int SoLuong { get => soLuong; set => soLuong = value; }
        public double TongTien { get => tongTien; set => tongTien = value; }
    }
}
