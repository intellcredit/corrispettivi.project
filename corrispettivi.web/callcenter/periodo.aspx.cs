using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace corrispettivi.web.callcenter
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
                //else cmbPeriodoRif.SelectedIndex = 0;
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
            tbAction.FindButtonByCommandName("expPdf").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expPdf").Value, cmbPeriodoRif.SelectedValue, Session["CallCenterID"].ToString());
        }

        protected void gvInfo_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
            {
                GridDataItem item = (e.Item as GridDataItem);
                e.Item.Cells[3].BackColor = corrispettivi.tools.SystemFunction.GetTabulatoStatusColor(Convert.ToInt32(item.GetDataKeyValue("StatusID")));
            }

            if (e.Item is GridNestedViewItem)
            {
                GridNestedViewItem nitem = (GridNestedViewItem)e.Item;
                RadToolBar tb = (RadToolBar)nitem.FindControl("tbAction");
                IRadToolBarButton b = tb.FindButtonByCommandName("Pdf");

                Label p = (Label)nitem.FindControl("lblPeriodoRif");
                Label id = (Label)nitem.FindControl("lblAgenteGroupID");

                b.NavigateUrl = string.Format(b.NavigateUrl, p.Text, id.Text);

                //Label lbl = (Label)item.FindControl("Label1");
                //RadGrid grid = (RadGrid)item.FindControl("RadGrid2");
            }
        }

        protected void gvSummary_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            //if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
            {
                GridDataItem dataItem = (e.Item as GridDataItem);

                string row = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["Row"].ToString();

                switch (row)
                {
                    case "3":
                        {
                            e.Item.BackColor = Color.LightGray;
                            e.Item.Font.Bold = true;
                            break;
                        }
                    case "7":
                        {
                            e.Item.BackColor = Color.LightGray;
                            e.Item.Font.Bold = true;
                            break;
                        }
                    case "9":
                        {
                            e.Item.BackColor = Color.LightGray;
                            //e.Item.ForeColor = Color.Red;
                            //e.Item.Font.Bold = true;
                            e.Item.CssClass = "titrosso12";
                            break;
                        }
                }
            }
        }

        protected void gvTabulati_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
            {
                GridDataItem item = (e.Item as GridDataItem);
                e.Item.Cells[8].BackColor = corrispettivi.tools.SystemFunction.GetTabulatoStatusColor(Convert.ToInt32(item.GetDataKeyValue("StatusID")));
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
                    ((RadGrid)nestedItem.FindControl("gvTabulati")).DataSourceID = "sdsTabulati";
                    ((RadGrid)nestedItem.FindControl("gvSummary")).DataSourceID = "sdsSummary";
                    ((RadGrid)nestedItem.FindControl("gvAnticipato")).DataSourceID = "sdsAnticipato";
                }
            }
        }
    }
}