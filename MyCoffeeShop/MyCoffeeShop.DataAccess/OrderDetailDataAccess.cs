using Microsoft.Practices.EnterpriseLibrary.Data;
using MyCoffeeShop.DomainModel;
using System.Data;
using System.Data.Common;
using System.Threading.Tasks;
using System;

namespace MyCoffeeShop.DataAccess
{
    public class OrderDetailDataAccess : IOrderDetailDataAccess
    {
        private readonly Database coffeeDatabase;

        public OrderDetailDataAccess(ICoffeeShopDatabaseFactory factory)
        {
            this.coffeeDatabase = factory.GetCoffeeDatabase();
        }

        public async Task<int> SaveOrderDetail(OrderDetail orderDetail)
        {
            using (DbCommand command = this.coffeeDatabase.GetStoredProcCommand("dbo.spSaveOrderDetail"))
            {
                this.coffeeDatabase.AddInParameter(command, "@CoffeeId", DbType.Int32, orderDetail.CofeeId);
                this.coffeeDatabase.AddInParameter(command, "@Quantity", DbType.Int32, orderDetail.Quantity);
                this.coffeeDatabase.AddInParameter(command, "@OrderId", DbType.Guid, orderDetail.OrderId);
                this.coffeeDatabase.AddInParameter(command, "@Price", DbType.Decimal, orderDetail.Price);

                Task<int> execNonQueryTask =
                Task<int>.Factory.FromAsync(this.coffeeDatabase.BeginExecuteNonQuery, this.coffeeDatabase.EndExecuteNonQuery, command, null);
                return await execNonQueryTask;
            }
        }
    }
}
