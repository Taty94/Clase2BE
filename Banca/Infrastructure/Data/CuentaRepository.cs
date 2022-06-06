using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Core.Entities;
using Core.Interfaces;
using Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure
{
    public class CuentaRepository : ICuentaRepository
    {
        private readonly StoreContext _context;

        public CuentaRepository(StoreContext context){
            _context = context;
        }

        public async Task<IReadOnlyList<Cuenta>> GetCuentasAsync()
        {
            var cuentas= await _context.Cuentas.ToListAsync();
            foreach(var item in cuentas){
                await _context.Cuentas
                    .Include(u=>u.Usuario)
                    .FirstOrDefaultAsync(u=>u.Id == item.Id);
            }
            return cuentas;
        }
            
        public async Task<bool> Deposito(int id, decimal deposito)
        {
            var cuenta = await _context.Cuentas.FindAsync(id);
            if(cuenta!=null){
                cuenta.Saldo = cuenta.Saldo + deposito;
                _context.Cuentas.Update(cuenta);
            }
            
            try {
                await _context.SaveChangesAsync();
                return true;
            }
            catch (Exception ex){
                return false;
            }
            
        }
        public async Task<bool> Retiro(int id, decimal retiro)
        {
            var cuenta = await _context.Cuentas.FindAsync(id);
            if(cuenta!=null){
                if(retiro <= cuenta.Saldo){
                    cuenta.Saldo = cuenta.Saldo - retiro;
                    _context.Cuentas.Update(cuenta);
                }
            }
            try {
                await _context.SaveChangesAsync();
                return true;
            }
            catch (Exception ex){
                return false;
            }
        }
    }
}