using System;
using System.Linq;
using System.Web.UI;
using Telerik.Web.UI;

using Corrispettivi.Library;

namespace corrispettivi.web.settings.ag_ctr
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                if (Request.Params.AllKeys.Contains("PeriodoRif"))
                    cmbPeriodoRif.SelectedValue = Request["PeriodoRif"];
                else
                    cmbPeriodoRif.SelectedValue = DateTime.Now.ToString("MM/yyyy");


                if (Session["Result"] != null)
                {
                    switch ((eWebResult)Session["Result"])
                    {
                        case eWebResult.Saved:
                            {
                                lblAction.Text = Message.HtmlSaved("Record aggiornato correttamente!");
                                break;
                            }
                        case eWebResult.Deleted:
                            {
                                lblAction.Text = Message.HtmlSaved("Record eliminato correttamente!");
                                break;
                            }
                        case eWebResult.Duplicated:
                            {
                                lblAction.Text = Message.HtmlSaved("Record duplicato correttamente!");
                                break;
                            }
                    }
                    Session["Result"] = null;
                }
                else
                {
                    lblAction.Text = "";
                }
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
            foreach (GridColumn column in gvInfo.MasterTableView.OwnerGrid.Columns)
            {
                column.CurrentFilterFunction = GridKnownFunction.NoFilter;
                column.CurrentFilterValue = string.Empty;
            }
            gvInfo.MasterTableView.FilterExpression = string.Empty;
            gvInfo.DataBind();
        }
    }
}