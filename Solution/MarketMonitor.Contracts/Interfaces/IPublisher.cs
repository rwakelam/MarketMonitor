using System.Collections.Generic;
using System.Threading.Tasks;

namespace MarketMonitor.Contracts.Interfaces
{
    public interface IPublisher<T>
    {
        Task PublishAsync(IEnumerable<T> items);
    }
}
