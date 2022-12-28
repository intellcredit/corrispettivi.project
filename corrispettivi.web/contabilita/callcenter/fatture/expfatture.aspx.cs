using System;
using System.Web.UI;

namespace corrispettivi.web.contabilita.callcenter.fatture
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