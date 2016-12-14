using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Mugurtham.UOW;
using Mugurtham.Common.Utilities;
using System.Data.SqlClient;
using System.Data;

namespace Mugurtham.Core.Dashboard.Sangam
{
    public class SangamDashboardCore
    {
        public List<SangamDashboardCoreEntity> GetAll(string strSangamID)
        {
            List<SangamDashboardCoreEntity> objListSangamDashboardCoreEntity = new List<SangamDashboardCoreEntity>();
            try
            {
                List<Mugurtham.DTO.Dashboard.Sangam.SangamDashboardChart> objListSangamDashboardChart = new List<Mugurtham.DTO.Dashboard.Sangam.SangamDashboardChart>();
                IUnitOfWork objUOW = new UnitOfWork();
                using (objUOW as IDisposable)
                    objListSangamDashboardChart = objUOW.RepositorySangamDashboardChart.getSangamDashboardChartData(strSangamID).ToList();
                objUOW = null;
                if (objListSangamDashboardChart != null && objListSangamDashboardChart.Count > 0)
                {
                    foreach (Mugurtham.DTO.Dashboard.Sangam.SangamDashboardChart objSangamDashboardChart in objListSangamDashboardChart)
                    {
                        using (objSangamDashboardChart as IDisposable)
                        {
                            SangamDashboardCoreEntity objSangamDashboardCoreEntity = new SangamDashboardCoreEntity();
                            objSangamDashboardCoreEntity.ID = objSangamDashboardChart.ID;
                            objSangamDashboardCoreEntity.Count = objSangamDashboardChart.Count;
                            objSangamDashboardCoreEntity.Month = objSangamDashboardChart.Month;
                            objSangamDashboardCoreEntity.SangamID = objSangamDashboardChart.SangamID;
                            objListSangamDashboardCoreEntity.Add(objSangamDashboardCoreEntity);
                            objSangamDashboardCoreEntity = null;
                        }
                    }
                }
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return objListSangamDashboardCoreEntity;
        }


        public int GetSangamDashboardData(string strConnectionString, string strSangamID,
             ref Core.Sangam.SangamDashboardEntity objSangamDashboardEntity)
        {
            try
            {
                using (SqlConnection objSqlConnection = new SqlConnection(strConnectionString))
                {
                    objSqlConnection.Open();
                    // 1.  create a command object identifying the stored procedure
                    SqlCommand objSqlCommand = new SqlCommand("UspGetSangamProfilesInfo", objSqlConnection);

                    // 2. set the command object so it knows to execute a stored procedure
                    objSqlCommand.CommandType = CommandType.StoredProcedure;

                    // 3. add parameter to command, which will be passed to the stored procedure
                    objSqlCommand.Parameters.Add(new SqlParameter("@SangamID", strSangamID));
                    // execute the command
                    using (SqlDataReader objSqlDataReader = objSqlCommand.ExecuteReader())
                    {
                        while (objSqlDataReader.Read())
                        {
                            if (!string.IsNullOrEmpty(objSqlDataReader["LoggedInCount"].ToString()))
                                objSangamDashboardEntity.TotalLogin = Convert.ToInt32(objSqlDataReader["LoggedInCount"].ToString());
                            if (!string.IsNullOrEmpty(objSqlDataReader["ViewedProfile"].ToString()))
                                objSangamDashboardEntity.ProfilesViewed = Convert.ToInt32(objSqlDataReader["ViewedProfile"].ToString());
                            if (!string.IsNullOrEmpty(objSqlDataReader["ActiveProfiles"].ToString()))
                                objSangamDashboardEntity.ActiveProfiles = Convert.ToInt32(objSqlDataReader["ActiveProfiles"].ToString());
                            if (!string.IsNullOrEmpty(objSqlDataReader["TotalProfiles"].ToString()))
                                objSangamDashboardEntity.TotalProfiles = Convert.ToInt32(objSqlDataReader["TotalProfiles"].ToString());
                        }
                        objSqlDataReader.Close();
                    }
                    objSqlCommand.Cancel();
                    objSqlCommand.Dispose();
                    objSqlConnection.Close();
                    objSqlConnection.Dispose();
                }
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }

    }
}
