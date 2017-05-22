using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Core.Reference;
using Mugurtham.Common.Utilities;
using Mugurtham.Service.Controllers;

namespace Mugurtham.Service.Areas.Profile.Controllers.API
{
    [MugurthamBaseAPIController]
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForSangamAdmin,
                                  Mugurtham.Core.Constants.RoleIDForUserProfile,
                                  Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class ReferenceAPIController : ApiController
    {
        [HttpPost]
        public void Post([FromBody]ReferenceCoreEntity objReferenceCoreEntity)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
                Request.Headers.GetValues("CommunityID").FirstOrDefault());
            using (objLoggedIn as IDisposable)
            {
                ReferenceCore objReferenceCore = new ReferenceCore(ref objLoggedIn);
                using (objReferenceCore as IDisposable)
                {
                    objReferenceCore.Add(ref objReferenceCoreEntity);
                }
                objReferenceCore = null;
            }
        }

        [HttpGet]
        public HttpResponseMessage Get(string ID)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
                Request.Headers.GetValues("CommunityID").FirstOrDefault());
            string LoggedInUserID = string.Empty;
            IEnumerable<string> headerValues = Request.Headers.GetValues("MugurthamUserToken");
            LoggedInUserID = headerValues.FirstOrDefault();
            return Request.CreateResponse(HttpStatusCode.OK, new ReferenceCore(ref objLoggedIn).GetByProfileID(ID, LoggedInUserID), Configuration.Formatters.JsonFormatter);
        }

        [HttpPut]
        public void Put([FromBody]ReferenceCoreEntity objReferenceCoreEntity)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
                Request.Headers.GetValues("CommunityID").FirstOrDefault());
            using (objLoggedIn as IDisposable)
            {
                ReferenceCore objReferenceCore = new ReferenceCore(ref objLoggedIn);
                using (objReferenceCore as IDisposable)
                {
                    objReferenceCore.Edit(ref objReferenceCoreEntity);
                }
                objReferenceCore = null;
            }
        }

    }
}
