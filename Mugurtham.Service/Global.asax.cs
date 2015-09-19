using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace Mugurtham.Service
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            //This is the [Authourize] attribute set in global level for Mugurtham
            GlobalFilters.Filters.Add(new System.Web.Mvc.AuthorizeAttribute());
            //Error Handling
            //RegisterGlobalFilters(GlobalFilters.Filters);
            
            AreaRegistration.RegisterAllAreas();
            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        /*public static void RegisterGlobalFilters(GlobalFilterCollection objFilters)
        {
            // Default Handler
            objFilters.Add(new HandleErrorAttribute());

            //SQL Exception Handler
            objFilters.Add(new HandleErrorAttribute
            {
                ExceptionType = typeof(SqlException),
                View = "",
                Order = 1
            }
            );


        }*/
    }
}