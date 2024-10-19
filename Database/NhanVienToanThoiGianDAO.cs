using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Database
{
    internal class NhanVienToanThoiGianDAO
    {
        public static void Xoa(string maNV)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaNV", maNV);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_XoaNhanVienToanThoiGian", DBConnection.parameters);
        }

        public static void Sua(NhanVienToanThoiGian lnvToanTG)
        {
            DBConnection.ClearParameters();
            DBConnection.AddParameters("@MaNV", lnvToanTG.MaNV);
            DBConnection.AddParameters("@LuongCoDinh", lnvToanTG.LuongCoDinh);

            DBConnection.ThucThiProc_CoThamSoVaKhongCoThamSo("proc_SuaNhanVienToanThoiGian", DBConnection.parameters);
        }
    }
}
