using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanCaPhe.Database
{
    public  class CaLamViecDAO
    {

        public static String LayMaCaMoiDeDangKy()
        {
            DBConnection.ClearParameters();

            object maCa = DBConnection.ThucThiFunction_Scalar("func_LayMaCaMoiDeDangKy_CaLamViec", DBConnection.parameters);
            
            if( maCa == null || maCa == DBNull.Value)
            {
                MessageBox.Show("Không lấy được mã ca để đăng ký","Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return string.Empty;
            }    
            return maCa.ToString();
        }

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
