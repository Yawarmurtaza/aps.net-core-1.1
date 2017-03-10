using System;
using MyCoffeeShop.DomainModel;
using System.Threading.Tasks;

namespace MyCoffeeShop.ServiceManagers
{
    public interface IOrderManager
    {
        Task CreateOrder(Order order, Guid shoppingBasketNumber);
    }
}
