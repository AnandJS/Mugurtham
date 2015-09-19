using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mugurtham.Service.Controllers;

namespace Mugurtham.Service.Areas.MugurthamAdmin.Controllers.MVC
{
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class MugurthamAdminController : Controller
    {
        public ActionResult Index()
        {
            
            return View();
        }
        public ActionResult Dashboard()
        {
            return View();
        }
        public ActionResult Profiles()
        {
            return View();
        }
    }
}
