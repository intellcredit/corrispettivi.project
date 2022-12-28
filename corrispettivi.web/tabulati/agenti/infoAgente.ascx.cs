using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace corrispettivi.web.tabulati.agenti
{
    public partial class infoAgente : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                if (Request["x"].ToString() != "")
                    lblPeriodo.Text = Request["x"].ToString();
                else
                    colPeriodo.Visible = false;

                if (Request["y"].ToString() != "")
                    lblAgenteGroupID.Text = Request["y"].ToString();
                else
                    colGroupID.Visible = false;

                if (Request["z"].ToString() != "")
                    lblAgenteGroupNome.Text = Request["z"].ToString();
                else
                    colGroupName.Visible = false;

                if ((Request["o"].ToString() != "") && (Request["o"].ToString() != "0"))
                    lblOreContratto.Text = Request["o"].ToString();
                else
                    colOre.Visible = false;

                if ((!string.IsNullOrEmpty(Request.QueryString["mp"])) && (Request["mp"].ToString() == "b"))
                    hlBack.Visible = false;
                //else
                //    hlBack.NavigateUrl = string.Format(hlBack.NavigateUrl, Request["x"].ToString());
            }
        }
    }
}