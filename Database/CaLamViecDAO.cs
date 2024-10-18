using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Database
{
    public  class CaLamViecDAO
    {
        public static void Them(CaLamViec clv)
        {
            DBConnection.ClearParameters();

            DBConnection.AddParameters("@MaCa", clv.MaCa);
            DBConnection.AddParameters("@TenCa", clv.TenCa);
            DBConnection.AddParameters("@Ngay", clv.Ngay);
            DBConnection.AddParameters("@GioBatDau", clv.GioBatDau);
            DBConnection.AddParameters("@GioKetThuc", clv.GioKetThuc);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("Proc_ThemCaLamViec_CaLamViec", DBConnection.parameters);
        }
    }
}
