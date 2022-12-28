using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace corrispettivi.web.admin
{
    public partial class repagexcontrollo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                tbAction.Visible = false;
                if ((Request.QueryString["x"] != null) && (Request.QueryString["Y"]) != null && (Request.QueryString["cc"] != null))
                {
                    cmbPeriodoRif.SelectedValue = string.Format("{0:00}/{1}", Convert.ToInt32(Request["y"]), Request["x"]);
                    setAction();
                }
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
            if (cmbPeriodoRif.SelectedValue != "")
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
        }

        protected void setAction()
        {
            tbAction.Visible = true;
            //tbAction.FindButtonByCommandName("expCsv").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expCsv").Value, cmbPeriodoRif.SelectedValue);
            tbAction.FindButtonByCommandName("expExcel").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expExcel").Value, cmbPeriodoRif.SelectedValue);
        }

        //protected void gvInfo_ItemDataBound(object sender, GridItemEventArgs e)
        //{
        //    int index = 0;

        //    if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem || e.Item.ItemType == GridItemType.Footer)
        //    {
        //        foreach (TableCell cell in e.Item.Cells)
        //        {
        //            index = e.Item.Cells.GetCellIndex(cell);
        //            if (index != 0) e.Item.Cells[index].Text = e.Item.Cells[index].Text.Replace("€ ", "");
        //        }
        //    }       
        //}
    }
}