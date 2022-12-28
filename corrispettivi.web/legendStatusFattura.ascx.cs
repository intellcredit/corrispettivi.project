using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace corrispettivi.web
{
    public partial class legendStatusFattura : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lbl0.BackColor = corrispettivi.tools.SystemFunction.GetFatturaStatusColor(0);
            lbl1.BackColor = corrispettivi.tools.SystemFunction.GetFatturaStatusColor(1);
            lbl2.BackColor = corrispettivi.tools.SystemFunction.GetFatturaStatusColor(2);
            lbl3.BackColor = corrispettivi.tools.SystemFunction.GetFatturaStatusColor(3);
        }
    }
}