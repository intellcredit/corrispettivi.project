using System;
using System.Web.UI;
using Telerik.Web.UI;

using Corrispettivi.Library;

namespace corrispettivi.web.tabulati.commerciali.corrispettivi
{
    public partial class dettaglio : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            if ((!string.IsNullOrEmpty(Request.QueryString["mp"])) && (Request["mp"].ToString() == "b"))
                this.MasterPageFile = "~/blank.master";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                if ((!string.IsNullOrEmpty(Request.QueryString["mp"])) && (Request["mp"].ToString() == "b"))
                    gvInfo.Height = 800;
            }
        }

        protected void gvInfo_DetailTableDataBind(object source, Telerik.Web.UI.GridDetailTableDataBindEventArgs e)
        {
            GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
            string id = dataItem.GetDataKeyValue("CommercialeCorrispettivoPraticaID").ToString();
            e.DetailTableView.DataSource = CommercialiCorrispettivi.PraticheDettalgio(Convert.ToInt32(id));
        }
    }
}