using System;
using System.Web.UI;
using Telerik.Web.UI;

namespace corrispettivi.web.contabilita.commerciali
{
    public partial class expperiodo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                gvInfo.ExportSettings.FileName = string.Format("Report_periodo_{0}", Request["x"].Replace("/", "_"));
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

        protected void gvInfo_ExportCellFormatting(object source, ExcelExportCellFormattingEventArgs e)
        {
            switch (e.FormattedColumn.UniqueName)
            {
                case "C1":
                    e.Cell.Style["mso-number-format"] = @"\@";
                    break;
                case "money":
                    e.Cell.Style["mso-number-format"] = @"€0.00";
                    break;
                case "C3":
                    e.Cell.Style["mso-number-format"] = @"0000";
                    break;
                case "C4":
                    e.Cell.Style["mso-number-format"] = @"mm\/dd\/yyyy";
                    break;
            }
        }
    }
}