using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MyCoffeeShop.DataAccess;
using MyCoffeeShop.DomainModel;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.Extensions.DependencyInjection;
using MyCoffeeShop.Web.ViewModels;
using System.Linq;
using MyCoffeeShop.ServiceManagers;

namespace MyCoffeeShop.Web.ViewComponents
{
    public class ShoppingBasketSummary : ViewComponent
    {
        private readonly IShoppingBasketManager manager;
        private readonly IServiceProvider services;
        public ShoppingBasketSummary(IShoppingBasketManager manager, IServiceProvider services)
        {
            this.manager = manager;
            this.services = services;
        }


        public async Task<IViewComponentResult> InvokeAsync()
        {
            ISession session = services.GetRequiredService<IHttpContextAccessor>()?.HttpContext.Session;

            if (session.GetString("ShoppingBasketId") == null)
            {
                session.SetString("ShoppingBasketId", Guid.NewGuid().ToString());
            }

            string BasketStringId = session.GetString("ShoppingBasketId");
            Guid BasketId = Guid.Parse(BasketStringId);

            IEnumerable<ShoppingBasketItem> shoppingBasketItems = await this.manager.GetShoppingBasketItemsForShoppingBasket(BasketId);           
            ShoppingBasketViewModel model = new ShoppingBasketViewModel()
            {
                ShoppingBasket = new ShoppingBasket() { Id = BasketId, ShoppingBasketItems = shoppingBasketItems.ToList() },
                ShoppingBasketTotal = await this.manager.GetTotalAsync(BasketId)
            };

            return this.View(model);
        }
    }
}
