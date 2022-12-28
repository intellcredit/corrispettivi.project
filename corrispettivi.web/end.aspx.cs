using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace corrispettivi.web
{
    public partial class end : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Request["key"] != null) && (Request["key"].ToString() == "1"))
            {
                lblMessage.Text = it.tools.library.message.HtmlExclamation("Utente non riconosciuto oppure non abilitato");
            }
            else
            {
                lblMessage.Text = it.tools.library.message.HtmlExclamation("Sessione terminata");
            }
        }
    }
}