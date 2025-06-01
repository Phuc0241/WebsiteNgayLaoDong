namespace QuanLyNgayLaoDong.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("TaoDotNgayLaoDong")]
    public partial class TaoDotNgayLaoDong
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public TaoDotNgayLaoDong()
        {
            PhieuDangKys = new HashSet<PhieuDangKy>(); // Kh?i t?o t?p h?p
        }

        public int ID { get; set; }

        [StringLength(255)]
        public string TenDotLaoDong { get; set; }

        [StringLength(500)]
        public string MoTa { get; set; }

        [Column(TypeName = "date")]
        public DateTime? NgayBatDau { get; set; }

        [Column(TypeName = "date")]
        public DateTime? NgayKetThuc { get; set; }

        public DateTime? NgayTao { get; set; }

        public DateTime? NgayCapNhat { get; set; }

        public int? NguoiTao { get; set; }

        [StringLength(255)]
        public string DotLaoDong { get; set; }

        [Column(TypeName = "date")]
        public DateTime? NgayLaoDong { get; set; }

        [StringLength(100)]
        public string Buoi { get; set; }

        [StringLength(255)]
        public string LoaiLaoDong { get; set; }

        public int? GiaTri { get; set; }

        [StringLength(100)]
        public string ThoiGian { get; set; }

        [StringLength(100)]
        public string KhuVuc { get; set; }

        public DateTime? Ngayxoa { get; set; }

        public int? SoLuongSinhVien { get; set; }

        public bool? TrangThaiDuyet { get; set; }
        public virtual TaiKhoan TaiKhoan { get; set; }
        public virtual ICollection<DanhSachDiemDanh> DanhSachDiemDanhs { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PhieuDangKy> PhieuDangKys { get; set; } // Thêm navigation property
    }
}