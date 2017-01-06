using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Core.BasicInfo;
using Mugurtham.Core.Profile.API;
using Mugurtham.Common.Utilities;
using Mugurtham.Service.Controllers;

namespace Mugurtham.Service.Areas.Search.Controllers.API
{
    [MugurthamBaseAPIController]
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForSangamAdmin,
                                 Mugurtham.Core.Constants.RoleIDForUserProfile,
                                 Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class AllProfilesAPIController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage getByProfileID(string ID)
        {
            ProfileCore objProfCore = null;
            if (!string.IsNullOrWhiteSpace(ID))
            {
                string strLoggedInUserID = string.Empty;
                IEnumerable<string> headerValues = Request.Headers.GetValues("MugurthamUserToken");
                strLoggedInUserID = headerValues.FirstOrDefault();

                Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(strLoggedInUserID);
                using (objLoggedIn as IDisposable)
                {
                    // Destroy this objLoggedIn object 
                    ProfileCore objProfileCore = new ProfileCore();
                    using (objProfileCore as IDisposable)
                        objProfileCore.GetByProfileID(ID, out objProfCore, objLoggedIn);
                    objProfileCore = null;
                }
                objLoggedIn = null;
            }
            return Request.CreateResponse(HttpStatusCode.OK, objProfCore,
              Configuration.Formatters.JsonFormatter);
        }

        /// <summary>
        /// This method is created for sending the errorID to the enduser
        /// </summary>
        public void raiseErrorForSample()
        {
            var resp = new HttpResponseMessage(HttpStatusCode.NotFound)
            {
                Content = new StringContent(string.Format("No product with ID = {0}", "ss")),
                ReasonPhrase = "Product ID Not Found"
            };
            int aa = 0;
            int a = (45 / aa);
            //throw new DivideByZeroException();
            //throw new NotImplementedException("This method is not implemented");
        }
    }
}
