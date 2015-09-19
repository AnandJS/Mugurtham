using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Core.BasicInfo;
using Mugurtham.Core.Profile.API;

namespace Mugurtham.Service.Areas.Search.Controllers.API
{
    public class AllProfilesAPIController : ApiController
    {
        public HttpResponseMessage getByProfileID(string ID)
        {
            ProfileCore objProfCore = null;
            if (!string.IsNullOrWhiteSpace(ID))
            {
                ProfileCore objProfileCore = new ProfileCore();
                using (objProfileCore as IDisposable)
                    objProfileCore.GetByProfileID(ID, out objProfCore);
                objProfileCore = null;
            }
            return Request.CreateResponse(HttpStatusCode.OK, objProfCore,
              Configuration.Formatters.JsonFormatter);
        }
    }
}
