using Mugurtham.Core.Profile.API;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Common.Utilities;
using Mugurtham.Service.Controllers;

namespace Mugurtham.Service.Areas.View.Controllers.API
{
    [MugurthamBaseAPIController]
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForSangamAdmin,
                                   Mugurtham.Core.Constants.RoleIDForUserProfile,
                                   Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class ProfileViewAPIController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage getProfileByProfileID(string ID)
        {
            ProfileCore objProfileCoreForView = null;
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
               Request.Headers.GetValues("CommunityID").FirstOrDefault());
            using (objLoggedIn as IDisposable)
            {
                ProfileCore objProfileCore = new ProfileCore(ref objLoggedIn);
                using (objProfileCore as IDisposable)
                {
                    objProfileCore.GetByProfileID(ID, out objProfileCoreForView, objLoggedIn);
                }
                objProfileCore = null;
            }
            objLoggedIn = null;
            return Request.CreateResponse(HttpStatusCode.OK, objProfileCoreForView,
              Configuration.Formatters.JsonFormatter);
        }
    }
}
