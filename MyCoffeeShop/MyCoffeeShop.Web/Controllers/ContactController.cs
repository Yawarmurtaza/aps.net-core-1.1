using Microsoft.AspNetCore.Mvc;

namespace MyCoffeeShop.Web.Controllers
{
    public class ContactController : Controller
    {
        public ActionResult Index()
        {
            return this.View();
        }
    }
}
