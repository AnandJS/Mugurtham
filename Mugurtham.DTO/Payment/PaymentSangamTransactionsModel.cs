using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Mugurtham.DTO.Payment
{
    [Table("PaymentSangamTransactions")]
    public class PaymentSangamTransactionsModel
    {
        public Decimal? PaymentAmountToSangam { get; set; }

        public DateTime PaymentDate { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime ModifiedDate { get; set; }
        [Key]
        public string ID { get; set; }
        public string TransactionID { get; set; }
        public string PaymentMode { get; set; }
        public string PaymentConfirmationDetails { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
    }
}
