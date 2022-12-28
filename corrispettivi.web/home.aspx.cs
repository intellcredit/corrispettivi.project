using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using authb = Authorize.Based;
using util = Utility.Library;

using System.Configuration;

namespace corrispettivi.web
{
    public partial class home : System.Web.UI.Page
    {
        private void Page_PreInit(object sender, System.EventArgs e)
        {
            if (Session["SessionInfo"] != null)
                Page.MasterPageFile = corrispettivi.tools.SystemFunction.SelectMasterPage(((authb.SessionInfo)Session["SessionInfo"]).UserInfo.RoleName);
        }
    }
}