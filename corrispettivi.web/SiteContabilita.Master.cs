using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using System.Net.Http;

using authb = Authorize.Based;
using util = Utility.Library;
using System.Net;
using it.tools.library;
using System.Configuration;

namespace corrispettivi.web
{
    public partial class Site4 : System.Web.UI.MasterPage
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
            else if (!corrispettivi.tools.SystemFunction.CheckAccessArea(userInfo.RoleName, "CONTABILITA"))
                Response.Redirect("~/end.aspx");


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

        protected void Page_Load(object sender, System.EventArgs e)
        {
            lblUsername.Text = userInfo.Username;

        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            HttpResponseMessage apiResponse;
            Dictionary<string, string> requestParam = new Dictionary<string, string>();

            // --> start - crypta le chiavi identificative del sito
            string appName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_AppName"]);
            string domainName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_DomainName"]);
            string groupName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_GroupName"]);
            string rolename = util.StringCoding.Encrypt(userInfo.RoleName);
            string userName = util.StringCoding.Encrypt(userInfo.Username);
            string hostName = util.StringCoding.Encrypt(HttpContext.Current.Request.UserHostAddress);
            string hostIp = util.StringCoding.Encrypt(HttpContext.Current.Request.UserHostName);
            // --> end

            requestParam = new Dictionary<string, string>()
                            {
                                { "appName", WebUtility.UrlEncode(appName) },
                                { "domainName", WebUtility.UrlEncode(domainName) },
                                { "groupname", WebUtility.UrlEncode(groupName) },
                                { "rolename", WebUtility.UrlEncode(rolename) },
                                { "Username", WebUtility.UrlEncode(userName) },
                                { "SessionID", WebUtility.UrlEncode(sessionInfo.SessionID) },
                                { "HostName", WebUtility.UrlEncode(hostName) },
                                { "HostIp", WebUtility.UrlEncode(hostIp) }
                            };

            apiResponse = util.WebApiCall.callApiGet(token.AccessToken, requestParam, webconfigkey.GetValue("APIURL_AUTHLDAP_Logout"));

            Session.Abandon();

            Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "script", "window.close();", true);

            Response.Redirect("~/login.aspx");
        }
    }
}