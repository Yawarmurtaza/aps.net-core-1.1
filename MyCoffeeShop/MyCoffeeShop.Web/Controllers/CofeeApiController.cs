using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using MyCoffeeShop.DataAccess;
using MyCoffeeShop.DomainModel;
using MyCoffeeShop.Web.ViewModels;

namespace MyCoffeeShop.Web.Controllers
{
    [Route("api/[controller]")]
    public class CoffeeApiController : Controller
    {
        private readonly ICoffeeDataAccess coffeeDataAccess;

        public CoffeeApiController(ICoffeeDataAccess coffeeDataAccess)
        {
            this.coffeeDataAccess = coffeeDataAccess;
        }

        [HttpGet]

        public async Task<IEnumerable<CoffeeViewModel>> LoadMoreCoffees()
        {
            IEnumerable<Coffee> allCoffees = (await this.coffeeDataAccess.GetAllAvailableCoffees()).OrderBy(c => c.Id).Take(10);
            return allCoffees.ConvertToCoffeeViewModel();
        }
    }

    public static class ExtensionMethods
    {
        public static IEnumerable<CoffeeViewModel> ConvertToCoffeeViewModel(this IEnumerable<Coffee> coffees)
        {
            foreach (Coffee nextCoffee in coffees)
            {
                CoffeeViewModel model = new CoffeeViewModel();
                model.Id = nextCoffee.Id;
                model.ImageThumbnailUrl = nextCoffee.ImageThumbnailUrl;
                model.Name = nextCoffee.Name;
                model.Price = nextCoffee.Price;
                model.ShortDesc = nextCoffee.ShortDesc;

                yield return model;
            }
        }
    }
}