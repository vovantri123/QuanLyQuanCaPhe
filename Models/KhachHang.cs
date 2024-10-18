using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Models
{
    public class KhachHang
    {
        private string maKH;
        private string tenKH;
        private string soDienThoai;
        private double soDiemTichLuy;

        public KhachHang()
        {

        }

        public KhachHang(string maKH)
        {
            this.maKH = maKH;
        }

        public KhachHang(string maKH, string tenKH, string soDienThoai, double soDiemTichLuy)
        {
            this.maKH = maKH;
            this.tenKH = tenKH;
            this.soDienThoai = soDienThoai;
            this.soDiemTichLuy = soDiemTichLuy;
        }

        public string MaKH { get => maKH; set => maKH = value; }
        public string TenKH { get => tenKH; set => tenKH = value; }
        public string SoDienThoai { get => soDienThoai; set => soDienThoai = value; }
        public double SoDiemTichLuy { get => soDiemTichLuy; set => soDiemTichLuy = value; }
    }
}
