using System;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace MyCoffeeShop.DataAccess
{
    public interface ICoffeeShopDatabaseFactory
    {
        Database GetCoffeeDatabase();
    }
}
