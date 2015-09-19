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
        public int getLookup(ref LookupEntity objLookupEntity)
        {
            List<Mugurtham.Core.Sangam.SangamCoreEntity> objSangamCoreEntityList = new List<Sangam.SangamCoreEntity>();
            List<Mugurtham.Core.Role.RoleCoreEntity> objRoleCoreEntityList = new List<Role.RoleCoreEntity>();
            Mugurtham.Core.Sangam.SangamCore objSangamCore = new Sangam.SangamCore();
            using (objSangamCore as IDisposable)
                objSangamCore.GetAll(ref objSangamCoreEntityList);
            objSangamCore = null;
            Mugurtham.Core.Role.RoleCore objRoleCore = new Role.RoleCore();
            using (objRoleCore as IDisposable)
                objRoleCore.GetAll(ref objRoleCoreEntityList);
            objRoleCore = null;
            objLookupEntity.RoleCoreEntity = objRoleCoreEntityList;
            objLookupEntity.SangamCoreEntity = objSangamCoreEntityList;
            return 0;
        }
    }
}
