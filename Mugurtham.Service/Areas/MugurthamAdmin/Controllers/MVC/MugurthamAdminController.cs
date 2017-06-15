using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mugurtham.Service.Controllers;
using Mugurtham.Common.Utilities;

namespace Mugurtham.Service.Areas.MugurthamAdmin.Controllers.MVC
{
    [MugurthamAuthorizeAttribute(Mugurtham.Core.Constants.RoleIDForMugurthamAdmin)]
    public class MugurthamAdminController : MugurthamBaseController
    {
        public ActionResult Index()
        {
           
            return View();
        }
        public ActionResult Dashboard()
        {
            Mugurtham.Core.Login.LoggedInUser objLoggedIn = (Mugurtham.Core.Login.LoggedInUser)Session["LoggedInUser"];
            string EncryptedString = "99052f9e744208478eedf2f57998ec4692101b060b486a49c0e972a2610ab2326193c5046ef571effee84a47365bb5238ac0dbd8473ce8e7263bafc519a51a23ac69521e800f203e38b7fcb840260a50e85ed08f37e7ad633cfcce91bae3b010213e9158767cbaf0942b5a4a1c399762b02a8929e9241e04c97d831208eaa6d54731ab7545046b9abbe68e27acad1599fc418a727ecaf1e07ab8030cbde338056516323235881f97088959e878991a62ab3be7289190610e60a909386556e8c0c4561125907f9c203e64896763c5ca5583083e5913b30e359c91b1b8cca55d3a66a147c00a3b61d21b23f54db4e4975943585b3d92038d1a1b7c611efb1c2282c0068e46233a4470dce75d8dbc5687420ff90d032f4a8a02f640f5d41e57eabb7a590177490494cf34cad54a3a0a11ab7a1567b6a9392dc563f9b6bddb3765fb8a2d38dbda2ce54153e2678cf583e5d515ee94bd05bc77440faa81f66414f042ed6ffc0a66f3594fb802ea9a5acf700be57f16b6011cfa1b7187839a60d42bbbec561bcdb620866618b913c23287868ad9acbed1de8024fae9433094ed9a82fb3a011f501ec035bf056486121f121cfb12f32e753e121783337ecd979180ce56df8d780685d72f5c916d8c80aea6c5c3dc8a8431aa15ff444b0d366aac32c8979d8e1cee08bbc2f5f5f4a44bf19eeec3e871b1600f44f69a88f1c34ea86b5e5146b63a568dfa16075cc8b939e50e25bc2d05aa776302ee983aa47844c5a4072d829f3ecc235484928ed83c74d4c6a66ee40b7b05fe637fb559db22ba05873665d7d1de80d5c0836e94755872024172a5a6d8cfb62dd64fef7c1992b8b3caf6ccb224524d4716d7fa958aba735d7e49f7291bbb6517a61b8d1e1c42e97ae0d3251d0b2fab5499d2b3270db95e6912e00e2e93d12532f481904c929be27143b5743fb63fdba53939e2c20dd97a4ebe6ce11162221407ccf3bb939d96c8bcd3c456a40eb5b0c611bcd337ddb58eb5467eff59277cde38e97888cb42606fa87f1b909d3c5e833027f07f4a0487da000b8124aaf6431d28d452934dd9a2c22f04f89bc264e846ef73d53b3fe4d82a2740c0651f93e0cc55cdc9b8d3457c4d0f067c3e602b9d31c47bac961ec3ed5f9eaf91f7146920c480a16376684c86e8cff4df16157173982c7286e34f2241540d1e73d1006ad8675ca35e1bdd4310f614a795a1";
            Mugurtham.Core.Payment.PaymentGatewayTransactions.PaymentGatewayTransactionsCore objPaymentGatewayTransactionsCore = new Core.Payment.PaymentGatewayTransactions.PaymentGatewayTransactionsCore(objLoggedIn);
            using (objPaymentGatewayTransactionsCore as IDisposable)
            {
                objPaymentGatewayTransactionsCore.Add(EncryptedString);
            }
            objPaymentGatewayTransactionsCore = null;
            return View();
        }
        public ActionResult Profiles()
        {
            return View();
        }
    }
}
