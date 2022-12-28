using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace corrispettivi.web
{
    public partial class legendStatusTabulato : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lbl0.BackColor = corrispettivi.tools.SystemFunction.GetTabulatoStatusColor(0);
            lbl1.BackColor = corrispettivi.tools.SystemFunction.GetTabulatoStatusColor(1);
            lbl2.BackColor = corrispettivi.tools.SystemFunction.GetTabulatoStatusColor(2);
            lbl3.BackColor = corrispettivi.tools.SystemFunction.GetTabulatoStatusColor(3);
            lbl4.BackColor = corrispettivi.tools.SystemFunction.GetTabulatoStatusColor(4);
        }
    }
}