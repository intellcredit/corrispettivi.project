using System;
using System.Data;
using System.Web.UI;
using Telerik.Web.UI;

using it.tools.library;
using authb = Authorize.Based;
using util = Utility.Library;
using Corrispettivi.Library;

namespace corrispettivi.web.settings.ag_ctr
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
                        DataTable dt = AgentiContratti.read(Convert.ToInt32(Request["id"]));
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];

                            lblPeriodoRif.Text = row["PeriodoRif"].ToString();
                            ViewState["AgenteGroupID"] = row["AgenteGroupID"];
                            lblAgente.Text = row["AgenteGroupAlias"].ToString();
                            lblCallCenter.Text = row["CallCenterNome"].ToString();

                            lblDataInizio.Text = String.Format("{0:dd/MM/yyyy}", row["DataInizioRapporto"]);
                            lblDataFine.Text = String.Format("{0:dd/MM/yyyy}", row["DataFineRapporto"]);

                            cmbOreGiornaliere.SelectedValue = row["OreGiornaliere"].ToString();
                            calcOreMensili(cmbOreGiornaliere.SelectedValue);

                            cmbTipoRetribuzioneID.SelectedValue = row["TipoRetribuzioneID"].ToString();

                            rowReWorksTab1.Visible = (lblPeriodoRif.Text == DateTime.Now.ToString("MM/yyyy"));
                            rowReWorksTab2.Visible = (lblPeriodoRif.Text == DateTime.Now.ToString("MM/yyyy"));
                            chkReWorksTab.Checked = (lblPeriodoRif.Text == DateTime.Now.ToString("MM/yyyy"));
                        }
                    }
                    catch (Exception)
                    {
                        lblMessage.Text = message.HtmlError("Si è verificata un anomalia durante il caricaremnto delle informazioni.<br />Se il problema persiste contattare l'assistenza.");
                        tbAction.Enabled = false;
                    }
                }
            }
        }

        protected void tbAction_ButtonClick(object sender, Telerik.Web.UI.RadToolBarEventArgs e)
        {
            try
            {
                Result.Default result;

                string url;
                int id = Convert.ToInt32(Request["id"]);

                switch (e.Item.Value)
                {
                    case "btnSave":
                    case "btnSaveClose":
                        {

                            result = AgentiContratti.write(id
                                                        , Convert.ToInt32(cmbOreGiornaliere.SelectedValue)
                                                        , Convert.ToInt32(lblOreMensili.Text)
                                                        , Convert.ToInt32(cmbTipoRetribuzioneID.SelectedValue)
                                                        , ((authb.UserInfo)Session["UserInfo"]).Username);

                            if (chkReWorksTab.Checked) reWorksTab();

                            if (result.DESC == "OK")
                            {
                                Session["Result"] = eWebResult.Saved;

                                if (e.Item.Value.ToString() == "btnSave")
                                {
                                    url = string.Format("scheda.aspx?id={0}", result.ID);
                                    Response.Redirect(url);
                                }
                                else
                                {
                                    url = string.Format("default.aspx?PeriodoRif={0}", lblPeriodoRif.Text);
                                    Response.Redirect(url);
                                }
                            }

                            break;
                        }
                    case "btnClose":
                        {
                            url = string.Format("default.aspx?PeriodoRif={0}", lblPeriodoRif.Text);
                            Response.Redirect(url);
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

        protected void cmbOreGiornaliere_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            calcOreMensili(cmbOreGiornaliere.SelectedValue);
            //if (cmbOreContratto.SelectedValue != "")
            //{
            //    calcOreMensili()
            //}
        }

        protected void calcOreMensili(string ore)
        {
            switch (ore.ToString())
            {
                case "2":
                    lblOreMensili.Text = "40";
                    break;
                case "4":
                    lblOreMensili.Text = "80";
                    break;
                case "6":
                    lblOreMensili.Text = "120";
                    break;
                case "8":
                    lblOreMensili.Text = "160";
                    break;
                default:
                    lblOreMensili.Text = "80";
                    break;
            }
        }

        protected Result.Default reWorksTab()
        {
            Result.Default result;

            lblActionMessage.Text = "Elaborazione bonus contatti in corso...";
            result = AgentiBc.ManualSingleElab((int)ViewState["AgenteGroupID"], lblPeriodoRif.Text);

            lblActionMessage.Text = "Elaborazione corrispettivi in corso...";
            result = AgentiCorrispettivi.ManualSingleElab((int)ViewState["AgenteGroupID"], lblPeriodoRif.Text);

            lblActionMessage.Text = "Elaborazione premi in corso ...";
            result = AgentiPremi.ManualSingleElab((int)ViewState["AgenteGroupID"], lblPeriodoRif.Text);

            lblActionMessage.Text = "Elaborazione bonus provvigionale in corso...";
            result = AgentiIntegrazioni.ManualSingleElab((int)ViewState["AgenteGroupID"], lblPeriodoRif.Text);

            lblActionMessage.Text = "Elaborazione bonus salva lavoro in corso...";
            result = AgentiBsl.Elaborazione.ManualSingleElab((int)ViewState["AgenteGroupID"], lblPeriodoRif.Text);

            lblActionMessage.Text = "Elaborazione terminata...";

            return result;
        }
    }
}