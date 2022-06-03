using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Banca
{
    /// <summary>
    /// Summary description for APIBanca
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class APIBanca : System.Web.Services.WebService
    {
        private static string ConnectionString => ConfigurationManager.ConnectionStrings["bancaEntities"].ConnectionString;

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public List<usuario> GetUsuarios()
        {
            using (bancaEntities ent = new bancaEntities())
            {
                var usuarios = ent.usuario.ToList();
                return usuarios;
            }
        }

        [WebMethod]
        public usuario AddEditUsuario(usuario objusuario)
        {
            
            using (bancaEntities ent = new bancaEntities())
            {
                if (objusuario.user_Id == 0)
                {
                    //objusuario.user_Edad = CalcularEdad((DateTime)objusuario.user_FechaNacimiento);
                    var usuario = ent.usuario.Add(objusuario);
                    ent.SaveChanges();
                }
                else
                {
                    var usuario = ent.usuario.Where(x => x.user_Id == objusuario.user_Id).FirstOrDefault();
                    if (usuario != null)
                    {
                        usuario.user_Id = objusuario.user_Id;
                        usuario.user_Cedula = objusuario.user_Cedula;
                        usuario.user_Nombre = objusuario.user_Nombre;
                        usuario.user_Direccion = objusuario.user_Direccion;
                        //usuario.user_FechaNacimiento = objusuario.user_FechaNacimiento;
                        usuario.user_Email = objusuario.user_Email;
                        //usuario.user_Edad = CalcularEdad((DateTime)objusuario.user_FechaNacimiento.Value);

                        ent.SaveChanges();
                    }
                }
                return objusuario;
            }
        }

        public int CalcularEdad(DateTime fecha)
        {
            DateTime now = DateTime.Today;
            int edad = DateTime.Today.Year - fecha.Year;

            if (DateTime.Today < fecha.AddYears(edad))
                return --edad;
            else
                return edad;
        }

        [WebMethod]
        public usuario GetUsuarioById(int user_Id)
        {
            using (bancaEntities ent = new bancaEntities())
            {
                var usuario = ent.usuario.Where(x => x.user_Id == user_Id).FirstOrDefault();
                return usuario;
            }


        }

        [WebMethod]
        public bool DeleteUsuarioById(int user_Id)
        {
            using (bancaEntities ent = new bancaEntities())
            {
                var usuario = ent.usuario.Where(x => x.user_Id == user_Id).FirstOrDefault();
                ent.usuario.Remove(usuario);
                var value = ent.SaveChanges();

                var accounts = GetAccounts().Where(x => x.account_user_Id == user_Id).ToList();
                foreach (var item in accounts)
                {
                    DeleteAccountById(item.account_Id);
                }
                var result = value == 1 ? true : false;
                return result;
            }


        }


        //ACCOUNTS

        [WebMethod]
        public List<account> GetAccounts()
        {
            using (bancaEntities ent = new bancaEntities())
            {
                var accounts = ent.account.ToList();
                return accounts;
            }
        }

        [WebMethod]
        public bool AddEditAccount(List<account> lstaccounts)
        {
            try
            {
                using (bancaEntities ent = new bancaEntities())
                {
                    foreach (var objaccount in lstaccounts)
                    {
                        if (objaccount.account_Id == 0)
                        {
                            var venta = ent.account.Add(objaccount);
                            ent.SaveChanges();
                        }
                        else
                        {
                            var account = ent.account.Where(x => x.account_Id == objaccount.account_Id).FirstOrDefault();
                            if (account != null)
                            {
                                account._account_deposito = objaccount._account_deposito;
                                account.account_Saldo = account.CalcularSaldo();
                                account.account_Numero = objaccount.account_Numero;
                                account.account_IdTipo = objaccount.account_IdTipo;

                                ent.SaveChanges();
                            }
                        }
                    }


                    return true;

                }
            }
            catch (Exception ex)
            {
                var error = ex.Message;
                return false;
            }
        }

        [WebMethod]
        public account GetAccountById(int account_id)
        {
            using (bancaEntities ent = new bancaEntities())
            {
                var account = ent.account.Where(x => x.account_Id == account_id).FirstOrDefault();
                return account;
            }


        }

        [WebMethod]
        public bool DeleteAccountById(int account_id)
        {
            using (bancaEntities ent = new bancaEntities())
            {
                var account = ent.account.Where(x => x.account_Id == account_id).FirstOrDefault();
                ent.account.Remove(account);
                var value = ent.SaveChanges();
                var result = value == 1 ? true : false;
                return result;
            }


        }

        [WebMethod]
        public List<account> FilterAccounts(string cuenta, string user_id)
        {
            using (bancaEntities ent = new bancaEntities())
            {

                List<account> accounts = new List<account>();
                if (cuenta != "" && user_id == "")
                {
                    accounts = ent.account.Where(x => x.account_Numero == cuenta).ToList();
                }
                else if (cuenta == "" && user_id != "")
                {
                    var user_Id = Convert.ToInt32(user_id);
                    accounts = ent.account.Where(x => x.account_user_Id == user_Id).ToList();
                }
                else if (cuenta != "" && user_id != "")
                {
                    var user_Id = Convert.ToInt32(user_id);
                    accounts = ent.account.Where(x => x.account_Numero == cuenta && x.account_user_Id == user_Id).ToList();
                }
                else if (cuenta == "" && user_id == "")
                {
                    accounts = ent.account.ToList();
                }


                return accounts;
            }


        }
    }
}
