using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace QuanLyNgayLaoDong.Areas.QuanLy.ViewModel
{
    public class DiemDanh
    {
        public int Id { get; set; }
        public int MSSV { get; set; }
        public DateTime NgayDiemDanh { get; set; }

        //public virtual SinhVien SinhVien { get; set; }
        public virtual QuanLyNgayLaoDong.Models.SinhVien SinhVien { get; set; }

        public DbSet<DiemDanh> DiemDanhs { get; set; }

    }
}