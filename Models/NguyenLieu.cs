using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Models
{
    public class NguyenLieu
    {
        private string maNL;
        private string tenNL;
        private int soLuongTonKho;
        
        public NguyenLieu()
        {

        }

        public NguyenLieu(string maNL, string tenNL, int soLuongTonKho)
        {
            this.maNL = maNL;
            this.tenNL = tenNL;
            SoLuongTonKho = soLuongTonKho;  
        }

        public string MaNL { get => maNL; set => maNL = value; }
        public string TenNL { get => tenNL; set => tenNL = value; }
        public int SoLuongTonKho { get => soLuongTonKho; set => soLuongTonKho = value; }
    }
}
