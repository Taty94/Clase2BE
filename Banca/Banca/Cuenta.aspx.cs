using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Banca
{
    public partial class Cuenta : System.Web.UI.Page
    {
        APIBanca api = new APIBanca();
        public int user_Id;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.QueryString["id"] != null)
            {
                user_Id = Convert.ToInt32(Request.QueryString["id"]);
            }

            var lstaccount = api.GetAccounts().Where(x=>x.usuarios.user_Id == user_Id).ToList();
            accounts.DataSource = lstaccount;
            accounts.DataBind();
        }
    }
}