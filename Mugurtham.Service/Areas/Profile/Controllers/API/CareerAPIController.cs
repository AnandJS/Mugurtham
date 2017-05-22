using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Core.Career;
using Mugurtham.Common.Utilities;
using Mugurtham.Service.Controllers;

namespace Mugurtham.Service.Areas.Profile.Controllers.API
{
    [MugurthamBaseAPIController]
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForSangamAdmin,
                                 Mugurtham.Core.Constants.RoleIDForUserProfile,
                                 Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class CareerAPIController : ApiController
    {
        [HttpPost]
        public void Post([FromBody]CareerCoreEntity objCareerCoreEntity)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
            using (objLoggedIn as IDisposable)
            {
                CareerCore objCareerCore = new CareerCore(ref objLoggedIn);
                using (objCareerCore as IDisposable)
                {
                    objCareerCore.Add(ref objCareerCoreEntity);
                }
                objCareerCore = null;
            }
        }

        [HttpGet]
        public HttpResponseMessage Get(string ID)
        {
            string LoggedInUserID = string.Empty;
            IEnumerable<string> headerValues = Request.Headers.GetValues("MugurthamUserToken");
            LoggedInUserID = headerValues.FirstOrDefault();
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
            return Request.CreateResponse(HttpStatusCode.OK, new CareerCore(ref objLoggedIn).GetByProfileID(ID, LoggedInUserID), Configuration.Formatters.JsonFormatter);
        }

        [HttpPut]
        public void Put([FromBody]CareerCoreEntity objCareerCoreEntity)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
            using (objLoggedIn as IDisposable)
            {
                CareerCore objCareerCore = new CareerCore(ref objLoggedIn);
                using (objCareerCore as IDisposable)
                {
                    objCareerCore.Edit(ref objCareerCoreEntity);
                }
                objCareerCore = null;
            }
        }
    }
}
