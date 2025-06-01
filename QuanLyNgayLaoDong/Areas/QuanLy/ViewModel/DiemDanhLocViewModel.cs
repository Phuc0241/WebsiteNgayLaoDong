using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuanLyNgayLaoDong.Areas.QuanLy.ViewModel
{
    public class DiemDanhLocViewModel
    {
        public DateTime? Ngay { get; set; }
        public string DotLaoDong { get; set; }
        public string LoaiLaoDong { get; set; }
        public string KhuVuc { get; set; }
        public string Buoi { get; set; }
        public int? GiaTri { get; set; } // ✅ thêm dòng này
    }
}