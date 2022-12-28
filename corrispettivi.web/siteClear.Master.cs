using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;

using authb = Authorize.Based;
using it.tools.library;
using util = Utility.Library;

using System.Configuration;


namespace corrispettivi.web
{
    public partial class siteClear : System.Web.UI.MasterPage
    {
        protected util.WebApiObject.TokenResponse token;
        protected authb.SessionInfo sessionInfo;
        protected authb.UserInfo userInfo;

        private void Page_Init(object sender, System.EventArgs e)
        {
            token = (util.WebApiObject.TokenResponse)Session["token"];
            sessionInfo = (authb.SessionInfo)Session["SessionInfo"];
            userInfo = sessionInfo.UserInfo;

            if ((Session.IsNewSession)
                || (Session["token"] == null)
                || (Session["SessionInfo"] == null))
            {
                Session.Abandon();
                Response.Redirect("login.aspx");
            }
            else if (!util.WebApiCall.getSessionIsActive(token.AccessToken, sessionInfo.SessionID, ConfigurationManager.AppSettings["APIURL_AUTHINFO_GetSessionIsActive"]))
            {
                Session.Abandon();
                Response.Redirect("login.aspx");
            }

            if (Page.IsPostBack != true)
            {
                HttpResponseMessage apiResponse;

                //string key = "";

                //if (userInfo.RoleName.ToLower() == "admin") key = "operatoreID";
                //else if (userInfo.RoleName.ToLower() == "agente") key = "agenteID";
                //else if (userInfo.RoleName.ToLower() == "operatore") key = "operatoreID";
                //else if (userInfo.RoleName.ToLower() == "callcenter") key = "callcenterID";
                //else if (userInfo.RoleName.ToLower() == "commerciale") key = "commercialeID";

                Dictionary<string, string> requestParam = new Dictionary<string, string>()
                                                        {
                                                            { "sessionID", sessionInfo.SessionID}
                                                            , { "url", Request.Url.ToString()}
                                                            , { "pageName", Request.ServerVariables["script_name"].Substring(1)}
                                                            //, { key, userInfo.EmployeeID}
                                                        };

                apiResponse = util.WebApiCall.callApiGet(token.AccessToken, requestParam, webconfigkey.GetValue("APIURL_TRACELOG_WebForm"));

            }
        }
    }
}