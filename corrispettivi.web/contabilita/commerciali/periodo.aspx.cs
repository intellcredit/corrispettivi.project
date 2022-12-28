using System;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace corrispettivi.web.contabilita.commerciali
{
    public partial class periodo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                string sel;
                if (Request.QueryString["x"] != null) sel = Request["x"].ToString();
                else sel = DateTime.Now.ToShortDateString().Substring(3, 7);
                if (cmbPeriodoRif.Items.FindItemByValue(sel) != null) cmbPeriodoRif.SelectedValue = sel;
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
            tbAction.FindButtonByCommandName("expCsv").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expCsv").Value, cmbPeriodoRif.SelectedValue, Session["CallCenterID"].ToString());
            tbAction.FindButtonByCommandName("expExcel").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expExcel").Value, cmbPeriodoRif.SelectedValue, Session["CallCenterID"].ToString());
        }

        protected void gvInfo_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
            {
                GridDataItem item = (e.Item as GridDataItem);
                e.Item.Cells[4].BackColor = corrispettivi.tools.SystemFunction.GetTabulatoStatusColor(Convert.ToInt32(item.GetDataKeyValue("StatusID")));
                e.Item.Cells[5].BackColor = corrispettivi.tools.SystemFunction.GetFatturaStatusColor(Convert.ToInt32(item.GetDataKeyValue("FatturaStatusID")));
            }

            if (e.Item is GridNestedViewItem)
            {
                GridNestedViewItem nitem = (GridNestedViewItem)e.Item;

                Label p = (Label)nitem.FindControl("lblPeriodoRif");
                Label id = (Label)nitem.FindControl("lblCommercialeID");

                RadToolBar tbFatt = (RadToolBar)nitem.FindControl("tbFatture");
                IRadToolBarButton bRegFatt = tbFatt.FindButtonByCommandName("RegFatt");
                bRegFatt.NavigateUrl = string.Format(bRegFatt.NavigateUrl, p.Text.Substring(3, 4), p.Text.Substring(0, 2), id.Text);
            }
        }

        protected void gvFatture_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (e.Item as GridDataItem);
                string row = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["Row"].ToString();

                switch (row)
                {
                    case "3":
                        {
                            e.Item.BackColor = Color.LightGray;
                            e.Item.ForeColor = Color.Red;
                            e.Item.Font.Bold = true;
                            //e.Item.CssClass = "titrosso12";
                            break;
                        }
                }
            }
        }

        protected void gvInfo_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "ExpandCollapse")
            {
                if (!e.Item.Expanded)
                {
                    GridDataItem item = e.Item as GridDataItem;
                    GridNestedViewItem nestedItem = (GridNestedViewItem)item.ChildItem;
                    ((RadGrid)nestedItem.FindControl("gvFatture")).DataSourceID = "sdsFatture";
                }
            }
        }
    }
}