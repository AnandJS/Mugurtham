using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Mugurtham.Core.BasicInfo;
using Mugurtham.Common.Utilities;
using Mugurtham.Service.Controllers;

namespace Mugurtham.Service.Areas.Profile.Controllers.API
{
    [MugurthamBaseAPIController]
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForSangamAdmin,
                                 Mugurtham.Core.Constants.RoleIDForUserProfile,
                                 Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class BasicInfoAPIController : ApiController
    {
        [HttpPost]
        public void Add([FromBody]BasicInfoCoreEntity objBasicInfoCoreEntity)
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
                Request.Headers.GetValues("CommunityID").FirstOrDefault());
            using (objLoggedIn as IDisposable)
            {
                BasicInfoCore objBasicInfoCore = new BasicInfoCore(ref objLoggedIn);
                using (objBasicInfoCore as IDisposable)
                {
                    string LoggedInUserID = string.Empty;
                    IEnumerable<string> headerValues = Request.Headers.GetValues("MugurthamUserToken");
                    LoggedInUserID = headerValues.FirstOrDefault();
                    objBasicInfoCore.Add(ref objBasicInfoCoreEntity, LoggedInUserID);
                }
                objBasicInfoCore = null;
            }
            objLoggedIn = null;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="ID"></param>
        /// <param name="MugurthamUserToken">Service Request Header Token</param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage Get(string ID, string MugurthamUserToken = null)
        {
            /*//Working snippet for sample
            IEnumerable<string> headerValues = Request.Headers.GetValues("MugurthamUserToken");
            string token = headerValues.FirstOrDefault();
            Helpers.LogMessageInFlatFile(token + "=====MugurthamUserToken");*/
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
            return Request.CreateResponse(HttpStatusCode.OK, new BasicInfoCore(ref objLoggedIn).GetByProfileID(ID, MugurthamUserToken), Configuration.Formatters.JsonFormatter);
        }

        [HttpPut]
        public void Put([FromBody]BasicInfoCoreEntity objBasicInfoCoreEntity)
        {
            string strLoggedInUserID = string.Empty;
            IEnumerable<string> headerValues = Request.Headers.GetValues("MugurthamUserToken");
            strLoggedInUserID = headerValues.FirstOrDefault();

            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(Request.Headers.GetValues("MugurthamUserToken").FirstOrDefault(),
           Request.Headers.GetValues("CommunityID").FirstOrDefault());
            using (objLoggedIn as IDisposable)
            {
                BasicInfoCore objBasicInfoCore = new BasicInfoCore(ref objLoggedIn);
                using (objBasicInfoCore as IDisposable)
                    objBasicInfoCore.Edit(ref objBasicInfoCoreEntity);
                objBasicInfoCore = null;
            }
            objLoggedIn = null;
        }
    }
}
