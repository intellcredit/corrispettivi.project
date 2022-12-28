using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using authb = Authorize.Based;
using util = Utility.Library;

namespace corrispettivi.web
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            util.WebApiObject.TokenResponse authorizeToken = (util.WebApiObject.TokenResponse)Session["Token"];
            authb.SessionInfo sessionInfo = (authb.SessionInfo)Session["SessionInfo"];
            authb.UserInfo userInfo = sessionInfo.UserInfo;

            // --> start - crypta le chiavi identificative del sito
            string appName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_AppName"]);
            string domainName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_DomainName"]);
            string groupName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_GroupName"]);
            string roleName = util.StringCoding.Encrypt(userInfo.RoleName);
            string userName = util.StringCoding.Encrypt(userInfo.Username);
            string hostName = util.StringCoding.Encrypt(sessionInfo.HostName);
            string hostIp = util.StringCoding.Encrypt(sessionInfo.HostIp);
            // --> end

            HttpResponseMessage apiResponse;
            var requestParam = new Dictionary<string, string>() {
                                                      { "appName", WebUtility.UrlEncode(appName) }
                                                    , { "domainName", WebUtility.UrlEncode(domainName) }
                                                    , { "groupname", WebUtility.UrlEncode(groupName) }
                                                    , { "rolename", WebUtility.UrlEncode(roleName) }
                                                    , { "Username", WebUtility.UrlEncode(userName) }
                                                    , { "SessionID", sessionInfo.SessionID }
                                                    , { "HostName", WebUtility.UrlEncode(hostName) }
                                                    , { "HostIp", WebUtility.UrlEncode(hostIp) }
                                                                };

            //if (Session["AccessType"].ToString().Equals("LDAP"))
            //    apiResponse = util.WebApiCall.callApiGet(authorizeToken.AccessToken, requestParam, ConfigurationManager.AppSettings["APIURL_AUTHLDAP_Logout"]);
            //else if (Session["AccessType"].ToString().Equals("DATABASE"))
            //    apiResponse = util.WebApiCall.callApiGet(authorizeToken.AccessToken, requestParam, ConfigurationManager.AppSettings["APIURL_AUTHDB_Logout"]);

            apiResponse = util.WebApiCall.callApiGet(authorizeToken.AccessToken, requestParam, ConfigurationManager.AppSettings["APIURL_AUTHLDAP_Logout"]);

            Session.Abandon();

            Response.Redirect("~/login.aspx");
        }
    }
}