using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

using Corrispettivi.Library;

namespace corrispettivi.web
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void gvInfo_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
            {
                if (e.Item.OwnerTableView.Name == "details")
                {
                    foreach (TableCell cell in e.Item.Cells)
                    {
                        if (e.Item.Cells.GetCellIndex(cell) == 2)
                        {
                            if (cell.Text == "&nbsp;" || cell.Text == "")
                                e.Item.Cells[4].Text = "";
                        }
                        if (e.Item.Cells.GetCellIndex(cell) == 3)
                        {
                            if (cell.Text == "&nbsp;" || cell.Text == "")
                                e.Item.Cells[5].Text = "";
                        }
                    }
                }
            }
        }

        protected void gvInfo_DetailTableDataBind(object source, Telerik.Web.UI.GridDetailTableDataBindEventArgs e)
        {
            GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
            string idAgente = dataItem.GetDataKeyValue("AgenteGroupID").ToString();
            string ore = dataItem.GetDataKeyValue("OreContratto").ToString();
            string idCallCenter = dataItem.GetDataKeyValue("CallCenterID").ToString();

            RadGrid gv = (RadGrid)dataItem.FindControl("gvDetails");
            gv.DataSource = Tabulati.Dettaglio(cmbPeriodoRif.SelectedValue, Convert.ToInt32(idAgente), Convert.ToInt32(ore), Convert.ToInt32(idCallCenter));
            gv.DataBind();
        }


        protected void LoadTabStip_TabClick(object sender, RadTabStripEventArgs e)
        {
            string selectedtabindex = e.Tab.Text;
            RadGrid grdSample = new RadGrid();
            grdSample.ID = "grdSample" + selectedtabindex;
            grdSample.Width = Unit.Pixel(300);
            switch (selectedtabindex)
            {
                case "Details":
                    {
                        e.Tab.PageView.Controls.Add(grdSample);
                        grdSample.DataSource = "";
                        grdSample.Rebind();
                        break;
                    }
                case "Compartments":
                    {
                        e.Tab.PageView.Controls.Add(grdSample);
                        grdSample.DataSource = "";
                        grdSample.Rebind();
                        break;
                    }
                case "Products":
                    {
                        //To populate a grid which is already declared in the PageView
                        RadPageView page = (RadPageView)e.Tab.PageView;
                        RadGrid grdProduct = (RadGrid)page.FindControl("grdProducts");
                        grdProduct.DataSource = "";
                        grdProduct.Rebind();
                        break;
                    }
            }
        }
    }
}
