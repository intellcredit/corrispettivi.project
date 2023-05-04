using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;

using Telerik.Web.UI;
using Corrispettivi.Library;
using it.tools.library;


namespace corrispettivi.web.tabulati.agenti.manuale
{
    public partial class scheda : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            //if ((!string.IsNullOrEmpty(Request.QueryString["mp"])) && (Request["mp"].ToString() == "b"))
            //    this.MasterPageFile = "~/blank.master";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //sep1.Visible = false;
            //tbAction.Visible = false;
            tbAction.FindItemByValue("btnRefresh").Visible = false;
        }

        protected void cmbPeriodoRif_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            lblMessage.Text = "";
            tbAction.FindItemByValue("btnRefresh").Visible = false;
            search();
        }

        protected void cmbAgenteGroupID_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            lblMessage.Text = "";
            tbAction.FindItemByValue("btnRefresh").Visible = false;
            search();
        }

        protected void search()
        {
            lblActionMessage.Text = "";
            gvInfo.DataBind();
        }


        protected void tbAction_ButtonClick(object sender, RadToolBarEventArgs e)
        {
            try
            {
                Result.Default result;

                int id = Convert.ToInt32(cmbAgenteGroupID.SelectedValue);
                string periodorif = cmbPeriodoRif.SelectedValue;

                if (e.Item.Value.StartsWith("btnReWorks"))
                {
                    lblActionMessage.Text = "Elaborazione bonus contatti in corso...";
                    result = AgentiBc.ManualSingleElab(id, periodorif);
                    Thread.Sleep(100);
                    if (!CheckResult(result)) return;

                    lblActionMessage.Text = "Elaborazione corrispettivi in corso...";
                    result = AgentiCorrispettivi.ManualSingleElab(id, periodorif);
                    Thread.Sleep(100);
                    if (!CheckResult(result)) return;

                    lblActionMessage.Text = "Elaborazione premi in corso ...";
                    result = AgentiPremi.ManualSingleElab(id, periodorif);
                    Thread.Sleep(100);
                    if (!CheckResult(result)) return;

                    lblActionMessage.Text = "Elaborazione bonus provvigionale in corso...";
                    result = AgentiIntegrazioni.ManualSingleElab(id, periodorif);
                    Thread.Sleep(100);
                    if (!CheckResult(result)) return;

                    lblActionMessage.Text = "Elaborazione bonus salva lavoro in corso...";
                    result = AgentiBsl.Elaborazione.ManualSingleElab(id, periodorif);
                    Thread.Sleep(100);
                    if (!CheckResult(result)) return;
                }

                if (e.Item.Value.EndsWith("Approved") || e.Item.Value.EndsWith("Published") || e.Item.Value.EndsWith("Close"))
                {
                    lblActionMessage.Text = "Impostazione stato approvato in corso...";
                    result = Tabulati.SetManualApproved(id, periodorif);
                    Thread.Sleep(100);
                    if (!CheckResult(result)) return;
                }

                if (e.Item.Value.EndsWith("Published") || e.Item.Value.EndsWith("Close"))
                {
                    lblActionMessage.Text = "Impostazione stato pubblicato in corso...";
                    result = Tabulati.SetManualPublished(id, periodorif);
                    Thread.Sleep(100);
                    if (!CheckResult(result)) return;
                }

                if (e.Item.Value.EndsWith("Close"))
                {
                    lblActionMessage.Text = "Impostazione stato chiuso in corso...";
                    result = Tabulati.SetManualClosed(id, periodorif);
                    Thread.Sleep(100);
                    if (!CheckResult(result)) return;
                }

                if (e.Item.Value != "btnRefresh")
                {
                    lblActionMessage.Text = "Elaborazione terminata";
                    lblMessage.Text = message.HtmlInfo("Elaborazione terminata correttamente.<br /><br />Se la griglia dei risultati non si è aggiornata clicca sul tasto refresh");
                    tbAction.FindItemByValue("btnRefresh").Visible = true;
                    Thread.Sleep(1000);
                }
                
                search();
            }
            catch (Exception ex)
            {
                if (ex.Message.StartsWith("ATTENZIONE!!"))
                    lblMessage.Text = message.HtmlExclamation(ex.Message);
                else
                    lblMessage.Text = message.HtmlError(ex.Message);
            }
            search();
        }

        
        private bool CheckResult(Result.Default result)
        {
            if (result == null || result.DESC == "OK") 
                return true;
            else
            {
                lblMessage.Text = result.DESC;
                return false;
            }       
        }
    }
}