using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mugurtham.Repository.Payment.PaymentGatewayTransactions
{
    public interface IPaymentGatewayTransactions : IRepository<Mugurtham.DTO.Payment.PaymentGatewayTransactionsModel>
    {
        IQueryable<Mugurtham.DTO.Payment.PaymentGatewayTransactionsModel> GetPaymentGatewayTransactionsByID(string ID);
    }
}
