using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace corrispettivi.web.contabilita.callcenter.fatture
{
    public partial class expdefault : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                string chkfatt = "";
                switch (Request["chkFatt"].ToString())
                {
                    case "1":
                        {
                            chkfatt = " (non fatturati)";
                            break;
                        }
                    case "2":
                        {
                            chkfatt = " (fatt.parziali)";
                            break;
                        }
                    case "3":
                        {
                            chkfatt = " (fatturati)";
                            break;
                        }
                }

                gvInfo.ExportSettings.FileName = string.Format("Report_anno_{0}{1}", Request["x"].Replace("/", "_"), chkfatt);
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