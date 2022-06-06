using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Core.Interfaces;
using Core.Entities;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Data
{
    public class UsuarioRepository : IUsuarioRepository 
    {
        private readonly StoreContext _context;

        public UsuarioRepository(StoreContext context){
            _context = context;
        }

        public async Task<IReadOnlyList<Usuario>> GetUsuariosAsync()
        {
            return await _context.Usuarios.ToListAsync();
        }
        public async Task<Usuario> GetUsuarioByIdAsync(int id)
        {
            return await _context.Usuarios.FindAsync(id);
        }
        
        public async Task<Usuario> CreateUpdateUsuario(Usuario usuario)
        {
            if(usuario.Id > 0){
                _context.Usuarios.Update(usuario);
            }else{
               await _context.Usuarios.AddAsync(usuario);
               await _context.SaveChangesAsync();

               if(usuario.Id > 0){
                Cuenta cuenta =  new Cuenta();
                var random = new Random();
                cuenta.NumCuenta = "172179"+ random.Next(0,99999).ToString();
                cuenta.Tipo = usuario.TipoCuenta;
                cuenta.UsuarioId = usuario.Id;
                await _context.Cuentas.AddAsync(cuenta);

                await _context.SaveChangesAsync();
               }              
            }
            return usuario;
        }

        public async Task<bool> DeleteUsuario(int id)
        {
            try
            {
                Usuario usuario = await _context.Usuarios.FindAsync(id);
                if(usuario ==null){
                    return false;
                }
                _context.Usuarios.Remove(usuario);
                await _context.SaveChangesAsync();
                return true;
            }
            catch(Exception)
            {
                return false;
            }
        }

    }
}
