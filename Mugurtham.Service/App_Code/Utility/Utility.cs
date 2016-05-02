using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mugurtham.Service.App_Code.Utility
{
    public class Utility
    {
        public static string connectionString()
        {
            /*www.codeproject.com/Articles/420217/DataSet-vs-DataReader*/
            string strConnectionString = string.Empty;
            strConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MugurthamConnectionString"].ConnectionString;
            return strConnectionString;
        }
    }
}