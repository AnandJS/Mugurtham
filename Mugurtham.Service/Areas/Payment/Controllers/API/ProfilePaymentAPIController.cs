using Mugurtham.Common.Utilities;
using Mugurtham.Service.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Mugurtham.Service.Areas.Payment.Controllers.API
{
    [MugurthamBaseAPIController]
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForSangamAdmin,
                                 Mugurtham.Core.Constants.RoleIDForUserProfile,
                                 Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class ProfilePaymentAPIController : ApiController
    {
        [HttpGet]
        [ActionName("GetAllPaymentTransactions")]
        public HttpResponseMessage GetAllPaymentTransactions()
        {
            List<Core.Payment.PaymentProfileTransactions.PaymentProfileTransactionsCoreEntity> objPaymentProfileTransactionsCoreEntityList = new List<Core.Payment.PaymentProfileTransactions.PaymentProfileTransactionsCoreEntity>();
            string strLoggedInUserID = string.Empty;
            IEnumerable<string> headerValues = Request.Headers.GetValues("MugurthamUserToken");
            strLoggedInUserID = headerValues.FirstOrDefault();

            Mugurtham.Core.Login.LoggedInUser objLoggedIn = new Core.Login.LoggedInUser(strLoggedInUserID,
                Request.Headers.GetValues("CommunityID").FirstOrDefault());
            using (objLoggedIn as IDisposable)
            {
                Core.Payment.PaymentProfileTransactions.PaymentProfileTransactionsCore objPaymentProfileTransactionsCore = new Core.Payment.PaymentProfileTransactions.PaymentProfileTransactionsCore(objLoggedIn);
                using (objPaymentProfileTransactionsCore as IDisposable)
                    objPaymentProfileTransactionsCore.GetAllPaymentTransactions(ref objPaymentProfileTransactionsCoreEntityList);
                objPaymentProfileTransactionsCore = null;
            }
            objLoggedIn = null;

            return Request.CreateResponse(HttpStatusCode.OK, objPaymentProfileTransactionsCoreEntityList,
                  Configuration.Formatters.JsonFormatter);
        }
    }
}