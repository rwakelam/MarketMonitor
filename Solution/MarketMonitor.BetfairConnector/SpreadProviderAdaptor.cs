using MarketMonitor.Contracts.Interfaces;
using MarketMonitor.Contracts.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Net.Http;
using Newtonsoft.Json;
using RichTools.Http.Contracts.Interfaces;

namespace MarketMonitor.BetfairConnector
{
    public class SpreadProviderAdaptor : ISpreadProvider
    {

        #region Class Variables

        private readonly IAuthenticator __Authenticator;
        private readonly IHttpClientFactory __HttpClientFactory;
        // Mapper?

        #endregion

        #region Constructors

        public SpreadProviderAdaptor(
            IAuthenticator authenticator, 
            IHttpClientFactory httpClientFactory)
        {
            __Authenticator = authenticator;
            __HttpClientFactory = httpClientFactory;
        }

        #endregion

        #region Methods

        public async Task<Spread> GetProductSpreadAsync(Guid productUid)
        {
            // Authenticate
            var _Authentication = await __Authenticator.AuthenticateAsync();

            // Call the source web service.
            var _HttpClient = __HttpClientFactory.CreateClient(_Authentication.access_token);
            using (_HttpClient)
            {
                var _Response = await _HttpClient.GetAsync($"api/data/v9.1/spread");// TODO: inject productUid

                if (!_Response.IsSuccessStatusCode)
                {
                    throw new HttpRequestException($"Http request failed. Url: {__Entity}. Sttaus Code: { _Response.StatusCode }.");
                }

                return _Response.Content == null ? null : JsonConvert.DeserializeObject<GetSpreadHttpResponse>(
                    await _Response.Content.ReadAsStringAsync()).Spreads.Single();
            }

            // TODO: map source objects to our objects
        }

        public async Task<List<Spread>> GetMarketSpreadsAsync(Guid marketUid)
        {
            // Call http client
            // map source objects to our objects
            return null;
        }

        #endregion

    }
}
