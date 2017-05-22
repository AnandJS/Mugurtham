using Mugurtham.Common.Utilities;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mugurtham.Core.Lookup
{
    public class LookupCore
    {
        private Mugurtham.Core.Login.LoggedInUser _objLoggedInUser = null;

        public LookupCore(ref Mugurtham.Core.Login.LoggedInUser objLoggedInUser)
        {
            _objLoggedInUser = objLoggedInUser;
        }

        public int getLookup(ref LookupEntity objLookupEntity)
        {
            try
            {
                List<Mugurtham.Core.Sangam.SangamCoreEntity> objSangamCoreEntityList = new List<Sangam.SangamCoreEntity>();
                List<Mugurtham.Core.Role.RoleCoreEntity> objRoleCoreEntityList = new List<Role.RoleCoreEntity>();
                Mugurtham.Core.Sangam.SangamCore objSangamCore = new Sangam.SangamCore(_objLoggedInUser.ConnectionStringAppKey);
                using (objSangamCore as IDisposable)
                    objSangamCore.GetAll(ref objSangamCoreEntityList);
                objSangamCore = null;
                Mugurtham.Core.Role.RoleCore objRoleCore = new Role.RoleCore(ref _objLoggedInUser);
                using (objRoleCore as IDisposable)
                    objRoleCore.GetAll(ref objRoleCoreEntityList);
                objRoleCore = null;
                objLookupEntity.RoleCoreEntity = objRoleCoreEntityList;
                objLookupEntity.SangamCoreEntity = objSangamCoreEntityList;
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }
    }
}
