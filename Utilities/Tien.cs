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

        public static string dinhDangTien(string tien)
        {
            return Convert.ToDouble(tien).ToString("#,##0");
        }
    }
}
