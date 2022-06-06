using System.Linq;
using System.Reflection;
using Microsoft.EntityFrameworkCore;
using Core.Entities;

namespace Infrastructure.Data
{
    public class StoreContext : DbContext   
    {
        public StoreContext(DbContextOptions<StoreContext> options) : base 
        (options)
        {

        }

        public DbSet<Usuario> Usuarios {get; set;}
        public DbSet<Cuenta> Cuentas {get; set;}
    }
}