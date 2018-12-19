using System;
using System.Collections.Generic;
using System.Text;

namespace MarketMonitor.Contracts.Models
{
    public class Product
    {
        public Guid MarketUid { get; set; }

        public string Name { get; set; }

        public Guid ProductUid { get; set; }
    }
}
