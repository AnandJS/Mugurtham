using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Mugurtham.Service.Areas.SangamAdmin.Reports
{
    public partial class test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write(Request.ServerVariables["SERVER_SOFTWARE"].ToString() + "sssssssssssss");
        }
    }
}