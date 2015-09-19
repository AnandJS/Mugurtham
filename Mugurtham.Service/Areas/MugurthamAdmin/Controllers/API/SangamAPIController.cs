using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Core.Sangam;

namespace Mugurtham.Service.Areas.MugurthamAdmin.Controllers.API
{
    public class SangamAPIController : ApiController
    {
        [HttpPost]
        public HttpResponseMessage Add([FromBody]SangamCoreEntity objSangamCoreEntity)
        {
            string strSangamID = string.Empty;
            SangamCore objSangamCore = new SangamCore();
            using (objSangamCore as IDisposable)
            {
                objSangamCore.Add(ref objSangamCoreEntity, out strSangamID);
            }
            objSangamCore = null;
            return Request.CreateResponse(HttpStatusCode.OK, strSangamID, Configuration.Formatters.JsonFormatter);

        }

        [HttpGet]
        public HttpResponseMessage Get(string ID)
        {
            return Request.CreateResponse(HttpStatusCode.OK, new SangamCore().GetByID(ID), Configuration.Formatters.JsonFormatter);
        }

        [HttpGet]
        public HttpResponseMessage GetAll()
        {
            List<SangamCoreEntity> objSangamCoreEntityList = new List<SangamCoreEntity>();
            SangamCore objSangamCore = new SangamCore();
            using (objSangamCore as IDisposable)
                objSangamCore.GetAll(ref objSangamCoreEntityList);
            objSangamCore = null;
            return Request.CreateResponse(HttpStatusCode.OK, objSangamCoreEntityList,
              Configuration.Formatters.JsonFormatter);
        }
        [HttpGet]
        [ActionName("GetAllWithoutRestrictions")]
        public HttpResponseMessage GetAllWithoutRestrictions()
        {
            List<SangamCoreEntity> objSangamCoreEntityList = new List<SangamCoreEntity>();
            SangamCore objSangamCore = new SangamCore();
            using (objSangamCore as IDisposable)
                objSangamCore.GetAllWithoutRestrictions(ref objSangamCoreEntityList);
            objSangamCore = null;
            return Request.CreateResponse(HttpStatusCode.OK, objSangamCoreEntityList,
              Configuration.Formatters.JsonFormatter);
        }

        [HttpPut]
        public void Put([FromBody]SangamCoreEntity objSangamCoreEntity)
        {
            SangamCore objSangamCore = new SangamCore();
            using (objSangamCore as IDisposable)
            {
                objSangamCore.Edit(ref objSangamCoreEntity);
            }
            objSangamCore = null;
        }
    }
}
