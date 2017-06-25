using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;
using System.Data;
using System.Configuration;

namespace Mugurtham.Service.Areas.SangamAdmin.Reports
{
    public partial class Tester : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Common.Utilities.Helpers.LogMessageInFlatFile("1111111111111111111111111");

                if (!IsPostBack)
                {
                    Common.Utilities.Helpers.LogMessageInFlatFile("22222222222222");

                    //set Processing Mode of Report as Local   
                    ReportViewer1.ProcessingMode = ProcessingMode.Local;
                    //set path of the Local report   
                    ReportViewer1.LocalReport.ReportPath = Server.MapPath("SangamReport.rdlc");
                    //creating object of DataSet dsMember and filling the DataSet using SQLDataAdapter   
                    DataSet objDS = new DataSet();
                    Common.Utilities.Helpers.LogMessageInFlatFile("3333333333");
                    GetDataSet(ref objDS);
                    Common.Utilities.Helpers.LogMessageInFlatFile("44444444444444");
                    string ConStr = ConfigurationManager.ConnectionStrings["VishwakarmaMugurtham"].ConnectionString;
                    SqlConnection con = new SqlConnection(ConStr);
                    con.Open();
                    SqlDataAdapter adapt = new SqlDataAdapter("select * from rolemaster", con);
                    Common.Utilities.Helpers.LogMessageInFlatFile("5555555555555555");

                    adapt.Fill(objDS, "SangamDataSet");
                    con.Close();
                    Common.Utilities.Helpers.LogMessageInFlatFile("666666666666666666");

                    //Providing DataSource for the Report   
                    ReportDataSource rds = new ReportDataSource("SangamDatset", objDS.Tables[0]);
                    ReportViewer1.LocalReport.DataSources.Clear();
                    //Add ReportDataSource   
                    ReportViewer1.LocalReport.DataSources.Add(rds);
                    Common.Utilities.Helpers.LogMessageInFlatFile("777777777777777777");

                }
            }
            catch (Exception objEx)
            {
                Common.Utilities.Helpers.LogExceptionInFlatFile(objEx);

            }
        }

        private int GetDataSet(ref DataSet objDataSet)
        {
            try
            {
                Mugurtham.Core.Login.LoggedInUser objLoggedIn = (Mugurtham.Core.Login.LoggedInUser)Session["LoggedInUser"];
                string conString = ConfigurationManager.ConnectionStrings["VishwakarmaMugurtham"].ConnectionString;
                SqlCommand cmd = new SqlCommand("select * from rolemaster");
                using (SqlConnection con = new SqlConnection(conString))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;

                        sda.SelectCommand = cmd;
                        objDataSet.DataSetName = "SangamDataset";
                        sda.Fill(objDataSet);
                        Common.Utilities.Helpers.LogMessageInFlatFile(objDataSet.Tables[0].Rows.Count.ToString());


                    }
                }
            }
            catch (Exception objEx)
            {
                Common.Utilities.Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }
    }
}