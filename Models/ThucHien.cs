using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Models
{
    public class ThucHien
    {
        private string maNV;
        private string maCV;
        private string maCa;

       

        public ThucHien()
        {

        }

        public ThucHien(string maCa, string maNV, string maCV)
        {
            this.maCa = maCa;
            this.maNV = maNV;
            this.maCV = maCV;
        }

        public string MaNV { get => maNV; set => maNV = value; }
        public string MaCV { get => maCV; set => maCV = value; }
        public string MaCa { get => maCa; set => maCa = value; }

    }
}
