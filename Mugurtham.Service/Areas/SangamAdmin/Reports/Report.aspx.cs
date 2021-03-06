﻿using System;
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
    public partial class Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    //set Processing Mode of Report as Local   
                    ReportViewer1.ProcessingMode = ProcessingMode.Local;
                    //set path of the Local report   
                    ReportViewer1.LocalReport.ReportPath = Server.MapPath("SangamReport.rdlc");
                    //creating object of DataSet dsMember and filling the DataSet using SQLDataAdapter   
                    DataSet objDS = new DataSet();
                    GetDataSet(ref objDS);
                    string ConStr = ConfigurationManager.ConnectionStrings["VishwakarmaMugurtham"].ConnectionString;
                    SqlConnection con = new SqlConnection(ConStr);
                    con.Open();
                    SqlDataAdapter adapt = new SqlDataAdapter("select * from rolemaster", con);
                    adapt.Fill(objDS, "SangamDataSet");
                    con.Close();
                    //Providing DataSource for the Report   
                    ReportDataSource rds = new ReportDataSource("SangamDatset", objDS.Tables[0]);
                    ReportViewer1.AsyncRendering = false;
                    ReportViewer1.LocalReport.DataSources.Clear();
                    
                    //Add ReportDataSource   
                    ReportViewer1.LocalReport.DataSources.Add(rds);
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