using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net;
using System.Net.Http;
using System.Web;

using it.tools.library;

using authb = Authorize.Based;
using util = Utility.Library;

using Newtonsoft.Json;

namespace corrispettivi.web
{
    public partial class autologin : System.Web.UI.Page
    {
        // APP = APPLICATION NAME
        // RSK = REMOTE SAFETYKEY
        // SK  = SESSIONKEY
        // UN  = USERNAME
        // UK  = USERKEY

        protected authb.SessionInfo sessionInfo;
        protected authb.UserInfo userInfo;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Request["RAPP"] != "" && Request["RAT"] != "" && Request["RSK"] != "" && Request["SID"] != "" && Request["UTK"] != "" && Request["RN"] != "")
                {
                    //--> start - decrypta i parametri remoti
                    string remoteAppName = util.StringCoding.Decrypt(Request["RAPP"]);
                    string remoteAccessType = util.StringCoding.Decrypt(Request["RAT"]);
                    string remoteSafetyKey = util.StringCoding.Decrypt(Request["RSK"].ToString());
                    string sessionID = util.StringCoding.Decrypt(Request["SID"].ToString());
                    string userToken = util.StringCoding.Decrypt(Request["UTK"].ToString());
                    string roleName = util.StringCoding.Decrypt(Request["RN"]);
                    //--> end

                    //--> start - crypta le chiavi identificative del sito
                    string authwsAppName = util.StringCoding.Encrypt(webconfigkey.GetValue("AUTHWS_AppName"));
                    string authwsSafetyKey = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_SafetyKey"]);
                    string domainName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_DomainName"]);
                    // valore calcolato
                    string groupName = util.StringCoding.Encrypt(string.Format("{0}.{1}", ConfigurationManager.AppSettings["AUTHWS_GroupName"], roleName));
                    string hostName = util.StringCoding.Encrypt(HttpContext.Current.Request.UserHostAddress);
                    string hostIp = util.StringCoding.Encrypt(HttpContext.Current.Request.UserHostName);
                    string requestUserAgent = util.StringCoding.Encrypt(HttpContext.Current.Request.UserAgent);
                    //--> end

                    authb.SessionInfo sessionInfo = new authb.SessionInfo();
                    authb.UserInfo userInfo = new authb.UserInfo();

                    //VERIFICA CHE IL REMOTE SAFETYKEY SIA ABILITATO ALL'ACCESSO AUTOMATICO
                    if (remoteSafetyKey.Equals(webconfigkey.GetValue(string.Format("AUTHWS_RemoteSafetyKey{0}", remoteAppName))))
                    {
                        bool result = false;

                        HttpResponseMessage apiResponse;

                        Dictionary<string, string> requestParam = new Dictionary<string, string>();

                        util.WebApiObject.TokenResponse token;

                        try
                        {
                            token = util.WebApiCall.getAccessToken(
                                                                  ConfigurationManager.AppSettings["AUTHWS_AppName"]
                                                                , ConfigurationManager.AppSettings["AUTHWS_SafetyKey"]
                                                                , ConfigurationManager.AppSettings["APIURL_TokenAuthorize"]
                                                                , Session.Timeout.ToString()
                                                                    );
                            Session["token"] = token;


                            if (!String.IsNullOrEmpty(token.AccessToken))
                            {
                                requestParam = new Dictionary<String, String> {
                                                { "AppName", WebUtility.UrlEncode(authwsAppName)},
                                                { "AppToken", WebUtility.UrlEncode(authwsSafetyKey)},
                                                { "DomainName", WebUtility.UrlEncode(domainName)},
                                                { "GroupName", WebUtility.UrlEncode(groupName)},
                                                { "RemoteAppName", WebUtility.UrlEncode(Request["RAPP"].ToString())},
                                                { "RemoteAccessType", WebUtility.UrlEncode(Request["RAT"].ToString())},
                                                { "UserToken", WebUtility.UrlEncode(Request["UTK"].ToString())},
                                                { "RoleName", WebUtility.UrlEncode(Request["RN"].ToString())},
                                                { "SessionID", WebUtility.UrlEncode(Request["SID"].ToString())},
                                                { "HostName", WebUtility.UrlEncode(hostName)},
                                                { "HostIp", WebUtility.UrlEncode(hostIp)},
                                                { "requestUserAgent", WebUtility.UrlEncode(requestUserAgent)}
                                                            };

                                apiResponse = util.WebApiCall.callApiGet(token.AccessToken, requestParam, ConfigurationManager.AppSettings["APIURL_AUTHGENERIC_LogonAuto"]);


                                string JsonContent = apiResponse.Content.ReadAsStringAsync().Result;
                                JsonContent = it.tools.library.UtilityBased.JsonClear(JsonContent);

                                Dictionary<string, object> logonAuto = JsonConvert.DeserializeObject<Dictionary<string, object>>(JsonContent);


                                if (logonAuto.ContainsKey("statusResponse"))
                                {
                                    util.WebApiObject.StatusResponse status = JsonConvert.DeserializeObject<util.WebApiObject.StatusResponse>(logonAuto["statusResponse"].ToString());

                                    if (status.MessageShort.StartsWith("OK"))
                                    {
                                        if (logonAuto.ContainsKey("userInfo"))
                                        {
                                            userInfo = JsonConvert.DeserializeObject<authb.UserInfo>(logonAuto["userInfo"].ToString());

                                            if (userInfo.UserID > 0)
                                            {
                                                Session["UserInfo"] = userInfo;

                                                sessionInfo.UserInfo = userInfo;
                                                sessionInfo.SessionID = sessionID;
                                                sessionInfo.SessionTimeOut = Session.Timeout;
                                                sessionInfo.HostName = HttpContext.Current.Request.UserHostName;
                                                sessionInfo.HostIp = HttpContext.Current.Request.UserHostAddress;
                                                sessionInfo.Url = Request.ServerVariables["HTTP_HOST"];
                                                sessionInfo.requestParamBased = new Dictionary<string, string>() { { "sessionID", sessionID } };
                                                sessionInfo.AutoLogin = true;

                                                Session["SessionInfo"] = sessionInfo;


                                                result = true;
                                            }
                                            else
                                            {
                                                result = false;
                                            }
                                        }
                                        else
                                        {
                                            result = false;
                                        }
                                    }
                                    else
                                    {
                                        result = false;
                                    }
                                }
                                else
                                {
                                    result = false;
                                }


                                if (result == true)
                                {
                                    //string key = "";

                                    //if (userInfo.RoleName.ToLower() == "agente") key = "agenteID";
                                    //else if (userInfo.RoleName.ToLower() == "operatore") key = "operatoreID";
                                    //else if (userInfo.RoleName.ToLower() == "callcenter") key = "callcenterID";
                                    //else if (userInfo.RoleName.ToLower() == "commerciale") key = "commercialeID";

                                    requestParam = new Dictionary<string, string> {
                                                              { "sessionID", sessionInfo.SessionID}
                                                            , { "url", Request.Url.ToString()}
                                                            , { "pageName", Request.ServerVariables["script_name"].Substring(1)}
                                                            //, { key, userInfo.EmployeeID}
                                                                              };
                                    apiResponse = util.WebApiCall.callApiGet(token.AccessToken, requestParam, webconfigkey.GetValue("APIURL_TRACELOG_WebForm"));

                                    Response.Redirect(corrispettivi.tools.SystemFunction.SelectUrlAfterLogin(userInfo.RoleName));
                                }
                                else
                                {
                                    Response.Redirect("errorkey.aspx");
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            string a = ex.Message;
                        }
                    }
                    else
                    {
                        Response.Write("app key non valida");
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }
    }
}