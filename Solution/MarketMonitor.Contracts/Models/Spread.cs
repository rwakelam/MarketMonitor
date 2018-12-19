using System;

namespace MarketMonitor.Contracts.Models
{
    public class Spread
    {
        public DateTime PublishedDate { get; set; } 

        public Guid SpreadUid { get; set; }

        public Guid ProductUid { get; set; }

        public Decimal BidPrice { get; set; }

        public int BidQuantity { get; set; }

        public Decimal OfferPrice { get; set; }

        public int OfferQuantity { get; set; }
    }
}
