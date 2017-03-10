using System;
using MyCoffeeShop.DataAccess;
using MyCoffeeShop.DomainModel;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace MyCoffeeShop.ServiceManagers
{

    public class ShoppingBasketManager : IShoppingBasketManager
    {        

        private readonly IShoppingBasketDataAccess shoppingBasketDataAccess;

        public ShoppingBasketManager(IShoppingBasketDataAccess shoppingBasketDataAccess)
        {            
            this.shoppingBasketDataAccess = shoppingBasketDataAccess;
        }


        public async Task<int> AddCoffeeToBasket(Coffee coffee, Guid shoppingBasketNumber)
        {
            ShoppingBasketItem shoppingItem = await this.shoppingBasketDataAccess.GetShoppingBasketItem(coffee.Id, shoppingBasketNumber);

            if (shoppingItem == null)
            {
                shoppingItem = new ShoppingBasketItem();
                shoppingItem.Quantity = 1;
                shoppingItem.ShoppingBasketId = shoppingBasketNumber;
                shoppingItem.Coffee = coffee;
            }
            else
            {
                shoppingItem.Quantity += 1;
                return await this.shoppingBasketDataAccess.UpdateShoppingBasketItem(shoppingItem);
            }

            int rowSaved = await this.shoppingBasketDataAccess.SaveShoppingBasketItem(shoppingItem);
            return rowSaved;

        }

        public async Task<int> RemoveCoffeeFromBasket(int coffeeId, Guid shoppingBasketNumber)
        {
            ShoppingBasketItem shoppingItem = await this.shoppingBasketDataAccess.GetShoppingBasketItem(coffeeId, shoppingBasketNumber);
            int result = 0;
            if (shoppingItem != null)
            {
                if (shoppingItem.Quantity > 1)
                {
                    shoppingItem.Quantity -= 1;
                    result = await this.shoppingBasketDataAccess.UpdateShoppingBasketItem(shoppingItem);
                }
                else
                {
                    result = await this.shoppingBasketDataAccess.DeleteShoppingBasketItem(shoppingItem.ShoppingBasketItemId);
                }
            }

            return result;
        }

        public async Task<int> ClearShoppingBasket(Guid shoppingBasketNumber)
        {
            return await shoppingBasketDataAccess.ClearShoppingBasket(shoppingBasketNumber);
        }

        public async Task<IEnumerable<ShoppingBasketItem>> GetShoppingBasketItemsForShoppingBasket(Guid shoppingBasketNumber)
        {
            return await this.shoppingBasketDataAccess.GetShoppingBasketItemsForShoppingBasket(shoppingBasketNumber);
        }

        public async Task<decimal> GetTotalAsync(Guid shoppingBasketNumber)
        {
            return await this.shoppingBasketDataAccess.GetTotalAsync(shoppingBasketNumber);
        }

        public async Task<int> UpdateShoppingBasketItem(ShoppingBasketItem shoppingItem)
        {
            return await this.shoppingBasketDataAccess.UpdateShoppingBasketItem(shoppingItem);
        }

        public async Task<int> DeleteShoppingBasketItem(int shoppingItemId)
        {
            return await this.shoppingBasketDataAccess.DeleteShoppingBasketItem(shoppingItemId);
        }

        public async Task<ShoppingBasketItem> GetShoppingBasketItem(int coffeeId, Guid shoppingBasketNumber)
        {
            return await this.shoppingBasketDataAccess.GetShoppingBasketItem(coffeeId, shoppingBasketNumber);
        }

        public async Task<int> SaveShoppingBasketItem(ShoppingBasketItem shoppingItem)
        {
            return await this.shoppingBasketDataAccess.SaveShoppingBasketItem(shoppingItem);
        }
    }
}
