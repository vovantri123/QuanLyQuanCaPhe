using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Models
{
    public class NhanVienToanThoiGian:NhanVien
    {
        private double luongCoDinh;

        public NhanVienToanThoiGian() 
        {

        }

        public NhanVienToanThoiGian(string maNV, string hoTenNV, string soDienThoai, int namSinh, string gioiTinh, string diaChi, string tenDangNhap, string matKhau, double luongCoDinh):base(maNV, hoTenNV, soDienThoai, namSinh, gioiTinh, diaChi,  tenDangNhap, matKhau)
        {
            this.luongCoDinh = luongCoDinh;
        }

        public double LuongCoDinh { get => luongCoDinh; set => luongCoDinh = value; }
    }
}
