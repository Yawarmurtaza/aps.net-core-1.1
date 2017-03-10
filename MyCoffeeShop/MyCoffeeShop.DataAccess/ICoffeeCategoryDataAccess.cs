using MyCoffeeShop.DomainModel;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MyCoffeeShop.DataAccess
{
    public interface ICoffeeCategoryDataAccess
    {
        Task<IEnumerable<CoffeeCategory>> GetAll();
    }
}