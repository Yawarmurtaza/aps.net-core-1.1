using MyCoffeeShop.DomainModel;
using System.Threading.Tasks;

namespace MyCoffeeShop.DataAccess
{
    public interface IOrderDetailDataAccess
    {
        Task<int> SaveOrderDetail(OrderDetail orderDetail);
    }
}
