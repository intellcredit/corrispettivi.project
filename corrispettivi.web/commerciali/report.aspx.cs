using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace corrispettivi.web.commerciali
{
    public partial class report : System.Web.UI.Page
    {
        protected void gvInfo_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
            {
                GridDataItem item = (e.Item as GridDataItem);
                e.Item.Cells[6].BackColor = corrispettivi.tools.SystemFunction.GetTabulatoStatusColor(Convert.ToInt32(item.GetDataKeyValue("StatusID")));
            }
        }
    }
}