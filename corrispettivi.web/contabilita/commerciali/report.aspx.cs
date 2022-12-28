using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace corrispettivi.web.contabilita.commerciali
{
    public partial class report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                if (Request.QueryString["x"] != null) cmbAnnoRif.SelectedValue = Request["x"].ToString();
                else cmbAnnoRif.SelectedValue = DateTime.Now.Year.ToString();
                setAction();
            }
        }

        protected void cmbAnnoRif_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
            tbAction.FindButtonByCommandName("expCsv").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expCsv").Value, cmbAnnoRif.SelectedValue);
            tbAction.FindButtonByCommandName("expExcel").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expExcel").Value, cmbAnnoRif.SelectedValue);
        }

        protected void gvInfo_ItemDataBound(object sender, GridItemEventArgs e)
        {
            GridDataItem item = e.Item as GridDataItem;
            int index = 0;

            if (e.Item.ItemType == GridItemType.Header)
            {
                foreach (TableCell cell in e.Item.Cells)
                {
                    index = e.Item.Cells.GetCellIndex(cell);
                    if (index >= 3 && index <= 14)
                        e.Item.Cells[index].Text = string.Format("<a href='periodo.aspx?x={1:00}/{2}'>{0}</>"
                                                                , e.Item.Cells[index].Text
                                                                , (index - 2)
                                                                , cmbAnnoRif.SelectedValue);
                }
            }

            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem || e.Item.ItemType == GridItemType.Footer)
            {
                foreach (TableCell cell in e.Item.Cells)
                {
                    index = e.Item.Cells.GetCellIndex(cell);

                    if (e.Item.ItemType != GridItemType.Footer && index >= 3 && index <= 14)
                    {

                        e.Item.Cells[index].BackColor = corrispettivi.tools.SystemFunction.GetFatturaStatusColor(Convert.ToInt32(item.GetDataKeyValue(corrispettivi.tools.SystemFunction.GetMonthPrefix(index) + "_CheckFattura").ToString()));

                        HyperLink c = (HyperLink)e.Item.Cells[index].Controls[0];
                        c.ToolTip = string.Format("Saldo -{0}€", Convert.ToDouble(item.GetDataKeyValue(corrispettivi.tools.SystemFunction.GetMonthPrefix(index) + "_Saldo")));
                        e.Item.Cells[index].ToolTip = c.ToolTip;
                    }
                }
            }
        }
    }
}