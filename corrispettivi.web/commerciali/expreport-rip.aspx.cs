using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace corrispettivi.web.commerciali
{
    public partial class expreport_rip : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void gvSummary_ItemDataBound(object sender, GridItemEventArgs e)
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
                            e.Item.ForeColor = Color.Red;
                            e.Item.Font.Bold = true;
                            break;
                        }
                }
            }
        }
    }
}