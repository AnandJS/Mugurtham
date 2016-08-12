using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Http;
using System.Net;
using System.Net.Http;
using System.Web.Http.Filters;

namespace Mugurtham.Common.Utilities
{
    public class MugurthamBaseAPIControllerAttribute : ExceptionFilterAttribute
    {
        private static readonly log4net.ILog objLog =
        log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public override void OnException(HttpActionExecutedContext context)
        {
            objLog.Info(context.Exception.StackTrace);
            objLog.Info("========================================================================");

            if (context.Exception is NotImplementedException)
            {
                //context.Response = new  HttpResponseMessage(HttpStatusCode.NotImplemented);
                //write your custom code here            
                //objLog.Info(filterContext.Exception.Data.Values); will get the controller and action method
            }
        }

    }
}
