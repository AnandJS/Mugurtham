using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Mugurtham.UOW;

namespace Mugurtham.Core.Location
{
    public class LocationCore
    {
        public int Add(ref Mugurtham.Core.Location.LocationCoreEntity objLocationCoreEntity)
        {
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                Mugurtham.DTO.Profile.Location objDTOLocation = new DTO.Profile.Location();
                using (objDTOLocation as IDisposable)
                {
                    AssignDTOFromEntity(ref objDTOLocation, ref objLocationCoreEntity);
                }
                objIUnitOfWork.RepositoryLocation.Add(objDTOLocation);
                objDTOLocation = null;
            }
            objIUnitOfWork.commit();
            objIUnitOfWork = null;
            return 0;
        }

        public int Edit(ref Mugurtham.Core.Location.LocationCoreEntity objLocationCoreEntity)
        {
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                Mugurtham.DTO.Profile.Location objDTOLocation = new DTO.Profile.Location();
                using (objDTOLocation as IDisposable)
                {
                    AssignDTOFromEntity(ref objDTOLocation, ref objLocationCoreEntity);
                }
                objIUnitOfWork.RepositoryLocation.Edit(objDTOLocation);
                objDTOLocation = null;
            }
            objIUnitOfWork.commit();
            objIUnitOfWork = null;
            return 0;
        }

        public LocationCoreEntity GetByProfileID(string strProfileID)
        {
            LocationCoreEntity objLocationCoreEntity = new LocationCoreEntity();
            Mugurtham.DTO.Profile.Location objLocation = new Mugurtham.DTO.Profile.Location();
            IUnitOfWork objUOW = new UnitOfWork();
            using (objUOW as IDisposable)
                objLocation = objUOW.RepositoryLocation.GetAll().ToList().Where(p => p.ProfileID.Trim().ToLower() == strProfileID.Trim().ToLower()).FirstOrDefault();
            objUOW = null;
            if (objLocation != null)
            {
                using (objLocation as IDisposable)
                {
                    AssignEntityFromDTO(ref objLocation, ref objLocationCoreEntity);
                }
            }
            objLocation = null;
            return objLocationCoreEntity;
        }

        private int AssignDTOFromEntity(ref Mugurtham.DTO.Profile.Location objDTOLocation, ref Mugurtham.Core.Location.LocationCoreEntity objLocationCoreEntity)
        {
            objDTOLocation.ProfileID = objLocationCoreEntity.ProfileID;
            objDTOLocation.CitizenShip = objLocationCoreEntity.CitizenShip;
            objDTOLocation.CountryLivingIn = objLocationCoreEntity.CountryLivingIn;
            objDTOLocation.ResidentStatus = objLocationCoreEntity.ResidentStatus;
            objDTOLocation.ResidingCity = objLocationCoreEntity.ResidingCity;
            objDTOLocation.ResidingState = objLocationCoreEntity.ResidingState;
            objDTOLocation.CreatedDate = DateTime.Now;
            objDTOLocation.ModifiedDate = DateTime.Now;
            return 0;
        }

        private int AssignEntityFromDTO(ref Mugurtham.DTO.Profile.Location objDTOLocation, ref Mugurtham.Core.Location.LocationCoreEntity objLocationCoreEntity)
        {
            objLocationCoreEntity.ProfileID = objDTOLocation.ProfileID;
            objLocationCoreEntity.CitizenShip = objDTOLocation.CitizenShip;
            objLocationCoreEntity.CountryLivingIn = objDTOLocation.CountryLivingIn;
            objLocationCoreEntity.ResidentStatus = objDTOLocation.ResidentStatus;
            objLocationCoreEntity.ResidingCity = objDTOLocation.ResidingCity;
            objLocationCoreEntity.ResidingState = objDTOLocation.ResidingState;
            return 0;
        }
    }
}
