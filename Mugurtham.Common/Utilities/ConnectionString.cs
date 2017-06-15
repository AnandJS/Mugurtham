using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mugurtham.Common.Utilities
{
    [MugurthamBaseAPIController]
    public class ConnectionString
    {
        // Name of the connectionstring stored in the web.config
        private string _AppKeyConnectionstring = string.Empty;
        // Connectionstring stored in the web.config
        private string _Connectionstring = string.Empty;
        private string _CommunityID = string.Empty;
        private string _CommunityName = string.Empty;

        public ConnectionString(string CommunityID)
        {
            _CommunityID = CommunityID;
            getConnectionString();
        }

        private int getConnectionString()
        {
            try
            {
                if (_CommunityID == "1")
                {
                    _CommunityName = "Aadhidhravidar";
                    _AppKeyConnectionstring = "AdidravidarMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "2")
                {
                    _CommunityName = "Agamudayar";
                    _AppKeyConnectionstring = "AgamudayarMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "3")
                {
                    _CommunityName = "Brahmin";
                    _AppKeyConnectionstring = "BrahminMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "4")
                {
                    _CommunityName = "Christian";
                    _AppKeyConnectionstring = "ChristianMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "5")
                {
                    _CommunityName = "Gounder";
                    _AppKeyConnectionstring = "GounderMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "6")
                {
                    _CommunityName = "Maruthuvar";
                    _AppKeyConnectionstring = "MaruthuvarMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "7")
                {
                    _CommunityName = "Mudaliyar";
                    _AppKeyConnectionstring = "MudaliyarMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "8")
                {
                    _CommunityName = "Mukkulathor";
                    _AppKeyConnectionstring = "MukkulathorMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "9")
                {
                    _CommunityName = "Nadar";
                    _AppKeyConnectionstring = "NadarMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "10")
                {
                    _CommunityName = "Naidu";
                    _AppKeyConnectionstring = "NaiduMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "11")
                {
                    _CommunityName = "Others";
                    _AppKeyConnectionstring = "OthersMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "12")
                {
                    _CommunityName = "Padayachi";
                    _AppKeyConnectionstring = "PadayachiMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "13")
                {
                    _CommunityName = "Parvatharajakulam";
                    _AppKeyConnectionstring = "ParvatharajakulamMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "14")
                {
                    _CommunityName = "Pillai";
                    _AppKeyConnectionstring = "PillaiMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "15")
                {
                    _CommunityName = "Reddiar";
                    _AppKeyConnectionstring = "ReddiarMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "16")
                {
                    _CommunityName = "ReMarriage";
                    _AppKeyConnectionstring = "ReMarriageMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "17")
                {
                    _CommunityName = "Thevar";
                    _AppKeyConnectionstring = "ThevarMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "18")
                {
                    _CommunityName = "Udayar";
                    _AppKeyConnectionstring = "UdayarMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "19")
                {
                    _CommunityName = "vanniyar";
                    _AppKeyConnectionstring = "VanniyarMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "20")
                {
                    _CommunityName = "Vellalar";
                    _AppKeyConnectionstring = "VellalarMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "21")
                {
                    _CommunityName = "Vishwakarma";
                    _AppKeyConnectionstring = "VishwakarmaMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "22")
                {
                    _CommunityName = "Yadava";
                    _AppKeyConnectionstring = "YadavaMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "23")
                {
                    _CommunityName = "CasteNoBar";
                    _AppKeyConnectionstring = "CasteNoBarMugurtham";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }
        public string CommunityID
        {
            get
            {
                return _CommunityID;
            }
        }
        public string CommunityName
        {
            get
            {
                return _CommunityName;
            }
        }
        public string AppKeyConnectionString
        {
            get
            {
                return _AppKeyConnectionstring;
            }
        }
        public string AppConnectionString
        {
            get
            {
                return _Connectionstring;
            }
        }


    }
}
