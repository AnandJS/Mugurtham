using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Mugurtham.Service.Areas.Classifieds.Controllers
{
    public class CategoryController : Controller
    {
        // GET: Classifieds/Category
        public ActionResult Index()
        {
            return View();
        }
    }
}