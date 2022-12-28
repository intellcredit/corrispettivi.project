using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace corrispettivi.web.contabilita.commerciali.fatture
{
    public partial class expfatture : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                gvInfo.ExportSettings.FileName = string.Format("Fatture periodo {0}-{1}", Request["y"], Request["x"]);
                gvInfo.MasterTableView.ExportToExcel();
            }
        }
    }
}