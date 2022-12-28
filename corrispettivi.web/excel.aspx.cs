using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using ClosedXML.Excel;
using Corrispettivi.Library;

namespace corrispettivi.web
{
    public partial class excel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string filename = "";
            DataTable dt = new DataTable();

            switch (Request["type"])
            {
                case "bslReport":
                    {
                        filename = string.Format("REPORT1_BSL_{0}", Request["rif"].Replace("/", "_"));
                        dt = AgentiBsl.Elaborazione.view(Request["rif"], true);
                        break;
                    }
                case "fineMese":
                    {
                        filename = string.Format("REPORT_FINE_MESE_{0}", Request["rif"].Replace("/", "_"));
                        dt = AgentiBsl.Elaborazione.finemese(Request["rif"]);
                        break;
                    }
                case "bslIntegrReport":
                    {
                        filename = string.Format("REPORT_BSL_INTEGRAZIONI_{0}", Request["rif"].Replace("/", "_"));
                        dt = AgentiBsl.Integrazioni.view(Request["rif"]);
                        break;
                    }
                case "bslOreStraordReport":
                    {
                        filename = string.Format("REPORT_BSL_ORE_ECCED_PRENOTAZIONE_{0}", Request["rif"].Replace("/", "_"));
                        dt = AgentiBsl.OreStraordinarie.export(Request["rif"]);
                        break;
                    }
                case "controlReport":
                    {
                        filename = string.Format("REPORT_CONTROLLO_{0}", Request["rif"].Replace("/", "_"));
                        dt = Report.AgentiControllo(Request["rif"]);
                        break;
                    }
            }

            if (dt.Rows.Count > 0)
            {
                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Worksheets.Add(dt, "Report");
                    Response.Clear();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", string.Format("attachment;filename={0}.xlsx", filename));
                    using (MemoryStream MyMemoryStream = new MemoryStream())
                    {
                        wb.SaveAs(MyMemoryStream);
                        MyMemoryStream.WriteTo(Response.OutputStream);
                        Response.Flush();
                        Response.End();
                    }
                }
            }
        }
    }
}