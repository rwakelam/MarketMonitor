using RichTools.Http.Contracts.Models;
using System.Threading.Tasks;

namespace RichTools.Http.Contracts.Interfaces
{
    public interface IAuthenticator
    {
        Task<Authentication> AuthenticateAsync();
    }
}
