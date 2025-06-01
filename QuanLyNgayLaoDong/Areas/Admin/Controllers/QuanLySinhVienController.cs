using QuanLyNgayLaoDong.Models;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using System;
using System.IO;
using System.Web;
using System.Collections.Generic;
using QuanLyNgayLaoDong.Areas.Admin.ViewModels;

namespace QuanLyNgayLaoDong.Areas.Admin.Controllers
{
    public class QuanLySinhVienController : Controller
    {
        private readonly DB_QLNLD _context;

        public QuanLySinhVienController()
        {
            _context = new DB_QLNLD();
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _context.Dispose();
            }
            base.Dispose(disposing);
        }

        // GET: Trang chủ sinh viên with pagination
        public ActionResult TrangChuSinhVien(int page = 1, int pageSize = 5)
        {
            try
            {
                var totalRecords = _context.SinhViens.Count();
                var sinhVienList = _context.SinhViens
                    .Include(sv => sv.Lop.Khoa)
                    .Include(sv => sv.Anh)
                    .OrderBy(sv => sv.MSSV)
                    .Skip((page - 1) * pageSize)
                    .Take(pageSize)
                    .ToList();

                ViewBag.LopList = new SelectList(_context.Lops, "lop_id", "ten_lop");

                // Pagination info
                ViewBag.CurrentPage = page;
                ViewBag.TotalPages = (int)Math.Ceiling((double)totalRecords / pageSize);
                ViewBag.PageSize = pageSize;

                if (!sinhVienList.Any() && totalRecords == 0)
                {
                    TempData["Message"] = "Không tìm thấy dữ liệu sinh viên.";
                }

                return View(sinhVienList);
            }
            catch (Exception ex)
            {
                TempData["Error"] = "Lỗi tải danh sách sinh viên: " + ex.Message;
                return View(new List<QuanLyNgayLaoDong.Models.SinhVien>());
            }
        }

        // GET: Chi tiết sinh viên
        public ActionResult ChiTietSinhVien(int? id)
        {
            try
            {
                if (id == null)
                {
                    TempData["Error"] = "MSSV không hợp lệ.";
                    return RedirectToAction("TrangChuSinhVien");
                }

                var sinhVien = _context.SinhViens
                    .Include(sv => sv.Lop.Khoa)
                    .Include(sv => sv.Anh)
                    .FirstOrDefault(sv => sv.MSSV == id);

                if (sinhVien == null)
                {
                    TempData["Error"] = $"Không tìm thấy sinh viên với MSSV: {id}";
                    return RedirectToAction("TrangChuSinhVien");
                }

                return View(sinhVien);
            }
            catch (Exception ex)
            {
                TempData["Error"] = "Lỗi xem chi tiết sinh viên: " + ex.Message;
                return RedirectToAction("TrangChuSinhVien");
            }
        }

        // GET: Sửa sinh viên
        public ActionResult SuaSinhVien(int? id)
        {
            try
            {
                if (id == null)
                {
                    TempData["Error"] = "MSSV không hợp lệ.";
                    return RedirectToAction("TrangChuSinhVien");
                }

                var sinhVien = _context.SinhViens
                    .Include(sv => sv.Lop)
                    .Include(sv => sv.Anh)
                    .FirstOrDefault(sv => sv.MSSV == id);

                if (sinhVien == null)
                {
                    TempData["Error"] = $"Không tìm thấy sinh viên với MSSV: {id}";
                    return RedirectToAction("TrangChuSinhVien");
                }

                ViewBag.LopList = new SelectList(_context.Lops, "lop_id", "ten_lop", sinhVien.lop_id);
                return View(sinhVien);
            }
            catch (Exception ex)
            {
                TempData["Error"] = "Lỗi tải form sửa sinh viên: " + ex.Message;
                return RedirectToAction("TrangChuSinhVien");
            }
        }

        // POST: Sửa sinh viên
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult SuaSinhVien(QuanLyNgayLaoDong.Models.SinhVien sinhVien, HttpPostedFileBase anh)
        {
            try
            {
                // Validate SĐT
                if (!string.IsNullOrEmpty(sinhVien.SDT))
                {
                    if (!System.Text.RegularExpressions.Regex.IsMatch(sinhVien.SDT, @"^\d{10}$"))
                    {
                        ModelState.AddModelError("SDT", "SĐT phải có đúng 10 chữ số.");
                    }
                    else if (_context.SinhViens.Any(sv => sv.SDT == sinhVien.SDT && sv.MSSV != sinhVien.MSSV))
                    {
                        ModelState.AddModelError("SDT", "SĐT đã được sử dụng.");
                    }
                }

                // Validate Email
                if (!string.IsNullOrEmpty(sinhVien.email))
                {
                    if (!System.Text.RegularExpressions.Regex.IsMatch(sinhVien.email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
                    {
                        ModelState.AddModelError("email", "Email không hợp lệ.");
                    }
                    else if (_context.SinhViens.Any(sv => sv.email == sinhVien.email && sv.MSSV != sinhVien.MSSV))
                    {
                        ModelState.AddModelError("email", "Email đã được sử dụng.");
                    }
                }

                if (ModelState.IsValid)
                {
                    var existingSinhVien = _context.SinhViens.Find(sinhVien.MSSV);
                    if (existingSinhVien == null)
                    {
                        TempData["Error"] = $"Không tìm thấy sinh viên với MSSV: {sinhVien.MSSV}";
                        return RedirectToAction("TrangChuSinhVien");
                    }

                    // Handle image upload
                    if (anh != null && anh.ContentLength > 0)
                    {
                        var allowedExtensions = new[] { ".jpg", ".jpeg", ".png" };
                        var extension = Path.GetExtension(anh.FileName).ToLower();
                        if (!allowedExtensions.Contains(extension))
                        {
                            TempData["Error"] = "Chỉ chấp nhận file .jpg, .jpeg, .png.";
                            ViewBag.LopList = new SelectList(_context.Lops, "lop_id", "ten_lop", sinhVien.lop_id);
                            return RedirectToAction("TrangChuSinhVien");
                        }

                        // Ensure Uploads folder exists
                        string uploadsDir = Server.MapPath("~/Uploads/SinhVien/");
                        if (!Directory.Exists(uploadsDir))
                        {
                            Directory.CreateDirectory(uploadsDir);
                        }

                        string fileName = Guid.NewGuid() + extension;
                        string path = Path.Combine(uploadsDir, fileName);

                        try
                        {
                            anh.SaveAs(path);
                        }
                        catch (Exception ex)
                        {
                            TempData["Error"] = $"Lỗi lưu file ảnh: {ex.Message}";
                            ViewBag.LopList = new SelectList(_context.Lops, "lop_id", "ten_lop", sinhVien.lop_id);
                            return RedirectToAction("TrangChuSinhVien");
                        }

                        // Delete old image if exists
                        if (!string.IsNullOrEmpty(existingSinhVien.Anh?.duongdan))
                        {
                            string oldPath = Path.Combine(Server.MapPath("~/Uploads/SinhVien/"), existingSinhVien.Anh.duongdan);
                            if (System.IO.File.Exists(oldPath))
                            {
                                try
                                {
                                    System.IO.File.Delete(oldPath);
                                }
                                catch (Exception ex)
                                {
                                    TempData["Error"] = $"Lỗi xóa ảnh cũ: {ex.Message}";
                                }
                            }
                        }

                        if (existingSinhVien.Anh == null)
                        {
                            existingSinhVien.Anh = new Anh();
                        }
                        existingSinhVien.Anh.duongdan = fileName; // Cập nhật đường dẫn mới
                    }

                    existingSinhVien.hoten = sinhVien.hoten;
                    existingSinhVien.ngaysinh = sinhVien.ngaysinh;
                    existingSinhVien.quequan = sinhVien.quequan;
                    existingSinhVien.gioitinh = sinhVien.gioitinh;
                    existingSinhVien.SDT = sinhVien.SDT;
                    existingSinhVien.email = sinhVien.email;
                    existingSinhVien.lop_id = sinhVien.lop_id;

                    _context.SaveChanges();
                    TempData["Message"] = "Cập nhật sinh viên thành công!";
                    return RedirectToAction("TrangChuSinhVien");
                }

                TempData["Error"] = "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.";
                ViewBag.LopList = new SelectList(_context.Lops, "lop_id", "ten_lop", sinhVien.lop_id);
                return RedirectToAction("TrangChuSinhVien");
            }
            catch (Exception ex)
            {
                TempData["Error"] = "Lỗi cập nhật sinh viên: " + ex.Message;
                ViewBag.LopList = new SelectList(_context.Lops, "lop_id", "ten_lop", sinhVien.lop_id);
                return RedirectToAction("TrangChuSinhVien");
            }
        }

        // GET: Xóa sinh viên
        public ActionResult XoaSinhVien(int? id)
        {
            try
            {
                if (id == null)
                {
                    TempData["Error"] = "MSSV không hợp lệ.";
                    return RedirectToAction("TrangChuSinhVien");
                }

                var sinhVien = _context.SinhViens
                    .Include(sv => sv.Lop.Khoa)
                    .Include(sv => sv.Anh)
                    .FirstOrDefault(sv => sv.MSSV == id);

                if (sinhVien == null)
                {
                    TempData["Error"] = $"Không tìm thấy sinh viên với MSSV: {id}";
                    return RedirectToAction("TrangChuSinhVien");
                }

                return View(sinhVien);
            }
            catch (Exception ex)
            {
                TempData["Error"] = "Lỗi tải form xóa sinh viên: " + ex.Message;
                return RedirectToAction("TrangChuSinhVien");
            }
        }

        // POST: Xóa sinh viên
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult XoaSinhVienConfirmed(int id)
        {
            try
            {
                var sinhVien = _context.SinhViens
                    .Include(sv => sv.Anh)
                    .FirstOrDefault(sv => sv.MSSV == id);

                if (sinhVien == null)
                {
                    TempData["Error"] = $"Không tìm thấy sinh viên với MSSV: {id}";
                    return RedirectToAction("TrangChuSinhVien");
                }

                // Delete associated image
                if (sinhVien.Anh != null && !string.IsNullOrEmpty(sinhVien.Anh.duongdan))
                {
                    string path = Path.Combine(Server.MapPath("~/Uploads/"), sinhVien.Anh.duongdan);
                    if (System.IO.File.Exists(path))
                    {
                        try
                        {
                            System.IO.File.Delete(path);
                        }
                        catch (Exception ex)
                        {
                            TempData["Error"] = $"Lỗi xóa ảnh: {ex.Message}";
                        }
                    }
                }

                _context.SinhViens.Remove(sinhVien);
                _context.SaveChanges();
                TempData["Message"] = "Xóa sinh viên thành công!";
                return RedirectToAction("TrangChuSinhVien");
            }
            catch (Exception ex)
            {
                TempData["Error"] = "Lỗi xóa sinh viên: " + ex.Message;
                return RedirectToAction("TrangChuSinhVien");
            }
        }

        // GET: Thêm sinh viên
        public ActionResult ThemSinhVien()
        {
            try
            {
                ViewBag.LopList = new SelectList(_context.Lops, "lop_id", "ten_lop");
                return View();
            }
            catch (Exception ex)
            {
                TempData["Error"] = "Lỗi tải form thêm sinh viên: " + ex.Message;
                return RedirectToAction("TrangChuSinhVien");
            }
        }

        // POST: Thêm sinh viên
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ThemSinhVien(QuanLyNgayLaoDong.Models.SinhVien sinhVien, HttpPostedFileBase anh)
        {
            try
            {
                // Validate SĐT
                if (!string.IsNullOrEmpty(sinhVien.SDT))
                {
                    if (!System.Text.RegularExpressions.Regex.IsMatch(sinhVien.SDT, @"^\d{10}$"))
                    {
                        ModelState.AddModelError("SDT", "SĐT phải có đúng 10 chữ số.");
                    }
                    else if (_context.SinhViens.Any(sv => sv.SDT == sinhVien.SDT))
                    {
                        ModelState.AddModelError("SDT", "SĐT đã được sử dụng.");
                    }
                }

                // Validate Email
                if (!string.IsNullOrEmpty(sinhVien.email))
                {
                    if (!System.Text.RegularExpressions.Regex.IsMatch(sinhVien.email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
                    {
                        ModelState.AddModelError("email", "Email không hợp lệ.");
                    }
                    else if (_context.SinhViens.Any(sv => sv.email == sinhVien.email))
                    {
                        ModelState.AddModelError("email", "Email đã được sử dụng.");
                    }
                }

                if (ModelState.IsValid)
                {
                    if (_context.SinhViens.Any(sv => sv.MSSV == sinhVien.MSSV))
                    {
                        TempData["Error"] = "MSSV đã tồn tại.";
                        ViewBag.LopList = new SelectList(_context.Lops, "lop_id", "ten_lop", sinhVien.lop_id);
                        return RedirectToAction("TrangChuSinhVien");
                    }

                    // Handle image upload
                    if (anh != null && anh.ContentLength > 0)
                    {
                        var allowedExtensions = new[] { ".jpg", ".jpeg", ".png" };
                        var extension = Path.GetExtension(anh.FileName).ToLower();
                        if (!allowedExtensions.Contains(extension))
                        {
                            TempData["Error"] = "Chỉ chấp nhận file .jpg, .jpeg, .png.";
                            ViewBag.LopList = new SelectList(_context.Lops, "lop_id", "ten_lop", sinhVien.lop_id);
                            return RedirectToAction("TrangChuSinhVien");
                        }

                        // Ensure Uploads folder exists
                        string uploadsDir = Server.MapPath("~/Uploads/");
                        if (!Directory.Exists(uploadsDir))
                        {
                            Directory.CreateDirectory(uploadsDir);
                        }

                        string fileName = Guid.NewGuid() + extension;
                        string path = Path.Combine(uploadsDir, fileName);

                        try
                        {
                            anh.SaveAs(path);
                            sinhVien.Anh = new Anh { duongdan = fileName }; // Lưu trực tiếp đường dẫn vào cột duongdan
                        }
                        catch (Exception ex)
                        {
                            TempData["Error"] = $"Lỗi lưu file ảnh: {ex.Message}";
                            ViewBag.LopList = new SelectList(_context.Lops, "lop_id", "ten_lop", sinhVien.lop_id);
                            return RedirectToAction("TrangChuSinhVien");
                        }
                    }

                    _context.SinhViens.Add(sinhVien);
                    _context.SaveChanges();
                    TempData["Message"] = "Thêm sinh viên thành công!";
                    return RedirectToAction("TrangChuSinhVien");
                }

                TempData["Error"] = "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.";
                ViewBag.LopList = new SelectList(_context.Lops, "lop_id", "ten_lop", sinhVien.lop_id);
                return RedirectToAction("TrangChuSinhVien");
            }
            catch (Exception ex)
            {
                TempData["Error"] = "Lỗi thêm sinh viên: " + ex.Message;
                ViewBag.LopList = new SelectList(_context.Lops, "lop_id", "ten_lop", sinhVien.lop_id);
                return RedirectToAction("TrangChuSinhVien");
            }
        }

        // POST: Check SĐT for duplicates
        [HttpPost]
        public JsonResult CheckSDT(string sdt, int mssv)
        {
            bool exists = _context.SinhViens.Any(sv => sv.SDT == sdt && sv.MSSV != mssv);
            return Json(new { exists });
        }

        // POST: Check Email for duplicates
        [HttpPost]
        public JsonResult CheckEmail(string email, int mssv)
        {
            bool exists = _context.SinhViens.Any(sv => sv.email == email && sv.MSSV != mssv);
            return Json(new { exists });
        }
    }
}