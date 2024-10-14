using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Models
{
    public class DonHang
    {
        private string maDH;
        private string maKH;
        private string maNV;
        private DateTime ngayMua;
        private double giaTriDon;

        public DonHang()
        {

        }

        public DonHang(string maDH, string maKH, string maNV, DateTime ngayMua, double giaTriDon)
        {
            this.maDH = maDH;
            this.maKH = maKH;
            this.maNV = maNV;
            this.ngayMua = ngayMua;
            this.giaTriDon = giaTriDon;
        }

        public string MaDH { get => maDH; set => maDH = value; }
        public string MaKH { get => maKH; set => maKH = value; }
        public string MaNV { get => maNV; set => maNV = value; }
        public DateTime NgayMua { get => ngayMua; set => ngayMua = value; }
        public double GiaTriDon { get => giaTriDon; set => giaTriDon = value; }
    }
}
