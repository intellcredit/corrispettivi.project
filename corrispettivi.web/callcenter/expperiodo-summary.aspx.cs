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
    public partial class expperiodo_summary : System.Web.UI.Page
    {
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

        protected void gvInfo_PreRender(object sender, EventArgs e)
        {
            gvInfo.ExportSettings.FileName = string.Format("Summary_{0}_{1}", Request["x"].Replace("/", "_"), Request["y"]);
            foreach (GridDataItem gi in gvInfo.MasterTableView.Items)
            {
                gi.Expanded = true;
            }

            switch (Request["mode"].ToString())
            {
                case "csv":
                    {
                        gvInfo.MasterTableView.ExportToCSV();
                        break;
                    }
                case "xls":
                    {
                        gvInfo.MasterTableView.ExportToExcel();
                        break;
                    }
                case "pdf":
                    {
                        gvInfo.MasterTableView.ExportToPdf();
                        break;
                    }
            }
        }
    }
}