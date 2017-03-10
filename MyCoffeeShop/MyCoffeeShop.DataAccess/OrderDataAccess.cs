using Microsoft.Practices.EnterpriseLibrary.Data;
using MyCoffeeShop.DomainModel;
using System.Data;
using System.Data.Common;
using System.Threading.Tasks;

namespace MyCoffeeShop.DataAccess
{
    public class OrderDataAccess : IOrderDataAccess
    {
        private readonly Database coffeeDatabase;
        public OrderDataAccess(ICoffeeShopDatabaseFactory factory)
        {
            this.coffeeDatabase = factory.GetCoffeeDatabase();
        }
        /*
         * ,@City			NVARCHAR(50)			  
			  ,@Email			NVARCHAR(50)
			  ,@FirstName		NVARCHAR(50)
			  ,@LastName		NVARCHAR(50)			  
			  ,@OrderTotal		DECIMAL(4,2)
			  ,@PhoneNumber		NVARCHAR(25)
			  ,@County			NVARCHAR(50)
			  ,@PostCode		NVARCHAR(10)

         */
        public async Task<int> SaveOrder(Order order)
        {
            using (DbCommand command = this.coffeeDatabase.GetStoredProcCommand("dbo.spSaveOrder"))
            {
                this.coffeeDatabase.AddInParameter(command, "@OrderId", DbType.Guid, order.OrderId);
                this.coffeeDatabase.AddInParameter(command, "@AddressLine1", DbType.String, order.AddressLine1);
                this.coffeeDatabase.AddInParameter(command, "@AddressLine2", DbType.String, order.AddressLine2);
                this.coffeeDatabase.AddInParameter(command, "@City", DbType.String, order.City);
                this.coffeeDatabase.AddInParameter(command, "@Email", DbType.String, order.Email);
                this.coffeeDatabase.AddInParameter(command, "@FirstName", DbType.String, order.FirstName);
                this.coffeeDatabase.AddInParameter(command, "@LastName", DbType.String, order.LastName);
                this.coffeeDatabase.AddInParameter(command, "@OrderTotal", DbType.Decimal, order.OrderTotal);
                this.coffeeDatabase.AddInParameter(command, "@PhoneNumber", DbType.String, order.PhoneNumber);                
                this.coffeeDatabase.AddInParameter(command, "@County", DbType.String, order.County);
                this.coffeeDatabase.AddInParameter(command, "@PostCode", DbType.String, order.PostCode);

                Task<int> execNonQueryTask =
                Task<int>.Factory.FromAsync(this.coffeeDatabase.BeginExecuteNonQuery, this.coffeeDatabase.EndExecuteNonQuery, command, null);
                return await execNonQueryTask;
            }
        }
    }
}
