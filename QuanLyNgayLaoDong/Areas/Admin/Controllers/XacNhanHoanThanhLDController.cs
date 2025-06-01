

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QuanLyNgayLaoDong.Models;
using System.Data.Entity;

namespace QuanLyNgayLaoDong.Areas.Admin.Controllers
{
    public class XacNhanHoanThanhLDController : Controller
    {
        private readonly DB_QLNLD _context = new DB_QLNLD();

        // GET: Admin/XacNhanHoanThanhLD
        public ActionResult XacNhanHoanThanh()
        {
            var laborData = _context.SoNgayLaoDongs
                .Include(s => s.SinhVien)
                .Include(s => s.SinhVien.Lop)
                .Include(s => s.SinhVien.Lop.Khoa)
                .Include(s => s.PhieuXacNhanHoanThanh)
                .Where(s => s.TongSoNgay >= 18) // chỉ lấy những sinh viên có tổng số ngày >= 18
                .ToList();

            if (!laborData.Any())
            {
                ViewBag.NoStudentsMessage = "Không có sinh viên nào đủ điều kiện xác nhận.";
            }

            return View(laborData);
        }

        // POST: Admin/XacNhanHoanThanhLD/UpdateStatus
        
        [HttpPost]
        public ActionResult UpdateStatus(int id, string trang_thai)
        {
            // Cập nhật trạng thái trong DB
            var record = _context.SoNgayLaoDongs.Find(id);
            if (record != null)
            {
                if (record.PhieuXacNhanHoanThanh == null)
                {
                    record.PhieuXacNhanHoanThanh = new PhieuXacNhanHoanThanh();
                }
                record.PhieuXacNhanHoanThanh.trang_thai = trang_thai;
                _context.SaveChanges();

                TempData["SuccessMessage"] = "Cập nhật trạng thái thành công!";
            }

            return RedirectToAction("XacNhanHoanThanh");
        }
    }
}