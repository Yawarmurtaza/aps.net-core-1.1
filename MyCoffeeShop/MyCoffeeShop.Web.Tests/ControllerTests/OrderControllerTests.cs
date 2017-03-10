using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;
using MyCoffeeShop.DomainModel;
using MyCoffeeShop.ServiceManagers;
using MyCoffeeShop.Web.Controllers;
using NUnit.Framework;
using Rhino.Mocks;

namespace MyCoffeeShop.Web.Tests.ControllerTests
{
    [TestFixture]
    public class OrderControllerTests
    {

        private IOrderManager mockOrderManager;
        private IShoppingBasketManager mockShoppingManager;
        private IServiceProvider mockServices;

        [SetUp]
        public void Setup()
        {
            this.mockOrderManager = MockRepository.GenerateMock<IOrderManager>();
            this.mockShoppingManager = MockRepository.GenerateMock<IShoppingBasketManager>();
            this.mockServices = MockRepository.GenerateMock<IServiceProvider>();
        }

        [Test]
        public async Task CheckoutTest()
        {
            // arrange.
            Guid basketId = Guid.NewGuid();
            ISession mockSession = MockRepository.GenerateMock<ISession>();
            IHttpContextAccessor  mockContextAccess = MockRepository.GenerateMock<IHttpContextAccessor>();

            HttpContext mockContext = MockRepository.GenerateMock<HttpContext>();
            mockContext.Stub(ctx => ctx.Session).Return(mockSession);

            mockContextAccess.Stub(accessor => accessor.HttpContext).Return(mockContext);

            mockSession.Stub(session => session.GetString("ShoppingBasketId")).Return(basketId.ToString());
            
            this.mockServices.Stub(s => s.GetRequiredService<IHttpContextAccessor>()).Return(mockContextAccess);

            OrderController controller = new OrderController(this.mockOrderManager, this.mockShoppingManager, this.mockServices);

            // act.

            ActionResult aResult = await controller.Checkout(new Order());


            // assert.
        }
    }
}