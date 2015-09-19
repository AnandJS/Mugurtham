using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Core.Contact;

namespace Mugurtham.Service.Areas.Profile.Controllers.API
{
    public class ContactAPIController : ApiController
    {
        [HttpPost]
        public void Post([FromBody]ContactCoreEntity objContactCoreEntity)
        {
            ContactCore objContactCore = new ContactCore();
            using (objContactCore as IDisposable)
            {
                objContactCore.Add(ref objContactCoreEntity);
            }
            objContactCore = null;
        }

        [HttpPut]
        public void Put([FromBody]ContactCoreEntity objContactCoreEntity)
        {
            ContactCore objContactCore = new ContactCore();
            using (objContactCore as IDisposable)
            {
                objContactCore.Edit(ref objContactCoreEntity);
            }
            objContactCore = null;
        }

        [HttpGet]
        public HttpResponseMessage Get(string ID)
        {
            return Request.CreateResponse(HttpStatusCode.OK, new ContactCore().GetByProfileID(ID), Configuration.Formatters.JsonFormatter);
        }

    }
}
