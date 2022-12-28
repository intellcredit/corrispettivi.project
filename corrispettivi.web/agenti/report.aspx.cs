using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace corrispettivi.web.agenti
{
    public partial class report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblAgenteGroupID.Text = ((Authorize.Based.UserInfo)Session["UserInfo"]).EmployeeID;
        }



        protected void gvInfo_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
            {
                GridDataItem item = (e.Item as GridDataItem);
                e.Item.Cells[4].BackColor = corrispettivi.tools.SystemFunction.GetTabulatoStatusColor(Convert.ToInt32(item.GetDataKeyValue("StatusID")));


                //int anno = Convert.ToInt32(e.Item.Cells[0].Text);
                //int mese = Convert.ToInt32(e.Item.Cells[1].Text);

                //if ((anno == 2021 && mese >= 7) || anno > 2021)
                //{
                //    HyperLink lnkView = (HyperLink)item["view"].Controls[0];
                //    lnkView.NavigateUrl = lnkView.NavigateUrl.Replace("dettaglio.aspx", "dettaglioweek.aspx");

                //    HyperLink lnkExport = (HyperLink)item["export"].Controls[0];
                //    lnkExport.NavigateUrl = lnkExport.NavigateUrl.Replace("expdettaglio.aspx", "expdettaglioweek.aspx");
                //}
            }

            if (e.Item is GridNestedViewItem)
            {
                GridNestedViewItem nitem = (GridNestedViewItem)e.Item;
                RadToolBar tb = (RadToolBar)nitem.FindControl("tbAction");
                IRadToolBarButton b = tb.FindButtonByCommandName("Pdf");

                Label p = (Label)nitem.FindControl("lblPeriodoRif");

                b.NavigateUrl = string.Format(b.NavigateUrl, p.Text, lblAgenteGroupID.Text);
            }


        }

        protected void gvSummary_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (e.Item as GridDataItem);

                string row = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["Row"].ToString();

                switch (row)
                {
                    case "3":
                        {
                            e.Item.BackColor = Color.LightGray;
                            e.Item.Font.Bold = true;
                            break;
                        }
                    case "7":
                        {
                            e.Item.BackColor = Color.LightGray;
                            e.Item.Font.Bold = true;
                            break;
                        }
                    case "9":
                        {
                            e.Item.BackColor = Color.LightGray;
                            e.Item.CssClass = "titrosso12";
                            break;
                        }
                }
            }
        }

        protected void gvTabulati_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
            {
                GridDataItem item = (e.Item as GridDataItem);
                e.Item.Cells[8].BackColor = corrispettivi.tools.SystemFunction.GetTabulatoStatusColor(Convert.ToInt32(item.GetDataKeyValue("StatusID")));
            }
        }
    }
}