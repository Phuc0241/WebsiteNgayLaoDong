using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using QuanLyNgayLaoDong.Models;
using QuanLyNgayLaoDong.Areas.Admin.ViewModels;
using System.Data.Entity;

namespace QuanLyNgayLaoDong.Areas.Admin.Controllers
{
    public class AdminTaskController : Controller
    {
        private readonly DB_QLNLD _context = new DB_QLNLD();

        public ActionResult DuyetLaoDong()
        {
            try
            {
                var dotLaoDongs = _context.TaoDotNgayLaoDongs.ToList();
                var model = dotLaoDongs.Select((d, index) => new DotLaoDongViewModel
                {
                    STT = index + 1,
                    ID = d.ID,
                    DotLaoDong = d.DotLaoDong,
                    NgayLaoDong = d.NgayLaoDong,
                    SoSinhVien = _context.PhieuDangKies.Count(p => p.DotLaoDongId == d.ID),
                    LoaiLaoDong = d.LoaiLaoDong,
                    SoLuongSinhVien = d.SoLuongSinhVien ?? 0,
                    TrangThaiDuyet = d.TrangThaiDuyet ?? false
                }).ToList();

                return View(model);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi tải danh sách: {ex.Message}";
                return View(new List<DotLaoDongViewModel>());
            }
        }

        [HttpGet]
        public ActionResult DanhSachSinhVien(int id)
        {
            try
            {
                var sinhViens = _context.PhieuDangKies
                    .Include(p => p.SinhVien)
                    .Include(p => p.SinhVien.Lop)
                    .Include(p => p.SinhVien.Lop.Khoa)
                    .Where(p => p.DotLaoDongId == id)
                    .Select(p => new
                    {
                        MSSV = p.MSSV,
                        TenSinhVien = p.SinhVien.hoten,
                        Lop = p.SinhVien.Lop != null ? p.SinhVien.Lop.ten_lop : null,
                        Khoa = p.SinhVien.Lop != null && p.SinhVien.Lop.Khoa != null ? p.SinhVien.Lop.Khoa.ten_khoa : null
                    })
                    .ToList();

                return Json(sinhViens, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Response.StatusCode = 500;
                return Json(new { error = $"Lỗi khi tải danh sách: {ex.Message}" }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Duyet(int id)
        {
            try
            {
                var dot = _context.TaoDotNgayLaoDongs.Find(id);
                if (dot == null)
                {
                    return Json(new { success = false, message = "Không tìm thấy đợt lao động." });
                }

                var soSinhVien = _context.PhieuDangKies.Count(p => p.DotLaoDongId == id);
                var soLuongSinhVien = dot.SoLuongSinhVien ?? 0;

                if (soSinhVien < 7)
                {
                    return Json(new { success = false, message = "Số sinh viên đăng ký phải ít nhất 7 để duyệt." });
                }

                if (soSinhVien > soLuongSinhVien)
                {
                    return Json(new { success = false, message = "Số sinh viên đăng ký vượt quá giới hạn cho phép." });
                }

                dot.TrangThaiDuyet = true;
                _context.SaveChanges();
                return Json(new { success = true, message = "Duyệt thành công!" });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = $"Lỗi khi duyệt: {ex.Message}" });
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult KhongDuyet(int id)
        {
            try
            {
                var dot = _context.TaoDotNgayLaoDongs.Find(id);
                if (dot == null)
                {
                    return Json(new { success = false, message = "Không tìm thấy đợt lao động." });
                }
                dot.TrangThaiDuyet = false;
                _context.SaveChanges();
                return Json(new { success = true, message = "Hủy duyệt thành công!" });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = $"Lỗi khi hủy duyệt: {ex.Message}" });
            }
        }

        public ActionResult ChiTiet(int id)
        {
            try
            {
                var dot = _context.TaoDotNgayLaoDongs.Find(id);
                if (dot == null)
                {
                    TempData["ErrorMessage"] = "Không tìm thấy đợt lao động.";
                    return RedirectToAction("DuyetLaoDong");
                }

                var model = new DotLaoDongViewModel
                {
                    ID = dot.ID,
                    DotLaoDong = dot.DotLaoDong,
                    NgayLaoDong = dot.NgayLaoDong,
                    SoSinhVien = _context.PhieuDangKies.Count(p => p.DotLaoDongId == dot.ID),
                    LoaiLaoDong = dot.LoaiLaoDong,
                    SoLuongSinhVien = dot.SoLuongSinhVien ?? 0,
                    TrangThaiDuyet = dot.TrangThaiDuyet ?? false
                };

                return View(model);
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"Lỗi khi xem chi tiết: {ex.Message}";
                return RedirectToAction("DuyetLaoDong");
            }
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _context.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}