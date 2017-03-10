using System;
using System.Collections.Generic;

namespace MyCoffeeShop.DomainModel
{
    public class ShoppingBasket
    {
        public Guid Id { get; set; }

        public IList<ShoppingBasketItem> ShoppingBasketItems { get; set; }
    }
}
