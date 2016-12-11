using Mugurtham.Common.Utilities;
using Mugurtham.Core.User;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mugurtham.Core.Profile
{
    public class ProfileSecurity
    {
        /// <summary>
        /// Validates based on the below conditions
        /// 1. I can view my profile
        /// 2. My Sangam Admin can View my Profile
        /// 3. Mugurtham Admin can view my Profile
        /// </summary>
        /// <param name="profileID"></param>
        /// <param name="loggedInUserID"></param>
        /// <returns></returns>
        public bool validateProfileViewAccess(string profileID, string loggedInUserID)
        {
            bool validateProfileViewAccess = false;
            try
            {
                //Validating condition 1
                if (profileID.ToLower().Trim() == loggedInUserID.ToLower().Trim())
                {
                    validateProfileViewAccess = true;
                    return validateProfileViewAccess;
                }
                //Validating condition 2
                string ProfileSangamAdminID = string.Empty;
                string LoggedInUserSangamAdminID = string.Empty;
                string LoggedInUserRole = string.Empty;
                UserCore objUserCore = new UserCore();
                using (objUserCore as IDisposable)
                {
                    UserCoreEntity objUserCoreEntity = new UserCoreEntity();
                    using (objUserCoreEntity as IDisposable)
                    {
                        objUserCoreEntity = objUserCore.GetByLoginID(profileID);
                        ProfileSangamAdminID = objUserCoreEntity.SangamID;
                    }
                    objUserCoreEntity = null;
                }
                objUserCore = null;


                UserCore objLoggedInUserCore = new UserCore();
                using (objLoggedInUserCore as IDisposable)
                {
                    UserCoreEntity objLoggedInUserCoreEntity = new UserCoreEntity();
                    using (objLoggedInUserCoreEntity as IDisposable)
                    {
                        objLoggedInUserCoreEntity = objLoggedInUserCore.GetByLoginID(loggedInUserID);
                        LoggedInUserRole = objLoggedInUserCoreEntity.RoleID;
                        if (objLoggedInUserCoreEntity.RoleID == Constants.RoleIDForSangamAdmin)
                        {
                            LoggedInUserSangamAdminID = objLoggedInUserCoreEntity.SangamID;
                            if (LoggedInUserSangamAdminID == ProfileSangamAdminID)
                            {
                                if (objLoggedInUserCoreEntity.RoleID == Constants.RoleIDForSangamAdmin)
                                {
                                    validateProfileViewAccess = true;
                                    return validateProfileViewAccess;
                                }
                            }
                        }
                        else
                        {
                            validateProfileViewAccess = false;
                        }
                    }
                    objLoggedInUserCoreEntity = null;
                }
                objLoggedInUserCore = null;

                //Validating condition 3
                if (LoggedInUserRole == Constants.RoleIDForMugurthamAdmin)
                {
                    validateProfileViewAccess = true;
                    return validateProfileViewAccess;
                }
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return validateProfileViewAccess;
        }


        public bool IsSangamAdmin(string profileID)
        {
            bool IsSangamAdmin = false;
            UserCore objUserCore = new UserCore();
            using (objUserCore as IDisposable)
            {
                UserCoreEntity objUserCoreEntity = new UserCoreEntity();
                using (objUserCoreEntity as IDisposable)
                {
                    objUserCoreEntity = objUserCore.GetByLoginID(profileID);
                    if(objUserCoreEntity.RoleID == Constants.RoleIDForSangamAdmin)
                    {
                        IsSangamAdmin = true;
                    }
                }
                objUserCoreEntity = null;
            }
            objUserCore = null;
            return IsSangamAdmin;
        }
    }
}
