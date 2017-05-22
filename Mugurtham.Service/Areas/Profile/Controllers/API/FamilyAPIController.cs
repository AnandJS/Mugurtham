using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Core.Family;
using Mugurtham.Common.Utilities;
using Mugurtham.Service.Controllers;

namespace Mugurtham.Service.Areas.Profile.Controllers.API
{
    [MugurthamBaseAPIController]
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForSangamAdmin,
                                  Mugurtham.Core.Constants.RoleIDForUserProfile,
                                  Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class FamilyAPIController : ApiController
    {
        [HttpPost]
        public void Post([FromBody]FamilyCoreEntity objFamilyCoreEntity)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
            using (objLoggedIn as IDisposable)
            {
                FamilyCore objFamilyCore = new FamilyCore(ref objLoggedIn);
                using (objFamilyCore as IDisposable)
                {
                    objFamilyCore.Add(ref objFamilyCoreEntity);
                }
                objFamilyCore = null;
            }
        }

        [HttpPut]
        public void Put([FromBody]FamilyCoreEntity objFamilyCoreEntity)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
            using (objLoggedIn as IDisposable)
            {
                FamilyCore objFamilyCore = new FamilyCore(ref objLoggedIn);
                using (objFamilyCore as IDisposable)
                {
                    objFamilyCore.Edit(ref objFamilyCoreEntity);
                }
                objFamilyCore = null;
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
            return Request.CreateResponse(HttpStatusCode.OK, new FamilyCore(ref objLoggedIn).GetByProfileID(ID, LoggedInUserID), Configuration.Formatters.JsonFormatter);
        }
    }
}
