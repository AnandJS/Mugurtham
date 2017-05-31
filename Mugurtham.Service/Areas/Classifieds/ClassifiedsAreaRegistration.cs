using System.Web.Mvc;

namespace Mugurtham.Service.Areas.Classifieds
{
    public class ClassifiedsAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Classifieds";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "Classifieds_default",
                "Classifieds/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}