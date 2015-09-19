﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Core;
using Mugurtham.Core.BasicInfo;
using Mugurtham.Core.Profile.API;

namespace Mugurtham.Service.Areas.Profile.Controllers.API
{
    public class ProfileAPIController : ApiController
    {

        [HttpGet]
        public HttpResponseMessage Get(string ID)
        {
            return Request.CreateResponse(HttpStatusCode.OK, new BasicInfoCore().GetByProfileID(ID), Configuration.Formatters.JsonFormatter);
        }

    }
}
