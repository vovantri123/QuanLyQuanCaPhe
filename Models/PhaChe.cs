﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCaPhe.Models
{
    public class PhaChe
    {
        private string maSP;
        private string maNL;
        private string soLuong;

        public PhaChe()
        {

        }

        public PhaChe(string maSP, string maNL, string soLuong)
        {
            this.maSP = maSP;
            this.maNL = maNL;
            this.soLuong = soLuong;
        }

        public string MaSP { get => maSP; set => maSP = value; }
        public string MaNL { get => maNL; set => maNL = value; }
        public string SoLuong { get => soLuong; set => soLuong = value; }
    }
}