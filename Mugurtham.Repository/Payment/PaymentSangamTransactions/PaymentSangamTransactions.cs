using System.Linq;
using System.Data.Entity;

namespace Mugurtham.Repository.Payment.PaymentSangamTransactions
{
    

    public class PaymentSangamTransactions : GenericRepository<Mugurtham.DTO.Payment.PaymentSangamTransactionsModel>, IPaymentSangamTransactions
    {
        public PaymentSangamTransactions(DbContext objDbContext)
            : base(objDbContext)
        {
        }

        public IQueryable<Mugurtham.DTO.Payment.PaymentSangamTransactionsModel> GetPaymentSangamTransactionsByID(string ID)
        {
            return GetAll().Where(p => p.ID == ID);
        }
    }
}
