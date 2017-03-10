using Microsoft.AspNetCore.Mvc;
using MyCoffeeShop.DataAccess;
using MyCoffeeShop.DomainModel;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MyCoffeeShop.Web.ViewComponents
{
    public class CategoryMenu : ViewComponent
    {
        private readonly ICoffeeCategoryDataAccess catRepo;

        public CategoryMenu(ICoffeeCategoryDataAccess catRepo)
        {
            this.catRepo = catRepo;
        }
        
        public async Task<IViewComponentResult> InvokeAsync()        
        {            
            IEnumerable<CoffeeCategory> categories = await this.catRepo.GetAll();
            return this.View(categories);
        }
    }
}
