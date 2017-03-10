using System;

namespace MyCoffeeShop.DomainModel
{
    public class ShoppingBasketItem
    {
        public int ShoppingBasketItemId { get; set; }
        public Coffee Coffee { get; set; }
        public int Quantity { get; set; }
        public Guid ShoppingBasketId { get; set; }

    }
}
