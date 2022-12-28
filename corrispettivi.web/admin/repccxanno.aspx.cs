using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace corrispettivi.web.admin
{
    public partial class repccxanno : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                if (Request.QueryString["x"] != null)
                {
                    cmbAnnoRif.SelectedValue = Request["x"].ToString();
                    tbAction.Visible = true;
                    search();
                }
                else
                {
                    tbAction.Visible = false;
                }
            }
        }

        protected void cmbAnnoRif_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            search();
        }

        protected void imgSearch_Click(object sender, ImageClickEventArgs e)
        {
            search();
        }

        protected void search()
        {
            foreach (GridColumn column in gvInfo.MasterTableView.OwnerGrid.Columns)
            {
                column.CurrentFilterFunction = GridKnownFunction.NoFilter;
                column.CurrentFilterValue = string.Empty;
            }
            gvInfo.MasterTableView.FilterExpression = string.Empty;
            gvInfo.DataBind();
            tbAction.Visible = true;
            tbAction.FindButtonByCommandName("expCsv").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expCsv").Value, cmbAnnoRif.SelectedValue);
            tbAction.FindButtonByCommandName("expExcel").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expExcel").Value, cmbAnnoRif.SelectedValue);
        }

        public string getPrefix(int col)
        {
            string ret = "";

            switch (col - 2)
            {
                case 1:
                    ret = "GEN";
                    break;
                case 2:
                    ret = "FEB";
                    break;
                case 3:
                    ret = "MAR";
                    break;
                case 4:
                    ret = "APR";
                    break;
                case 5:
                    ret = "MAG";
                    break;
                case 6:
                    ret = "GIU";
                    break;
                case 7:
                    ret = "LUG";
                    break;
                case 8:
                    ret = "AGO";
                    break;
                case 9:
                    ret = "SET";
                    break;
                case 10:
                    ret = "OTT";
                    break;
                case 11:
                    ret = "NOV";
                    break;
                case 12:
                    ret = "DIC";
                    break;
            }

            return ret;
        }
    }
}