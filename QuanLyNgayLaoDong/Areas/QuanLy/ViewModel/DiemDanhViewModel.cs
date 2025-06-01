using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuanLyNgayLaoDong.Areas.QuanLy.ViewModel
{
    public class DiemDanhViewModel
    {
        public int MSSV { get; set; }
        public string HoTen { get; set; }
        public string Lop { get; set; }
        public DateTime ThoiGianDiemDanh { get; set; }
        public string MaDiemDanh { get; set; }
        public int DotLaoDongId { get; set; } // Thêm để lưu đúng đợt
        public int? GiaTri { get; set; } // Thêm để hiển thị số ngày lao động
        public bool DaXacNhan { get; set; } // Trạng thái xác nhận
        public string KhuVuc { get; set; } // ✅ thêm
    }
}