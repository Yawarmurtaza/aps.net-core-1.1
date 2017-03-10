using Microsoft.AspNetCore.Mvc;
using MyCoffeeShop.DataAccess;
using MyCoffeeShop.DomainModel;
using MyCoffeeShop.ServiceManagers;
using MyCoffeeShop.Web.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MyCoffeeShop.Web.Controllers
{
    public class ShoppingBasketController : BaseController
    {
        private readonly ICoffeeDataAccess coffeeDataAccess;
        private readonly IShoppingBasketManager manager;
        
        public ShoppingBasketController(IShoppingBasketManager manager, ICoffeeDataAccess coffeeDataAccess, IServiceProvider services) : base(services)
        {
            this.manager = manager;            
            this.coffeeDataAccess = coffeeDataAccess;            
        }

        public async Task<ActionResult> Index()
        {
            IEnumerable<ShoppingBasketItem> shoppingBasketItems = await this.manager.GetShoppingBasketItemsForShoppingBasket(base.BasketId);

            ShoppingBasketViewModel model = new ShoppingBasketViewModel()
            {
                ShoppingBasket = new ShoppingBasket() { ShoppingBasketItems = shoppingBasketItems.ToList(), Id = base.BasketId },
                ShoppingBasketTotal = await this.manager.GetTotalAsync(base.BasketId)
            };

            return this.View(model);
        }

        public async Task<ActionResult> AddToShoppingBasket(int coffeeId)
        {
            Coffee coffeeToadd = await this.coffeeDataAccess.GetCoffeeById(coffeeId);

            await this.manager.AddCoffeeToBasket(coffeeToadd, base.BasketId);
            return this.RedirectToAction("Index");
        }
    }
}
