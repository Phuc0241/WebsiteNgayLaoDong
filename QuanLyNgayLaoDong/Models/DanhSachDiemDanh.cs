using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace QuanLyNgayLaoDong.Models
{
[Table("DanhSachDiemDanh")]
public class DanhSachDiemDanh
{

    public int id { get; set; }

    public int MSSV { get; set; }

    [ForeignKey("Dot")]
    public int dot_id { get; set; }

    public string ma_diem_danh { get; set; }

    public DateTime thoi_gian { get; set; }

    public virtual SinhVien SinhVien { get; set; }

    public virtual TaoDotNgayLaoDong Dot { get; set; }
}
}