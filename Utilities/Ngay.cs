using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Utilities
{
    public class Ngay
    {
        public Ngay()
        {

        }
         

        public static string NgayHienTai()
        {
            DateTime ngayHienTai = DateTime.Today;
            return ngayHienTai.ToString("dd/MM/yyyy");
        }


    }
}
