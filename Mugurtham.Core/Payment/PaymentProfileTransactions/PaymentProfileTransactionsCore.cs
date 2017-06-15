using Mugurtham.Common.Utilities;
using Mugurtham.Core.Payment.PaymentGatewayTransactions;
using Mugurtham.DTO.Payment;
using Mugurtham.UOW;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mugurtham.Core.Payment.PaymentProfileTransactions
{
    public class PaymentProfileTransactionsCore
    {
        Mugurtham.Core.Login.LoggedInUser _objLoggedInUser = null;
        public PaymentProfileTransactionsCore(Mugurtham.Core.Login.LoggedInUser objLoggedInUser)
        {
            _objLoggedInUser = objLoggedInUser;
        }

        public int Add(ref PaymentGatewayTransactionsCoreEntity objPaymentGatewayTransactionsCoreEntity)
        {
            try
            {
                PaymentProfileTransactionsCoreEntity objPaymentProfileTransactionsCoreEntity = new PaymentProfileTransactions.PaymentProfileTransactionsCoreEntity();
                using (objPaymentProfileTransactionsCoreEntity as IDisposable)
                {
                    AssignProfileTransactionFromGatewayTransaction(ref objPaymentGatewayTransactionsCoreEntity, ref objPaymentProfileTransactionsCoreEntity);
                    PaymentProfileTransactionsModel objPaymentProfileTransactionsModel = new PaymentProfileTransactionsModel();
                    using (objPaymentProfileTransactionsModel as IDisposable)
                    {
                        AssignModelFromEntity(ref objPaymentProfileTransactionsCoreEntity, ref objPaymentProfileTransactionsModel);
                        IUnitOfWork objIUnitOfWorkAdd = new UnitOfWork(_objLoggedInUser.ConnectionStringAppKey);
                        using (objIUnitOfWorkAdd as IDisposable)
                        {
                            objIUnitOfWorkAdd.RepositoryPaymentProfileTransactions.Add(objPaymentProfileTransactionsModel);
                            objIUnitOfWorkAdd.commit();
                        }
                        objIUnitOfWorkAdd = null;
                    }
                    objPaymentProfileTransactionsModel = null;
                }
                objPaymentProfileTransactionsCoreEntity = null;
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }


        public int GetAllPaymentTransactions(ref List<PaymentProfileTransactionsCoreEntity> objPaymentProfileTransactionsCoreEntityList)
        {
            try
            {
                IUnitOfWork objIUnitOfWork = new UnitOfWork(_objLoggedInUser.ConnectionStringAppKey);
                using (objIUnitOfWork as IDisposable)
                {
                    foreach (PaymentProfileTransactionsModel objPaymentProfileTransactionsModel in objIUnitOfWork.RepositoryPaymentProfileTransactions.GetAll().OrderByDescending(x => x.PaymentDate).ToList())
                    {
                        PaymentProfileTransactionsModel _objPaymentProfileTransactionsModel = objPaymentProfileTransactionsModel;
                        using (_objPaymentProfileTransactionsModel as IDisposable)
                        {
                            PaymentProfileTransactionsCoreEntity objPaymentProfileTransactionsCoreEntity = new PaymentProfileTransactionsCoreEntity();
                            using (objPaymentProfileTransactionsCoreEntity as IDisposable)
                            {
                                AssignEntityFromModel(ref objPaymentProfileTransactionsCoreEntity, ref _objPaymentProfileTransactionsModel);
                                objPaymentProfileTransactionsCoreEntityList.Add(objPaymentProfileTransactionsCoreEntity);
                            }
                            objPaymentProfileTransactionsCoreEntity = null;
                        }
                        _objPaymentProfileTransactionsModel = null;
                    }
                }
                objIUnitOfWork = null;
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }

        private int AssignProfileTransactionFromGatewayTransaction
                          (
                            ref PaymentGatewayTransactionsCoreEntity objPaymentGatewayTransactionsCoreEntity,
                            ref PaymentProfileTransactionsCoreEntity objPaymentProfileTransactionsCoreEntity
                          )
        {
            try
            {
                objPaymentProfileTransactionsCoreEntity.CreatedBy = _objLoggedInUser.LoginID;
                objPaymentProfileTransactionsCoreEntity.CreatedDate = DateTime.Now;
                objPaymentProfileTransactionsCoreEntity.PaymentAmount = objPaymentGatewayTransactionsCoreEntity.MerAmount;
                objPaymentProfileTransactionsCoreEntity.PaymentDate = objPaymentGatewayTransactionsCoreEntity.TranDate;
                objPaymentProfileTransactionsCoreEntity.PaymentFor = objPaymentGatewayTransactionsCoreEntity.MerchantParam2;
                objPaymentProfileTransactionsCoreEntity.PaymentMode = Constants.MEMBERSHIPONLINEPAYMENT;
                objPaymentProfileTransactionsCoreEntity.PaymentNotes = objPaymentGatewayTransactionsCoreEntity.MerchantParam3;
                objPaymentProfileTransactionsCoreEntity.ProfileID = objPaymentGatewayTransactionsCoreEntity.MerchantParam1;
                objPaymentProfileTransactionsCoreEntity.TransactionID = objPaymentGatewayTransactionsCoreEntity.TransactionID;
                objPaymentProfileTransactionsCoreEntity.ValidityExpiryDate = objPaymentGatewayTransactionsCoreEntity.TranDate.AddMonths(Constants.MEMBERSHIPFORSIXMONTHS);
                objPaymentProfileTransactionsCoreEntity.SangamID = _objLoggedInUser.sangamID;
            }
            catch(Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }

        private int AssignModelFromEntity
                        (
                            ref PaymentProfileTransactionsCoreEntity objPaymentProfileTransactionsCoreEntity,
                            ref PaymentProfileTransactionsModel objPaymentProfileTransactionsModel
                        )
        {
            try
            {
                objPaymentProfileTransactionsModel.CreatedBy = objPaymentProfileTransactionsCoreEntity.CreatedBy;
                objPaymentProfileTransactionsModel.CreatedDate = objPaymentProfileTransactionsCoreEntity.CreatedDate;
                objPaymentProfileTransactionsModel.PaymentAmount = objPaymentProfileTransactionsCoreEntity.PaymentAmount;
                objPaymentProfileTransactionsModel.PaymentDate = objPaymentProfileTransactionsCoreEntity.PaymentDate;
                objPaymentProfileTransactionsModel.PaymentFor = objPaymentProfileTransactionsCoreEntity.PaymentFor;
                objPaymentProfileTransactionsModel.PaymentMode = objPaymentProfileTransactionsCoreEntity.PaymentMode;
                objPaymentProfileTransactionsModel.PaymentNotes = objPaymentProfileTransactionsCoreEntity.PaymentNotes;
                objPaymentProfileTransactionsModel.ProfileID = objPaymentProfileTransactionsCoreEntity.ProfileID;
                objPaymentProfileTransactionsModel.SangamID = objPaymentProfileTransactionsCoreEntity.SangamID;
                objPaymentProfileTransactionsModel.TransactionID = objPaymentProfileTransactionsCoreEntity.TransactionID;
                objPaymentProfileTransactionsModel.ValidityExpiryDate = objPaymentProfileTransactionsCoreEntity.ValidityExpiryDate;
                objPaymentProfileTransactionsModel.ValidityStartDate = objPaymentProfileTransactionsCoreEntity.ValidityStartDate;
            }
            catch(Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }

        private int AssignEntityFromModel
                       (
                           ref PaymentProfileTransactionsCoreEntity objPaymentProfileTransactionsCoreEntity,
                           ref PaymentProfileTransactionsModel objPaymentProfileTransactionsModel
                       )
        {
            try
            {
                objPaymentProfileTransactionsCoreEntity.CreatedBy = objPaymentProfileTransactionsModel.CreatedBy;
                objPaymentProfileTransactionsCoreEntity.CreatedDate = objPaymentProfileTransactionsModel.CreatedDate;
                objPaymentProfileTransactionsCoreEntity.PaymentAmount = objPaymentProfileTransactionsModel.PaymentAmount;
                objPaymentProfileTransactionsCoreEntity.PaymentDate = objPaymentProfileTransactionsModel.PaymentDate;
                objPaymentProfileTransactionsCoreEntity.PaymentFor = objPaymentProfileTransactionsModel.PaymentFor;
                objPaymentProfileTransactionsCoreEntity.PaymentMode = objPaymentProfileTransactionsModel.PaymentMode;
                objPaymentProfileTransactionsCoreEntity.PaymentNotes = objPaymentProfileTransactionsModel.PaymentNotes;
                objPaymentProfileTransactionsCoreEntity.ProfileID = objPaymentProfileTransactionsModel.ProfileID;
                objPaymentProfileTransactionsCoreEntity.SangamID = objPaymentProfileTransactionsModel.SangamID;
                objPaymentProfileTransactionsCoreEntity.TransactionID = objPaymentProfileTransactionsModel.TransactionID;
                objPaymentProfileTransactionsCoreEntity.ValidityExpiryDate = objPaymentProfileTransactionsModel.ValidityExpiryDate;
                objPaymentProfileTransactionsCoreEntity.ValidityStartDate = objPaymentProfileTransactionsModel.ValidityStartDate;
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }

    }
}
