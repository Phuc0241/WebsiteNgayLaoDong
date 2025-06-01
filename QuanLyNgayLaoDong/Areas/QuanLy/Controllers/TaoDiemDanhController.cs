using QuanLyNgayLaoDong.Areas.QuanLy.ViewModel;
using QuanLyNgayLaoDong.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanLyNgayLaoDong.Areas.QuanLy.Controllers
{
    [Authorize]
    public class TaoDiemDanhController : Controller
    {
        private DB_QLNLD _contextdb = new DB_QLNLD();
        // GET: QuanLy/TaoDiemDanh
        public ActionResult Index()
        {
            return View();
        }
        //thứ 2
        public ActionResult DiemDanhHomNay()
        {
            var today = DateTime.Today;
            ViewBag.Today = today;

            var danhSachDot = _contextdb.TaoDotNgayLaoDongs.ToList();
            ViewBag.DanhSachDot = danhSachDot;

            return View();
        }

        //thứ 2
        [HttpPost]
        public ActionResult TaoMaDiemDanh(int DotLaoDongId)
        {
            var dot = _contextdb.TaoDotNgayLaoDongs.FirstOrDefault(x => x.ID == DotLaoDongId);

            if (dot == null || !dot.NgayLaoDong.HasValue || dot.NgayLaoDong.Value.Date != DateTime.Today)
            {
                TempData["Error"] = "Không thể tạo mã vì chưa đến ngày lao động!";
                return RedirectToAction("DiemDanhHomNay");
            }


            var random = new Random();
            string ma = random.Next(100000, 999999).ToString();

            DiemDanhTempStore.TaoMaDiemDanh(ma);
            TempData["MaMoi"] = ma;

            return RedirectToAction("DiemDanhHomNay");
            //return RedirectToAction("DiemDanhHomNay", new { tab = "taoma" });
        }
     
            [HttpGet]
            public ActionResult LocDiemDanhTheoNgay()
            {
                ViewBag.DanhSachDot = _contextdb.TaoDotNgayLaoDongs.ToList();
                return View(new DiemDanhLocViewModel
                {
                    Ngay = DateTime.Today
                });
            }

            [HttpPost]
            public ActionResult LocDiemDanhTheoNgay(DiemDanhLocViewModel model)
            {
                if (model.Ngay == null)
                {
                    TempData["Error"] = "Bạn cần chọn ngày.";
                    return RedirectToAction("DanhSachTheoNgay");
                }

                // Chuyển hướng sang trang hiển thị danh sách
                return RedirectToAction("DanhSachTheoNgay", "TaoDiemDanh", new
                {
                    ngay = model.Ngay?.ToString("yyyy-MM-dd"),
                    dotLaoDong = model.DotLaoDong,
                    loaiLaoDong = model.LoaiLaoDong,
                    moTa = model.KhuVuc,
                    buoi = model.Buoi,
                    giaTri = model.GiaTri // ✅ truyền thêm
                });
            }

        public ActionResult DanhSachTheoNgay(DateTime? ngay, string dotLaoDong, string loaiLaoDong, string moTa, string buoi, int? giaTri, bool? success) // ✅ thêm)
        {
            if (success == true)
            {
                TempData["Success"] = "Xác nhận hoàn thành thành công."; // gán lại để view dùng được
            }
            if (ngay == null)
            {
                TempData["Error"] = "Thiếu ngày điểm danh.";
                return RedirectToAction("LocDiemDanhTheoNgay", "TaoDiemDanh");
            }

            // Tìm đợt phù hợp theo ngày và điều kiện lọc
            var dot = _contextdb.TaoDotNgayLaoDongs.FirstOrDefault(d =>
                d.NgayLaoDong.HasValue &&
                DbFunctions.TruncateTime(d.NgayLaoDong.Value) == DbFunctions.TruncateTime(ngay.Value) &&
                (string.IsNullOrEmpty(dotLaoDong) || d.DotLaoDong == dotLaoDong) &&
                (string.IsNullOrEmpty(loaiLaoDong) || d.LoaiLaoDong == loaiLaoDong) &&
                (string.IsNullOrEmpty(moTa) || d.MoTa == moTa) &&
                (string.IsNullOrEmpty(buoi) || d.Buoi == buoi)
            );
            var DotLaoDongIds = _contextdb.TaoDotNgayLaoDongs
                        .Where(d =>
                            d.NgayLaoDong.HasValue &&
                            DbFunctions.TruncateTime(d.NgayLaoDong.Value) == DbFunctions.TruncateTime(ngay.Value) &&
                            (string.IsNullOrEmpty(dotLaoDong) || d.DotLaoDong == dotLaoDong) &&
                            (string.IsNullOrEmpty(loaiLaoDong) || d.LoaiLaoDong == loaiLaoDong) &&
                            (string.IsNullOrEmpty(moTa) || d.KhuVuc == moTa) &&
                            (string.IsNullOrEmpty(buoi) || d.Buoi == buoi) &&
                            (!giaTri.HasValue || d.GiaTri == giaTri) // ✅ lọc theo giá trị
                        )
                        .Select(d => d.ID)
                        .ToList();


            if (DotLaoDongIds.Count == 0)
            {
                ViewBag.Ngay = ngay;
                return View(new List<DiemDanhViewModel>());
            }

            var danhSach = _contextdb.DanhSachDiemDanhs
                            .Where(dd => DotLaoDongIds.Contains(dd.dot_id))
                            .Join(_contextdb.SinhViens, dd => dd.MSSV, sv => sv.MSSV, (dd, sv) => new { dd, sv })
                           .Join(_contextdb.TaoDotNgayLaoDongs, x => x.dd.dot_id, d => d.ID, (x, d) => new DiemDanhViewModel
                           {
                               MSSV = x.sv.MSSV,
                               HoTen = x.sv.hoten,
                               Lop = _contextdb.Lops.Where(l => l.lop_id == x.sv.lop_id).Select(l => l.ten_lop).FirstOrDefault(),
                               ThoiGianDiemDanh = x.dd.thoi_gian,
                               MaDiemDanh = x.dd.ma_diem_danh,
                               DotLaoDongId = x.dd.dot_id,
                               GiaTri = d.GiaTri,         // lấy thêm thông tin
                               KhuVuc = d.KhuVuc,         // lấy thêm thông tin
                           }).ToList();

            ViewBag.Ngay = ngay;
            return View(danhSach); // 👈 THÊM DÒNG NÀY ĐỂ RETURN KẾT QUẢ
        }


     
        // GET: Tạo mã điểm danh mới
        public ActionResult TaoMa()
        {
            var random = new Random();
            string ma = random.Next(100000, 999999).ToString();

            DiemDanhTempStore.TaoMaDiemDanh(ma);
            ViewBag.MaMoi = ma;

            return View();
        }

        // GET: Danh sách sinh viên đã điểm danh theo mã
        public ActionResult DanhSach(string ma)
        {
            if (!DiemDanhTempStore.KiemTraMa(ma))
            {
                TempData["Error"] = "Mã điểm danh không hợp lệ hoặc đã hết hạn.";
                return RedirectToAction("TaoMa");
            }

            var mssvs = DiemDanhTempStore.LayDanhSachMSSV(ma);

            var danhSach = _contextdb.SinhViens.Where(sv => mssvs.Contains(sv.MSSV)).ToList();
            return View( danhSach); // Trả về view danh sách sinh viên đã điểm danh
        }
        [HttpGet]
        public ActionResult XacNhanHoanThanh(DateTime? ngay, string dotLaoDong, string loaiLaoDong, string moTa, string buoi)
        {
            if (ngay == null)
            {
                TempData["Error"] = "Ngày không được để trống.";
                return RedirectToAction("LocDiemDanhTheoNgay");
            }

            // Lấy danh sách các DotLaoDongId phù hợp điều kiện
            var DotLaoDongIds = _contextdb.TaoDotNgayLaoDongs
                .Where(d =>
                    d.NgayLaoDong.HasValue &&
                    DbFunctions.TruncateTime(d.NgayLaoDong.Value) == DbFunctions.TruncateTime(ngay.Value) &&
                    (string.IsNullOrEmpty(dotLaoDong) || d.DotLaoDong == dotLaoDong) &&
                    (string.IsNullOrEmpty(loaiLaoDong) || d.LoaiLaoDong == loaiLaoDong) &&
                    (string.IsNullOrEmpty(moTa) || d.MoTa == moTa) &&
                    (string.IsNullOrEmpty(buoi) || d.Buoi == buoi)
                )
                .Select(d => d.ID)
                .ToList();

            // Lấy danh sách điểm danh tương ứng
            var danhSachDiemDanh = _contextdb.DanhSachDiemDanhs
                .Where(dd => DotLaoDongIds.Contains(dd.dot_id))
                .ToList();

            // Lấy danh sách sinh viên
            var sinhVienList = _contextdb.SinhViens.ToList();

            // Lấy danh sách lớp (để lấy tên lớp)
            var lopList = _contextdb.Lops.ToList();

            // Lấy danh sách phiếu xác nhận đã có (để check trạng thái)
            var phieuXacNhanList = _contextdb.PhieuXacNhanHoanThanhs.ToList();

            // Tạo ViewModel với trạng thái đã xác nhận
            var danhSach = (from dd in danhSachDiemDanh
                            join sv in sinhVienList on dd.MSSV equals sv.MSSV
                            join lop in lopList on sv.lop_id equals lop.lop_id
                            select new DiemDanhXacNhanViewModel
                            {
                                MSSV = sv.MSSV,
                                HoTen = sv.hoten,
                                Lop = lop.ten_lop,
                                ThoiGianDiemDanh = dd.thoi_gian,
                                DotLaoDongId = dd.dot_id,
                                DuocXacNhan = false,
                                DaXacNhan = phieuXacNhanList.Any(px => px.MSSV == sv.MSSV && px.phieuduyet == dd.dot_id)
                            }).ToList();

            ViewBag.Ngay = ngay;
            return View(danhSach);
        }


        [HttpPost]
        public ActionResult XacNhanHoanThanh(List<DiemDanhXacNhanViewModel> danhSach)
        {
            int nextId = 1;
            if (_contextdb.PhieuXacNhanHoanThanhs.Any())
            {
                nextId = _contextdb.PhieuXacNhanHoanThanhs.Max(p => p.id) + 1;
            }
            var nguoiXacNhanId = 1; // giả định chưa có session

            foreach (var item in danhSach.Where(x => x.DuocXacNhan))
            {
                var phieuDuyet = _contextdb.PhieuDuyets
                    .Include(p => p.PhieuDangKy1)
                    .FirstOrDefault(p =>
                        p.PhieuDangKy1.DotLaoDongId == item.DotLaoDongId &&
                        p.PhieuDangKy1.MSSV == item.MSSV);
                if (phieuDuyet == null)
                {
                    // Có thể lưu phiếu xác nhận không liên kết phiếu duyệt
                    var phieu = new PhieuXacNhanHoanThanh
                    {
                        id = nextId++,
                        MSSV = item.MSSV,
                        phieuduyet = null, // ✅ cho phép null
                        NguoiXacNhan = nguoiXacNhanId,
                        ThoiGian = DateTime.Now
                    };

                    _contextdb.PhieuXacNhanHoanThanhs.Add(phieu);
                    _contextdb.SaveChanges();
                    continue;
                }

                var daCoPhieu = _contextdb.PhieuXacNhanHoanThanhs
                    .Any(px => px.MSSV == item.MSSV && px.phieuduyet == phieuDuyet.id);

                if (!daCoPhieu)
                {
                    var phieu = new PhieuXacNhanHoanThanh
                    {
                        MSSV = item.MSSV,
                        phieuduyet = phieuDuyet.id,
                        NguoiXacNhan = nguoiXacNhanId,
                        ThoiGian = DateTime.Now
                    };

                    _contextdb.PhieuXacNhanHoanThanhs.Add(phieu);
                    _contextdb.SaveChanges(); // ✅ để lấy được id

                    var dot = _contextdb.TaoDotNgayLaoDongs.FirstOrDefault(d => d.ID == item.DotLaoDongId);
                    int soNgay = dot?.GiaTri ?? 1;

                    var soNgayLaoDong = new SoNgayLaoDong
                    {
                        MSSV = item.MSSV,
                        TongSoNgay = soNgay,
                        Ma_phieu_xac_nhan = phieu.id
                    };

                    _contextdb.SoNgayLaoDongs.Add(soNgayLaoDong);
                    _contextdb.SaveChanges(); // ✅ nhớ lưu tiếp
                }
            }

            _contextdb.SaveChanges();

            TempData["Success"] = "Xác nhận hoàn thành thành công.";
            var ngay = DateTime.Today; // hoặc lấy từ ViewBag, TempData, v.v.
                                       //return RedirectToAction("LocDiemDanhTheoNgay");
            return RedirectToAction("DanhSachTheoNgay", new { ngay = DateTime.Today, success = true });
        }
        //[HttpPost]
        //public ActionResult XacNhanSoNgayLaoDong(List<DiemDanhXacNhanViewModel> danhSach)
        //{
        //    // Lấy dot để có GiaTri mặc định
        //    var dotIds = danhSach.Select(d => d.DotId).Distinct().ToList();
        //    var dotInfos = _contextdb.TaoDotNgayLaoDongs
        //                    .Where(d => dotIds.Contains(d.ID))
        //                    .ToDictionary(d => d.ID, d => d.GiaTri ?? 1);

        //    // Chuẩn bị danh sách mới
        //    var viewModelList = danhSach
        //        .Where(x => x.DuocXacNhan)
        //        .Select(x => new XacNhanSoNgayLaoDongViewModel
        //        {
        //            MSSV = x.MSSV,
        //            HoTen = x.HoTen,
        //            Lop = x.Lop,
        //            DotId = x.DotId,
        //            GiaTriMacDinh = dotInfos.ContainsKey(x.DotId) ? dotInfos[x.DotId] : 1,
        //            SoNgayXacNhan = dotInfos.ContainsKey(x.DotId) ? dotInfos[x.DotId] : 1
        //        }).ToList();

        //    return View("XacNhanSoNgayLaoDong", viewModelList);
        //}
        [HttpPost]
        public ActionResult XacNhanSoNgayLaoDong(List<DiemDanhXacNhanViewModel> danhSach)
        {
            var DotLaoDongIds = danhSach.Select(d => d.DotLaoDongId).Distinct().ToList();
            var dotInfos = _contextdb.TaoDotNgayLaoDongs
                            .Where(d => DotLaoDongIds.Contains(d.ID))
                            .ToDictionary(d => d.ID, d => d.GiaTri ?? 1);

            // Lấy danh sách phiếu xác nhận để tìm đúng id
            var danhSachPhieu = _contextdb.PhieuXacNhanHoanThanhs.ToList();

            var viewModelList = danhSach
                .Where(x => x.DuocXacNhan)
                .Select(x =>
                {
                    var phieu = danhSachPhieu.FirstOrDefault(p =>
                        p.MSSV == x.MSSV &&
                        p.phieuduyet.HasValue &&
                        _contextdb.PhieuDuyets.Any(pd =>
                            pd.id == p.phieuduyet &&
                            pd.PhieuDangKy1.DotLaoDongId == x.DotLaoDongId &&
                            pd.PhieuDangKy1.MSSV == x.MSSV)
                    );

                    return new XacNhanSoNgayLaoDongViewModel
                    {
                        MSSV = x.MSSV,
                        HoTen = x.HoTen,
                        Lop = x.Lop,
                        DotLaoDongId = x.DotLaoDongId,
                        GiaTriMacDinh = dotInfos.ContainsKey(x.DotLaoDongId) ? dotInfos[x.DotLaoDongId] : 1,
                        SoNgayXacNhan = dotInfos.ContainsKey(x.DotLaoDongId) ? dotInfos[x.DotLaoDongId] : 1,
                        PhieuXacNhanId = phieu?.id
                    };
                }).ToList();

            return View("XacNhanSoNgayLaoDong", viewModelList);
        }

        //[HttpPost]
        //public ActionResult LuuSoNgayLaoDong(List<XacNhanSoNgayLaoDongViewModel> danhSach)
        //{
        //    int nextId = 1;
        //    if (_contextdb.SoNgayLaoDongs.Any())
        //        nextId = _contextdb.SoNgayLaoDongs.Max(x => x.id) + 1;

        //    foreach (var item in danhSach)
        //    {
        //        // Kiểm tra đã có chưa
        //        var daCo = _contextdb.SoNgayLaoDongs
        //                    .Any(s => s.MSSV == item.MSSV && s.Ma_phieu_xac_nhan == null && s.TongSoNgay == item.SoNgayXacNhan);

        //        if (!daCo)
        //        {
        //            var soNgay = new SoNgayLaoDong
        //            {
        //                id = nextId++,
        //                MSSV = item.MSSV,
        //                TongSoNgay = item.SoNgayXacNhan,
        //                Ma_phieu_xac_nhan = null // nếu chưa liên kết phiếu xác nhận
        //            };

        //            _contextdb.SoNgayLaoDongs.Add(soNgay);
        //        }
        //    }

        //    _contextdb.SaveChanges();

        //    TempData["Success"] = "Lưu số ngày lao động thành công.";
        //    return RedirectToAction("DanhSachTheoNgay", new { ngay = DateTime.Today, success = true });
        //}
        [HttpPost]
        public ActionResult LuuSoNgayLaoDong(List<XacNhanSoNgayLaoDongViewModel> danhSach)
        {
            int nextId = 1;
            if (_contextdb.SoNgayLaoDongs.Any())
                nextId = _contextdb.SoNgayLaoDongs.Max(x => x.id) + 1;

            foreach (var item in danhSach)
            {
                // Kiểm tra nếu đã tồn tại (dựa theo MSSV + Ma_phieu_xac_nhan)
                bool daCo = item.PhieuXacNhanId.HasValue &&
                    _contextdb.SoNgayLaoDongs.Any(s =>
                        s.MSSV == item.MSSV &&
                        s.Ma_phieu_xac_nhan == item.PhieuXacNhanId);

                if (!daCo)
                {
                    var soNgay = new SoNgayLaoDong
                    {
                        id = nextId++,
                        MSSV = item.MSSV,
                        TongSoNgay = item.SoNgayXacNhan,
                        Ma_phieu_xac_nhan = item.PhieuXacNhanId // ✅ LIÊN KẾT CHUẨN
                    };

                    _contextdb.SoNgayLaoDongs.Add(soNgay);
                }
            }

            _contextdb.SaveChanges();

            TempData["Success"] = "Lưu số ngày lao động thành công.";
            return RedirectToAction("DanhSachTheoNgay", new { ngay = DateTime.Today, success = true });
        }


    }
}