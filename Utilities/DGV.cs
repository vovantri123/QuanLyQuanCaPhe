using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanCaPhe.Utilities
{
    public class DGV //DataGridView
    {
        public static void ChinhSizeCotTuDong(DataGridView tenDGV) //Chỉnh size cột tự động  
        { 
            if (tenDGV.Rows.Count > 0)
            {
                int columnCount = tenDGV.Rows[0].Cells.Count;
                for (int i = 0; i < columnCount; i++)
                {
                    DataGridViewColumn col = tenDGV.Columns[i];
                    col.AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells;
                }
            }
        }
    }
}
