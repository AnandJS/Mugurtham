﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Mugurtham.UOW;
using Mugurtham.Common.Utilities;

namespace Mugurtham.Core.Family
{
    public class FamilyCore
    {
        private Mugurtham.Core.Login.LoggedInUser _objLoggedInUser = null;

        public FamilyCore(ref Mugurtham.Core.Login.LoggedInUser objLoggedInUser)
        {
            _objLoggedInUser = objLoggedInUser;
        }

        public int Add(ref Mugurtham.Core.Family.FamilyCoreEntity objFamilyCoreEntity)
        {
            try
            {
                IUnitOfWork objIUnitOfWork = new UnitOfWork(_objLoggedInUser.ConnectionStringAppKey);
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
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }

        public int Edit(ref Mugurtham.Core.Family.FamilyCoreEntity objFamilyCoreEntity)
        {
            try
            {
                IUnitOfWork objIUnitOfWork = new UnitOfWork(_objLoggedInUser.ConnectionStringAppKey);
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
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }

        public FamilyCoreEntity GetByProfileID(string strProfileID, string strLoggedInUserID)
        {
            Profile.ProfileSecurity objProfileSecurity = new Profile.ProfileSecurity(ref _objLoggedInUser);
            using (objProfileSecurity as IDisposable)
            {
                if (!string.IsNullOrEmpty(strLoggedInUserID))
                {
                    //MugurthamUserToken - If null - hacker is trying to hack the system so redirect to unauthorized page
                    if (!objProfileSecurity.validateProfileViewAccess(strProfileID, strLoggedInUserID))
                    {
                        strProfileID = strLoggedInUserID;
                    }
                }
            }
            objProfileSecurity = null;
            return GetByProfileID(strProfileID);
        }
        private FamilyCoreEntity GetByProfileID(string strProfileID)
        {
            FamilyCoreEntity objFamilyCoreEntity = new FamilyCoreEntity();
            try
            {
                Mugurtham.DTO.Profile.Family objFamily = new Mugurtham.DTO.Profile.Family();
                IUnitOfWork objUOW = new UnitOfWork(_objLoggedInUser.ConnectionStringAppKey);
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
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return objFamilyCoreEntity;
        }

        private int AssignDTOFromEntity(ref Mugurtham.DTO.Profile.Family objDTOFamily, ref Mugurtham.Core.Family.FamilyCoreEntity objFamilyCoreEntity)
        {
            try
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
                objDTOFamily.MothersSubSect = objFamilyCoreEntity.MothersSubSect;
                objDTOFamily.ParentsAlive = objFamilyCoreEntity.ParentsAlive;
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }

        private int AssignEntityFromDTO(ref Mugurtham.DTO.Profile.Family objDTOFamily, ref Mugurtham.Core.Family.FamilyCoreEntity objFamilyCoreEntity)
        {
            try
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
                objFamilyCoreEntity.MothersSubSect = objDTOFamily.MothersSubSect;
                objFamilyCoreEntity.ParentsAlive = objDTOFamily.ParentsAlive;
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }
    }
}
