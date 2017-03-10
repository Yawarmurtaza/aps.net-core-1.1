using Microsoft.AspNetCore.Mvc;

using MyCoffeeShop.DataAccess;
using MyCoffeeShop.DomainModel;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MyCoffeeShop.Web.Controllers
{

    public class CoffeeController : Controller
    {
        private readonly ICoffeeDataAccess coffDataAccess;
        public CoffeeController(ICoffeeDataAccess coffDataAccess)
        {
            this.coffDataAccess = coffDataAccess;
        }

        public async Task<ActionResult> Detail(int id)
        {
            Coffee coffee = await this.coffDataAccess.GetCoffeeById(id);
            return this.View(coffee);
        }


        public async Task<ActionResult> ListCoffeesByCategoryName(string coffeeCategoryName)
        {
            IEnumerable<Coffee> coffees = await this.coffDataAccess.GetCoffeesByCategoryName(coffeeCategoryName);
            return this.View(coffees);
        }

        public ActionResult List()
        {
            return this.View();
        }
    }
}
