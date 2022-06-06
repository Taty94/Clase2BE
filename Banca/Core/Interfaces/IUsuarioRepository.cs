using System.Collections.Generic;
using System.Threading.Tasks;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IUsuarioRepository
    {
        Task<IReadOnlyList<Usuario>> GetUsuariosAsync();
        Task<Usuario> GetUsuarioByIdAsync(int id);
        Task<Usuario> CreateUpdateUsuario(Usuario Usuario);
        Task<bool> DeleteUsuario(int id);
    }
}