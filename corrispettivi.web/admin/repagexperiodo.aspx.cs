using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

using Corrispettivi.Library;

namespace corrispettivi.web.admin
{
    public partial class repagexperiodo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                tbAction.Visible = false;
                if ((Request.QueryString["x"] != null) && (Request.QueryString["Y"]) != null && (Request.QueryString["cc"] != null))
                {
                    cmbPeriodoRif.SelectedValue = string.Format("{0:00}/{1}", Convert.ToInt32(Request["y"]), Request["x"]);
                    cmbCallCenter.SelectedValue = Request["cc"].ToString();
                    setAction();
                }
            }
        }

        protected void cmbPeriodoRif_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            search();
        }

        protected void cmbCallCenter_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            search();
        }

        protected void imgSearch_Click(object sender, ImageClickEventArgs e)
        {
            search();
        }

        protected void search()
        {
            if (cmbPeriodoRif.SelectedValue != "" && cmbCallCenter.SelectedValue != "")
            {
                foreach (GridColumn column in gvInfo.MasterTableView.OwnerGrid.Columns)
                {
                    column.CurrentFilterFunction = GridKnownFunction.NoFilter;
                    column.CurrentFilterValue = string.Empty;
                }
                gvInfo.MasterTableView.FilterExpression = string.Empty;
                gvInfo.DataBind();
                setAction();
            }
        }

        protected void setAction()
        {
            tbAction.Visible = true;
            tbAction.FindButtonByCommandName("expCsv").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expCsv").Value, cmbPeriodoRif.SelectedValue, cmbCallCenter.SelectedValue, cmbCallCenter.Text);
            tbAction.FindButtonByCommandName("expExcel").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expExcel").Value, cmbPeriodoRif.SelectedValue, cmbCallCenter.SelectedValue, cmbCallCenter.Text);
        }

        protected void viewCol()
        {
            DataTable dt = paramCallCenter.read(Convert.ToInt32(cmbCallCenter.SelectedValue)
                                                , cmbPeriodoRif.SelectedValue);
            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                //gvInfo.Columns[ (bool)row["AgentiBc"];

                //<telerik:GridBoundColumn DataField="AgentiBc"  HeaderText="Bonus contatti" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                //<telerik:GridBoundColumn DataField="AgentiCorrispettivi"  HeaderText="Corrispettivi" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                //<telerik:GridBoundColumn DataField="AgentiPremi"  HeaderText="Premi" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                //<telerik:GridBoundColumn DataField="AgentiIntegrazioni"  HeaderText="Bonus provvigionali" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                //<telerik:GridBoundColumn DataField="AgentiBe"  HeaderText="Bonus salva lavoro" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
            }
        }


        protected void gvInfo_ItemDataBound(object sender, GridItemEventArgs e)
        {
            int index = 0;

            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem || e.Item.ItemType == GridItemType.Footer)
            {
                foreach (TableCell cell in e.Item.Cells)
                {
                    index = e.Item.Cells.GetCellIndex(cell);
                    if (index != 0) e.Item.Cells[index].Text = e.Item.Cells[index].Text.Replace("€ ", "");
                }
            }
        }
    }
}