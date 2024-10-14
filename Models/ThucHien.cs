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
        private string mvCV;
        private string maCa;

        public ThucHien()
        {

        }

        public ThucHien(string maNV, string mvCV, string maCa)
        {
            this.maNV = maNV;
            this.mvCV = mvCV;
            this.maCa = maCa;
        }

        public string MaNV { get => maNV; set => maNV = value; }
        public string MvCV { get => mvCV; set => mvCV = value; }
        public string MaCa { get => maCa; set => maCa = value; }
    }
}
