using System;
using Microsoft.AspNetCore.Mvc;
using MyCoffeeShop.ServiceManagers;
using MyCoffeeShop.DomainModel;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Linq;

namespace MyCoffeeShop.Web.Controllers
{
    public class OrderController : BaseController
    {
        private readonly IOrderManager orderManager;
        private readonly IShoppingBasketManager shoppingManager;

        public OrderController(IOrderManager orderManager, IShoppingBasketManager shoppingManager, IServiceProvider services) : base(services)
        {
            this.orderManager = orderManager;
            this.shoppingManager = shoppingManager;
        }

        public ActionResult Checkout()
        {            
            return View();
        }

        [HttpPost]
        public async Task<ActionResult> Checkout(Order order)
        {
            IEnumerable<ShoppingBasketItem> basketItems = 
                await this.shoppingManager.GetShoppingBasketItemsForShoppingBasket(base.BasketId);
            if (!basketItems.Any())
            {
                ModelState.AddModelError("", "Your basket is empty, add some coffees first");
            }

            if (ModelState.IsValid)
            {
                await this.orderManager.CreateOrder(order, base.BasketId);
                await this.shoppingManager.ClearShoppingBasket(base.BasketId);
                return this.RedirectToAction("CheckoutComplete");
            }

            return View(order);
        }

        public IActionResult CheckoutComplete()
        {
            ViewBag.CheckoutCompleteMessage = "Thanks for your order. You'll soon enjoy our delicious coffee!";
            return View();
        }
    }
}
