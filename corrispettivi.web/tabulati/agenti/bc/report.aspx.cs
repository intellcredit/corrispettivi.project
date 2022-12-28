using System;
using System.Web.UI;
using System.Web.UI.WebControls;

using Telerik.Web.UI;

namespace corrispettivi.web.tabulati.agenti.bc
{
    public partial class report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                if (Request.QueryString["x"] != null) cmbPeriodoRif.SelectedValue = Request["x"].ToString();
                else cmbPeriodoRif.SelectedValue = DateTime.Now.ToShortDateString().Substring(3, 7);
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
        }

        protected void gvInfo_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            int mese = Convert.ToInt32(cmbPeriodoRif.SelectedValue.Split('/')[0]);
            int anno = Convert.ToInt32(cmbPeriodoRif.SelectedValue.Split('/')[1]);

            if ((anno == 2021 && mese >= 7) || anno > 2021)
            {
                if (e.Item is GridDataItem)
                {
                    GridDataItem item = (GridDataItem)e.Item;

                    HyperLink lnkView = (HyperLink)item["view"].Controls[0];
                    lnkView.NavigateUrl = lnkView.NavigateUrl.Replace("dettaglio.aspx", "dettaglioweek.aspx");

                    HyperLink lnkExport = (HyperLink)item["export"].Controls[0];
                    lnkExport.NavigateUrl = lnkExport.NavigateUrl.Replace("expdettaglio.aspx", "expdettaglioweek.aspx");
                }
            }
        }
    }
}