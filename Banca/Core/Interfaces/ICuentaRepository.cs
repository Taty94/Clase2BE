using System.Collections.Generic;
using System.Threading.Tasks;
using Core.Entities;

namespace Core.Interfaces
{
    public interface ICuentaRepository
    {
        Task<IReadOnlyList<Cuenta>> GetCuentasAsync();
        Task<bool> Deposito(int id, decimal deposito);
        Task<bool> Retiro(int id, decimal retiro);
    }
}