using Microsoft.Extensions.Options;
using RichTools.Http.Contracts.Options;
using System;
using System.Net.Http;
using System.Net.Http.Headers;

namespace RichTools.Http.Factories
{
    public class JsonHttpClientFactory : IHttpClientFactory
    {

        #region Class Variables

        private readonly HttpClientFactoryOptions __Options;

        #endregion

        #region Constructors

        public JsonHttpClientFactory(IOptions<HttpClientFactoryOptions> accessor)
        {
            __Options = accessor.Value;
        }

        #endregion

        #region Methods

        public HttpClient CreateClient(string accessToken)
        {
            var _HttpClient = new HttpClient
            {
                BaseAddress = new Uri(__Options.BaseAddress),
                Timeout = new TimeSpan(0, 2, 0)
            };
            _HttpClient.DefaultRequestHeaders.Add("OData-MaxVersion", "4.0");
            _HttpClient.DefaultRequestHeaders.Add("OData-Version", "4.0");
            _HttpClient.DefaultRequestHeaders.Accept.Add(
                new MediaTypeWithQualityHeaderValue("application/json"));
            _HttpClient.DefaultRequestHeaders.Authorization =
                new AuthenticationHeaderValue("Bearer", accessToken);
            return _HttpClient;
        }

        #endregion

    }
}
