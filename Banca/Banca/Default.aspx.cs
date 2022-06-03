using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Banca
{
    public partial class _Default : Page
    {
        APIBanca api = new APIBanca();
        protected void Page_Load(object sender, EventArgs e)
        {
            var lstusuarios = api.GetUsuarios();
            usuarios.DataSource = lstusuarios;
            usuarios.DataBind();


        }
    }
}