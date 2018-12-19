using MarketMonitor.Contracts.Models;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MarketMonitor.Contracts.Interfaces
{
    public interface IProductProvider
    {
        Task<List<Product>> GetProductsAsync(Guid marketUid);
    }
}
