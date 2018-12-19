using MarketMonitor.Contracts.Models;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MarketMonitor.Contracts.Interfaces
{
    public interface ISpreadProvider
    {
        Task<List<Spread>> GetMarketSpreadsAsync(Guid marketUid);

        Task<Spread> GetProductSpreadAsync(Guid productUid);
    }
}
