using Microsoft.Reporting.WinForms;
using QuanLyQuanCaPhe.Database;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanCaPhe
{
    public partial class fBill : Form
    {
        private string ngayMua;
        private string maDH;
        private string tenKH;
        private string tenNV;

        private string tong;
        private string giam;
        private string thanhTien;



        public fBill()
        {
            InitializeComponent();
        }

        public fBill(string ngayMua, string maDH, string tenKH, string tenNV, string tong, string giam, string thanhTien)
        {
            this.ngayMua = ngayMua;
            this.maDH = maDH;
            this.tenKH = tenKH;
            this.tenNV = tenNV;
            this.tong = tong;
            this.giam = giam;
            this.thanhTien = thanhTien;
            InitializeComponent();
        }

        private void fBill_Load(object sender, EventArgs e)
        { 
            // Đặt báo cáo RDLC
            rpvBill.LocalReport.ReportEmbeddedResource = "QuanLyQuanCaPhe.Views.ReportBill.rdlc";

            // Tạo ReportDataSource và liên kết DataTable vào báo cáo
            ReportDataSource rds = new ReportDataSource();
            rds.Name = "DataSet1";  // Đảm bảo tên DataSet trong RDLC khớp
            rds.Value = DBConnection.LoadTableVaView("v_DanhSachSanPhamDaChon");   

            // Thêm nguồn dữ liệu vào ReportViewer
            rpvBill.LocalReport.DataSources.Add(rds);


            // Thêm tham số vào báo cáo
            ReportParameter[] parameters = new ReportParameter[7];
            parameters[0] = new ReportParameter("txtNgayMua", ngayMua);
            parameters[1] = new ReportParameter("txtTenNV", tenNV);
            parameters[2] = new ReportParameter("txtTenKH", tenKH);
            parameters[3] = new ReportParameter("txtMaDH", maDH);
            parameters[4] = new ReportParameter("txtTong", tong);
            parameters[5] = new ReportParameter("txtGiam", giam);
            parameters[6] = new ReportParameter("txtThanhTien", thanhTien);

            // Truyền tham số vào báo cáo RDLC
            rpvBill.LocalReport.SetParameters(parameters);

            // Refresh báo cáo
            rpvBill.RefreshReport();

        }
         
    }
}
