﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Mugurtham.Service.Controllers
{
    public class LookupAPIController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Get()
        {
            Mugurtham.Core.Lookup.LookupEntity objLookupEntity = new Core.Lookup.LookupEntity();
            Mugurtham.Core.Lookup.LookupCore objLookupCore = new Core.Lookup.LookupCore();
            using (objLookupCore as IDisposable)
                objLookupCore.getLookup(ref objLookupEntity);
            objLookupCore = null;
            return Request.CreateResponse(HttpStatusCode.OK, objLookupEntity, Configuration.Formatters.JsonFormatter);
        }
    }
}
