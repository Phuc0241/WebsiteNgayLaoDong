using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuanLyNgayLaoDong.Areas.QuanLy.ViewModel
{
    public class XacNhanSoNgayLaoDongViewModel
    {
        public int MSSV { get; set; }
        public string HoTen { get; set; }
        public string Lop { get; set; }
        public int DotLaoDongId { get; set; }
        public int GiaTriMacDinh { get; set; } // từ bảng TaoDotNgayLaoDong
        public int SoNgayXacNhan { get; set; } // nhập từ người xác nhận
        public int? PhieuXacNhanId { get; set; } // ➕ thêm dòng này
    }
}