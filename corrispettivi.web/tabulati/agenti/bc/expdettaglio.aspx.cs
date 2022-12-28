using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace corrispettivi.web.tabulati.agenti.bc
{
    public partial class expdettaglio : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                gvInfo.ExportSettings.FileName = string.Format("REPORT_PRESENZE_{0}_AGENTE_{1}", Request["x"].Replace("/", "_"), Request["y"]);
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

        protected void gvInfo_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == RadGrid.ExportToExcelCommandName)
            {
                foreach (GridDataItem item in gvInfo.MasterTableView.Items)
                {
                    item["Agente"].Text = (item.FindControl("lblNome") as Label).Text;
                    item["Ore contratto"].Text = (item.FindControl("lblOreContratto") as Label).Text;
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