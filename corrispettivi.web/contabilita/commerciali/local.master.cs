﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace corrispettivi.web.contabilita.commerciali
{
    public partial class local : System.Web.UI.MasterPage
    {
        private void Page_Init(object sender, System.EventArgs e)
        {
            if (Session.IsNewSession)
                Response.Redirect("~/login.aspx");
            else if (Session["SessionInfo"] == null)
                Response.Redirect("~/login.aspx");
        }
    }
}