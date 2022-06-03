//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Banca
{
    using System;
    using System.Collections.Generic;
    
    public partial class account
    {
        APIBanca api = new APIBanca();
        private int _account_iduser;
        

        public int account_Id { get; set; }
        public string account_Numero { get; set; }
        public Nullable<int> account_IdTipo { get; set; }
        public Nullable<decimal> account_Saldo { get; set; }
        public usuario usuarios { get; set; }

        public int account_user_Id
        {
            get
            {
                return _account_iduser;
            }
            set
            {
                _account_iduser = value;
                this.usuarios = api.GetUsuarioById(_account_iduser);
            }
        }

        public string account_Tipo
        {
            get
            {
                return account_IdTipo==1?"Ahorro":"Corriente";
            }
        }

        public decimal _account_deposito;

        public decimal? CalcularSaldo()
        {
           return account_Saldo + _account_deposito;
        }
    }
}
