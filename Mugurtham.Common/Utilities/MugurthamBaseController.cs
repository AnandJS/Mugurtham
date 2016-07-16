using System;
using System.Web.Mvc;

namespace Mugurtham.Common.Utilities
{
    public class MugurthamBaseController : Controller, IDisposable
    {
        private static readonly log4net.ILog objLog =
          log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        protected void SetAuthInfo(Guid Id, string Email, string FullName, string Role)
        {
            //AuthUtil.SetAuthInfo(Id, Email, FullName, Role);
        }
        protected override void OnException(ExceptionContext filterContext)
        {
            //write your custom code here            
            //objLog.Info(filterContext.Exception.Data.Values); will get the controller and action method
            objLog.Info(filterContext.Exception.StackTrace);
            objLog.Info("========================================================================");


        }
        protected override void OnAuthorization(AuthorizationContext filterContext)
        {
            //write your custom code here
        }

             
    }
}
