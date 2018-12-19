using MarketMonitor.Contracts.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MarketMonitor.Contracts.Interfaces
{
    public interface IMarketProvider
    {
        Task<List<Market>> GetMarketsAsync();
    }
}
