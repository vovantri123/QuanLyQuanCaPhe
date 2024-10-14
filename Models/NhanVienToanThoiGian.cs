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
        private string vaiTro;

        public NhanVienToanThoiGian() 
        {

        }

        public NhanVienToanThoiGian(string maNV, string hoTenNV, string soDienThoai, int namSinh, string gioiTinh, string diaChi, string tenDangNhap, string matKhau, double luongCoDinh, string vaiTro):base(maNV, hoTenNV, soDienThoai, namSinh, gioiTinh, diaChi,  tenDangNhap, matKhau)
        {
            this.luongCoDinh = luongCoDinh;
            this.vaiTro = vaiTro;
        }

        public double LuongCoDinh { get => luongCoDinh; set => luongCoDinh = value; }
        public string VaiTro { get => vaiTro; set => vaiTro = value; }
    }
}
