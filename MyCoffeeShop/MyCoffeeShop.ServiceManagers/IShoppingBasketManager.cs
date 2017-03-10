using System;
using MyCoffeeShop.DomainModel;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace MyCoffeeShop.ServiceManagers
{
    public interface IShoppingBasketManager
    {
        Task<int> AddCoffeeToBasket(Coffee coffee, Guid shoppingBasketNumber);
        Task<int> RemoveCoffeeFromBasket(int coffeeId, Guid shoppingBasketNumber);

        Task<int> ClearShoppingBasket(Guid shoppingBasketNumber);

        Task<IEnumerable<ShoppingBasketItem>> GetShoppingBasketItemsForShoppingBasket(Guid shoppingBasketNumber);

        Task<decimal> GetTotalAsync(Guid shoppingBasketNumber);

        Task<int> UpdateShoppingBasketItem(ShoppingBasketItem shoppingItem);

        Task<int> DeleteShoppingBasketItem(int shoppingItemId);

        Task<ShoppingBasketItem> GetShoppingBasketItem(int coffeeId, Guid shoppingBasketNumber);

        Task<int> SaveShoppingBasketItem(ShoppingBasketItem shoppingItem);
    }
}
