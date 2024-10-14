using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Models
{
    public class CaLamViec
    {
        private string maCa;
        private string tenCa;
        private DateTime ngay;
        TimeSpan gioBatDau;
        TimeSpan gioKetThuc;


        public CaLamViec() 
        { 
        
        }

        public CaLamViec(string maCa, string tenCa, DateTime ngay, TimeSpan gioBatDau, TimeSpan gioKetThuc)
        {
            this.maCa = maCa;
            this.tenCa = tenCa;
            this.ngay = ngay;
            this.gioBatDau = gioBatDau;
            this.gioKetThuc = gioKetThuc;
        }

        public string MaCa { get => maCa; set => maCa = value; }
        public string TenCa { get => tenCa; set => tenCa = value; }
        public DateTime Ngay { get => ngay; set => ngay = value; }
        public TimeSpan GioBatDau { get => gioBatDau; set => gioBatDau = value; }
        public TimeSpan GioKetThuc { get => gioKetThuc; set => gioKetThuc = value; }
    }
}
