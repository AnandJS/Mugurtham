using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Mugurtham.Common.Utilities
{
    public class HandleError : HandleErrorAttribute
    {
        public override void OnException(ExceptionContext filterContext)
        {
            Exception objEx = filterContext.Exception;
            filterContext.ExceptionHandled = true;
            var model = new HandleErrorInfo(filterContext.Exception, "Controller", "Action");

            filterContext.Result = new ViewResult()
            {
                ViewName = "Error1",
                ViewData = new ViewDataDictionary(model)
            };
        }
    }
}
