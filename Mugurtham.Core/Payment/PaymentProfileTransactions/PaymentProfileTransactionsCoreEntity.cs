using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mugurtham.Core.Payment.PaymentProfileTransactions
{
    public class PaymentProfileTransactionsCoreEntity
    {
        public Decimal? PaymentAmount { get; set; }

        public DateTime? CreatedDate { get; set; }
        public DateTime? PaymentDate { get; set; }
        public DateTime? ValidityStartDate { get; set; }
        public DateTime? ValidityExpiryDate { get; set; }

        public string TransactionID { get; set; }
        public string ProfileID { get; set; }
        public string SangamID { get; set; }
        public string PaymentMode { get; set; }
        public string PaymentFor { get; set; }
        public string PaymentNotes { get; set; }
        public string CreatedBy { get; set; }
    }
}
