using System;
using System.Web.UI;
using it.tools.library;
using Telerik.Web.UI;
using System.Data;

using authb = Authorize.Based;
using util = Utility.Library;
using Corrispettivi.Library;

namespace corrispettivi.web.settings.bc_cm
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
                        DataTable dt = paramBcCompensiMensili.read(Convert.ToInt32(Request["id"]));
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];

                            cmbOreContratto.SelectedValue = row["OreContratto"].ToString();

                            txtCntNumMin.Value = Convert.ToInt32(row["CntNumMin"]);
                            txtCntNumMax.Value = Convert.ToInt32(row["CntNumMax"]);

                            txtCompenso.Value = Convert.ToDouble(row["Compenso"]);

                            if (validate.IsValidDate(row["DataInizio"].ToString()))
                            {
                                cmbAnnoInizio.SelectedValue = Convert.ToDateTime(row["DataInizio"]).Year.ToString();
                                cmbMeseInizio.SelectedValue = Convert.ToDateTime(row["DataInizio"]).Month.ToString();
                            }

                            if (validate.IsValidDate(row["DataFine"].ToString()))
                            {
                                cmbAnnoFine.SelectedValue = Convert.ToDateTime(row["DataFine"]).Year.ToString();
                                cmbMeseFine.SelectedValue = Convert.ToDateTime(row["DataFine"]).Month.ToString();
                            }

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

                            DateTime dtInizio = new DateTime(Convert.ToInt32(cmbAnnoInizio.SelectedValue), Convert.ToInt32(cmbMeseInizio.SelectedValue), 1);
                            DateTime? dtFine = null;
                            if ((cmbAnnoFine.SelectedValue != "") && (cmbMeseFine.SelectedValue != ""))
                                dtFine = new DateTime(Convert.ToInt32(cmbAnnoFine.SelectedValue), Convert.ToInt32(cmbMeseFine.SelectedValue), DateTime.DaysInMonth(Convert.ToInt32(cmbAnnoFine.SelectedValue), Convert.ToInt32(cmbMeseFine.SelectedValue)));

                            //result = paramCntCompensiMensili.checkrange(id
                            //                                            , Convert.ToInt32(cmbOreContratto.SelectedValue)
                            //                                            , dtInizio
                            //                                            , dtFine);
                            //if (result.DESC == "OK")
                            //{
                            result = paramBcCompensiMensili.write(id
                                                                , Convert.ToInt32(cmbOreContratto.SelectedValue)
                                                                , (int)txtCntNumMin.Value
                                                                , (int)txtCntNumMax.Value
                                                                , (double)txtCompenso.Value
                                                                , dtInizio
                                                                , dtFine
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
                            //}
                            //else
                            //{
                            //    lblMessage.Text = message.HtmlExclamation(result.DESC);
                            //}

                            break;
                        }
                    case "btnDelete":
                        {
                            result = paramBcCompensiMensili.delete(id, ((authb.UserInfo)Session["UserInfo"]).Username);

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
                    lblMessage.Text = Message.HtmlExclamation(ex.Message);
                else
                    lblMessage.Text = Message.HtmlError(ex.Message);
            }
        }
    }
}