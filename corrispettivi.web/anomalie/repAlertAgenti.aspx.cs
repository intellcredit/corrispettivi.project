using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace corrispettivi.web.anomalie
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        private void Page_PreInit(object sender, System.EventArgs e)
        {
            if (Session["UserInfo"] != null)
            {
                Authorize.Based.UserInfo user = (Authorize.Based.UserInfo)Session["UserInfo"];
                Page.MasterPageFile = corrispettivi.tools.SystemFunction.SelectMasterPage(user.RoleName);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                if (Request.QueryString["x"] != null) cmbTipoAnomalia.SelectedValue = Request["x"].ToString();
                else cmbTipoAnomalia.SelectedValue = "0";
            }
        }

        protected void cmbTipoAnomalia_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            search();
        }

        protected void imgSearch_Click(object sender, ImageClickEventArgs e)
        {
            search();
        }

        protected void search()
        {
            gvInfo.DataBind();
            tbAction.Visible = true;
            tbAction.FindButtonByCommandName("expCsv").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expCsv").Value, cmbTipoAnomalia.SelectedValue, cmbTipoAnomalia.Text);
            tbAction.FindButtonByCommandName("expExcel").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expExcel").Value, cmbTipoAnomalia.SelectedValue, cmbTipoAnomalia.Text);
        }
    }
}