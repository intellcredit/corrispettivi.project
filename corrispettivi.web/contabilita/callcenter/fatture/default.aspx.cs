using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace corrispettivi.web.contabilita.callcenter.fatture
{
    public partial class _default : System.Web.UI.Page
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

        protected void cmbMeseRif_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            search();
        }

        protected void cmbStatusFattura_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            search();
        }

        protected void imgSearch_Click(object sender, ImageClickEventArgs e)
        {
            search();
        }

        protected void search()
        {
            gvInfo.DataBind();
            tbAction.Visible = true;
            tbAction.FindButtonByCommandName("expCsv").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expCsv").Value, cmbAnnoRif.SelectedValue, cmbStatusFattura.SelectedValue);
            tbAction.FindButtonByCommandName("expExcel").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expExcel").Value, cmbAnnoRif.SelectedValue, cmbStatusFattura.SelectedValue);
        }

        protected void gvInfo_ItemDataBound(object sender, GridItemEventArgs e)
        {
            GridDataItem item = e.Item as GridDataItem;
            int index = 0;

            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem || e.Item.ItemType == GridItemType.Footer)
            {
                foreach (TableCell cell in e.Item.Cells)
                {
                    index = e.Item.Cells.GetCellIndex(cell);

                    if (e.Item.ItemType != GridItemType.Footer && index >= 3 && index <= 14)
                    {

                        e.Item.Cells[index].BackColor = corrispettivi.tools.SystemFunction.GetFatturaStatusColor(Convert.ToInt32(item.GetDataKeyValue("StatusFatturaID").ToString()));

                        //switch (Convert.ToInt32(item.GetDataKeyValue("StatusFatturaID").ToString()))
                        //{
                        //    case 1:
                        //        e.Item.BackColor = Color.Pink;
                        //        break;
                        //    case 2:
                        //        e.Item.BackColor = Color.Yellow;
                        //        break;
                        //    case 3:
                        //        e.Item.BackColor = Color.LightGreen;
                        //        break;
                        //    default:
                        //        break;
                        //}
                    }
                }
            }
        }
    }
}