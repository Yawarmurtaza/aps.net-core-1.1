using Microsoft.Practices.EnterpriseLibrary.Data;
using MyCoffeeShop.DomainModel;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System;

namespace MyCoffeeShop.DataAccess
{
    public class CoffeeDataAccess : ICoffeeDataAccess
    {
        private readonly Database coffeeDatabase;

        public CoffeeDataAccess(ICoffeeShopDatabaseFactory factory)
        {
            this.coffeeDatabase = factory.GetCoffeeDatabase();
        }

        public async Task<IEnumerable<Coffee>> GetCoffeesByCategoryName(string categoryName)
        {
            using (DbCommand command = this.coffeeDatabase.GetStoredProcCommand("dbo.spGetCoffeesByCategoryName"))
            {
                this.coffeeDatabase.AddInParameter(command, "@categoryName", DbType.String, categoryName);
                return await this.ExecuteCommandAsync(command);
            }
        }

        public async Task<Coffee> GetCoffeeById(int coffeeId)
        {
            Coffee coffee;

            using (DbCommand command = this.coffeeDatabase.GetStoredProcCommand("dbo.spGetCofeeById"))
            {
                this.coffeeDatabase.AddInParameter(command, "@coffeeId", DbType.Int32, coffeeId);
                coffee = (await this.ExecuteCommandAsync(command)).FirstOrDefault();
            }

            return coffee;
        }

        public async Task<IEnumerable<Coffee>> GetAllAvailableCoffees()
        {
            using (DbCommand command = this.coffeeDatabase.GetStoredProcCommand("dbo.spGetAllCoffees"))
            {
                return await this.ExecuteCommandAsync(command);
            }
        }

        public async Task<IEnumerable<Coffee>> GetCofeesOfTheWeek()
        {
            using (DbCommand command = this.coffeeDatabase.GetStoredProcCommand("dbo.spGetCoffeesOfTheWeek"))
            {
                return await this.ExecuteCommandAsync(command);
            }
        }


        private async Task<IEnumerable<Coffee>> ExecuteCommandAsync(DbCommand command)
        {
            IList<Coffee> coffees;
            Task<IDataReader> dataReaderTask =
                Task<IDataReader>.Factory.FromAsync(this.coffeeDatabase.BeginExecuteReader, this.coffeeDatabase.EndExecuteReader, command, null);

            using (IDataReader reader = await dataReaderTask)
            {
                coffees = new List<Coffee>();
                while (reader.Read())
                {
                    Coffee c = new Coffee();

                    c.Id = int.Parse(reader["ID"].ToString());
                    c.Name = reader["Name"].ToString();
                    c.ShortDesc = reader["ShortDesc"].ToString();
                    c.LongDesc = reader["LongDesc"].ToString();
                    c.Price = decimal.Parse(reader["Price"].ToString());
                    c.ImageUrl = reader["ImageUrl"].ToString();
                    c.ImageThumbnailUrl = reader["ImageThumbnailUrl"].ToString();
                    c.CategoryId = int.Parse(reader["CategoryId"].ToString());
                    coffees.Add(c);
                }
            }

            return coffees;
        }
    }
}
