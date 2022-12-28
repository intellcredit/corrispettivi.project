using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using it.tools.library;
using System.Net;

using authb = Authorize.Based;
using util = Utility.Library;

using System.Net.Http;

namespace corrispettivi.web
{
    public partial class blank : System.Web.UI.MasterPage
    {
        private void Page_Init(object sender, System.EventArgs e)
        {
            if (Session.IsNewSession)
                Response.Redirect("~/login.aspx");
            else if (Session["SessionInfo"] == null)
                Response.Redirect("~/login.aspx");

            if (Page.IsPostBack != true)
            {
                HttpResponseMessage apiResponse;

                util.WebApiObject.TokenResponse token = (util.WebApiObject.TokenResponse)Session["token"];
                authb.SessionInfo sessionInfo = (authb.SessionInfo)Session["SessionInfo"];

                Dictionary<string, string> requestParam = new Dictionary<string, string>()
                                                        {
                                                            { "sessionID", sessionInfo.SessionID}
                                                            , { "url", Request.Url.ToString()}
                                                            , { "pageName", Request.ServerVariables["script_name"].Substring(1)}
                                                            //, { "agenteID", "0"}
                                                            //, { "operatoreID", sessionInfo.UserInfo.EmployeeID}
                                                        };

                apiResponse = util.WebApiCall.callApiGet(token.AccessToken, requestParam, webconfigkey.GetValue("APIURL_TRACELOG_WebForm"));

            }
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {

        }
    }
}