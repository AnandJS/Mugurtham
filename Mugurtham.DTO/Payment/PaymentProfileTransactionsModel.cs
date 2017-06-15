using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Mugurtham.DTO.Payment
{
    [Table("PaymentProfileTransactions")]
    public class PaymentProfileTransactionsModel
    {
        public Decimal? PaymentAmount { get; set; }
        public Decimal? CreatedDate { get; set; }

        public DateTime PaymentDate { get; set; }
        public DateTime ValidityStartDate { get; set; }
        public DateTime ValidityExpiryDate { get; set; }
        [Key]
        public string TransactionID { get; set; }
        public string ProfileID { get; set; }
        public string SangamID { get; set; }
        public string PaymentMode { get; set; }
        public string PaymentFor { get; set; }
        public string PaymentNotes { get; set; }
        public string CreatedBy { get; set; }
    }
}
