using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace corrispettivi.web.callcenter
{
    public partial class report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                string sel;
                if (Request.QueryString["x"] != null) sel = Request["x"].ToString();
                else sel = DateTime.Now.Year.ToString();
                if (cmbAnnoRif.Items.FindItemByValue(sel) != null) cmbAnnoRif.SelectedValue = sel;
                //else cmbAnnoRif.SelectedIndex = 0;
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

            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem || e.Item.ItemType == GridItemType.Footer)
            {
                foreach (TableCell cell in e.Item.Cells)
                {
                    index = e.Item.Cells.GetCellIndex(cell);

                    if (e.Item.ItemType != GridItemType.Footer && index >= 3 && index <= 14)
                    {
                        e.Item.Cells[index].BackColor = corrispettivi.tools.SystemFunction.GetTabulatoStatusColor(Convert.ToInt32(item.GetDataKeyValue(corrispettivi.tools.SystemFunction.GetMonthPrefix(index) + "_StatusID")));
                    }
                }
            }
        }
    }
}