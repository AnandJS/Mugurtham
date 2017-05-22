using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Core.Profile.Horoscope;
using Mugurtham.Common.Utilities;
using Mugurtham.Service.Controllers;

namespace Mugurtham.Service.Areas.Profile.Controllers.API
{
    [MugurthamBaseAPIController]
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForSangamAdmin,
                                   Mugurtham.Core.Constants.RoleIDForUserProfile,
                                   Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class HoroscopeAPIController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Get(string ID)
        {
            string LoggedInUserID = string.Empty;
            IEnumerable<string> headerValues = Request.Headers.GetValues("MugurthamUserToken");
            LoggedInUserID = headerValues.FirstOrDefault();
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
            return Request.CreateResponse(HttpStatusCode.OK, new HoroscopeCore(ref objLoggedIn).GetByProfileID(ID, LoggedInUserID), Configuration.Formatters.JsonFormatter);
        }
        [HttpPut]
        public void Put([FromBody]HoroscopeCoreEntity objHoroscopeCoreEntity)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
            using (objLoggedIn as IDisposable)
            {
                HoroscopeCore objHoroscopeCore = new HoroscopeCore(ref objLoggedIn);
                using (objHoroscopeCore as IDisposable)
                    objHoroscopeCore.Edit(ref objHoroscopeCoreEntity);
                objHoroscopeCore = null;
            }
        }
    }
}
