using System.Linq;
using System.Data.Entity;

namespace Mugurtham.Repository.Payment.PaymentProfileTransactions
{
    public class PaymentProfileTransactions : GenericRepository<Mugurtham.DTO.Payment.PaymentProfileTransactionsModel>, IPaymentProfileTransactions
    {
        public PaymentProfileTransactions(DbContext objDbContext)
            : base(objDbContext)
        {
        }

        public IQueryable<Mugurtham.DTO.Payment.PaymentProfileTransactionsModel> GetPaymentProfileTransactionsByID(string ID)
        {
            return GetAll().Where(p => p.TransactionID == ID);

        }
    }
}
