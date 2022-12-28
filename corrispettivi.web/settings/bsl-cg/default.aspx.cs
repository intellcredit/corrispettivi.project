using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Corrispettivi.Library;

namespace corrispettivi.web.settings.bsl_cg
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                if (Session["Result"] != null)
                {
                    switch ((eWebResult)Session["Result"])
                    {
                        case eWebResult.Saved:
                            {
                                lblAction.Text = Message.HtmlSaved("Record aggiornato correttamente!");
                                break;
                            }
                        case eWebResult.Deleted:
                            {
                                lblAction.Text = Message.HtmlSaved("Record eliminato correttamente!");
                                break;
                            }
                        case eWebResult.Duplicated:
                            {
                                lblAction.Text = Message.HtmlSaved("Record duplicato correttamente!");
                                break;
                            }
                    }
                    Session["Result"] = null;
                }
                else
                {
                    lblAction.Text = "";
                }
            }
        }
    }
}