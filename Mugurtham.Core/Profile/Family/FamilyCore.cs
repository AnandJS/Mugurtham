using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Mugurtham.UOW;

namespace Mugurtham.Core.Family
{
    public class FamilyCore
    {
        public int Add(ref Mugurtham.Core.Family.FamilyCoreEntity objFamilyCoreEntity)
        {
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                Mugurtham.DTO.Profile.Family objDTOFamily = new DTO.Profile.Family();
                using (objDTOFamily as IDisposable)
                {
                    AssignDTOFromEntity(ref objDTOFamily, ref objFamilyCoreEntity);
                }
                objIUnitOfWork.RepositoryFamily.Add(objDTOFamily);
                objDTOFamily = null;
            }
            objIUnitOfWork.commit();
            objIUnitOfWork = null;
            return 0;
        }

        public int Edit(ref Mugurtham.Core.Family.FamilyCoreEntity objFamilyCoreEntity)
        {
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                Mugurtham.DTO.Profile.Family objDTOFamily = new DTO.Profile.Family();
                using (objDTOFamily as IDisposable)
                {
                    AssignDTOFromEntity(ref objDTOFamily, ref objFamilyCoreEntity);
                }
                objIUnitOfWork.RepositoryFamily.Edit(objDTOFamily);
                objDTOFamily = null;
            }
            objIUnitOfWork.commit();
            objIUnitOfWork = null;
            return 0;
        }

        public FamilyCoreEntity GetByProfileID(string strProfileID)
        {
            FamilyCoreEntity objFamilyCoreEntity = new FamilyCoreEntity();
            Mugurtham.DTO.Profile.Family objFamily = new Mugurtham.DTO.Profile.Family();
            IUnitOfWork objUOW = new UnitOfWork();
            using (objUOW as IDisposable)
                objFamily = objUOW.RepositoryFamily.GetAll().ToList().Where(p => p.ProfileID.Trim().ToLower() == strProfileID.Trim().ToLower()).FirstOrDefault();
            objUOW = null;
            if (objFamily != null)
            {
                using (objFamily as IDisposable)
                {
                    AssignEntityFromDTO(ref objFamily, ref objFamilyCoreEntity);
                }
            }
            objFamily = null;
            return objFamilyCoreEntity;
        }

        private int AssignDTOFromEntity(ref Mugurtham.DTO.Profile.Family objDTOFamily, ref Mugurtham.Core.Family.FamilyCoreEntity objFamilyCoreEntity)
        {
            objDTOFamily.AboutFamily = objFamilyCoreEntity.AboutFamily;
            objDTOFamily.BrothersMarried = objFamilyCoreEntity.MarriedBrothers;
            objDTOFamily.FamilType = objFamilyCoreEntity.FamilType;
            objDTOFamily.FamilyOrigin = objFamilyCoreEntity.FamilyOrigin;
            objDTOFamily.FamilyStatus = objFamilyCoreEntity.FamilyStatus;
            objDTOFamily.FamilyValue = objFamilyCoreEntity.FamilyValue;
            objDTOFamily.FathersName = objFamilyCoreEntity.FathersName;
            objDTOFamily.FathersOccupation = objFamilyCoreEntity.FathersOccupation;
            objDTOFamily.Mothersname = objFamilyCoreEntity.Mothersname;
            objDTOFamily.MothersOccupation = objFamilyCoreEntity.MothersOccupation;
            objDTOFamily.NoOfBrothers = objFamilyCoreEntity.NoOfBrothers;
            objDTOFamily.NoOfSisters = objFamilyCoreEntity.NoOfSisters;
            objDTOFamily.SistersMarried = objFamilyCoreEntity.MarriedSisters;
            objDTOFamily.CreateDate = DateTime.Now;
            objDTOFamily.ModifiedDate = DateTime.Now;
            objDTOFamily.ProfileID = objFamilyCoreEntity.ProfileID;
            return 0;
        }

        private int AssignEntityFromDTO(ref Mugurtham.DTO.Profile.Family objDTOFamily, ref Mugurtham.Core.Family.FamilyCoreEntity objFamilyCoreEntity)
        {
            objFamilyCoreEntity.AboutFamily = objDTOFamily.AboutFamily;
            objFamilyCoreEntity.MarriedBrothers = objDTOFamily.BrothersMarried;
            objFamilyCoreEntity.FamilType = objDTOFamily.FamilType;
            objFamilyCoreEntity.FamilyOrigin = objDTOFamily.FamilyOrigin;
            objFamilyCoreEntity.FamilyStatus = objDTOFamily.FamilyStatus;
            objFamilyCoreEntity.FamilyValue = objDTOFamily.FamilyValue;
            objFamilyCoreEntity.FathersName = objDTOFamily.FathersName;
            objFamilyCoreEntity.FathersOccupation = objDTOFamily.FathersOccupation;
            objFamilyCoreEntity.Mothersname = objDTOFamily.Mothersname;
            objFamilyCoreEntity.MothersOccupation = objDTOFamily.MothersOccupation;
            objFamilyCoreEntity.NoOfBrothers = objDTOFamily.NoOfBrothers;
            objFamilyCoreEntity.NoOfSisters = objDTOFamily.NoOfSisters;
            objFamilyCoreEntity.MarriedSisters = objDTOFamily.SistersMarried;
            objFamilyCoreEntity.ProfileID = objDTOFamily.ProfileID;
            return 0;
        }
    }
}
