using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Mugurtham.DTO.Payment
{
    [Table("PaymentGatewayTransactions")]
    public class PaymentGatewayTransactionsModel
    {
        public Decimal? Amount { get; set; }
        public Decimal? MerAmount { get; set; }

        public DateTime TranDate { get; set; }
        public DateTime CreatedDate { get; set; }
        [Key]
        public string TransactionID { get; set; }
        public string OrderID { get; set; }
        public string TrackingID { get; set; }
        public string BankRefNo { get; set; }
        public string OrderStatus { get; set; }
        public string FailureMessage { get; set; }
        public string PaymentMode { get; set; }
        public string CardName { get; set; }
        public string StatusCode { get; set; }
        public string StatusMessage { get; set; }
        public string Currency { get; set; }
        public string BillingName { get; set; }
        public string BillingAddress { get; set; }
        public string BillingCity { get; set; }
        public string BillingState { get; set; }
        public string BillingCountry { get; set; }
        public string BillingTel { get; set; }
        public string BillingEmail { get; set; }
        public string DeliveryName { get; set; }
        public string DeliveryAddress { get; set; }
        public string DeliveryCity { get; set; }
        public string DeliveryState { get; set; }
        public string BillingZip { get; set; }
        public string DeliveryZip { get; set; }
        public string DeliveryCountry { get; set; }
        public string DeliveryTel { get; set; }
        public string MerchantParam1 { get; set; }
        public string MerchantParam2 { get; set; }
        public string MerchantParam3 { get; set; }
        public string MerchantParam4 { get; set; }
        public string MerchantParam5 { get; set; }
        public string Vault { get; set; }
        public string OfferType { get; set; }
        public string OfferCode { get; set; }
        public string DiscountValue { get; set; }
        public string ECIValue { get; set; }
        public string Retry { get; set; }
        public string ResponseCode { get; set; }
        public string BillingNotes { get; set; }
        public string BinCountry { get; set; }
        public string EncryptedText { get; set; }
        public string CreatedBy { get; set; }
    }
}
