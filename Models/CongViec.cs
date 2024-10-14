using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace QuanLyQuanCaPhe
{
    public class CongViec
    {
        private string maCV;
        private string tenCV;

        public CongViec()
        {

        }

        public CongViec(string maCV, string tenCV)
        {
            this.maCV = maCV;
            this.tenCV = tenCV;
        }

        public string MaCV { get => maCV; set => maCV = value; }
        public string TenCV { get => tenCV; set => tenCV = value; }
    }
}