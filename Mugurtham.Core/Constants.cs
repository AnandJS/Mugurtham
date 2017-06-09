using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mugurtham.Core
{
    public class Constants
    {
        // ROLEMASTER DATABASE TABLE CONSTANTS
        public const string RoleIDForUserProfile = "F62DDFBE55448E3A3";
        public const string RoleIDForSangamAdmin = "6F12E0055B6450BB3";
        public const string RoleIDForMugurthamAdmin = "FE1C8DE449F4AA8A0";
        public const string RoleIDForUserPublic = "5DD71987C324A1E86";

        // THEMEMASTER DATABASE TABLE CONSTANTS
        public const string ThemeBootstrap = "Bootstrap";
        public const string ThemeFlatly = "Flatly";
        public const string ThemeSpacelab = "Spacelab";

        // LOCALEMASTER DATABASE TABLE CONSTANTS
        public const string LocaleTamil = "0449";
        public const string LocaleUSEnglish = "0409";
        public const string LocaleHindi = "0439";
        public const string LocaleTelgu = "044a";
        public const string LocaleMalayalam = "044c";
        public const string LocaleKannada = "044b";

        // HOME PAGE PATH
        public const string HomePagePathForProfileUser = "Matrimony#/ProfileUserDashboard";
        public const string HomePagePathForPublicUser = "Matrimony#/PublicUserDashboard";
        public const string HomePagePathForMugurthamAdmin = "Matrimony#/MugurthamAdminDashboard";
        public const string HomePagePathForSangamAdmin = "Matrimony#/SangamDashboard";

        // APPSETTINGS VALUE IN THE WEB.CONFIG - CONSTANTS
        public const string AppSetttingsKeyProductVersion = "ProductVersion";
        public const string AppSetttingsKeyLogFilePath = "LogFilePath";

        //CCAVENUE TEST SERVER CREDENTIALS
        public const string ccAvenueworkingKeyTest = "56FDB199FAF2C31B82E95CC1551BB423";
        public const string ccAvenueMerchantIDTest = "133253";
        public const string ccAvenueAccessCodeTest = "AVYE70EE68AT08EYTA";
        public const string ccAvenueTransactionURLTest = "https://test.ccavenue.com/transaction/transaction.do?command=initiateTransaction";

        //CCAVENUE PRODUCTION SERVER CREDENTIALS
        public const string ccAvenueworkingKey = "3A06578B61932B9F5DCB333BBCCF727B";
        public const string ccAvenueMerchantID = "133253";
        public const string ccAvenueAccessCode = "AVWW71EF27AP21WWPA";
        public const string ccAvenueTransactionURL = "https://secure.ccavenue.com/transaction/transaction.do?command=initiateTransaction";






    }
}
