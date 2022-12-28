using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;

using authb = Authorize.Based;
using util = Utility.Library;

namespace corrispettivi.web.tabulati.agenti.bslintegr
{
    public partial class report : System.Web.UI.Page
    {
        protected util.WebApiObject.TokenResponse token;
        protected authb.SessionInfo sessionInfo;
        protected authb.UserInfo userInfo;


        protected void Page_PreInit(object sender, EventArgs e)
        {
            token = (util.WebApiObject.TokenResponse)Session["token"];
            sessionInfo = (authb.SessionInfo)Session["SessionInfo"];
            userInfo = sessionInfo.UserInfo;

            if (Page.IsPostBack != true)
            {
                if (Session["SessionInfo"] != null)
                {
                    if (userInfo.RoleName == "UFFICIOPERSONALE") Page.MasterPageFile = "localUffPers.master";
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                string value;

                if (Request.QueryString["x"] != null)
                    value = Request["x"].ToString();
                else
                    value = DateTime.Now.ToShortDateString().Substring(3, 7);

                if (cmbPeriodoRif.Items.FindItemByValue(value) != null)
                    cmbPeriodoRif.SelectedValue = Request["x"].ToString();

                setAction();
            }
        }

        protected void cmbPeriodoRif_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            search();
        }

        protected void imgSearch_Click(object sender, ImageClickEventArgs e)
        {
            search();
        }

        protected void search()
        {
            foreach (GridColumn column in gvInfo.MasterTableView.OwnerGrid.Columns)
            {
                column.CurrentFilterFunction = GridKnownFunction.NoFilter;
                column.CurrentFilterValue = string.Empty;
            }
            gvInfo.MasterTableView.FilterExpression = string.Empty;
            gvInfo.DataBind();
            setAction();
        }

        protected void setAction()
        {
            tbAction.Visible = true;
            tbAction.FindButtonByCommandName("expCsv").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expCsv").Value, cmbPeriodoRif.SelectedValue);
            tbAction.FindButtonByCommandName("expExcel").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expExcel").Value, cmbPeriodoRif.SelectedValue);

            // per utenti diversi da:
            // SuperAdmin, Admin e Direzione
            // disabilita il men "azioni"
            if (!(userInfo.RoleName == "SUPERADMIN" || userInfo.RoleName == "ADMIN" || userInfo.RoleName == "DIREZIONE"))
                gvInfo.Columns[0].Visible = false;
        }

        protected void gvInfo_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;

                if (Convert.ToInt32(item.GetDataKeyValue("StatusID")) == 4 && userInfo.RoleName == "UFFICIOPERSONALE")
                    item.Cells[2].Text = "";
            }
        }
    }
}