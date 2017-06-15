using System.Linq;
using System.Data.Entity;


namespace Mugurtham.Repository.Payment.PaymentGatewayTransactions
{
    public class PaymentGatewayTransactions : GenericRepository<Mugurtham.DTO.Payment.PaymentGatewayTransactionsModel>, IPaymentGatewayTransactions
    {
        public PaymentGatewayTransactions(DbContext objDbContext)
            : base(objDbContext)
        {
        }

        public IQueryable<Mugurtham.DTO.Payment.PaymentGatewayTransactionsModel> GetPaymentGatewayTransactionsByID(string ID)
        {
            return GetAll().Where(p => p.TransactionID == ID);
        }
    }
}
