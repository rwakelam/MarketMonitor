using MarketMonitor.Contracts.Models;
using Newtonsoft.Json;

namespace MarketMonitor.BetfairConnector
{
    class GetSpreadHttpResponse
    {
        [JsonProperty("odatacontext")]
        public string Context { get; set; }

        [JsonProperty("value")]
        public Spread[] Spreads { get; set; }
    }
}
