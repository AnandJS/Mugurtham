using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mugurtham.Repository.Payment.PaymentSangamTransactions
{
    public interface IPaymentSangamTransactions : IRepository<Mugurtham.DTO.Payment.PaymentSangamTransactionsModel>
    {
        IQueryable<Mugurtham.DTO.Payment.PaymentSangamTransactionsModel> GetPaymentSangamTransactionsByID(string ID);
    }
}
