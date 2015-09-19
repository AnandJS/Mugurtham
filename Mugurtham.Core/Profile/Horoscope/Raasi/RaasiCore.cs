using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Mugurtham.UOW;

namespace Mugurtham.Core.Raasi
{
    public class RaasiCore
    {
        public int Add(ref Mugurtham.Core.Raasi.RaasiCoreEntity objRaasiCoreEntity)
        {
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                Mugurtham.DTO.Profile.Raasi objDTORaasi = new DTO.Profile.Raasi();
                using (objDTORaasi as IDisposable)
                {
                    AssignDTOFromEntity(ref objDTORaasi, ref objRaasiCoreEntity);
                }
                objIUnitOfWork.RepositoryRaasi.Add(objDTORaasi);
                objDTORaasi = null;
            }
            objIUnitOfWork.commit();
            objIUnitOfWork = null;
            return 0;
        }

        public int Edit(ref Mugurtham.Core.Raasi.RaasiCoreEntity objRaasiCoreEntity)
        {
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                Mugurtham.DTO.Profile.Raasi objDTORaasi = new DTO.Profile.Raasi();
                using (objDTORaasi as IDisposable)
                {
                    AssignDTOFromEntity(ref objDTORaasi, ref objRaasiCoreEntity);
                }
                objIUnitOfWork.RepositoryRaasi.Edit(objDTORaasi);
                objDTORaasi = null;
            }
            objIUnitOfWork.commit();
            objIUnitOfWork = null;
            return 0;
        }

        public RaasiCoreEntity GetByProfileID(string strProfileID)
        {
            RaasiCoreEntity objRaasiCoreEntity = new RaasiCoreEntity();
            Mugurtham.DTO.Profile.Raasi objRaasi = new Mugurtham.DTO.Profile.Raasi();
            IUnitOfWork objUOW = new UnitOfWork();
            using (objUOW as IDisposable)
                objRaasi = objUOW.RepositoryRaasi.GetAll().ToList().Where(p => p.ProfileID.Trim().ToLower() == strProfileID.Trim().ToLower()).FirstOrDefault();
            objUOW = null;
            if (objRaasi != null)
            {
                using (objRaasi as IDisposable)
                {
                    AssignEntityFromDTO(ref objRaasi, ref objRaasiCoreEntity);
                }
            }
            objRaasi = null;
            return objRaasiCoreEntity;
        }

        public int AssignDTOFromEntity(ref Mugurtham.DTO.Profile.Raasi objDTORaasi, ref Mugurtham.Core.Raasi.RaasiCoreEntity objRaasiCoreEntity)
        {
            objDTORaasi.CreatedBy = objRaasiCoreEntity.CreatedBy;
            objDTORaasi.Kattam1 = objRaasiCoreEntity.Kattam1;
            objDTORaasi.Kattam2 = objRaasiCoreEntity.Kattam2;
            objDTORaasi.Kattam3 = objRaasiCoreEntity.Kattam3;
            objDTORaasi.Kattam4 = objRaasiCoreEntity.Kattam4;
            objDTORaasi.Kattam5 = objRaasiCoreEntity.Kattam5;
            objDTORaasi.Kattam6 = objRaasiCoreEntity.Kattam6;
            objDTORaasi.Kattam7 = objRaasiCoreEntity.Kattam7;
            objDTORaasi.Kattam8 = objRaasiCoreEntity.Kattam8;
            objDTORaasi.Kattam9 = objRaasiCoreEntity.Kattam9;
            objDTORaasi.Kattam10 = objRaasiCoreEntity.Kattam10;
            objDTORaasi.Kattam11 = objRaasiCoreEntity.Kattam11;
            objDTORaasi.Kattam12 = objRaasiCoreEntity.Kattam12;
            objDTORaasi.CreatedDate = DateTime.Now;
            objDTORaasi.ModifiedDate = DateTime.Now;
            objDTORaasi.ProfileID = objRaasiCoreEntity.ProfileID;
            return 0;
        }

        public int AssignEntityFromDTO(ref Mugurtham.DTO.Profile.Raasi objDTORaasi, ref Mugurtham.Core.Raasi.RaasiCoreEntity objRaasiCoreEntity)
        {
            objRaasiCoreEntity.CreatedBy = objDTORaasi.CreatedBy;
            objRaasiCoreEntity.Kattam1 = objDTORaasi.Kattam1;
            objRaasiCoreEntity.Kattam2 = objDTORaasi.Kattam2;
            objRaasiCoreEntity.Kattam3 = objDTORaasi.Kattam3;
            objRaasiCoreEntity.Kattam4 = objDTORaasi.Kattam4;
            objRaasiCoreEntity.Kattam5 = objDTORaasi.Kattam5;
            objRaasiCoreEntity.Kattam6 = objDTORaasi.Kattam6;
            objRaasiCoreEntity.Kattam7 = objDTORaasi.Kattam7;
            objRaasiCoreEntity.Kattam8 = objDTORaasi.Kattam8;
            objRaasiCoreEntity.Kattam9 = objDTORaasi.Kattam9;
            objRaasiCoreEntity.Kattam10 = objDTORaasi.Kattam10;
            objRaasiCoreEntity.Kattam11 = objDTORaasi.Kattam11;
            objRaasiCoreEntity.Kattam12 = objDTORaasi.Kattam12;
            objRaasiCoreEntity.CreatedDate = DateTime.Now;
            objRaasiCoreEntity.ModifiedDate = DateTime.Now;
            objRaasiCoreEntity.ProfileID = objDTORaasi.ProfileID;
            return 0;
        }
    }
}
