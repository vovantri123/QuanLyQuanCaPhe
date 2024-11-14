using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Models
{
    public class NhanVienBanThoiGian:NhanVien
    {
            private double luongTheoGio;
            private int soGio;

            public NhanVienBanThoiGian()
            {

            }

            public NhanVienBanThoiGian(string maNV, string hoTenNV, string soDienThoai, int namSinh, string gioiTinh, string diaChi, string email,string tenDangNhap, string matKhau, double luongTheoGio, int soGio) : base(maNV, hoTenNV, soDienThoai, namSinh, gioiTinh, diaChi, email,tenDangNhap, matKhau)
            {
                this.luongTheoGio = luongTheoGio;
                this.soGio = soGio;
            }

        public int SoGio { get => soGio; set => soGio = value; }
        public double LuongTheoGio { get => luongTheoGio; set => luongTheoGio = value; }
    }
}
