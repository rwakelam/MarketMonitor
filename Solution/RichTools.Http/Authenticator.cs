using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using RichTools.Http.Contracts.Interfaces;
using RichTools.Http.Contracts.Models;
using RichTools.Http.Contracts.Options;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;

namespace MarketMonitor.Service
{
    public class Authenticator : IAuthenticator
    {
        #region Class Variables

        private readonly AuthenticatorOptions __Options;

        #endregion

        #region Constructors

        public Authenticator(IOptions<AuthenticatorOptions> accessor)
        {
            __Options = accessor.Value;
        }

        #endregion

        #region Methods

        public async Task<Authentication> AuthenticateAsync()
        {
            // Post an authentication request.
            HttpResponseMessage _Response;
            using (HttpClient _HttpClient = new HttpClient())
            {
                var _Request = new FormUrlEncodedContent(new[]
                {
                    new KeyValuePair<string, string>("resource", __Options.Resource),
                    new KeyValuePair<string, string>("client_id", __Options.ClientId),
                    new KeyValuePair<string, string>("client_secret", __Options.ClientSecret),
                    new KeyValuePair<string, string>("grant_type", "client_credentials")
                });
                _Response = await _HttpClient.PostAsync(__Options.Authority, _Request);
            }

            // If the request fails, throw an exception.
            if (!_Response.IsSuccessStatusCode)
            {
                throw new HttpRequestException($"Authentication failed. Status code: {_Response.StatusCode}. Reason phrase: '{_Response.ReasonPhrase}'.");
            }

            // Otherwise, return the access token.
            return JsonConvert.DeserializeObject<Authentication>(await _Response.Content.ReadAsStringAsync());
        }

        #endregion
    }
}