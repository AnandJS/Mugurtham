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
                    _CommunityName = "udayar";
                    _AppKeyConnectionstring = "udayar";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "2")
                {
                    _CommunityName = "pillai";
                    _AppKeyConnectionstring = "pillai";
                    _Connectionstring = System.Configuration.ConfigurationManager.ConnectionStrings[_AppKeyConnectionstring].ConnectionString;
                }
                else if (_CommunityID == "3")
                {
                    _CommunityName = "thevar";
                    _AppKeyConnectionstring = "thevar";
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
