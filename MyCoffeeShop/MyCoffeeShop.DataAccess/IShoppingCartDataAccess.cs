using MyCoffeeShop.DomainModel;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MyCoffeeShop.DataAccess
{
    public interface IShoppingBasketDataAccess
    {
        Task<int> ClearShoppingBasket(Guid shoppingBasketNumber);

        Task<IEnumerable<ShoppingBasketItem>> GetShoppingBasketItemsForShoppingBasket(Guid shoppingBasketNumber);

        Task<decimal> GetTotalAsync(Guid shoppingBasketNumber);

        Task<int> SaveShoppingBasketItem(ShoppingBasketItem shoppingItem);

        Task<int> UpdateShoppingBasketItem(ShoppingBasketItem shoppingItem);

        Task<int> DeleteShoppingBasketItem(int shoppingItemId);

        Task<ShoppingBasketItem> GetShoppingBasketItem(int coffeeId, Guid shoppingBasketNumber);
        
    }
}
