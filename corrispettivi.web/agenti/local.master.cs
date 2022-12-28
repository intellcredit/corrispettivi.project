using Corrispettivi.Library;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace corrispettivi.web.agenti
{
    public partial class local : System.Web.UI.MasterPage
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (Session["LoginType"] != null)
            {
                switch ((typeinfo.eTypeLogin)Session["LoginType"])
                {
                    case typeinfo.eTypeLogin.Manuale:
                        Page.MasterPageFile = "~/site.master";
                        break;
                    case typeinfo.eTypeLogin.Automatico:
                        Page.MasterPageFile = "~/siteClear.master";
                        break;
                }
            }
        }
    }
}