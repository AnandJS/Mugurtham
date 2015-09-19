﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Mugurtham.UOW;

namespace Mugurtham.Core.Reference
{
    public class ReferenceCore
    {
        public int Add(ref Mugurtham.Core.Reference.ReferenceCoreEntity objReferenceCoreEntity)
        {
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                Mugurtham.DTO.Profile.Reference objDTOReference = new DTO.Profile.Reference();
                using (objDTOReference as IDisposable)
                {
                    AssignDTOFromEntity(ref objDTOReference, ref objReferenceCoreEntity);
                }
                objIUnitOfWork.RepositoryReference.Add(objDTOReference);
                objDTOReference = null;
            }
            objIUnitOfWork.commit();
            objIUnitOfWork = null;
            return 0;
        }

        public int Edit(ref Mugurtham.Core.Reference.ReferenceCoreEntity objReferenceCoreEntity)
        {
            IUnitOfWork objIUnitOfWork = new UnitOfWork();
            using (objIUnitOfWork as IDisposable)
            {
                Mugurtham.DTO.Profile.Reference objDTOReference = new DTO.Profile.Reference();
                using (objDTOReference as IDisposable)
                {
                    AssignDTOFromEntity(ref objDTOReference, ref objReferenceCoreEntity);
                }
                objIUnitOfWork.RepositoryReference.Edit(objDTOReference);
                objDTOReference = null;
            }
            objIUnitOfWork.commit();
            objIUnitOfWork = null;
            return 0;
        }

        public ReferenceCoreEntity GetByProfileID(string strProfileID)
        {
            ReferenceCoreEntity objReferenceCoreEntity = new ReferenceCoreEntity();
            Mugurtham.DTO.Profile.Reference objReference = new Mugurtham.DTO.Profile.Reference();
            IUnitOfWork objUOW = new UnitOfWork();
            using (objUOW as IDisposable)
                objReference = objUOW.RepositoryReference.GetAll().ToList().Where(p => p.ProfileID.Trim().ToLower() == strProfileID.Trim().ToLower()).FirstOrDefault();
            objUOW = null;
            if (objReference != null)
            {
                using (objReference as IDisposable)
                {
                    AssignEntityFromDTO(ref objReference, ref objReferenceCoreEntity);
                }
            }
            objReference = null;
            return objReferenceCoreEntity;
        }

        private int AssignDTOFromEntity(ref Mugurtham.DTO.Profile.Reference objDTOReference, ref Mugurtham.Core.Reference.ReferenceCoreEntity objReferenceCoreEntity)
        {
            objDTOReference.ContactNo = objReferenceCoreEntity.ContactNo;
            objDTOReference.NomineeName = objReferenceCoreEntity.NomineeName;
            objDTOReference.CreatedDate = DateTime.Now;
            objDTOReference.ModifiedDate = DateTime.Now;
            objDTOReference.ProfileID = objReferenceCoreEntity.ProfileID;
            return 0;
        }

        private int AssignEntityFromDTO(ref Mugurtham.DTO.Profile.Reference objDTOReference, ref Mugurtham.Core.Reference.ReferenceCoreEntity objReferenceCoreEntity)
        {
            objReferenceCoreEntity.ContactNo = objDTOReference.ContactNo;
            objReferenceCoreEntity.NomineeName = objDTOReference.NomineeName;
            objReferenceCoreEntity.ProfileID = objDTOReference.ProfileID;
            return 0;
        }
    }
}
