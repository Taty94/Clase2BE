using System.Collections.Generic;
using System.Threading.Tasks;
using Core.Entities;
using Core.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CuentasController : ControllerBase
    {
        private readonly ICuentaRepository _repo;

        public CuentasController(ICuentaRepository repo){
            _repo = repo;
        }

        //GET: api/Cuentas
        [HttpGet]
        public async Task<ActionResult<List<Cuenta>>> GetCuentas()
        {
            var cuentas = await _repo.GetCuentasAsync();
            return Ok(cuentas);
        }

        //Post:api/Cuentas/1/1/20
        [HttpPut("{transaccion}/{id}/{cantidad}")]
        public async Task<IActionResult> Transaccion(int transaccion, int id, decimal cantidad){
            bool result = false;
            switch (transaccion)
            {
                case 1:
                    if(id> 0 && cantidad>0){
                        result = await _repo.Deposito(id,cantidad);
                    }
                break;
                case 2:
                    if(id> 0 && cantidad>0){
                        result = await _repo.Retiro(id,cantidad);
                    }
                break;
            }
            if(result)
            {
                return Ok(result);
            }
            {
                return BadRequest(result);
            }
        }

        
    }
}