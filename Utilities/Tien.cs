using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Utilities
{
    public class Tien
    {
        public Tien() 
        {
        
        }

        public static string DinhDangTien(string tien)
        {
            return Convert.ToDouble(tien).ToString("#,##0");
        }

        public static double HuyDinhDangTien(string tien)
        { 
            string tienKhongDauPhay = tien.Replace(",", "");
            return Double.Parse(tienKhongDauPhay);
        }

    }
}
