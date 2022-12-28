using System;
using System.Web.UI;
using Telerik.Web.UI;

using authb = Authorize.Based;
using util = Utility.Library;

namespace corrispettivi.web.contabilita.commerciali.fatture
{
    public partial class scheda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsPostBack != true)
                {
                    if (Request["c"] != "0")
                    {
                        cmbCommerciale.SelectedValue = Request["c"];
                        cmbCommerciale.Enabled = false;
                    }
                    if (Request["x"] != "0")
                    {
                        cmbAnnoRif.SelectedValue = Request["x"];
                        cmbAnnoRif.Enabled = false;
                    }
                    if (Request["y"] != "0")
                    {
                        cmbMeseRif.SelectedValue = Convert.ToInt32(Request["y"]).ToString();
                        cmbMeseRif.Enabled = false;
                    }

                    string a = string.Format(tbAction2.FindButtonByCommandName("ExportSelected").Value
                                                , Request["x"]
                                                , Request["y"]
                                                , Request["c"]);

                    tbAction2.FindButtonByCommandName("ExportSelected").NavigateUrl = a;

                    setSaldo();
                }
            }
            catch (Exception ex)
            {
                if (ex.Message.StartsWith("ATTENZIONE!!"))
                    lblMessage.Text = Corrispettivi.Library.Message.HtmlExclamation(ex.Message);
                else
                    lblMessage.Text = Corrispettivi.Library.Message.HtmlError(ex.Message);
            }
        }

        protected void tbAction1_ButtonClick(object sender, Telerik.Web.UI.RadToolBarEventArgs e)
        {
            try
            {
                Corrispettivi.Library.Result.Default result;

                int id = Convert.ToInt32(Request["id"]);

                switch (e.Item.Value)
                {
                    case "btnClose":
                        {
                            switch (Request["ret"].ToString())
                            {
                                case "r":   //report
                                    {
                                        Response.Redirect("../report.aspx?x=" + Request["x"].ToString());
                                        break;
                                    }
                                case "f":   //fatture
                                    {
                                        Response.Redirect("default.aspx?x=" + Request["x"].ToString());
                                        break;
                                    }
                            }


                            Response.Redirect("../report.aspx?x=" + Request["x"].ToString());
                            break;
                        }
                }
            }
            catch (Exception ex)
            {
                if (ex.Message.StartsWith("ATTENZIONE!!"))
                    lblMessage.Text = Corrispettivi.Library.Message.HtmlExclamation(ex.Message);
                else
                    lblMessage.Text = Corrispettivi.Library.Message.HtmlError(ex.Message);
            }
        }

        protected void tbAction2_ButtonClick(object sender, Telerik.Web.UI.RadToolBarEventArgs e)
        {
            double res = 0;

            try
            {
                Corrispettivi.Library.Result.Default result;

                switch (e.Item.Value)
                {
                    case "btnAdd":
                        {
                            result = Corrispettivi.Library.Fatture.write(0
                                                , 0
                                                , 0
                                                , Convert.ToInt32(cmbCommerciale.SelectedValue)
                                                , Convert.ToInt32(cmbAnnoRif.SelectedValue)
                                                , Convert.ToInt32(cmbMeseRif.SelectedValue)
                                                , txtNumero.Text
                                                , txtData.SelectedDate
                                                , txtImporto.Value
                                                , txtNote.Text
                                                , ((authb.UserInfo)Session["UserInfo"]).Username);

                            if (result.DESC == "OK")
                            {
                                Session["Result"] = Corrispettivi.Library.eWebResult.Saved;
                                txtNumero.Text = "";
                                txtData.SelectedDate = null;
                                txtImporto.Value = null;
                            }

                            break;
                        }
                    case "btnDeleteAll":
                        {
                            result = Corrispettivi.Library.Fatture.deleteAll(0
                                                    , 0
                                                    , Convert.ToInt32(cmbCommerciale.SelectedValue)
                                                    , Convert.ToInt32(cmbAnnoRif.SelectedValue)
                                                    , Convert.ToInt32(cmbMeseRif.SelectedValue)
                                                    , ((authb.UserInfo)Session["UserInfo"]).Username);

                            if (result.DESC == "OK") Session["Result"] = Corrispettivi.Library.eWebResult.Deleted;

                            break;
                        }

                        //case "btnExpExcel":
                        //    {
                        //        Response.Redirect(string.Format("expfatture.aspx?x={0}&y={1}&c={2}&name={3}"
                        //                                        , cmbAnnoRif.SelectedValue
                        //                                        , cmbMeseRif.SelectedValue
                        //                                        , cmbCallCenter.SelectedValue
                        //                                        , cmbCallCenter.Text));

                        //        break;
                        //    }
                }

                if (e.Item.Value == "btnAdd" || e.Item.Value == "btnDeleteAll") setSaldo();

                gvFatture.DataBind();
            }
            catch (Exception ex)
            {
                if (ex.Message.StartsWith("ATTENZIONE!!"))
                    lblMessage.Text = Corrispettivi.Library.Message.HtmlExclamation(ex.Message);
                else
                    lblMessage.Text = Corrispettivi.Library.Message.HtmlError(ex.Message);
            }
        }

        protected void gvFatture_ItemCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                Corrispettivi.Library.Result.Default result;

                if (e.CommandName == "Delete")
                {
                    GridDataItem item = (GridDataItem)e.Item;
                    int fatturaID = Convert.ToInt32(item.GetDataKeyValue("FatturaID"));
                    result = Corrispettivi.Library.Fatture.delete(fatturaID, ((authb.UserInfo)Session["UserInfo"]).Username);
                    if (result.DESC == "OK")
                    {
                        Session["Result"] = Corrispettivi.Library.eWebResult.Deleted;
                        gvFatture.DataBind();
                        setSaldo();
                    }
                }
            }
            catch (Exception ex)
            {
                if (ex.Message.StartsWith("ATTENZIONE!!"))
                    lblMessage.Text = Corrispettivi.Library.Message.HtmlExclamation(ex.Message);
                else
                    lblMessage.Text = Corrispettivi.Library.Message.HtmlError(ex.Message);
            }
        }

        protected void setSaldo()
        {
            double res = Corrispettivi.Library.Fatture.saldo(0, 0, Convert.ToInt32(cmbCommerciale.SelectedValue), Convert.ToInt32(cmbAnnoRif.SelectedValue), Convert.ToInt32(cmbMeseRif.SelectedValue));
            lblResiduo.Text = String.Format("{0:C}", res);
            if (res >= 0)
            {
                txtImporto.MinValue = 0;
                txtImporto.MaxValue = res;
            }
            else
            {
                txtImporto.MinValue = res;
                txtImporto.MaxValue = 0;
            }
        }
    }
}