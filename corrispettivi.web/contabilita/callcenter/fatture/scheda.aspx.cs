using System;
using System.Drawing;
using System.Web.UI;
using Telerik.Web.UI;

using authb = Authorize.Based;
using util = Utility.Library;
using Corrispettivi.Library;

namespace corrispettivi.web.contabilita.callcenter.fatture
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
                        cmbCallCenter.SelectedValue = Request["c"];
                        cmbCallCenter.Enabled = false;
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

                    lblPeriodoRif.Text = string.Format("{0:00}/{1}", Convert.ToInt32(cmbMeseRif.SelectedValue), cmbAnnoRif.SelectedValue);

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
                    lblMessage.Text = Message.HtmlExclamation(ex.Message);
                else
                    lblMessage.Text = Message.HtmlError(ex.Message);
            }
        }

        protected void tbAction1_ButtonClick(object sender, Telerik.Web.UI.RadToolBarEventArgs e)
        {
            try
            {
                Result.Default result;

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
                    lblMessage.Text = Message.HtmlExclamation(ex.Message);
                else
                    lblMessage.Text = Message.HtmlError(ex.Message);
            }
        }

        protected void tbAction2_ButtonClick(object sender, Telerik.Web.UI.RadToolBarEventArgs e)
        {
            double res = 0;

            try
            {
                Result.Default result;

                switch (e.Item.Value)
                {
                    case "btnAdd":
                        {
                            result = Corrispettivi.Library.Fatture.write(0
                                                , Convert.ToInt32(cmbCallCenter.SelectedValue)
                                                , 0
                                                , 0
                                                , Convert.ToInt32(cmbAnnoRif.SelectedValue)
                                                , Convert.ToInt32(cmbMeseRif.SelectedValue)
                                                , txtNumero.Text
                                                , txtData.SelectedDate
                                                , txtImporto.Value
                                                , txtNote.Text
                                                , ((authb.UserInfo)Session["UserInfo"]).Username);

                            if (result.DESC == "OK")
                            {
                                Session["Result"] = eWebResult.Saved;
                                txtNumero.Text = "";
                                txtData.SelectedDate = null;
                                txtImporto.Value = null;
                            }

                            break;
                        }
                    case "btnDeleteAll":
                        {
                            result = Corrispettivi.Library.Fatture.deleteAll(Convert.ToInt32(cmbCallCenter.SelectedValue)
                                                    , 0
                                                    , 0
                                                    , Convert.ToInt32(cmbAnnoRif.SelectedValue)
                                                    , Convert.ToInt32(cmbMeseRif.SelectedValue)
                                                    , ((authb.UserInfo)Session["UserInfo"]).Username);

                            if (result.DESC == "OK") Session["Result"] = eWebResult.Deleted;

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
                    lblMessage.Text = Message.HtmlExclamation(ex.Message);
                else
                    lblMessage.Text = Message.HtmlError(ex.Message);
            }
        }

        protected void gvFatture_ItemCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                Result.Default result;

                if (e.CommandName == "Delete")
                {
                    GridDataItem item = (GridDataItem)e.Item;
                    int fatturaID = Convert.ToInt32(item.GetDataKeyValue("FatturaID"));
                    result = Corrispettivi.Library.Fatture.delete(fatturaID, ((authb.UserInfo)Session["UserInfo"]).Username);
                    if (result.DESC == "OK")
                    {
                        Session["Result"] = eWebResult.Deleted;
                        gvFatture.DataBind();
                        setSaldo();
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

        protected void setSaldo()
        {
            double res = Corrispettivi.Library.Fatture.saldo(Convert.ToInt32(cmbCallCenter.SelectedValue)
                                                            , 0
                                                            , 0
                                                            , Convert.ToInt32(cmbAnnoRif.SelectedValue)
                                                            , Convert.ToInt32(cmbMeseRif.SelectedValue));
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

        protected void gvSummary_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (e.Item as GridDataItem);
                string row = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["Row"].ToString();
                switch (row)
                {
                    case "3":
                        {
                            e.Item.BackColor = Color.LightGray;
                            e.Item.Font.Bold = true;
                            break;
                        }
                    case "7":
                        {
                            e.Item.BackColor = Color.LightGray;
                            e.Item.Font.Bold = true;
                            break;
                        }
                    case "9":
                        {
                            e.Item.BackColor = Color.LightGray;
                            e.Item.ForeColor = Color.Red;
                            e.Item.Font.Bold = true;
                            //e.Item.CssClass = "titrosso12";
                            break;
                        }
                }
            }
        }
    }
}