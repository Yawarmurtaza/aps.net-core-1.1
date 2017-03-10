using Microsoft.Practices.EnterpriseLibrary.Data;
using MyCoffeeShop.DomainModel;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Threading.Tasks;

namespace MyCoffeeShop.DataAccess
{


    public class CoffeeCategoryDataAccess : ICoffeeCategoryDataAccess
    {
        private readonly Database coffeeDatabase;
        public CoffeeCategoryDataAccess(ICoffeeShopDatabaseFactory factory)
        {
            this.coffeeDatabase = factory.GetCoffeeDatabase();
        }

        public async Task<IEnumerable<CoffeeCategory>> GetAll()
        {
            IList<CoffeeCategory> allCategories;

            using (DbCommand command = this.coffeeDatabase.GetStoredProcCommand("dbo.spGetAllCategories"))
            {
               Task<IDataReader> dataReaderTask =
               Task<IDataReader>.Factory.FromAsync(this.coffeeDatabase.BeginExecuteReader, this.coffeeDatabase.EndExecuteReader, command, null);
                using (IDataReader reader = await dataReaderTask)
                {
                    allCategories = new List<CoffeeCategory>();
                    while (reader.Read())
                    {
                        CoffeeCategory cc = new CoffeeCategory();
                        cc.Id = int.Parse(reader["ID"].ToString());
                        cc.Name = reader["NAME"].ToString();
                        cc.Description = reader["DESCRIPTION"].ToString();

                        allCategories.Add(cc);
                    }
                }


            }

            return allCategories;
        }
    }
}
