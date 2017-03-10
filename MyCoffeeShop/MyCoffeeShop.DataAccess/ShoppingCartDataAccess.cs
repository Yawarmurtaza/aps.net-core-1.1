using Microsoft.Practices.EnterpriseLibrary.Data;
using MyCoffeeShop.DomainModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Threading.Tasks;

namespace MyCoffeeShop.DataAccess
{
    public class ShoppingBasketDataAccess : IShoppingBasketDataAccess
    {
        private readonly Database coffeeDatabase;

        private readonly ICoffeeDataAccess coffeeDataAccess;

        public ShoppingBasketDataAccess(ICoffeeShopDatabaseFactory factory, ICoffeeDataAccess coffeeDataAccess)
        {
            this.coffeeDatabase = factory.GetCoffeeDatabase();
            this.coffeeDataAccess = coffeeDataAccess;
        }              

        public async Task<int> ClearShoppingBasket(Guid shoppingBasketNumber)
        {
            using (DbCommand command = this.coffeeDatabase.GetStoredProcCommand("dbo.spClearAllItemsFromBasket"))
            {
                this.coffeeDatabase.AddInParameter(command, "@shoppingBasketNumber", DbType.Guid, shoppingBasketNumber);
                Task<int> execNonQueryTask =
                 Task<int>.Factory.FromAsync(this.coffeeDatabase.BeginExecuteNonQuery, this.coffeeDatabase.EndExecuteNonQuery, command, null);
                return await execNonQueryTask;
            }
        }

        public async Task<IEnumerable<ShoppingBasketItem>> GetShoppingBasketItemsForShoppingBasket(Guid shoppingBasketNumber)
        {
            IList<ShoppingBasketItem> shoppingItems;
            using (DbCommand command = this.coffeeDatabase.GetStoredProcCommand("dbo.spGetShoppingBasketItemsForShoppingBasket"))
            {
                this.coffeeDatabase.AddInParameter(command, "@shoppingBasketNumber", DbType.Guid, shoppingBasketNumber);
                Task<IDataReader> readerTask =
                   Task<IDataReader>.Factory.FromAsync(this.coffeeDatabase.BeginExecuteReader, this.coffeeDatabase.EndExecuteReader, command, null);
                using (IDataReader reader = await readerTask)
                {
                    shoppingItems = new List<ShoppingBasketItem>();
                    while (reader.Read())
                    {
                        ShoppingBasketItem shoppingItem = new ShoppingBasketItem();

                        shoppingItem.Quantity = int.Parse(reader["Quantity"].ToString());
                        shoppingItem.ShoppingBasketItemId = int.Parse(reader["ShoppingBasketItem_id"].ToString());
                        shoppingItem.ShoppingBasketId = Guid.Parse(reader["ShoppingBasketNumber"].ToString());

                        shoppingItem.Coffee = new Coffee();
                        shoppingItem.Coffee.Id = int.Parse(reader["CoffeeId"].ToString());

                        shoppingItem.Coffee.CategoryId = int.Parse(reader["CategoryId"].ToString());
                        shoppingItem.Coffee.ImageThumbnailUrl = reader["ImageThumbnailUrl"].ToString();
                        shoppingItem.Coffee.ImageUrl = reader["ImageUrl"].ToString();
                        shoppingItem.Coffee.InStock = bool.Parse(reader["InStock"].ToString());
                        shoppingItem.Coffee.IsCoffeeOfTheWeek = bool.Parse(reader["IsCoffeeOfTheWeek"].ToString());
                        shoppingItem.Coffee.LongDesc = reader["LongDesc"].ToString();
                        shoppingItem.Coffee.Name = reader["Name"].ToString();
                        shoppingItem.Coffee.ShortDesc = reader["ShortDesc"].ToString();
                        shoppingItem.Coffee.Price = decimal.Parse(reader["Price"].ToString());

                        shoppingItems.Add(shoppingItem);
                    }
                }
            }

            return shoppingItems;
        }

        public async Task<decimal> GetTotalAsync(Guid shoppingBasketNumber)
        {
            using (DbCommand command = this.coffeeDatabase.GetStoredProcCommand("dbo.spGetShoppingBasketTotal"))
            {
                this.coffeeDatabase.AddInParameter(command, "@shoppingBasketNumber", DbType.Guid, shoppingBasketNumber);
                
                Task<object> executeScalarTask =
                  Task<object>.Factory.FromAsync(this.coffeeDatabase.BeginExecuteScalar, this.coffeeDatabase.EndExecuteScalar, command, null);
                object resultObj = await executeScalarTask;
                if (!string.IsNullOrEmpty(resultObj.ToString()))
                {                    
                    decimal shoppingBasketTotal = decimal.Parse(resultObj.ToString());
                    return shoppingBasketTotal;
                }
                else
                {
                    return 0.00m;
                }
            }
        }

        public async Task<int> UpdateShoppingBasketItem(ShoppingBasketItem shoppingItem)
        {
            using (DbCommand command = this.coffeeDatabase.GetStoredProcCommand("dbo.spUpdateShoppingBasketItem"))
            {
                this.coffeeDatabase.AddInParameter(command, "@id", DbType.Int32, shoppingItem.ShoppingBasketItemId);
                this.coffeeDatabase.AddInParameter(command, "@coffeeId", DbType.Int32, shoppingItem.Coffee.Id);
                this.coffeeDatabase.AddInParameter(command, "@quantity", DbType.Int32, shoppingItem.Quantity);
                this.coffeeDatabase.AddInParameter(command, "@shoppingBasketNumber", DbType.Guid, shoppingItem.ShoppingBasketId);

                Task<int> execNonQueryTask =
                  Task<int>.Factory.FromAsync(this.coffeeDatabase.BeginExecuteNonQuery, this.coffeeDatabase.EndExecuteNonQuery, command, null);
                return await execNonQueryTask;
            }
        }

        public async Task<int> DeleteShoppingBasketItem(int shoppingItemId)
        {
            using (DbCommand command = this.coffeeDatabase.GetStoredProcCommand("dbo.spRemoveShoppingBasketItem"))
            {
                this.coffeeDatabase.AddInParameter(command, "@id", DbType.Int32, shoppingItemId);

                Task<int> execNonQueryTask =
                  Task<int>.Factory.FromAsync(this.coffeeDatabase.BeginExecuteNonQuery, this.coffeeDatabase.EndExecuteNonQuery, command, null);
                return await execNonQueryTask;
            }
        }

        public async Task<ShoppingBasketItem> GetShoppingBasketItem(int coffeeId, Guid shoppingBasketNumber)
        {
            ShoppingBasketItem shoppingItem = null;
            using (DbCommand command = this.coffeeDatabase.GetStoredProcCommand("dbo.spGetShoppingBasketItem"))
            {
                this.coffeeDatabase.AddInParameter(command, "@coffeeId", DbType.Int32, coffeeId);
                this.coffeeDatabase.AddInParameter(command, "@shoppingBasketNumber", DbType.Guid, shoppingBasketNumber);

                Task<IDataReader> readerTask =
                    Task<IDataReader>.Factory.FromAsync(this.coffeeDatabase.BeginExecuteReader, this.coffeeDatabase.EndExecuteReader, command, null);
                using (IDataReader reader = await readerTask)
                {                    
                    while (reader.Read())
                    {
                        shoppingItem = new ShoppingBasketItem();
                        shoppingItem.ShoppingBasketId = Guid.Parse(reader["ShoppingBasketNumber"].ToString());
                        shoppingItem.ShoppingBasketItemId = int.Parse(reader["Id"].ToString());
                        shoppingItem.Quantity = int.Parse(reader["Quantity"].ToString());
                        shoppingItem.Coffee = new Coffee() { Id = int.Parse(reader["CoffeeId"].ToString()) };
                    }                   
                }
            }

            if (shoppingItem != null)
            {
                shoppingItem.Coffee = await this.coffeeDataAccess.GetCoffeeById(coffeeId);
            }

            return shoppingItem;
        }

        public async Task<int> SaveShoppingBasketItem(ShoppingBasketItem shoppingItem)
        {
            using (DbCommand command = this.coffeeDatabase.GetStoredProcCommand("dbo.spSaveShoppingBasketItem"))
            {
                this.coffeeDatabase.AddInParameter(command, "@coffeeId", DbType.Int32, shoppingItem.Coffee.Id);
                this.coffeeDatabase.AddInParameter(command, "@quantity", DbType.Int32, shoppingItem.Quantity);
                this.coffeeDatabase.AddInParameter(command, "@shoppingBasketNumber", DbType.Guid, shoppingItem.ShoppingBasketId);
                Task<int> execNonQueryTask =
                    Task<int>.Factory.FromAsync(this.coffeeDatabase.BeginExecuteNonQuery, this.coffeeDatabase.EndExecuteNonQuery, command, null);

                int result = await execNonQueryTask;
                return result;
            }
        }

    }
}
