using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Net.Http;

using authb = Authorize.Based;
using it.tools.library;

using util = Utility.Library;

namespace Corrispettivi.Library
{
    public class KitFunction
    {
        public static void LogOut(util.WebApiObject.TokenResponse token, authb.SessionInfo sessionInfo)
        {
            authb.UserInfo userInfo = sessionInfo.UserInfo;

            // --> start - crypta le chiavi identificative del sito
            String appName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_AppName"]);
            String domainName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_DomainName"]);
            String groupName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_GroupName"]);
            String rolename = util.StringCoding.Encrypt(userInfo.RoleName);
            String userName = util.StringCoding.Encrypt(userInfo.Username);
            String hostName = util.StringCoding.Encrypt(HttpContext.Current.Request.UserHostAddress);
            String hostIp = util.StringCoding.Encrypt(HttpContext.Current.Request.UserHostName);
            // --> end

            HttpResponseMessage apiResponse;
            Dictionary<string, string> requestParam = new Dictionary<string, string>();

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

            //Session.Abandon();

            //this.ClientScript.RegisterClientScriptBlock(this.GetType(), "script", "window.close();", true);

            //response.Redirect("~/login.aspx");
        }
    }
}