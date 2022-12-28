using System;
using System.Web.UI;
using System.Data;

using Telerik.Web.UI;

using authb = Authorize.Based;
using it.tools.library;
using util = Utility.Library;

using Corrispettivi.Library;

namespace corrispettivi.web.settings.callcenter
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
                        DataTable dt = paramCallCenter.read(Convert.ToInt32(Request["id"]));
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];

                            cmbCallCenter.SelectedValue = row["CallCenterID"].ToString();

                            cmbTipoElaborazioneID.SelectedValue = row["TipoElaborazioneID"].ToString();

                            chkAgentiCorrispettivi.Checked = Convert.ToBoolean(row["execAgentiCorrispettivi"]);
                            chkAgentiPremi.Checked = Convert.ToBoolean(row["execAgentiPremi"]);
                            chkAgentiPremi.Checked = Convert.ToBoolean(row["execAgentiIntegrazioni"]);
                            chkAgentiPremi.Checked = Convert.ToBoolean(row["execAgentiSpese"]);
                            chkAgentiBc.Checked = Convert.ToBoolean(row["execAgentiBc"]);
                            chkAgentiBsl.Checked = Convert.ToBoolean(row["execAgentiBsl"]);
                            cbkAgentiOreStraordinarie.Checked = Convert.ToBoolean(row["execAgentiOreStraordinarie"]);

                            chkAdmin.Checked = Convert.ToBoolean(row["viewAmministratore"]);
                            chkDirezione.Checked = Convert.ToBoolean(row["viewDirezione"]);
                            chkContabilitaCallCenter.Checked = Convert.ToBoolean(row["viewContabilitaCallCenter"]);
                            chkContabilitaAgenti.Checked = Convert.ToBoolean(row["viewContabilitaAgenti"]);
                            chkContabilitaProcuratori.Checked = Convert.ToBoolean(row["viewContabilitaProcuratori"]);
                            chkUffPersonale.Checked = Convert.ToBoolean(row["viewUffPersonale"]);

                            setOreLavorative();
                            chkOreLavorative.Checked = Convert.ToBoolean(row["viewOreLavorative"]);

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

                            result = paramCallCenter.checkrange(id
                                                            , Convert.ToInt32(cmbCallCenter.SelectedValue)
                                                            , dtInizio
                                                            , dtFine);
                            if (result.DESC == "OK")
                            {
                                result = paramCallCenter.write(id
                                                            , Convert.ToInt32(cmbCallCenter.SelectedValue)
                                                            , chkAgentiCorrispettivi.Checked
                                                            , chkAgentiBsl.Checked
                                                            , chkAgentiBc.Checked
                                                            , chkAgentiPremi.Checked
                                                            , chkAgentiIntegrazioni.Checked
                                                            , chkAgentiSpese.Checked
                                                            , cbkAgentiOreStraordinarie.Checked
                                                            , chkAdmin.Checked
                                                            , chkDirezione.Checked
                                                            , chkContabilitaCallCenter.Checked
                                                            , chkContabilitaAgenti.Checked
                                                            , chkContabilitaProcuratori.Checked
                                                            , chkUffPersonale.Checked
                                                            , Convert.ToInt32(cmbTipoElaborazioneID.SelectedValue)
                                                            , chkOreLavorative.Checked
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
                            }
                            else
                            {
                                lblMessage.Text = message.HtmlExclamation(result.DESC);
                            }

                            break;
                        }
                    case "btnDelete":
                        {
                            result = paramCallCenter.delete(id, ((authb.UserInfo)Session["UserInfo"]).Username);

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

        protected void chkAgentiBc_CheckedChanged(object sender, EventArgs e)
        {
            setOreLavorative();
        }

        private void setOreLavorative()
        {
            if (chkAgentiBc.Checked)
            {
                chkOreLavorative.Enabled = true;
                chkOreLavorative.Checked = true;
            }
            else
            {
                chkOreLavorative.Enabled = false;
                chkOreLavorative.Checked = false;
            }
        }
    }
}