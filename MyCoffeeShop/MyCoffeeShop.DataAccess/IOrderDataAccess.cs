using MyCoffeeShop.DomainModel;
using System.Threading.Tasks;

namespace MyCoffeeShop.DataAccess
{
    public interface IOrderDataAccess
    {
        Task<int> SaveOrder(Order order);
    }
}
