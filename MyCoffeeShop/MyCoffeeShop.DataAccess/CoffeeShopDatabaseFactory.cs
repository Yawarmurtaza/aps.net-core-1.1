using Microsoft.Practices.EnterpriseLibrary.Data;

namespace MyCoffeeShop.DataAccess
{
    public class CoffeeShopDatabaseFactory : ICoffeeShopDatabaseFactory
    {     
        public Database GetCoffeeDatabase()
        {
            DatabaseProviderFactory dbFact = new DatabaseProviderFactory();
            return dbFact.Create("CoffeeDatabaseConnString");            
        }
    }
}
