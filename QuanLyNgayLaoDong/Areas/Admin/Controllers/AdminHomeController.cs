using QuanLyNgayLaoDong.Models;
using System;
using System.Linq;
using System.Web.Mvc;
using System.Data.Entity;

namespace QuanLyNgayLaoDong.Areas.Admin.Controllers
{
    [Authorize]
    public class AdminHomeController : Controller
    {
        // GET: Admin/AdminHome
        public ActionResult Index()
        {
            return View();
        }

        /* Khu vực dành cho trang Tài Khoản */
        public ActionResult TrangTaiKhoan()
        {
            using (var db = new DB_QLNLD())
            {
                var list = db.TaiKhoans
                             .Where(t => t.deleted_at == null)
                             .Include(t => t.VaiTro)
                             .ToList();
                ViewBag.TaiKhoanEdit = TempData["TaiKhoanEdit"];
                ViewBag.TaiKhoanDetail = TempData["TaiKhoanDetail"];
                return View(list);
            }
        }

        // Thêm tài khoản 
        [HttpPost]
        public ActionResult AddTaiKhoan(TaiKhoan tk)
        {
            using (var db = new DB_QLNLD())
            {
                // Kiểm tra email trùng lặp
                var existingEmail = db.TaiKhoans
                    .FirstOrDefault(t => t.email == tk.email && t.deleted_at == null);
                if (existingEmail != null)
                {
                    TempData["Error"] = "Email đã tồn tại. Vui lòng sử dụng email khác.";
                    return RedirectToAction("TrangTaiKhoan");
                }

                if (ModelState.IsValid)
                {
                    // Đặt mật khẩu mặc định nếu không có
                    if (string.IsNullOrEmpty(tk.password))
                    {
                        tk.password = "abc@123"; // Gợi ý mã hóa mật khẩu
                    }

                    db.TaiKhoans.Add(tk);
                    db.SaveChanges();

                    TempData["Message"] = "Thêm tài khoản thành công!";
                    return RedirectToAction("TrangTaiKhoan");
                }

                TempData["Error"] = "Dữ liệu không hợp lệ. Không thể thêm tài khoản.";
                return RedirectToAction("TrangTaiKhoan");
            }
        }

        // Xóa tài khoản (soft delete)
        public ActionResult Delete(int id)
        {
            using (var db = new DB_QLNLD())
            {
                var taiKhoan = db.TaiKhoans.Find(id);
                if (taiKhoan != null)
                {
                    taiKhoan.deleted_at = DateTime.Now;
                    db.SaveChanges();

                    TempData["Message"] = "Xóa tài khoản thành công!";
                }
                else
                {
                    TempData["Error"] = "Không tìm thấy tài khoản cần xóa.";
                }
            }
            return RedirectToAction("TrangTaiKhoan");
        }

        // Xem chi tiết tài khoản
        public ActionResult Details(int id)
        {
            using (var db = new DB_QLNLD())
            {
                var taiKhoan = db.TaiKhoans
                    .Include(t => t.VaiTro)
                    .FirstOrDefault(t => t.taikhoan_id == id && t.deleted_at == null);

                if (taiKhoan == null)
                {
                    TempData["Error"] = "Không tìm thấy tài khoản.";
                    return RedirectToAction("TrangTaiKhoan");
                }

                TempData["TaiKhoanDetail"] = taiKhoan;
                return RedirectToAction("TrangTaiKhoan");
            }
        }

        // Sửa tài khoản (GET)
        public ActionResult Edit(int id)
        {
            using (var db = new DB_QLNLD())
            {
                var taiKhoan = db.TaiKhoans
                    .Include(t => t.VaiTro)
                    .FirstOrDefault(t => t.taikhoan_id == id && t.deleted_at == null);

                if (taiKhoan == null)
                {
                    TempData["Error"] = "Không tìm thấy tài khoản để sửa.";
                    return RedirectToAction("TrangTaiKhoan");
                }

                TempData["TaiKhoanEdit"] = taiKhoan;
                return RedirectToAction("TrangTaiKhoan");
            }
        }

        // Sửa tài khoản (POST)
        [HttpPost]
        public ActionResult EditTaiKhoan(TaiKhoan tk)
        {
            if (ModelState.IsValid)
            {
                using (var db = new DB_QLNLD())
                {
                    // Kiểm tra email trùng lặp
                    var existingEmail = db.TaiKhoans
                        .FirstOrDefault(t => t.email == tk.email && t.taikhoan_id != tk.taikhoan_id && t.deleted_at == null);
                    if (existingEmail != null)
                    {
                        TempData["Error"] = "Email đã tồn tại. Vui lòng sử dụng email khác.";
                        return RedirectToAction("TrangTaiKhoan");
                    }

                    var existingTaiKhoan = db.TaiKhoans.Find(tk.taikhoan_id);
                    if (existingTaiKhoan != null && existingTaiKhoan.deleted_at == null)
                    {
                        existingTaiKhoan.username = tk.username;

                        if (!string.IsNullOrEmpty(tk.password))
                        {
                            existingTaiKhoan.password = tk.password;
                        }

                        existingTaiKhoan.email = tk.email;
                        existingTaiKhoan.role_id = tk.role_id;

                        db.SaveChanges();

                        TempData["Message"] = "Cập nhật tài khoản thành công!";
                    }
                    else
                    {
                        TempData["Error"] = "Không tìm thấy tài khoản để cập nhật.";
                    }
                }
            }
            else
            {
                TempData["Error"] = "Dữ liệu không hợp lệ. Không thể cập nhật.";
            }

            return RedirectToAction("TrangTaiKhoan");
        }

        // Đặt lại mật khẩu
        [HttpPost]
        public ActionResult ResetPassword(int id)
        {
            using (var db = new DB_QLNLD())
            {
                var taiKhoan = db.TaiKhoans
                                 .FirstOrDefault(t => t.taikhoan_id == id && t.deleted_at == null);

                if (taiKhoan == null)
                {
                    TempData["Error"] = "Không tìm thấy tài khoản để đặt lại mật khẩu.";
                    return RedirectToAction("TrangTaiKhoan");
                }

                taiKhoan.password = "abc@123"; // Nên mã hóa mật khẩu
                db.SaveChanges();

                TempData["Message"] = "Đặt lại mật khẩu thành công!";
            }

            return RedirectToAction("TrangTaiKhoan");
        }

        // Hiển thị danh sách đợt lao động
        public ActionResult TrangTaoDotLaoDong()
        {
            using (var db = new DB_QLNLD())
            {
                // Lấy danh sách đợt lao động kèm thông tin tài khoản liên quan
                var list = db.TaoDotNgayLaoDongs
                             .Include(t => t.TaiKhoan)
                             .Where(t => t.Ngayxoa == null) // Chỉ lấy các bản ghi chưa bị xóa
                             .ToList();
                return View(list);
            }
        }

        // Tạo mới đợt lao động
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult TaoMoiDotLaoDong(TaoDotNgayLaoDong model)
        {
            if (ModelState.IsValid)
            {
                // Kiểm tra năm của NgayLaoDong
                if (model.NgayLaoDong.HasValue && model.NgayLaoDong.Value.Year < DateTime.Now.Year)
                {
                    ModelState.AddModelError("NgayLaoDong", $"Năm không được nhỏ hơn {DateTime.Now.Year}.");
                }
                // Kiểm tra số lượng sinh viên
                if (model.SoLuongSinhVien < 0)
                {
                    ModelState.AddModelError("SoLuongSinhVien", "Số lượng sinh viên không được âm.");
                }

                if (ModelState.IsValid)
                {
                    try
                    {
                        using (var db = new DB_QLNLD())
                        {
                            // Lấy thông tin người dùng đã đăng nhập
                            if (User.Identity.IsAuthenticated)
                            {
                                string username = User.Identity.Name;
                                var taiKhoan = db.TaiKhoans.FirstOrDefault(t => t.username == username);
                                if (taiKhoan != null)
                                {
                                    model.NguoiTao = taiKhoan.taikhoan_id;
                                }
                                else
                                {
                                    System.Diagnostics.Debug.WriteLine($"Không tìm thấy tài khoản cho username: {username}");
                                    ModelState.AddModelError("", "Không tìm thấy thông tin tài khoản người dùng.");
                                }
                            }
                            else
                            {
                                System.Diagnostics.Debug.WriteLine("Người dùng chưa đăng nhập");
                                ModelState.AddModelError("", "Vui lòng đăng nhập để thực hiện thao tác này.");
                            }

                            if (ModelState.IsValid)
                            {
                                model.NgayTao = DateTime.Now;
                                model.NgayCapNhat = DateTime.Now;

                                db.TaoDotNgayLaoDongs.Add(model);
                                db.SaveChanges();
                                TempData["SuccessMessage"] = "Thêm đợt lao động thành công!";
                                return RedirectToAction("TrangTaoDotLaoDong");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        var innerException = ex.InnerException?.Message ?? ex.Message;
                        System.Diagnostics.Debug.WriteLine($"Lỗi khi lưu dữ liệu: {ex.Message}");
                        System.Diagnostics.Debug.WriteLine($"Inner Exception: {innerException}");
                        ModelState.AddModelError("", $"Lỗi khi lưu dữ liệu: {innerException}");
                    }
                }
            }

            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            System.Diagnostics.Debug.WriteLine("Lỗi ModelState: " + string.Join(", ", errors));

            using (var db = new DB_QLNLD())
            {
                var list = db.TaoDotNgayLaoDongs
                             .Include(t => t.TaiKhoan)
                             .Where(t => t.Ngayxoa == null)
                             .ToList();
                ViewBag.TaiKhoans = db.TaiKhoans.ToList();
                ViewBag.Errors = errors;
                return View("TrangTaoDotLaoDong", list);
            }
        }

        // Sửa đợt lao động
        [HttpGet]
        public ActionResult ChinhSuaDotLaoDong(int id)
        {
            using (var db = new DB_QLNLD())
            {
                var dotLaoDong = db.TaoDotNgayLaoDongs.Find(id);
                if (dotLaoDong == null || dotLaoDong.Ngayxoa != null)
                {
                    System.Diagnostics.Debug.WriteLine($"Không tìm thấy đợt lao động với ID: {id}");
                    return HttpNotFound();
                }

                // Log dữ liệu trả về để kiểm tra
                System.Diagnostics.Debug.WriteLine($"Dữ liệu trả về cho ID {id}: " +
                    $"DotLaoDong={dotLaoDong.DotLaoDong}, " +
                    $"NgayLaoDong={dotLaoDong.NgayLaoDong?.ToString("yyyy-MM-dd")}, " +
                    $"KhuVuc={dotLaoDong.KhuVuc}, " +
                    $"Buoi={dotLaoDong.Buoi}, " +
                    $"LoaiLaoDong={dotLaoDong.LoaiLaoDong}, " +
                    $"GiaTri={dotLaoDong.GiaTri}, " +
                    $"MoTa={dotLaoDong.MoTa}, " +
                    $"ThoiGian={dotLaoDong.ThoiGian}, " +
                    $"SoLuongSinhVien={dotLaoDong.SoLuongSinhVien}");

                // Trả về JSON cho AJAX
                return Json(new
                {
                    ID = dotLaoDong.ID,
                    DotLaoDong = dotLaoDong.DotLaoDong,
                    NgayLaoDong = dotLaoDong.NgayLaoDong?.ToString("yyyy-MM-dd"),
                    Buoi = dotLaoDong.Buoi,
                    LoaiLaoDong = dotLaoDong.LoaiLaoDong,
                    GiaTri = dotLaoDong.GiaTri,
                    ThoiGian = dotLaoDong.ThoiGian,
                    MoTa = dotLaoDong.MoTa,
                    KhuVuc = dotLaoDong.KhuVuc,
                    SoLuongSinhVien = dotLaoDong.SoLuongSinhVien
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ChinhSuaDotLaoDong(TaoDotNgayLaoDong model)
        {
            if (ModelState.IsValid)
            {
                // Kiểm tra năm của NgayLaoDong
                if (model.NgayLaoDong.HasValue && model.NgayLaoDong.Value.Year < DateTime.Now.Year)
                {
                    ModelState.AddModelError("NgayLaoDong", $"Năm không được nhỏ hơn {DateTime.Now.Year}.");
                }
                // Kiểm tra số lượng sinh viên
                if (model.SoLuongSinhVien < 0)
                {
                    ModelState.AddModelError("SoLuongSinhVien", "Số lượng sinh viên không được âm.");
                }

                if (ModelState.IsValid)
                {
                    try
                    {
                        using (var db = new DB_QLNLD())
                        {
                            var dotLaoDong = db.TaoDotNgayLaoDongs.Find(model.ID);
                            if (dotLaoDong == null || dotLaoDong.Ngayxoa != null)
                            {
                                System.Diagnostics.Debug.WriteLine($"Không tìm thấy đợt lao động với ID: {model.ID}");
                                return HttpNotFound();
                            }

                            // Cập nhật thông tin
                            dotLaoDong.DotLaoDong = model.DotLaoDong;
                            dotLaoDong.NgayLaoDong = model.NgayLaoDong;
                            dotLaoDong.Buoi = model.Buoi;
                            dotLaoDong.LoaiLaoDong = model.LoaiLaoDong;
                            dotLaoDong.GiaTri = model.GiaTri;
                            dotLaoDong.ThoiGian = model.ThoiGian;
                            dotLaoDong.KhuVuc = model.KhuVuc;
                            dotLaoDong.MoTa = model.MoTa;
                            dotLaoDong.SoLuongSinhVien = model.SoLuongSinhVien;
                            dotLaoDong.NgayCapNhat = DateTime.Now;

                            db.SaveChanges();

                            TempData["SuccessMessage"] = "Cập nhật đợt lao động thành công!";
                            return RedirectToAction("TrangTaoDotLaoDong");
                        }
                    }
                    catch (Exception ex)
                    {
                        var innerException = ex.InnerException?.Message ?? ex.Message;
                        System.Diagnostics.Debug.WriteLine($"Lỗi khi cập nhật dữ liệu: {ex.Message}");
                        System.Diagnostics.Debug.WriteLine($"Inner Exception: {innerException}");
                        ModelState.AddModelError("", $"Lỗi khi cập nhật dữ liệu: {innerException}");
                    }
                }
            }

            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            System.Diagnostics.Debug.WriteLine("Lỗi ModelState: " + string.Join(", ", errors));
            ViewBag.Errors = errors;

            using (var db = new DB_QLNLD())
            {
                var list = db.TaoDotNgayLaoDongs
                             .Include(t => t.TaiKhoan)
                             .Where(t => t.Ngayxoa == null)
                             .ToList();
                ViewBag.TaiKhoans = db.TaiKhoans.ToList();
                return View("TrangTaoDotLaoDong", list);
            }
        }

        // Xem chi tiết đợt lao động
        [HttpGet]
        public ActionResult ChiTietDotLaoDong(int id)
        {
            using (var db = new DB_QLNLD())
            {
                var dotLaoDong = db.TaoDotNgayLaoDongs.Find(id);
                if (dotLaoDong == null || dotLaoDong.Ngayxoa != null)
                {
                    System.Diagnostics.Debug.WriteLine($"Không tìm thấy đợt lao động với ID: {id}");
                    return HttpNotFound();
                }

                return Json(new
                {
                    ID = dotLaoDong.ID,
                    DotLaoDong = dotLaoDong.DotLaoDong,
                    NgayLaoDong = dotLaoDong.NgayLaoDong?.ToString("dd-MM-yyyy"),
                    KhuVuc = dotLaoDong.KhuVuc,
                    Buoi = dotLaoDong.Buoi,
                    LoaiLaoDong = dotLaoDong.LoaiLaoDong,
                    GiaTri = dotLaoDong.GiaTri,
                    MoTa = dotLaoDong.MoTa,
                    ThoiGian = dotLaoDong.ThoiGian,
                    SoLuongSinhVien = dotLaoDong.SoLuongSinhVien
                }, JsonRequestBehavior.AllowGet);
            }
        }

        // Xóa đợt lao động (Soft Delete)
        [HttpPost]
        public ActionResult XoaDotLaoDong(int id)
        {
            try
            {
                using (var db = new DB_QLNLD())
                {
                    var dotLaoDong = db.TaoDotNgayLaoDongs.Find(id);
                    if (dotLaoDong == null || dotLaoDong.Ngayxoa != null)
                    {
                        System.Diagnostics.Debug.WriteLine($"Không tìm thấy đợt lao động với ID: {id}");
                        return Json(new { success = false, message = "Không tìm thấy đợt lao động." });
                    }

                    // Kiểm tra quyền truy cập
                    if (User.Identity.IsAuthenticated)
                    {
                        string username = User.Identity.Name;
                        var taiKhoan = db.TaiKhoans.FirstOrDefault(t => t.username == username);
                        if (taiKhoan == null || dotLaoDong.NguoiTao != taiKhoan.taikhoan_id)
                        {
                            System.Diagnostics.Debug.WriteLine($"Người dùng {username} không có quyền xóa đợt lao động ID: {id}");
                            return Json(new { success = false, message = "Bạn không có quyền xóa đợt lao động này." });
                        }
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine("Người dùng chưa đăng nhập");
                        return Json(new { success = false, message = "Vui lòng đăng nhập để thực hiện thao tác này." });
                    }

                    // Soft delete bằng cách cập nhật Ngayxoa
                    dotLaoDong.Ngayxoa = DateTime.Now;
                    db.SaveChanges();

                    return Json(new { success = true, message = "Xóa đợt lao động thành công!" });
                }
            }
            catch (Exception ex)
            {
                var innerException = ex.InnerException?.Message ?? ex.Message;
                System.Diagnostics.Debug.WriteLine($"Lỗi khi xóa đợt lao động: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Inner Exception: {innerException}");
                return Json(new { success = false, message = $"Lỗi khi xóa: {innerException}" });
            }
        }
    }
}