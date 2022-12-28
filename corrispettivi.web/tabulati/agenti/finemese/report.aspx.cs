using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using ClosedXML.Excel;
using System.IO;

using authb = Authorize.Based;
using util = Utility.Library;
using Corrispettivi.Library;

namespace corrispettivi.web.tabulati.agenti.finemese
{
    public partial class report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                string value;

                if (Request.QueryString["x"] != null) value = Request["x"].ToString();
                else value = DateTime.Now.ToShortDateString().Substring(3, 7);

                if (cmbPeriodoClose.Items.FindItemByValue(value) != null)
                    cmbPeriodoClose.SelectedValue = Request["x"].ToString();

                setAction();
            }
        }

        protected void cmbPeriodoClose_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
            if (cmbPeriodoClose.SelectedValue != "")
            {
                tbAction.Visible = true;
                //tbAction.FindButtonByCommandName("expCsv").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expCsv").Value, cmbPeriodoClose.SelectedValue);
                tbAction.FindButtonByCommandName("expExcel").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expExcel").Value, cmbPeriodoClose.SelectedValue);
            }
            else
                tbAction.Visible = false;
        }

        protected void tbAction_ButtonClick(object sender, RadToolBarEventArgs e)
        {
            switch (e.Item.Value)
            {
                case "tabReworks":
                    {
                        AgentiBsl.Elaborazione.tabReworks(
                                                          cmbPeriodoClose.SelectedValue
                                                        , ((authb.UserInfo)Session["UserInfo"]).Username
                                                            );
                        search();
                        break;
                    }
                case "setStatusClosed":
                    {
                        AgentiBsl.Elaborazione.setStatusClosed(cmbPeriodoClose.SelectedValue);
                        search();
                        break;
                    }
            }
        }
    }
}