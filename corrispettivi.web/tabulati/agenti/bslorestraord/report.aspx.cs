using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClosedXML.Excel;
using Telerik.Web.UI;

using authb = Authorize.Based;
using util = Utility.Library;
using Corrispettivi.Library;

namespace corrispettivi.web.tabulati.agenti.bslorestraord
{
    public partial class report : System.Web.UI.Page
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
                if (Session["SessionInfo"] != null)
                {
                    if (userInfo.RoleName == "UFFICIOPERSONALE") Page.MasterPageFile = "localUffPers.master";
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                string value;

                if (Request.QueryString["x"] != null) value = Request["x"].ToString();
                else value = DateTime.Now.ToShortDateString().Substring(3, 7);

                if (cmbPeriodoRif.Items.FindItemByValue(value) != null)
                    cmbPeriodoRif.SelectedValue = Request["x"].ToString();

                setAction();
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
            ViewState["CheckIfClosed"] = AgentiBsl.Elaborazione.CheckIfClosed(cmbPeriodoRif.SelectedValue);

            tbAction.FindItemByText("Salva").Enabled = ((bool)ViewState["CheckIfClosed"] ? false : true);

            foreach (GridColumn column in gvInfo.MasterTableView.OwnerGrid.Columns)
            {
                column.CurrentFilterFunction = GridKnownFunction.NoFilter;
                column.CurrentFilterValue = string.Empty;
            }
            gvInfo.MasterTableView.FilterExpression = string.Empty;
            gvInfo.DataBind();
            setAction();
        }

        protected void setAction()
        {
            if (cmbPeriodoRif.SelectedValue != "")
            {
                tbAction.Visible = true;
                //tbAction.FindButtonByCommandName("expCsv").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expCsv").Value, cmbPeriodoRif.SelectedValue);
                tbAction.FindButtonByCommandName("expExcel").NavigateUrl = string.Format(tbAction.FindButtonByCommandName("expExcel").Value, cmbPeriodoRif.SelectedValue);
            }
            else
                tbAction.Visible = false;


            // per utenti diversi da:
            // SuperAdmin, Admin e Direzione
            // disabilita il men "azioni"
            if (!(userInfo.RoleName == "SUPERADMIN" || userInfo.RoleName == "ADMIN" || userInfo.RoleName == "DIREZIONE"))
                tbAction.FindItemByText("Salva").Visible = false;
        }

        protected void tbAction_ButtonClick(object sender, RadToolBarEventArgs e)
        {
            if (e.Item.Value == "Save" || e.Item.Value == "SaveExec")
            {
                foreach (GridDataItem item in gvInfo.Items)
                {
                    CheckBox chk = item["Sel"].Controls[0] as CheckBox;
                    if (chk.Checked)
                    {
                        RadNumericTextBox txt = item["Ore"].Controls[0] as RadNumericTextBox;
                        int a = (int)txt.Value;

                        AgentiBsl.OreStraordinarie.write(
                                                  (int)item.GetDataKeyValue("AgenteBslOraStraordinariaID")
                                                , (int)item.GetDataKeyValue("AnnoRif")
                                                , (int)item.GetDataKeyValue("MeseRif")
                                                , (int)item.GetDataKeyValue("CallCenterID")
                                                , (int)item.GetDataKeyValue("AgenteGroupID")
                                                , (int)item.GetDataKeyValue("OreLavorative")
                                                , (int)item.GetDataKeyValue("OreMensiliCtr")
                                                , Convert.ToDouble(item.GetDataKeyValue("ImpOrario"))
                                                , (int)item.GetDataKeyValue("OreLogEffettive")
                                                , (int)item.GetDataKeyValue("OreLogMinMax")
                                                , (int)item.GetDataKeyValue("OreFranchigia")
                                                , (int)item.GetDataKeyValue("OreLog")
                                                , (int)item.GetDataKeyValue("OreMensiliMax")
                                                , (int)txt.Value
                                                , ((authb.UserInfo)Session["UserInfo"]).Username
                                                    );
                    }
                    else
                    {
                        if ((int)item.GetDataKeyValue("AgenteBslOraStraordinariaID") > 0)
                        {
                            AgentiBsl.OreStraordinarie.delete(
                                                  (int)item.GetDataKeyValue("AgenteBslOraStraordinariaID")
                                                , ((authb.UserInfo)Session["UserInfo"]).Username
                                                    );
                        }
                    }
                }
            }


            if (e.Item.Value == "SaveExec")
            {
                AgentiBsl.OreStraordinarie.exec(
                                                  Convert.ToInt32(cmbPeriodoRif.SelectedValue.Substring(3, 4))
                                                , Convert.ToInt32(cmbPeriodoRif.SelectedValue.Substring(0, 2))
                                                , ((authb.UserInfo)Session["UserInfo"]).Username
                                                   );
            }


            search();
        }

        protected void gvInfo_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;

                CheckBox chk = new CheckBox();
                if (item.GetDataKeyValue("UTENTE_INS").ToString() != "")
                    chk.Text = string.Format("{0} {1}", item.GetDataKeyValue("UTENTE_INS").ToString(), item.GetDataKeyValue("DATA_CREAZIONE").ToString());

                if (Convert.ToBoolean(item.GetDataKeyValue("Refresh")) == false)
                {
                    chk.Enabled = false;
                }

                RadNumericTextBox txt = new RadNumericTextBox();
                txt.Width = 35;
                txt.NumberFormat.DecimalDigits = 0;
                txt.MinValue = Convert.ToInt32(item.GetDataKeyValue("OreMensiliCtr"));
                txt.MaxValue = Convert.ToInt32(ConfigurationManager.AppSettings["BslMaxOreStraordinarie"]);

                if (Convert.ToInt32(item.GetDataKeyValue("OreAutorizzate")) > 0)
                {
                    chk.Checked = true;
                    txt.Value = Convert.ToInt32(item.GetDataKeyValue("OreAutorizzate"));

                    if (Convert.ToInt32(item.GetDataKeyValue("OreStraordinarie")) > 0)
                    {
                        item.BackColor = System.Drawing.Color.LightGreen;
                    }
                    else
                    {
                        item.BackColor = System.Drawing.Color.Yellow;
                    }
                }
                else
                {
                    chk.Checked = false;
                    txt.Value = Convert.ToInt32(item.GetDataKeyValue("OreMensiliMax"));

                    if (Convert.ToInt32(item.GetDataKeyValue("OreMensiliCtr")) > Convert.ToInt32(item.GetDataKeyValue("OreMensiliCtr")) && Convert.ToInt32(item.GetDataKeyValue("OreAutorizzate")) == 0)
                    {
                        item.BackColor = System.Drawing.Color.LightPink;
                    }
                }


                chk.Enabled = ((bool)ViewState["CheckIfClosed"] ? false : true);
                txt.Enabled = ((bool)ViewState["CheckIfClosed"] ? false : true);

                // per utenti diversi da:
                // SuperAdmin, Admin e Direzione
                // disabilita il men "azioni"
                if (!(userInfo.RoleName == "SUPERADMIN" || userInfo.RoleName == "ADMIN" || userInfo.RoleName == "DIREZIONE"))
                {
                    chk.Enabled = false;
                    txt.Enabled = false;
                }

                item["Sel"].Controls.Add(chk);
                item["Ore"].Controls.Add(txt);
            }
        }
    }
}