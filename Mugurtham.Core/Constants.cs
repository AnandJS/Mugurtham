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
        public const string HomePagePathForProfileUser = "Mugurtham#/ProfileUserDashboard";
        public const string HomePagePathForPublicUser = "Mugurtham#/PublicUserDashboard";
        public const string HomePagePathForMugurthamAdmin = "Mugurtham#/MugurthamDashboard";
        public const string HomePagePathForSangamAdmin = "Mugurtham#/SangamDashboard";

        // APPSETTINGS VALUE IN THE WEB.CONFIG - CONSTANTS
        public const string AppSetttingsKeyProductVersion = "ProductVersion";
        public const string AppSetttingsKeyLogFilePath = "LogFilePath";
    }
}
