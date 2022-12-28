using System;
using System.Web.UI;

namespace corrispettivi.web.contabilita.callcenter
{
    public partial class expreport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                gvInfo.ExportSettings.FileName = string.Format("Report_anno_{0}", Request["x"].Replace("/", "_"));
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
                }
            }
        }
    }
}