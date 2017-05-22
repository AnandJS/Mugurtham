using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Core.User;
using Mugurtham.Common.Utilities;
using Mugurtham.Service.Controllers;

namespace Mugurtham.Service.Areas.MugurthamAdmin.Controllers.API
{
    [MugurthamBaseAPIController]
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class UserAPIController : ApiController
    {
        [HttpPost]
        public HttpResponseMessage Add([FromBody]UserCoreEntity objUserCoreEntity)
        {
            string strUserID = string.Empty;
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
            UserCore objUserCore = new UserCore(objLoggedIn.ConnectionStringAppKey);
            using (objUserCore as IDisposable)
            {
                objUserCoreEntity.RoleID = Mugurtham.Core.Constants.RoleIDForSangamAdmin;
                objUserCore.Add(ref objUserCoreEntity, out strUserID);
            }
            objUserCore = null;
            return Request.CreateResponse(HttpStatusCode.OK, strUserID, Configuration.Formatters.JsonFormatter);

        }

        [HttpGet]
        [ActionName("Get")]
        public HttpResponseMessage Get(string ID)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
            return Request.CreateResponse(HttpStatusCode.OK, new UserCore(objLoggedIn.ConnectionStringAppKey).GetByID(ID), Configuration.Formatters.JsonFormatter);
        }

        [HttpGet]
        [ActionName("LookupDTO")]
        public HttpResponseMessage GetLookupDTO()
        {
            List<Mugurtham.Core.Sangam.SangamCoreEntity> objSangamCoreEntityList = new List<Core.Sangam.SangamCoreEntity>();
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
            Mugurtham.Core.Sangam.SangamCore objSangamCore = new Core.Sangam.SangamCore(objLoggedIn.ConnectionStringAppKey);
            using (objSangamCore as IDisposable)
                objSangamCore.GetAll(ref objSangamCoreEntityList);
            return Request.CreateResponse(HttpStatusCode.OK, objSangamCoreEntityList, Configuration.Formatters.JsonFormatter);
        }

        [HttpGet]
        [ActionName("GetAll")]
        public HttpResponseMessage GetAll()
        {
            List<UserCoreEntity> objSangamCoreEntityList = new List<UserCoreEntity>();
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
            UserCore objUserCore = new UserCore(objLoggedIn.ConnectionStringAppKey);
            using (objUserCore as IDisposable)
                objUserCore.GetAll(ref objSangamCoreEntityList);
            objUserCore = null;
            return Request.CreateResponse(HttpStatusCode.OK, objSangamCoreEntityList,
              Configuration.Formatters.JsonFormatter);
        }
        [HttpGet]
        [ActionName("GetAllSangamUsers")]
        public HttpResponseMessage GetAllSangamUsers(string ID)
        {
            List<UserCoreEntity> objSangamCoreEntityList = new List<UserCoreEntity>();
            if (!string.IsNullOrWhiteSpace(ID))
            {
                Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
                UserCore objUserCore = new UserCore(objLoggedIn.ConnectionStringAppKey);
                using (objUserCore as IDisposable)
                    objUserCore.GetAllSangamUsers(ref objSangamCoreEntityList, ID);
                objUserCore = null;
            }
            return Request.CreateResponse(HttpStatusCode.OK, objSangamCoreEntityList,
              Configuration.Formatters.JsonFormatter);
        }

        [HttpPut]
        public void Put([FromBody]UserCoreEntity objUserCoreEntity)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
            UserCore objUserCore = new UserCore(objLoggedIn.ConnectionStringAppKey);
                using (objUserCore as IDisposable)
                {
                    objUserCore.Edit(ref objUserCoreEntity);
                }
                objUserCore = null;
        }

    }
}
