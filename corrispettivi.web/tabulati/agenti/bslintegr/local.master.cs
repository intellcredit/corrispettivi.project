using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace corrispettivi.web.tabulati.agenti.bslintegr
{
    public partial class local : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // per utenti diversi da:
            // SuperAdmin e Admin
            // disabilita il tasto per la modifica dei record
            Authorize.Based.SessionInfo sessionInfo = (Authorize.Based.SessionInfo)Session["SessionInfo"];
            if (!(sessionInfo.UserInfo.RoleName == "SUPERADMIN" || sessionInfo.UserInfo.RoleName == "ADMIN"))
                tbLocalMenu.FindItemByText("Nuovo").Visible = false;

        }
    }
}