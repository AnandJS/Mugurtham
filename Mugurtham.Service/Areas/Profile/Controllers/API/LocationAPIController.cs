using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Core.Location;
using Mugurtham.Common.Utilities;
using Mugurtham.Service.Controllers;

namespace Mugurtham.Service.Areas.Profile.Controllers.API
{
    [MugurthamBaseAPIController]
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForSangamAdmin,
                                  Mugurtham.Core.Constants.RoleIDForUserProfile,
                                  Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class LocationAPIController : ApiController
    {
        [HttpPost]
        public void Post([FromBody]LocationCoreEntity objLocationCoreEntity)
        {
            LocationCore objLocationCore = new LocationCore();
            using (objLocationCore as IDisposable)
            {
                objLocationCore.Add(ref objLocationCoreEntity);
            }
            objLocationCore = null;
        }

        [HttpGet]
        public HttpResponseMessage Get(string ID)
        {
            string LoggedInUserID = string.Empty;
            IEnumerable<string> headerValues = Request.Headers.GetValues("MugurthamUserToken");
            LoggedInUserID = headerValues.FirstOrDefault();

            return Request.CreateResponse(HttpStatusCode.OK, new LocationCore().GetByProfileID(ID, LoggedInUserID), Configuration.Formatters.JsonFormatter);
        }

        [HttpPut]
        public void Put([FromBody]LocationCoreEntity objLocationCoreEntity)
        {
            LocationCore objLocationCore = new LocationCore();
            using (objLocationCore as IDisposable)
            {
                objLocationCore.Edit(ref objLocationCoreEntity);
            }
            objLocationCore = null;
        }

    }
}
