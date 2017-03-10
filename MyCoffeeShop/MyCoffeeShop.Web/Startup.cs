using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;

using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using MyCoffeeShop.DataAccess;
using MyCoffeeShop.ServiceManagers;

namespace MyCoffeeShop.Web
{
    public class Startup
    {
        public Startup(IHostingEnvironment env)
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(env.ContentRootPath)
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .AddJsonFile($"appsettings.{env.EnvironmentName}.json", optional: true)
                .AddEnvironmentVariables();
            Configuration = builder.Build();
        }

        public IConfigurationRoot Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            //
            // Service Managers
            //
            services.AddTransient<IShoppingBasketManager, ShoppingBasketManager>();
            services.AddTransient<IOrderManager, OrderManager>();


            //
            // Data Access
            //
            services.AddTransient<ICoffeeDataAccess, CoffeeDataAccess>();
            services.AddTransient<ICoffeeShopDatabaseFactory, CoffeeShopDatabaseFactory>();
            services.AddTransient<ICoffeeCategoryDataAccess, CoffeeCategoryDataAccess>();
            services.AddTransient<IShoppingBasketDataAccess, ShoppingBasketDataAccess>();
            services.AddTransient<IOrderDataAccess, OrderDataAccess>();
            services.AddTransient<IOrderDetailDataAccess, OrderDetailDataAccess>();
            
            //
            // Add framework support.
            //
            services.AddMvc();
            services.AddMemoryCache();
            services.AddSession();


        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory)
        {
            loggerFactory.AddConsole(Configuration.GetSection("Logging"));
            loggerFactory.AddDebug();
            app.UseSession();
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseBrowserLink();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
            }

            app.UseStaticFiles();

            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
