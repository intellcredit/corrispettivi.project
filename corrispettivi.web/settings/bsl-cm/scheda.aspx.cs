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

namespace corrispettivi.web.settings.bsl_cm
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
                        DataTable dt = paramBslCompensiMensili.read(Convert.ToInt32(Request["id"]));
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];

                            cmbTipoRetribuzione.SelectedValue = row["TipoRetribuzioneID"].ToString();

                            cmbOreContratto.SelectedValue = row["OreGiornaliereCtr"].ToString();
                            calcOreMensili();
                            txtOreMensFranchigia.Value = Convert.ToInt32(row["OreMensiliFranchigia"]);
                            txtOreMensMax.Value = Convert.ToInt32(row["OreMensiliMax"]);

                            txtImpMinMensile.Value = Convert.ToDouble(row["ImpMinMensile"]);
                            txtImpOrario.Value = Convert.ToDouble(row["ImpOrario"]);
                            txtImpPenaleOraria.Value = Convert.ToDouble(row["ImpPenaleOraria"]);

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

                            result = paramBslCompensiMensili.checkrange(id
                                                                        , Convert.ToInt32(cmbTipoRetribuzione.SelectedValue)
                                                                        , Convert.ToInt32(cmbOreContratto.SelectedValue)
                                                                        , dtInizio
                                                                        , dtFine);
                            if (result.DESC == "OK")
                            {
                                result = paramBslCompensiMensili.write(id
                                                                    , Convert.ToInt32(cmbTipoRetribuzione.SelectedValue)
                                                                    , Convert.ToInt32(cmbOreContratto.SelectedValue)
                                                                    , (int)txtOreMensCtr.Value
                                                                    , (int)txtOreMensFranchigia.Value
                                                                    , (int)txtOreMensMax.Value
                                                                    , (double)txtImpMinMensile.Value
                                                                    , (double)txtImpOrario.Value
                                                                    , (double)txtImpPenaleOraria.Value
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
                            result = paramBslCompensiMensili.delete(id, ((authb.UserInfo)Session["UserInfo"]).Username);

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

        protected void cmbOreContratto_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            calcOreMensili();
            //if (cmbOreContratto.SelectedValue != "")
            //{
            //    calcOreMensili()
            //}
        }

        protected void calcOreMensili()
        {
            switch (cmbOreContratto.SelectedValue)
            {
                case "2":
                    txtOreMensCtr.Value = 40;
                    txtOreMensMax.MinValue = 40;
                    break;
                case "4":
                    txtOreMensCtr.Value = 80;
                    txtOreMensMax.MinValue = 80;
                    break;
                case "6":
                    txtOreMensCtr.Value = 120;
                    txtOreMensMax.MinValue = 120;
                    break;
                case "8":
                    txtOreMensCtr.Value = 160;
                    txtOreMensMax.MinValue = 160;
                    break;
                default:
                    txtOreMensCtr.Value = 0;
                    break;
            }
        }
    }
}