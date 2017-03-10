using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using Microsoft.Extensions.DependencyInjection;

namespace MyCoffeeShop.Web.Controllers
{
    public class BaseController : Controller
    {
        public Guid BasketId { get; set; }

        public BaseController(IServiceProvider services)
        {
            ISession session = services.GetRequiredService<IHttpContextAccessor>()?.HttpContext.Session;
            if (session.GetString("ShoppingBasketId") == null)
            {
                session.SetString("ShoppingBasketId", Guid.NewGuid().ToString());
            }

            string basketStringId = session.GetString("ShoppingBasketId");
            this.BasketId = Guid.Parse(basketStringId);
        }
    }
}
