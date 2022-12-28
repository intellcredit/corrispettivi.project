using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Corrispettivi.Library;

namespace corrispettivi.web
{
    public partial class redirectView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //x    = PeriodoRif
            //y    = ID
            //z    = Nome
            //o    = OreContratto
            //key  = SourceID
            //type = TipoTabulatoID
            //area = 1 = agenti; 2 = commerciali

            if (Page.IsPostBack != true)
            {
                if (Request.QueryString["type"] != null && Request.QueryString["area"] != null)
                {
                    string url = "";

                    switch (Convert.ToInt32(Request.QueryString["area"]))
                    {
                        case 1:
                            url = Tabulati.UrlAgenti(Convert.ToInt32(Request.QueryString["type"]), Tabulati.UrlType.Url);

                            int mese = Convert.ToInt32(Request["x"].Split('/')[0]);
                            int anno = Convert.ToInt32(Request["x"].Split('/')[1]);

                            // eccezione per BonusContatti
                            if (Convert.ToInt32(Request.QueryString["type"]) == 8 && ((anno == 2021 && mese >= 7) || anno > 2021))
                                url = url.Replace("dettaglio.aspx", "dettaglioweek.aspx");

                            break;
                        case 2:
                            url = Tabulati.UrlCommerciali(Convert.ToInt32(Request.QueryString["type"]), Tabulati.UrlType.Url);
                            break;
                    }

                    url = string.Format(url
                                    , Request.QueryString["x"]
                                    , Request.QueryString["y"]
                                    , Request.QueryString["z"]
                                    , Request.QueryString["o"]
                                    , Request.QueryString["key"]);

                    url += "&mp=b";

                    Response.Redirect(url);
                }
            }
        }
    }
}