using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using it.tools.library;
using System.Configuration;
using Telerik.Web.UI;
using System.Data;

using authb = Authorize.Based;
using util = Utility.Library;

using Corrispettivi.Library;

namespace corrispettivi.web.settings.bsl_cg
{
    public partial class scheda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                if (Convert.ToInt32(Request["id"]) > 0)
                {
                    try
                    {
                        DataTable dt = paramBslCompensiGiornalieri.read(Convert.ToInt32(Request["id"]));
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];

                            cmbOreContratto.SelectedValue = row["OreContratto"].ToString();

                            txtCntNumMin.Value = Convert.ToInt32(row["CntNumMin"]);
                            txtCntNumMax.Value = Convert.ToInt32(row["CntNumMax"]);

                            txtCompenso.Value = Convert.ToDouble(row["Compenso"]);

                            if (validate.IsValidDate(row["DataInizio"].ToString()))
                                txtDataInizio.SelectedDate = Convert.ToDateTime(row["DataInizio"]);

                            if (validate.IsValidDate(row["DataFine"].ToString()))
                                txtDataFine.SelectedDate = Convert.ToDateTime(row["DataFine"]);

                            txtNote.Text = row["Note"].ToString();
                        }
                    }
                    catch (Exception)
                    {
                        lblMessage.Text = message.HtmlError("Si è verificata un anomalia durante il caricaremnto delle informazioni.<br />Se il problema persiste contattare l'assistenza.");
                        tbAction.Enabled = false;
                    }
                }
                else
                {
                    tbAction.FindItemByValue("btnDelete").Visible = false;
                    tbAction.FindItemByValue("sepDelete").Visible = false;
                }
            }
        }

        protected void tbAction_ButtonClick(object sender, Telerik.Web.UI.RadToolBarEventArgs e)
        {
            try
            {
                Result.Default result;

                int id = Convert.ToInt32(Request["id"]);

                switch (e.Item.Value)
                {
                    case "btnSave":
                    case "btnSaveClose":
                        {

                            result = paramBslCompensiGiornalieri.checkrange(id
                                                                    , Convert.ToInt32(cmbOreContratto.SelectedValue)
                                                                    , (DateTime)txtDataInizio.SelectedDate
                                                                    , txtDataFine.SelectedDate);
                            if (result.DESC == "OK")
                            {
                                result = paramBslCompensiGiornalieri.write(id
                                                                    , Convert.ToInt32(cmbOreContratto.SelectedValue)
                                                                    , (int)txtCntNumMin.Value
                                                                    , (int)txtCntNumMax.Value
                                                                    , (double)txtCompenso.Value
                                                                    , (DateTime)txtDataInizio.SelectedDate
                                                                    , txtDataFine.SelectedDate
                                                                    , txtNote.Text
                                                                    , ((authb.UserInfo)Session["UserInfo"]).Username);

                                if (result.DESC == "OK")
                                {
                                    Session["Result"] = eWebResult.Saved;

                                    if (e.Item.Value.ToString() == "btnSave")
                                    {
                                        string url = string.Format("scheda.aspx?id={0}", result.ID);
                                        Response.Redirect(url);
                                    }
                                    else
                                        Response.Redirect("default.aspx");
                                }
                            }
                            else
                            {
                                lblMessage.Text = message.HtmlExclamation(result.DESC);
                            }

                            break;
                        }
                    case "btnDelete":
                        {
                            result = paramBslCompensiGiornalieri.delete(id, ((authb.UserInfo)Session["UserInfo"]).Username);

                            if (result.DESC == "OK")
                            {
                                Session["Result"] = eWebResult.Deleted;

                                Response.Redirect("default.aspx");
                            }

                            break;
                        }
                    case "btnClose":
                        {
                            Response.Redirect("default.aspx");
                            break;
                        }
                }
            }
            catch (Exception ex)
            {
                if (ex.Message.StartsWith("ATTENZIONE!!"))
                    lblMessage.Text = message.HtmlExclamation(ex.Message);
                else
                    lblMessage.Text = message.HtmlError(ex.Message);
            }
        }
    }
}