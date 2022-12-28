using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Corrispettivi.Library;

namespace corrispettivi.web.tabulati.agenti.bc
{
    public partial class dettaglioWeek : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            if ((!string.IsNullOrEmpty(Request.QueryString["mp"])) && (Request["mp"].ToString() == "b"))
                this.MasterPageFile = "~/blank.master";
        }

        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    if (Page.IsPostBack != true)
        //    {
        //        lblPeriodo.Text = Request["x"].ToString();
        //        lblAgenteGroupID.Text = Request["y"].ToString();
        //        lblAgenteGroupNome.Text = Request["z"].ToString();
        //        lblOreContratto.Text = Request["o"].ToString();
        //        hlBack.NavigateUrl = string.Format(hlBack.NavigateUrl, Request["x"].ToString());

        //        if ((!string.IsNullOrEmpty(Request.QueryString["mp"])) && (Request["mp"].ToString() == "b"))
        //        {
        //            gvInfo.Height = 800;
        //            hlBack.Visible = false;
        //        }
        //    }
        //}

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
            string id = dataItem.GetDataKeyValue("AgenteBcPresenzeWeekID").ToString();
            e.DetailTableView.DataSource = AgentiBc.PresenzeDettaglioWeek(Convert.ToInt32(id));
        }
    }
}