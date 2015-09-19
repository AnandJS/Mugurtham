using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Mugurtham.Common.Utilities
{
    public class MugurthamBaseController : Controller
    {
        protected void SetAuthInfo(Guid Id, string Email, string FullName, string Role)
        {
            //AuthUtil.SetAuthInfo(Id, Email, FullName, Role);
        }
        protected override void OnException(ExceptionContext filterContext)
        {
            //write your custom code here
        }
        protected override void OnAuthorization(AuthorizationContext filterContext)
        {
            //write your custom code here
        }
    }
}
