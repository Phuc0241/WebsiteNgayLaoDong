using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuanLyNgayLaoDong.Areas.QuanLy.Controllers
{
    public class QuanLyHomeController : Controller
    {
        // GET: QuanLy/QuanLyHome
        public ActionResult Index()
        {
            return View();
        }
    }
}