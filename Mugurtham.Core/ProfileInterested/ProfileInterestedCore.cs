using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Mugurtham.UOW;
using Mugurtham.Common.Utilities;
using Mugurtham.Core.Profile.API;
using Mugurtham.Core.BasicInfo;

namespace Mugurtham.Core.ProfileInterested
{
    public class ProfileInterestedCore
    {
        public int Add(ref Mugurtham.Core.ProfileInterested.ProfileInterestedCoreEntity objProfileInterestedCoreEntity)
        {
            string strMappingID = string.Empty;
            string strViewerID = objProfileInterestedCoreEntity.ViewerID;
            string strInterestedInID = objProfileInterestedCoreEntity.InterestedInID;
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                Mugurtham.DTO.ProfileInterested.ProfileInterested objDTOProfileInterested = new DTO.ProfileInterested.ProfileInterested();
                using (objDTOProfileInterested as IDisposable)
                {
                    objDTOProfileInterested.ID = Helpers.primaryKey();
                    AssignDTOFromEntity(ref objDTOProfileInterested, ref objProfileInterestedCoreEntity);
                }
                List<Mugurtham.DTO.ProfileInterested.ProfileInterested> objProfileInterested = new List<DTO.ProfileInterested.ProfileInterested>();
                using (objProfileInterested as IDisposable)
                {
                    objProfileInterested = objIUnitOfWork.RepositoryProfileInterested.GetAll().ToList().
                    Where(p => p.ViewerID.Trim().ToLower() == strViewerID.Trim().ToLower() &&
                          p.InterestedInID.Trim().ToLower() == strInterestedInID.Trim().ToLower()).ToList();
                    foreach (DTO.ProfileInterested.ProfileInterested objProfiles in objProfileInterested)
                    {
                        strMappingID = objProfiles.ID;
                    }
                }
                if (objProfileInterested.Count == 0)
                {
                    IUnitOfWork objIUnitOfWorkAdd = new UnitOfWork();
                    using (objIUnitOfWorkAdd as IDisposable)
                    {
                        objIUnitOfWorkAdd.RepositoryProfileInterested.Add(objDTOProfileInterested);
                        objIUnitOfWorkAdd.commit();
                        objDTOProfileInterested = null;
                    }
                    objIUnitOfWorkAdd = null;
                }
            }
            objIUnitOfWork = null;
            return 0;
        }
        public int Delete(string strViewerID, string strInterestedInID)
        {
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                Mugurtham.DTO.ProfileInterested.ProfileInterested objProfileInterested = new DTO.ProfileInterested.ProfileInterested();
                using (objProfileInterested as IDisposable)
                {
                    objProfileInterested = objIUnitOfWork.RepositoryProfileInterested.GetAll().ToList().
                    Where(p => p.ViewerID.Trim().ToLower() == strViewerID.Trim().ToLower() &&
                          p.InterestedInID.Trim().ToLower() == strInterestedInID.Trim().ToLower()).FirstOrDefault();
                }
                if (objProfileInterested != null)
                {
                    IUnitOfWork objIUnitOfWorkAdd = new UnitOfWork();
                    using (objIUnitOfWorkAdd as IDisposable)
                    {
                        objIUnitOfWorkAdd.RepositoryProfileInterested.Delete(objProfileInterested);
                        objIUnitOfWorkAdd.commit();
                    }
                    objIUnitOfWorkAdd = null;
                }
                objProfileInterested = null;
            }
            objIUnitOfWork = null;
            return 0;
        }
        public int GetInterestedProfiles(ref List<ProfileCore> objProfileCoreList, string strGender, string strInterestedProfileID, string strSangamID)
        {
            List<ProfileInterestedCoreEntity> objProfileInterestedCoreEntityList = new List<ProfileInterestedCoreEntity>();
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                if ((objIUnitOfWork.RepositoryProfileInterested.GetInterestedProfiles(strGender, strInterestedProfileID, strSangamID) != null) &&
                    (objIUnitOfWork.RepositoryProfileInterested.GetInterestedProfiles(strGender, strInterestedProfileID, strSangamID).Count > 0))
                {
                    List<Mugurtham.DTO.Profile.BasicInfo> objListBasicInfo = new List<Mugurtham.DTO.Profile.BasicInfo>();
                    objListBasicInfo = objIUnitOfWork.RepositoryProfileInterested.GetInterestedProfiles(strGender, strInterestedProfileID, strSangamID);
                    if (objListBasicInfo != null && objListBasicInfo.Count > 0)
                    {
                        foreach (Mugurtham.DTO.Profile.BasicInfo objDTOBasicInfo in objListBasicInfo)
                        {
                            using (objDTOBasicInfo as IDisposable)
                            {
                                ProfileInterestedCoreEntity objProfileInterestedCoreEntity = new ProfileInterestedCoreEntity();
                                using (objProfileInterestedCoreEntity as IDisposable)
                                {
                                    objProfileInterestedCoreEntity.InterestedInID = objDTOBasicInfo.ProfileID;
                                    objProfileInterestedCoreEntityList.Add(objProfileInterestedCoreEntity);
                                }
                                objProfileInterestedCoreEntity = null;
                            }
                        }
                    }
                }
            }
            objIUnitOfWork = null;
            ProfileCore objBaseProfileCore = new ProfileCore();
            using (objBaseProfileCore as IDisposable)
            {
                foreach (ProfileInterestedCoreEntity objProfileInterestedCoreEntity in objProfileInterestedCoreEntityList)
                {
                    ProfileCore objProfileCore = null;
                    objBaseProfileCore.GetByProfileID(objProfileInterestedCoreEntity.InterestedInID, out objProfileCore);
                    objProfileCoreList.Add(objProfileCore);
                    using (objProfileCore as IDisposable) { }
                    objProfileCore = null;
                }
            }
            objBaseProfileCore = null;
            return 0;
        }
        public int GetInterestedInMeProfiles(ref List<ProfileCore> objProfileCoreList, string strGender, string strInterestedProfileID, string strSangamID)
        {
            List<ProfileInterestedCoreEntity> objProfileInterestedCoreEntityList = new List<ProfileInterestedCoreEntity>();
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                if ((objIUnitOfWork.RepositoryProfileInterested.GetInterestedInMeProfiles(strGender, strInterestedProfileID, strSangamID) != null) &&
                    (objIUnitOfWork.RepositoryProfileInterested.GetInterestedInMeProfiles(strGender, strInterestedProfileID, strSangamID).Count > 0))
                {
                    List<Mugurtham.DTO.Profile.BasicInfo> objListBasicInfo = new List<Mugurtham.DTO.Profile.BasicInfo>();
                    objListBasicInfo = objIUnitOfWork.RepositoryProfileInterested.GetInterestedInMeProfiles(strGender, strInterestedProfileID, strSangamID);
                    if (objListBasicInfo != null && objListBasicInfo.Count > 0)
                    {
                        foreach (Mugurtham.DTO.Profile.BasicInfo objDTOBasicInfo in objListBasicInfo)
                        {
                            using (objDTOBasicInfo as IDisposable)
                            {
                                ProfileInterestedCoreEntity objProfileInterestedCoreEntity = new ProfileInterestedCoreEntity();
                                using (objProfileInterestedCoreEntity as IDisposable)
                                {
                                    objProfileInterestedCoreEntity.InterestedInID = objDTOBasicInfo.ProfileID;
                                    objProfileInterestedCoreEntityList.Add(objProfileInterestedCoreEntity);
                                }
                                objProfileInterestedCoreEntity = null;
                            }
                        }
                    }
                }
            }
            objIUnitOfWork = null;
            ProfileCore objBaseProfileCore = new ProfileCore();
            using (objBaseProfileCore as IDisposable)
            {
                foreach (ProfileInterestedCoreEntity objProfileInterestedCoreEntity in objProfileInterestedCoreEntityList)
                {
                    ProfileCore objProfileCore = null;
                    objBaseProfileCore.GetByProfileID(objProfileInterestedCoreEntity.InterestedInID, out objProfileCore);
                    objProfileCoreList.Add(objProfileCore);
                    using (objProfileCore as IDisposable) { }
                    objProfileCore = null;
                }
            }
            objBaseProfileCore = null;
            return 0;
        }
        public bool isInterestedProfile(string strViewerID, string strInterestedInID)
        {
            bool boolInterestedProfile = false;
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                Mugurtham.DTO.ProfileInterested.ProfileInterested objProfileInterested = new DTO.ProfileInterested.ProfileInterested();
                using (objProfileInterested as IDisposable)
                {
                    objProfileInterested = objIUnitOfWork.RepositoryProfileInterested.GetAll().ToList().
                    Where(p => p.ViewerID.Trim().ToLower() == strViewerID.Trim().ToLower() &&
                          p.InterestedInID.Trim().ToLower() == strInterestedInID.Trim().ToLower()).FirstOrDefault();
                }
                if (objProfileInterested != null)
                    boolInterestedProfile = true;
            }
            objIUnitOfWork = null;
            return boolInterestedProfile;
        }
        private int AssignDTOFromEntity(ref Mugurtham.DTO.ProfileInterested.ProfileInterested objDTOProfileInterested, ref Mugurtham.Core.ProfileInterested.ProfileInterestedCoreEntity objProfileInterestedCoreEntity)
        {
            objDTOProfileInterested.ViewerID = objProfileInterestedCoreEntity.ViewerID;
            objDTOProfileInterested.InterestedInID = objProfileInterestedCoreEntity.InterestedInID;
            objDTOProfileInterested.InterestedDate = DateTime.Now;
            return 0;
        }
        private int AssignEntityFromDTO(ref ProfileInterestedCoreEntity objProfileInterestedCoreEntity, Mugurtham.DTO.ProfileInterested.ProfileInterested objDTOProfileInterested)
        {
            objProfileInterestedCoreEntity.ID = objDTOProfileInterested.ID;
            objProfileInterestedCoreEntity.ViewerID = objDTOProfileInterested.ViewerID;
            objProfileInterestedCoreEntity.InterestedInID = objDTOProfileInterested.InterestedInID;
            objProfileInterestedCoreEntity.InterestedDate = objDTOProfileInterested.InterestedDate;
            return 0;
        }
    }
}
