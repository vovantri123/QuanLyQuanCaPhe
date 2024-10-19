using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Database
{
    internal class NhanVienBanThoiGianDAO
    {
        public static void Xoa(string maNV)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaNV", maNV);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_XoaNhanVienBanThoiGian", DBConnection.parameters);
        }

        public static void Sua(NhanVienBanThoiGian lnvBanTG)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaNV", lnvBanTG.MaNV);
            DBConnection.AddParameters("@SoGio", lnvBanTG.SoGio);
            DBConnection.AddParameters("@LuongTheoGio", lnvBanTG.LuongTheoGio);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_SuaNhanVienBanThoiGian", DBConnection.parameters);
        }
    }
}
