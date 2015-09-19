using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mugurtham.Service.Controllers;

namespace Mugurtham.Service.Areas.MugurthamAdmin.Controllers.MVC
{
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class RoleController : Controller
    {        
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult List()
        {
            return View();
        }
        public ActionResult Form()
        {
            return View();
        }
    }
}
