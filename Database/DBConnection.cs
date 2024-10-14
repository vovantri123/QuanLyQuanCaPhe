using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanCaPhe.Database
{
    public class DBConnection
    {   
        // Tạo một đối tượng kết nối Database
        public static SqlConnection conn = new SqlConnection(@"Data Source=(localdb)\mssqllocaldb;Initial Catalog=QuanLyQuanCaPhe;Integrated Security=True");

        // List tham số truyền vào proc và function
        public static List<KeyValuePair<string, object>> parameters = new List<KeyValuePair<string, object>>();
        public static void ClearParameters()
        {
            parameters.Clear();
        }

        public static void AddParameters(string key, object value)
        {
            parameters.Add(new KeyValuePair<string, object>(key, value));
        }

        public DBConnection() 
        {
            
        }
         
        public static DataTable LoadTableVaView(string tenTable)
        {
            try
            {
                moKetNoi();
                string truyVan = string.Format($"SELECT * FROM {tenTable}"); 

                SqlDataAdapter adapter = new SqlDataAdapter(truyVan, conn);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                return dt;
            }
            catch (Exception exc)
            {
                MessageBox.Show(exc.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }
            finally
            {
                dongKetNoi();
            }
        }

        public static DataTable ThucThiFunction_InlineVaMultiStatement(string tenFunction, List<KeyValuePair<string, object>> parameters)
        {
            try
            {
                moKetNoi();
                string truyVan = $@"SELECT * FROM {tenFunction}(";
                for (int i = 0; i < parameters.Count; i++)
                {
                    truyVan += parameters[i].Key;
                    if (i < parameters.Count - 1)
                    {
                        truyVan += ", ";
                    }
                    else
                    {
                        truyVan += ")";
                    }    
                }

                //MessageBox.Show(truyVan);

                SqlCommand cmd = new SqlCommand(truyVan, conn);
                 
                foreach (var param in parameters)
                {
                    cmd.Parameters.AddWithValue(param.Key, param.Value);
                }

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Thất bại\n" + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }
            finally
            {
                dongKetNoi();
            }
        }

        public static void ThucThiProc_CoThamSoVaKhongCoThamSo(string tenProc, List<KeyValuePair<string, object>> parameters)  
        {
            try
            {
                moKetNoi();
                SqlCommand cmd = new SqlCommand(tenProc, conn);
                
                cmd.CommandType = CommandType.StoredProcedure;
                 
                foreach (var param in parameters)
                {
                    cmd.Parameters.AddWithValue(param.Key, param.Value);
                }

                if (cmd.ExecuteNonQuery() > 0)
                    MessageBox.Show("Thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Thất bại\n" + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                dongKetNoi();
            }
        }

        public static void thucThi(string truyVan) //Thực thi câu truy vấn trong c# (cách cũ - không xài trong môn này nữa)
        {
            try
            {
                moKetNoi();
                SqlCommand cmd = new SqlCommand(truyVan, conn);
                if (cmd.ExecuteNonQuery() > 0)
                    MessageBox.Show("Thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Thất bại\n" + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                dongKetNoi();
            }
        }

        public static void moKetNoi()
        {
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                    //MessageBox.Show("Kết nối thành công");
                }
            }
            catch (Exception ex) 
            { 
                MessageBox.Show(ex.Message);
            }
        }

        public static void dongKetNoi()
        {
            if (conn != null && conn.State == ConnectionState.Open)
            {
                conn.Close();
                //MessageBox.Show("Đóng kết nối thành công");
            }
            else
            {
                MessageBox.Show("Chưa tạo kết nối");
            }
        }

    }
}
