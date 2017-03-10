using MyCoffeeShop.DomainModel;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace MyCoffeeShop.DataAccess
{
    public interface ICoffeeDataAccess
    {
        Task<IEnumerable<Coffee>> GetCofeesOfTheWeek();
        Task<IEnumerable<Coffee>> GetAllAvailableCoffees();

        Task<Coffee> GetCoffeeById(int coffeeId);

        Task<IEnumerable<Coffee>> GetCoffeesByCategoryName(string categoryName);
    }
}
