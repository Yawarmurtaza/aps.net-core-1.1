namespace MyCoffeeShop.DomainModel
{

    public class Coffee
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string ShortDesc { get; set; }
        public string LongDesc { get; set; }
        public string AllergyInformation { get; set; }
        public decimal Price { get; set; }
        public string ImageUrl { get; set; }
        public string ImageThumbnailUrl { get; set; }
        public bool IsCoffeeOfTheWeek { get; set; }
        public bool InStock { get; set; }
        public int CategoryId { get; set; }

    }
}
