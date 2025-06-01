using System.Linq;
using System.Web.Mvc;
using QuanLyNgayLaoDong.Models; // Đổi namespace cho phù hợp với DbContext

namespace QuanLyNgayLaoDong.Areas.Admin.Controllers
{
    public class ThongKeController : Controller
    {
        private readonly DB_QLNLD db = new DB_QLNLD(); // Đổi tên DbContext đúng với project

      
        // Giao diện thống kê
        public ActionResult ThongKeIndex()
        {
            return View();
        }

        // API lấy dữ liệu thống kê
        [HttpGet]
        public JsonResult GetThongKe()
        {
            var soSinhVien = db.SinhViens.Count(); 
            var soDotLaoDong = db.TaoDotNgayLaoDongs.Count(); // tên DbSet có thể là DotLaoDonges, đổi nếu khác
            var soTaiKhoan = db.TaiKhoans.Count();
            var taikhoansinhvien = db.TaiKhoans.Count(a => a.role_id == 3 );
            return Json(new
            {
                tongSinhVien = soSinhVien,
                tongDotLaoDong = soDotLaoDong,
                tongTaiKhoan = soTaiKhoan
            }, JsonRequestBehavior.AllowGet);
        }
    }
}
