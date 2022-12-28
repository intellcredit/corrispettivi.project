using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace corrispettivi.web.callcenter
{
    public partial class summary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsPostBack != true)
                {
                    string sel;
                    if (Request.QueryString["x"] != null) sel = Request["x"].ToString();
                    else sel = DateTime.Now.ToShortDateString().Substring(3, 7);

                    if (cmbPeriodoRif.Items.FindItemByValue(sel) != null) cmbPeriodoRif.SelectedValue = sel;
                    setAction();
                }

                DataView dv = (DataView)sdsInfo.Select(DataSourceSelectArguments.Empty);
                if (dv != null)
                {
                    tbAction.Visible = true;
                    tblStatus.Visible = true;
                    foreach (DataRowView row in dv)
                    {
                        lblStatusDesc.Text = row["StatusDesc"].ToString();
                        lblStatusInfo.Text = row["StatusInfo"].ToString();
                        Color c = corrispettivi.tools.SystemFunction.GetTabulatoStatusColor(Convert.ToInt32(row["StatusID"]));
                        tblStatus.BgColor = ColorTranslator.ToHtml(c);
                    }
                }
                else
                {
                    tbAction.Visible = false;
                    tblStatus.Visible = false;
                }

            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
        }

        protected void cmbPeriodoRif_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            search();
        }

        protected void imgSearch_Click(object sender, ImageClickEventArgs e)
        {
            search();
        }

        protected void search()
        {
            try
            {
                gvSummary.DataBind();
                setAction();
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
        }

        protected void setAction()
        {
            try
            {
                tbAction.Visible = true;
                tbAction.FindButtonByCommandName("expPdf").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expPdf").Value, cmbPeriodoRif.SelectedValue, Session["CallCenterID"].ToString());
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
        }

        protected void gvSummary_ItemDataBound(object sender, GridItemEventArgs e)
        {
            try
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
                                e.Item.ForeColor = Color.Red;
                                e.Item.Font.Bold = true;
                                break;
                            }
                        case "999":
                            {
                                e.Item.BackColor = Color.LightGray;
                                e.Item.ForeColor = Color.Red;
                                e.Item.Font.Bold = true;
                                break;
                            }
                    }
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
        }

        protected void gvTabulati_ItemDataBound(object sender, GridItemEventArgs e)
        {
            try
            {
                if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
                {
                    GridDataItem item = (e.Item as GridDataItem);
                    e.Item.Cells[8].BackColor = corrispettivi.tools.SystemFunction.GetTabulatoStatusColor(Convert.ToInt32(item.GetDataKeyValue("StatusID")));
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
        }
    }
}