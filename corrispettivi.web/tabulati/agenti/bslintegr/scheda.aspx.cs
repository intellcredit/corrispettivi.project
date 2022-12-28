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

namespace corrispettivi.web.tabulati.agenti.bslintegr
{
    public partial class scheda : System.Web.UI.Page
    {
        protected util.WebApiObject.TokenResponse token;
        protected authb.SessionInfo sessionInfo;
        protected authb.UserInfo userInfo;


        protected void Page_PreInit(object sender, EventArgs e)
        {
            token = (util.WebApiObject.TokenResponse)Session["token"];
            sessionInfo = (authb.SessionInfo)Session["SessionInfo"];
            userInfo = sessionInfo.UserInfo;

            if (Page.IsPostBack != true)
            {
                if ((!string.IsNullOrEmpty(Request.QueryString["mp"])) && (Request["mp"].ToString() == "b"))
                    this.MasterPageFile = "~/blank.master";
                else
                {
                    if (Session["SessionInfo"] != null)
                    {
                        if (userInfo.RoleName == "UFFICIOPERSONALE") Page.MasterPageFile = "localUffPers.master";
                    }
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                cmbAnnoRif.SelectedValue = DateTime.Now.Year.ToString();
                cmbMeseRif.SelectedValue = DateTime.Now.Month.ToString();

                if (Convert.ToInt32(Request["id"]) > 0)
                {
                    try
                    {
                        DataTable dt = AgentiBsl.Integrazioni.read(Convert.ToInt32(Request["id"]));
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];
                            cmbAgenteGroupID.SelectedValue = row["AgenteGroupID"].ToString();
                            txtImporto.Value = Convert.ToDouble(row["Importo"]);
                            cmbAnnoRif.SelectedValue = row["AnnoRif"].ToString();
                            cmbMeseRif.SelectedValue = row["MeseRif"].ToString();
                            txtNote.Text = row["SystemInfo"].ToString();
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

                if ((!string.IsNullOrEmpty(Request.QueryString["mp"])) && (Request["mp"].ToString() == "b"))
                {
                    tbAction.Visible = false;
                    cmbAgenteGroupID.Enabled = false;
                    txtImporto.Enabled = false;
                    cmbAnnoRif.Enabled = false;
                    cmbMeseRif.Enabled = false;
                    txtNote.Enabled = false;
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
                            result = AgentiBsl.Integrazioni.check(id
                                                                , Convert.ToInt32(cmbAgenteGroupID.SelectedValue)
                                                                , Convert.ToInt32(cmbAnnoRif.SelectedValue)
                                                                , Convert.ToInt32(cmbMeseRif.SelectedValue));
                            if (result.DESC == "OK")
                            {
                                result = AgentiBsl.Integrazioni.write(id
                                            , Convert.ToInt32(cmbAgenteGroupID.SelectedValue)
                                            , (double)txtImporto.Value
                                            , Convert.ToInt32(cmbAnnoRif.SelectedValue)
                                            , Convert.ToInt32(cmbMeseRif.SelectedValue)
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
                                        Response.Redirect(string.Format("report.aspx?x={0}", Request["x"]));
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
                            result = AgentiBsl.Integrazioni.delete(id, ((authb.UserInfo)Session["UserInfo"]).Username);

                            if (result.DESC == "OK")
                            {
                                Session["Result"] = eWebResult.Deleted;

                                Response.Redirect(string.Format("report.aspx?x={0}", Request["x"]));
                            }

                            break;
                        }
                    case "btnClose":
                        {
                            Response.Redirect(string.Format("report.aspx?x={0}", Request["x"]));
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