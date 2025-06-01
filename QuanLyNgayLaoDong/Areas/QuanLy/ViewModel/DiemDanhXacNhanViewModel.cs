using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuanLyNgayLaoDong.Areas.QuanLy.ViewModel
{
    public class DiemDanhXacNhanViewModel
    {
        public int MSSV { get; set; }
        public string HoTen { get; set; }
        public string Lop { get; set; }
        public DateTime ThoiGianDiemDanh { get; set; }
        public int DotLaoDongId { get; set; }
        public bool DuocXacNhan { get; set; } // checkbox từ người xác nhận
        public bool DaXacNhan { get; set; } // trạng thái đã xác nhận rồi (để disable checkbox nếu cần)
    }
}