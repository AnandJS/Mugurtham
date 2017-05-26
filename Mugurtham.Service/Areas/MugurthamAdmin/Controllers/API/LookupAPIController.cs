using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Common.Utilities;
using Mugurtham.Service.Controllers;

namespace Mugurtham.Service.Controllers
{
    [MugurthamBaseAPIController]
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class LookupAPIController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Get()
        {
            Mugurtham.Core.Lookup.LookupEntity objLookupEntity = new Core.Lookup.LookupEntity();
            try
            {
                Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
                    Request.Headers.GetValues("CommunityID").FirstOrDefault());
                using (objLoggedIn as IDisposable)
                {
                    Mugurtham.Core.Lookup.LookupCore objLookupCore = new Core.Lookup.LookupCore(ref objLoggedIn);
                    using (objLookupCore as IDisposable)
                        objLookupCore.getLookup(ref objLookupEntity);
                    objLookupCore = null;
                }
            }
            catch(Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return Request.CreateResponse(HttpStatusCode.OK, objLookupEntity, Configuration.Formatters.JsonFormatter);
        }
    }
}
