using System;
using System.Collections.Generic;
using System.Linq;
using Mugurtham.UOW;
using Mugurtham.Common.Utilities;
using Mugurtham.Core.Profile.View;
using Mugurtham.Core.Profile.Photo;
using System.Data.SqlClient;
using System.Data;
using CCA.Util;
using System.Collections.Specialized;
using Mugurtham.DTO.Payment;

namespace Mugurtham.Core.Payment.PaymentGatewayTransactions
{
    public class PaymentGatewayTransactionsCore
    {
        Mugurtham.Core.Login.LoggedInUser _objLoggedInUser = null;
        public PaymentGatewayTransactionsCore(Mugurtham.Core.Login.LoggedInUser objLoggedInUser)
        {
            _objLoggedInUser = objLoggedInUser;
        }

        public int Add(string EncryptedString)
        {
            try
            {
                PaymentGatewayTransactionsCoreEntity objPaymentGatewayTransactionsCoreEntity = new PaymentGatewayTransactionsCoreEntity();
                using (objPaymentGatewayTransactionsCoreEntity as IDisposable)
                {
                    getPaymentGatewayTransactionsCoreEntity(EncryptedString, ref objPaymentGatewayTransactionsCoreEntity);
                    PaymentGatewayTransactionsModel objPaymentGatewayTransactionsModel = new PaymentGatewayTransactionsModel();
                    using (objPaymentGatewayTransactionsModel as IDisposable)
                    {
                        AssignModelFromEntity(ref objPaymentGatewayTransactionsCoreEntity, ref objPaymentGatewayTransactionsModel);
                        IUnitOfWork objIUnitOfWorkAdd = new UnitOfWork(_objLoggedInUser.ConnectionStringAppKey);
                        using (objIUnitOfWorkAdd as IDisposable)
                        {
                            objIUnitOfWorkAdd.RepositoryPaymentGatewayTransactions.Add(objPaymentGatewayTransactionsModel);
                            objIUnitOfWorkAdd.commit();
                        }
                        objIUnitOfWorkAdd = null;
                    }
                    objPaymentGatewayTransactionsModel = null;
                }
                objPaymentGatewayTransactionsCoreEntity = null;
            }
            catch(Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }


        private int getPaymentGatewayTransactionsCoreEntity(string EncryptedString, ref PaymentGatewayTransactionsCoreEntity objPaymentGatewayTransactionsCoreEntity)
        {
            try
            {
                objPaymentGatewayTransactionsCoreEntity.TransactionID = Helpers.primaryKey;
                string workingKey = "56FDB199FAF2C31B82E95CC1551BB423";//put in the 32bit alpha numeric key in the quotes provided here
                CCACrypto ccaCrypto = new CCACrypto();
                string encResponse = ccaCrypto.Decrypt(EncryptedString, workingKey);
                NameValueCollection Params = new NameValueCollection();
                string[] segments = encResponse.Split('&');
                foreach (string seg in segments)
                {
                    string[] parts = seg.Split('=');
                    if (parts.Length > 0)
                    {
                        string Key = parts[0].Trim();
                        string Value = parts[1].Trim();
                        Params.Add(Key, Value);
                    }
                }
                for (int i = 0; i < Params.Count; i++)
                {
                    //Helpers.LogMessageInFlatFile(Params.Keys[i] + " = " + Params[i] + "<br>");
                    switch (Params.Keys[i])
                    {
                        case "order_id":
                            objPaymentGatewayTransactionsCoreEntity.OrderID = Params[i];
                            break;
                        case "tracking_id":
                            objPaymentGatewayTransactionsCoreEntity.TrackingID = Params[i];
                            break;
                        case "bank_ref_no":
                            objPaymentGatewayTransactionsCoreEntity.BankRefNo = Params[i];
                            break;
                        case "order_status":
                            objPaymentGatewayTransactionsCoreEntity.OrderStatus = Params[i];
                            break;
                        case "failure_message":
                            objPaymentGatewayTransactionsCoreEntity.FailureMessage = Params[i];
                            break;
                        case "payment_mode":
                            objPaymentGatewayTransactionsCoreEntity.PaymentMode = Params[i];
                            break;
                        case "card_name":
                            objPaymentGatewayTransactionsCoreEntity.CardName = Params[i];
                            break;
                        case "status_code":
                            objPaymentGatewayTransactionsCoreEntity.StatusCode = Params[i];
                            break;
                        case "status_message":
                            objPaymentGatewayTransactionsCoreEntity.StatusMessage = Params[i];
                            break;
                        case "currency":
                            objPaymentGatewayTransactionsCoreEntity.Currency = Params[i];
                            break;
                        case "amount":
                            {
                                decimal amount = 0;
                                if (!string.IsNullOrEmpty(Params[i]))
                                    amount = Convert.ToDecimal(Params[i]);
                                objPaymentGatewayTransactionsCoreEntity.Amount = amount;
                            }
                            break;
                        case "billing_name":
                            objPaymentGatewayTransactionsCoreEntity.BillingName = Params[i];
                            break;
                        case "billing_address":
                            objPaymentGatewayTransactionsCoreEntity.BillingAddress = Params[i];
                            break;
                        case "billing_city":
                            objPaymentGatewayTransactionsCoreEntity.BillingCity = Params[i];
                            break;
                        case "billing_state":
                            objPaymentGatewayTransactionsCoreEntity.BillingState = Params[i];
                            break;
                        case "billing_zip":
                            objPaymentGatewayTransactionsCoreEntity.BillingZip = Params[i];
                            break;
                        case "billing_country":
                            objPaymentGatewayTransactionsCoreEntity.BillingCountry = Params[i];
                            break;
                        case "billing_tel":
                            objPaymentGatewayTransactionsCoreEntity.BillingTel = Params[i];
                            break;
                        case "billing_email":
                            objPaymentGatewayTransactionsCoreEntity.BillingEmail = Params[i];
                            break;
                        case "delivery_name":
                            objPaymentGatewayTransactionsCoreEntity.DeliveryName = Params[i];
                            break;
                        case "delivery_address":
                            objPaymentGatewayTransactionsCoreEntity.DeliveryAddress = Params[i];
                            break;
                        case "delivery_city":
                            objPaymentGatewayTransactionsCoreEntity.DeliveryCity = Params[i];
                            break;
                        case "delivery_state":
                            objPaymentGatewayTransactionsCoreEntity.DeliveryState = Params[i];
                            break;
                        case "delivery_zip":
                            objPaymentGatewayTransactionsCoreEntity.DeliveryZip = Params[i];
                            break;
                        case "delivery_country":
                            objPaymentGatewayTransactionsCoreEntity.DeliveryCountry = Params[i];
                            break;
                        case "delivery_tel":
                            objPaymentGatewayTransactionsCoreEntity.DeliveryTel = Params[i];
                            break;
                        case "merchant_param1":
                            objPaymentGatewayTransactionsCoreEntity.MerchantParam1 = Params[i];
                            break;
                        case "merchant_param2":
                            objPaymentGatewayTransactionsCoreEntity.MerchantParam2 = Params[i];
                            break;
                        case "merchant_param3":
                            objPaymentGatewayTransactionsCoreEntity.MerchantParam3 = Params[i];
                            break;
                        case "merchant_param4":
                            objPaymentGatewayTransactionsCoreEntity.MerchantParam4 = Params[i];
                            break;
                        case "merchant_param5":
                            objPaymentGatewayTransactionsCoreEntity.MerchantParam5 = Params[i];
                            break;
                        case "vault":
                            objPaymentGatewayTransactionsCoreEntity.Vault = Params[i];
                            break;
                        case "OfferType":
                            objPaymentGatewayTransactionsCoreEntity.OfferType = Params[i];
                            break;
                        case "OfferCode":
                            objPaymentGatewayTransactionsCoreEntity.OfferCode = Params[i];
                            break;
                        case "discount_value":
                            objPaymentGatewayTransactionsCoreEntity.DiscountValue = Params[i];
                            break;
                        case "ECIValue":
                            objPaymentGatewayTransactionsCoreEntity.ECIValue = Params[i];
                            break;

                        case "retry":
                            objPaymentGatewayTransactionsCoreEntity.Retry = Params[i];
                            break;
                        case "response_code":
                            objPaymentGatewayTransactionsCoreEntity.ResponseCode = Params[i];
                            break;
                        case "billing_notes":
                            objPaymentGatewayTransactionsCoreEntity.BillingNotes = Params[i];
                            break;
                       /* case "trans_date":
                            {
                                DateTime dtTarnsdate;
                                if (!string.IsNullOrEmpty(Params[i]))
                                {
                                    dtTarnsdate = Convert.ToDateTime(Params[i]);
                                    objPaymentGatewayTransactionsCoreEntity.TranDate = dtTarnsdate;
                                }
                                //objPaymentGatewayTransactionsCoreEntity.TranDate = Params[i];
                            }
                            break;*/
                        case "bin_country":
                            objPaymentGatewayTransactionsCoreEntity.BillingCountry = Params[i];
                            break;
                    }
                }
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }

        private int AssignModelFromEntity(
                                            ref PaymentGatewayTransactionsCoreEntity objPaymentGatewayTransactionsEntity,
                                            ref PaymentGatewayTransactionsModel objPaymentGatewayTransactionsModel
                                       )
        {
            try
            {

                objPaymentGatewayTransactionsModel.Amount = objPaymentGatewayTransactionsEntity.Amount;
                objPaymentGatewayTransactionsModel.BankRefNo = objPaymentGatewayTransactionsEntity.BankRefNo;
                objPaymentGatewayTransactionsModel.BillingAddress = objPaymentGatewayTransactionsEntity.BillingAddress;
                objPaymentGatewayTransactionsModel.BillingCity = objPaymentGatewayTransactionsEntity.BillingCity;
                objPaymentGatewayTransactionsModel.BillingCountry = objPaymentGatewayTransactionsEntity.BillingCountry;
                objPaymentGatewayTransactionsModel.BillingEmail = objPaymentGatewayTransactionsEntity.BillingEmail;
                objPaymentGatewayTransactionsModel.BillingName = objPaymentGatewayTransactionsEntity.BillingName;
                objPaymentGatewayTransactionsModel.BillingNotes = objPaymentGatewayTransactionsEntity.BillingNotes;
                objPaymentGatewayTransactionsModel.BillingState = objPaymentGatewayTransactionsEntity.BillingState;
                objPaymentGatewayTransactionsModel.BillingTel = objPaymentGatewayTransactionsEntity.BillingTel;
                objPaymentGatewayTransactionsModel.BillingZip = objPaymentGatewayTransactionsEntity.BillingZip;
                objPaymentGatewayTransactionsModel.BinCountry = objPaymentGatewayTransactionsEntity.BinCountry;
                objPaymentGatewayTransactionsModel.CardName = objPaymentGatewayTransactionsEntity.CardName;
                objPaymentGatewayTransactionsModel.CreatedBy = objPaymentGatewayTransactionsEntity.CreatedBy;
                objPaymentGatewayTransactionsModel.CreatedDate = objPaymentGatewayTransactionsEntity.CreatedDate;
                objPaymentGatewayTransactionsModel.Currency = objPaymentGatewayTransactionsEntity.Currency;
                objPaymentGatewayTransactionsModel.DeliveryAddress = objPaymentGatewayTransactionsEntity.DeliveryAddress;
                objPaymentGatewayTransactionsModel.DeliveryCity = objPaymentGatewayTransactionsEntity.DeliveryCity;
                objPaymentGatewayTransactionsModel.DeliveryCountry = objPaymentGatewayTransactionsEntity.DeliveryCountry;
                objPaymentGatewayTransactionsModel.DeliveryName = objPaymentGatewayTransactionsEntity.DeliveryName;
                objPaymentGatewayTransactionsModel.DeliveryState = objPaymentGatewayTransactionsEntity.DeliveryState;
                objPaymentGatewayTransactionsModel.DeliveryTel = objPaymentGatewayTransactionsEntity.DeliveryTel;
                objPaymentGatewayTransactionsModel.DeliveryZip = objPaymentGatewayTransactionsEntity.DeliveryZip;
                objPaymentGatewayTransactionsModel.DiscountValue = objPaymentGatewayTransactionsEntity.DiscountValue;
                objPaymentGatewayTransactionsModel.ECIValue = objPaymentGatewayTransactionsEntity.ECIValue;
                objPaymentGatewayTransactionsModel.EncryptedText = objPaymentGatewayTransactionsEntity.EncryptedText;
                objPaymentGatewayTransactionsModel.FailureMessage = objPaymentGatewayTransactionsEntity.FailureMessage;
                objPaymentGatewayTransactionsModel.TransactionID = objPaymentGatewayTransactionsEntity.TransactionID;
                objPaymentGatewayTransactionsModel.MerAmount = objPaymentGatewayTransactionsEntity.MerAmount;
                objPaymentGatewayTransactionsModel.MerchantParam1 = objPaymentGatewayTransactionsEntity.MerchantParam1;
                objPaymentGatewayTransactionsModel.MerchantParam2 = objPaymentGatewayTransactionsEntity.MerchantParam2;
                objPaymentGatewayTransactionsModel.MerchantParam3 = objPaymentGatewayTransactionsEntity.MerchantParam3;
                objPaymentGatewayTransactionsModel.MerchantParam4 = objPaymentGatewayTransactionsEntity.MerchantParam4;
                objPaymentGatewayTransactionsModel.MerchantParam5 = objPaymentGatewayTransactionsEntity.MerchantParam5;
                objPaymentGatewayTransactionsModel.OfferCode = objPaymentGatewayTransactionsEntity.OfferCode;
                objPaymentGatewayTransactionsModel.OfferType = objPaymentGatewayTransactionsEntity.OfferType;
                objPaymentGatewayTransactionsModel.OrderID = objPaymentGatewayTransactionsEntity.OrderID;
                objPaymentGatewayTransactionsModel.OrderStatus = objPaymentGatewayTransactionsEntity.OrderStatus;
                objPaymentGatewayTransactionsModel.PaymentMode = objPaymentGatewayTransactionsEntity.PaymentMode;
                objPaymentGatewayTransactionsModel.ResponseCode = objPaymentGatewayTransactionsEntity.ResponseCode;
                objPaymentGatewayTransactionsModel.Retry = objPaymentGatewayTransactionsEntity.Retry;
                objPaymentGatewayTransactionsModel.StatusCode = objPaymentGatewayTransactionsEntity.StatusCode;
                objPaymentGatewayTransactionsModel.StatusMessage = objPaymentGatewayTransactionsEntity.StatusMessage;
                objPaymentGatewayTransactionsModel.TrackingID = objPaymentGatewayTransactionsEntity.TrackingID;
                objPaymentGatewayTransactionsModel.TranDate = objPaymentGatewayTransactionsEntity.TranDate;
                objPaymentGatewayTransactionsModel.TransactionID = objPaymentGatewayTransactionsEntity.TransactionID;
                objPaymentGatewayTransactionsModel.Vault = objPaymentGatewayTransactionsEntity.Vault;
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }
    }
}
