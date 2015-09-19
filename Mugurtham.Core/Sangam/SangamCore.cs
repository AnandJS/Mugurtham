using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Mugurtham.UOW;
using Mugurtham.Common.Utilities;

namespace Mugurtham.Core.Sangam
{
    public class SangamCore
    {
        public int Add(ref Mugurtham.Core.Sangam.SangamCoreEntity objSangamCoreEntity, out string strSangamID)
        {
            strSangamID = Helpers.primaryKey();
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                Mugurtham.DTO.Sangam.Sangam objDTOSangam = new DTO.Sangam.Sangam();
                using (objDTOSangam as IDisposable)
                {
                    objSangamCoreEntity.ID = strSangamID;
                    objSangamCoreEntity.RunningNoStartsFrom = 1000;
                    objSangamCoreEntity.LastProfileIDNo = 1000;
                    AssignDTOFromEntity(ref objDTOSangam, ref objSangamCoreEntity);
                }
                objIUnitOfWork.RepositorySangam.Add(objDTOSangam);
                objDTOSangam = null;
            }
            objIUnitOfWork.commit();
            objIUnitOfWork = null;
            return 0;
        }

        public int Edit(ref Mugurtham.Core.Sangam.SangamCoreEntity objSangamCoreEntity)
        {
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                Mugurtham.DTO.Sangam.Sangam objDTOSangam = new DTO.Sangam.Sangam();
                using (objDTOSangam as IDisposable)
                {
                    AssignDTOFromEntity(ref objDTOSangam, ref objSangamCoreEntity);
                }
                objIUnitOfWork.RepositorySangam.Edit(objDTOSangam);
                objDTOSangam = null;
            }
            objIUnitOfWork.commit();
            objIUnitOfWork = null;
            return 0;
        }

        public SangamCoreEntity GetByID(string strID)
        {
            SangamCoreEntity objSangamCoreEntity = new SangamCoreEntity();
            Mugurtham.DTO.Sangam.Sangam objSangam = new Mugurtham.DTO.Sangam.Sangam();
            IUnitOfWork objUOW = new UnitOfWork();
            using (objUOW as IDisposable)
                objSangam = objUOW.RepositorySangam.GetAll().ToList().Where(p => p.ID.Trim().ToLower() == strID.Trim().ToLower()).FirstOrDefault();
            objUOW = null;
            if (objSangam != null)
            {
                using (objSangam as IDisposable)
                {
                    AssignEntityFromDTO(ref objSangam, ref objSangamCoreEntity);
                }
            }
            objSangam = null;
            return objSangamCoreEntity;
        }

        public int GetAll(ref List<SangamCoreEntity> objSangamCoreEntityList)
        {
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                foreach (Mugurtham.DTO.Sangam.Sangam objSangam in objIUnitOfWork.RepositorySangam.GetAll().Where(p => p.IsActivated == "1").ToList())
                {
                    Mugurtham.DTO.Sangam.Sangam _objSangam = objSangam;
                    using (_objSangam as IDisposable)
                    {
                        SangamCoreEntity objSangamCoreEntity = new SangamCoreEntity();
                        using (objSangamCoreEntity as IDisposable)
                        {
                            AssignEntityFromDTO(ref _objSangam, ref objSangamCoreEntity);
                            objSangamCoreEntityList.Add(objSangamCoreEntity);
                        }
                        objSangamCoreEntity = null;
                    }
                    _objSangam = null;
                }
            }
            return 0;
        }
        public int GetAllWithoutRestrictions(ref List<SangamCoreEntity> objSangamCoreEntityList)
        {
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                foreach (Mugurtham.DTO.Sangam.Sangam objSangam in objIUnitOfWork.RepositorySangam.GetAll().ToList())
                {
                    Mugurtham.DTO.Sangam.Sangam _objSangam = objSangam;
                    using (_objSangam as IDisposable)
                    {
                        SangamCoreEntity objSangamCoreEntity = new SangamCoreEntity();
                        using (objSangamCoreEntity as IDisposable)
                        {
                            AssignEntityFromDTO(ref _objSangam, ref objSangamCoreEntity);
                            objSangamCoreEntityList.Add(objSangamCoreEntity);
                        }
                        objSangamCoreEntity = null;
                    }
                    _objSangam = null;
                }
            }
            return 0;
        }

        public int GetNewProfileID(out string strNewProfileID, Mugurtham.Core.Login.LoggedInUser objLoggedIn)
        {
            strNewProfileID = string.Empty;
            if (!string.IsNullOrWhiteSpace(objLoggedIn.sangamID))
            {
                SangamCoreEntity objSangamCoreEntity = new SangamCoreEntity();
                using (objSangamCoreEntity as IDisposable)
                {
                    objSangamCoreEntity = GetByID(objLoggedIn.sangamID);
                    strNewProfileID = objSangamCoreEntity.ProfileIDStartsWith + (objSangamCoreEntity.LastProfileIDNo + 1).ToString();
                }
            }
            return 0;
        }

        private int AssignDTOFromEntity(ref Mugurtham.DTO.Sangam.Sangam objDTOSangam, ref Mugurtham.Core.Sangam.SangamCoreEntity objSangamCoreEntity)
        {
            objDTOSangam.AboutSangam = objSangamCoreEntity.AboutSangam;
            objDTOSangam.Address = objSangamCoreEntity.Address;
            objDTOSangam.ContactNumber = objSangamCoreEntity.ContactNumber;
            objDTOSangam.CreatedDate = DateTime.Now;
            objDTOSangam.ID = objSangamCoreEntity.ID;
            objDTOSangam.ModifiedDate = DateTime.Now;
            objDTOSangam.Name = objSangamCoreEntity.Name;
            objDTOSangam.ProfileIDStartsWith = objSangamCoreEntity.ProfileIDStartsWith;
            objDTOSangam.IsActivated = objSangamCoreEntity.IsActivated;
            objDTOSangam.LogoPath = objSangamCoreEntity.LogoPath;
            objDTOSangam.BannerPath = objSangamCoreEntity.BannerPath;
            objDTOSangam.RunningNoStartsFrom = objSangamCoreEntity.RunningNoStartsFrom;
            objDTOSangam.LastProfileIDNo = objSangamCoreEntity.LastProfileIDNo;
            return 0;
        }

        private int AssignEntityFromDTO(ref Mugurtham.DTO.Sangam.Sangam objDTOSangam, ref Mugurtham.Core.Sangam.SangamCoreEntity objSangamCoreEntity)
        {
            objSangamCoreEntity.AboutSangam = objDTOSangam.AboutSangam;
            objSangamCoreEntity.Address = objDTOSangam.Address;
            objSangamCoreEntity.ContactNumber = objDTOSangam.ContactNumber;
            objSangamCoreEntity.ID = objDTOSangam.ID;
            objSangamCoreEntity.Name = objDTOSangam.Name;
            objSangamCoreEntity.ProfileIDStartsWith = objDTOSangam.ProfileIDStartsWith;
            objSangamCoreEntity.IsActivated = objDTOSangam.IsActivated;
            objSangamCoreEntity.LogoPath = objDTOSangam.LogoPath;
            objSangamCoreEntity.BannerPath = objDTOSangam.BannerPath;
            objSangamCoreEntity.RunningNoStartsFrom = objDTOSangam.RunningNoStartsFrom;
            objSangamCoreEntity.LastProfileIDNo = objDTOSangam.LastProfileIDNo;
            return 0;
        }        
    }
}
