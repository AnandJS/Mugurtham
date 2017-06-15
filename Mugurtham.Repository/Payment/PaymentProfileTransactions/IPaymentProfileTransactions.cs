using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mugurtham.Repository.Payment.PaymentProfileTransactions
{
    public interface IPaymentProfileTransactions : IRepository<Mugurtham.DTO.Payment.PaymentProfileTransactionsModel>
    {
        IQueryable<Mugurtham.DTO.Payment.PaymentProfileTransactionsModel> GetPaymentProfileTransactionsByID(string ID);
    }
}
