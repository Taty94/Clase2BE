using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Banca
{
    public partial class ListadoCuentas : System.Web.UI.Page
    {
        APIBanca api = new APIBanca();
        protected void Page_Load(object sender, EventArgs e)
        {
            var lstaccount = api.GetAccounts();
            accounts.DataSource = lstaccount;
            accounts.DataBind();

            var lstusuarios = api.GetUsuarios();
            fltusuarios.DataSource = lstusuarios;
            fltusuarios.DataBind();
        }
    }
}