namespace RichTools.Http.Contracts.Options
{
    public class AuthenticatorOptions
    {
        public string ClientId { get; set; }
        public string ClientSecret { get; set; }
        public string Resource { get; set; }
        public string Authority { get; set; }
    }
}
