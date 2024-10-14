using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Models
{
    public class LoaiSanPham
    {
        private string maLoaiSP;
        private string tenLoaiSP;



        public LoaiSanPham()
        {

        }

        public LoaiSanPham(string maLoaiSP, string tenLoaiSP)
        {
            this.maLoaiSP = maLoaiSP;
            this.tenLoaiSP = tenLoaiSP; 
        }

        public string TenLoaiSP { get => tenLoaiSP; set => tenLoaiSP = value; }
        public string MaLoaiSP { get => maLoaiSP; set => maLoaiSP = value; }
    }
}
