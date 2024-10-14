using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Models
{
    public class SanPham
    {
        private string maSP;
        private string tenSP;
        private double gia;
        private string anhSP;
        private string maLoaiSP;

        public SanPham() 
        {
        
        }

        public SanPham(string maSP, string tenSP, double gia, string anhSP, string maLoaiSP)
        {
            this.maSP = maSP;
            this.tenSP = tenSP;
            this.gia = gia;
            this.anhSP = anhSP;
            this.maLoaiSP = maLoaiSP;
        }

        public string MaSP { get => maSP; set => maSP = value; }
        public string TenSP { get => tenSP; set => tenSP = value; }
        public double Gia { get => gia; set => gia = value; }
        public string AnhSP { get => anhSP; set => anhSP = value; }
        public string MaLoaiSP { get => maLoaiSP; set => maLoaiSP = value; }
    }
}
