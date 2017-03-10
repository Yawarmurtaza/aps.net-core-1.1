using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using MyCoffeeShop.DataAccess;
using MyCoffeeShop.DomainModel;

namespace MyCoffeeShop.Web.Controllers
{

    public class HomeController : Controller
    {
        private readonly ICoffeeDataAccess coffDataAccess;

        public HomeController(ICoffeeDataAccess coffDataAccess)
        {
            this.coffDataAccess = coffDataAccess;
        }

        public async Task<IActionResult> Index()
        {
            IEnumerable<Coffee> coffeesOfTheWeek = await this.coffDataAccess.GetCofeesOfTheWeek();
            return View(coffeesOfTheWeek);
        }
      

        public IActionResult Error()
        {
            return View();
        }
    }
}
