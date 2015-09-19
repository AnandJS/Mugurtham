using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Mugurtham.Service.Controllers
{
    public class MugurthamController : Controller
    {
        //
        // GET: /Mugurtham/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Home()
        {
            return View();
            //return RedirectToAction("Home", "User/User");
        }

        public ActionResult Info()
        {
            return View();
        }
    }
}
