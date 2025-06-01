using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuanLyNgayLaoDong.Areas.Admin.ViewModels
{
    public class DotLaoDongViewModel
    {
        public int STT { get; set; }
        public int ID { get; set; }
        public string DotLaoDong { get; set; }
        public DateTime? NgayLaoDong { get; set; }
        public int SoSinhVien { get; set; }
        public bool? TrangThaiDuyet { get; set; } // true: Duyệt, false: Không duyệt, null: Chưa duyệt
        public int SoLuongSinhVien { get; set; }
        public string LoaiLaoDong { get; set; }
        public List<SinhVienViewModel> SinhVien { get; internal set; }
    }
}
