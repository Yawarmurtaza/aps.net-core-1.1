using System;

namespace MyCoffeeShop.DomainModel
{
    public class OrderDetail
    {
        public int OrderDetailId { get; set; }
        public Guid OrderId { get; set; }
        public int CofeeId { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public Coffee Coffee { get; set; }
        public Order Order { get; set; }
    }
}
