﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Mugurtham.UOW;
using Mugurtham.Common.Utilities;

namespace Mugurtham.Core.Contact
{
    public class ContactCore
    {
        private Mugurtham.Core.Login.LoggedInUser _objLoggedInUser = null;

        public ContactCore(ref Mugurtham.Core.Login.LoggedInUser objLoggedInUser)
        {
            _objLoggedInUser = objLoggedInUser;
        }

        public int Add(ref Mugurtham.Core.Contact.ContactCoreEntity objContactCoreEntity)
        {
            try
            {
                IUnitOfWork objIUnitOfWork = new UnitOfWork(_objLoggedInUser.ConnectionStringAppKey);
                using (objIUnitOfWork as IDisposable)
                {
                    Mugurtham.DTO.Profile.Contact objDTOContact = new DTO.Profile.Contact();
                    using (objDTOContact as IDisposable)
                    {
                        AssignDTOFromEntity(ref objDTOContact, ref objContactCoreEntity);
                    }
                    objIUnitOfWork.RepositoryContact.Add(objDTOContact);
                    objDTOContact = null;
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

        public int Edit(ref Mugurtham.Core.Contact.ContactCoreEntity objContactCoreEntity)
        {
            IUnitOfWork objIUnitOfWork = new UnitOfWork(_objLoggedInUser.ConnectionStringAppKey);
            try
            {
                using (objIUnitOfWork as IDisposable)
                {
                    Mugurtham.DTO.Profile.Contact objDTOContact = new DTO.Profile.Contact();
                    using (objDTOContact as IDisposable)
                    {
                        AssignDTOFromEntity(ref objDTOContact, ref objContactCoreEntity);
                    }
                    objIUnitOfWork.RepositoryContact.Edit(objDTOContact);
                    objDTOContact = null;
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


        public ContactCoreEntity GetByProfileID(string strProfileID, string strLoggedInUserID)
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


        private ContactCoreEntity GetByProfileID(string strProfileID)
        {
            ContactCoreEntity objContactCoreEntity = new ContactCoreEntity();
            try
            {
                Mugurtham.DTO.Profile.Contact objContact = new Mugurtham.DTO.Profile.Contact();
                IUnitOfWork objUOW = new UnitOfWork(_objLoggedInUser.ConnectionStringAppKey);
                using (objUOW as IDisposable)
                    objContact = objUOW.RepositoryContact.GetAll().ToList().Where(p => p.ProfileID.Trim().ToLower() == strProfileID.Trim().ToLower()).FirstOrDefault();
                objUOW = null;
                if (objContact != null)
                {
                    using (objContact as IDisposable)
                    {
                        AssignEntityFromCore(ref objContact, ref objContactCoreEntity);
                    }
                }
                objContact = null;
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return objContactCoreEntity;
        }

        private int AssignDTOFromEntity(ref Mugurtham.DTO.Profile.Contact objDTOContact, ref Mugurtham.Core.Contact.ContactCoreEntity objContactCoreEntity)
        {
            try
            {
                objDTOContact.Name = objContactCoreEntity.Name;
                objDTOContact.Address = objContactCoreEntity.ResidentialAddress;
                objDTOContact.ConvinientTimeToCall = objContactCoreEntity.TimeToCall;
                objDTOContact.EMail = objContactCoreEntity.Email;
                objDTOContact.LandLineNumber = objContactCoreEntity.LandlineNumber;
                objDTOContact.MobileNumber = objContactCoreEntity.MobileNumber;
                objDTOContact.RelationShipWithMember = objContactCoreEntity.Relationship;
                objDTOContact.CreatedDate = DateTime.Now;
                objDTOContact.ModifiedDate = DateTime.Now;
                objDTOContact.ProfileID = objContactCoreEntity.ProfileID;
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }

        private int AssignEntityFromCore(ref Mugurtham.DTO.Profile.Contact objDTOContact, ref Mugurtham.Core.Contact.ContactCoreEntity objContactCoreEntity)
        {
            try
            {
                objContactCoreEntity.Name = objDTOContact.Name;
                objContactCoreEntity.ResidentialAddress = objDTOContact.Address;
                objContactCoreEntity.TimeToCall = objDTOContact.ConvinientTimeToCall;
                objContactCoreEntity.Email = objDTOContact.EMail;
                objContactCoreEntity.LandlineNumber = objDTOContact.LandLineNumber;
                objContactCoreEntity.MobileNumber = objDTOContact.MobileNumber;
                objContactCoreEntity.Relationship = objDTOContact.RelationShipWithMember;
                objContactCoreEntity.ProfileID = objDTOContact.ProfileID;
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }

        public int AssignEntityToEmpty(Mugurtham.Core.Contact.ContactCoreEntity objContactCoreEntity)
        {
            try
            {
                objContactCoreEntity.Name = string.Empty;
                objContactCoreEntity.ResidentialAddress = string.Empty;
                objContactCoreEntity.TimeToCall = string.Empty;
                objContactCoreEntity.Email = string.Empty;
                objContactCoreEntity.LandlineNumber = string.Empty;
                objContactCoreEntity.MobileNumber = string.Empty;
                objContactCoreEntity.Relationship = string.Empty;
                objContactCoreEntity.ProfileID = string.Empty;
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }
    }
}
