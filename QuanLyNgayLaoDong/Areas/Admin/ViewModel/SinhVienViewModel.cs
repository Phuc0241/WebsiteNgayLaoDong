using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuanLyNgayLaoDong.Areas.Admin.ViewModels
{
    public class SinhVienViewModel
    {
        public int? MSSV { get; set; }
        public string TenSinhVien { get; set; }

        public bool? gioitinh { get; set; }

        public int? lop_id { get; set; }

        public string SDT { get; set; }

    }
}
