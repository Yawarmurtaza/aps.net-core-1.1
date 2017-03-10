using System;
using MyCoffeeShop.DataAccess;
using MyCoffeeShop.DomainModel;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace MyCoffeeShop.ServiceManagers
{
    public class OrderManager : IOrderManager
    {
        private readonly IOrderDataAccess orderDataAccess;
        private readonly IOrderDetailDataAccess orderDetailDataAccess;
        private readonly IShoppingBasketManager shoppingManager;

        public OrderManager(IOrderDataAccess orderDataAccess, IOrderDetailDataAccess orderDetailDataAccess, IShoppingBasketManager shoppingManager)
        {
            this.orderDataAccess = orderDataAccess;
            this.orderDetailDataAccess = orderDetailDataAccess;
            this.shoppingManager = shoppingManager;
        }

        public async Task CreateOrder(Order order, Guid shoppingBasketNumber)
        {
            order.OrderId = Guid.NewGuid();
            await this.orderDataAccess.SaveOrder(order);
            IEnumerable<ShoppingBasketItem> basketItems = await this.shoppingManager.GetShoppingBasketItemsForShoppingBasket(shoppingBasketNumber);

            foreach (ShoppingBasketItem nextItem in basketItems)
            {
                OrderDetail orderDetail = new OrderDetail()
                {
                    CofeeId = nextItem.Coffee.Id,
                    Quantity = nextItem.Quantity,
                    OrderId = order.OrderId,
                    Price = nextItem.Coffee.Price
                };

                await this.orderDetailDataAccess.SaveOrderDetail(orderDetail);
            }

        }
    }
}
