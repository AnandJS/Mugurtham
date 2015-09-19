using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Core.Reference;

namespace Mugurtham.Service.Areas.Profile.Controllers.API
{
    public class ReferenceAPIController : ApiController
    {
        [HttpPost]
        public void Post([FromBody]ReferenceCoreEntity objReferenceCoreEntity)
        {
            ReferenceCore objReferenceCore = new ReferenceCore();
            using (objReferenceCore as IDisposable)
            {
                objReferenceCore.Add(ref objReferenceCoreEntity);
            }
            objReferenceCore = null;
        }

        [HttpGet]
        public HttpResponseMessage Get(string ID)
        {
            return Request.CreateResponse(HttpStatusCode.OK, new ReferenceCore().GetByProfileID(ID), Configuration.Formatters.JsonFormatter);
        }

        [HttpPut]
        public void Put([FromBody]ReferenceCoreEntity objReferenceCoreEntity)
        {
            ReferenceCore objReferenceCore = new ReferenceCore();
            using (objReferenceCore as IDisposable)
            {
                objReferenceCore.Edit(ref objReferenceCoreEntity);
            }
            objReferenceCore = null;
        }

    }
}
