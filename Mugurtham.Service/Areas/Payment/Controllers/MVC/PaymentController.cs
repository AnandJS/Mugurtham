using CCA.Util;
using Mugurtham.Common.Utilities;
using Mugurtham.Service.App_Code.Utility;
using Mugurtham.Service.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Mugurtham.Service.Areas.Payment.Controllers.MVC
{
    public class ccavenueresponse
    {
        public string data { get; set; }
        public string encResp { get; set; }
    }

    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForSangamAdmin,
                                Mugurtham.Core.Constants.RoleIDForUserProfile,
                                Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class PaymentController : MugurthamBaseController
    {
        // GET: Payment/Payment
        public ActionResult Index()
        {
            return View();
        }

        // GET: Payment/Invoice
        public ActionResult Invoice()
        {
            return View();
        }

        public ActionResult PaymentRequest()
        {
            return View();
        }
        public ActionResult PaymentSuccess()
        {
            return View();
        }

        public ActionResult PaymentFailure()
        {
            return View();
        }

        public ActionResult Transactions()
        {
            return View();
        }

        public ActionResult Processor()
        {
            return View();
        }

    }
}