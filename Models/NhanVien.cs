using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Models
{
    public class NhanVien
    {
        private string maNV;
        private string hoTenNV;
        private string soDienThoai;
        private int namSinh;
        private string gioiTinh;
        private string diaChi;
        private string email;
        private string tenDangNhap;
        private string matKhau;
        private string vaiTro;
        public NhanVien()
        {

        }

        public NhanVien(string maNV, string hoTenNV, string soDienThoai, int namSinh, string gioiTinh, string diaChi, string email,string tenDangNhap, string matKhau)
        {
            this.maNV = maNV;
            this.hoTenNV = hoTenNV;
            this.soDienThoai = soDienThoai;
            this.namSinh = namSinh;
            this.gioiTinh = gioiTinh;
            this.diaChi = diaChi;
            this.email = email;
            this.tenDangNhap = tenDangNhap;
            this.matKhau = matKhau;
        }

        public string MaNV { get => maNV; set => maNV = value; }
        public string HoTenNV { get => hoTenNV; set => hoTenNV = value; }
        public string SoDienThoai { get => soDienThoai; set => soDienThoai = value; }
        public int NamSinh { get => namSinh; set => namSinh = value; }
        public string GioiTinh { get => gioiTinh; set => gioiTinh = value; }
        public string DiaChi { get => diaChi; set => diaChi = value; }
        public string TenDangNhap { get => tenDangNhap; set => tenDangNhap = value; }
        public string MatKhau { get => matKhau; set => matKhau = value; }
        public string Email { get => email; set => email = value; }
        public string VaiTro { get => vaiTro; set => vaiTro = value; }
    }
}
