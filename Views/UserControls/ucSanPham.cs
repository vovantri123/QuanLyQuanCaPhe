using QuanLyQuanCaPhe.Database;
using QuanLyQuanCaPhe.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanCaPhe.Views.UserControls
{
    public partial class ucSanPham : UserControl
    {
        public ucSanPham()
        {
            InitializeComponent();
        }

        #region Từ con gọi cha 
        public class ThamSoThayDoi : EventArgs
        {
           // public string SoTienMoi { get; set; } //Thêm tham số nếu cần 
        }

        public event EventHandler<ThamSoThayDoi> SuKienGoiFormChaTuFormCon;

        #endregion 

        private void btnDat_Click(object sender, EventArgs e)
        {
            ChiTietHoaDon cthd = new ChiTietHoaDon();
            cthd.MaSP = lblMaSP.Text;
            ChiTietHoaDonDAO.Them(cthd);

            // Gọi sự kiện để thông báo cho form cha
            SuKienGoiFormChaTuFormCon?.Invoke(this, new ThamSoThayDoi());
        }
    }
}
