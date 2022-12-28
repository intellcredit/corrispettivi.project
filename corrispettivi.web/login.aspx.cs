using System;
using System.Collections.Generic;
using System.Web;
using System.Configuration;
using System.Net;
using System.Net.Http;

using authb = Authorize.Based;
using it.tools.library;
using util = Utility.Library;

using Newtonsoft.Json;

namespace corrispettivi.web
{
    public partial class login : System.Web.UI.Page
    {
        protected authb.SessionInfo sessionInfo;
        protected authb.UserInfo userInfo;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SessionInfo"] != null)
            {
                sessionInfo = (authb.SessionInfo)Session["SessionInfo"];
                spanLogin.Visible = false;
                string msg = "Su questa postazione è già attiva una sessione per l'utente: <font class=titrosso12>" + sessionInfo.UserInfo.Username + "</font>";
                msg += "<br />Per proseguire scollegare l'utente ed effettuare un nuovo accesso.";
                msg += "<br /><a href='logout.aspx'>Clicca qui per scollegare l'utente.</a>";
                lblMessage.Text = message.HtmlExclamation(msg);
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string usr = txtUsername.Text.Trim();
            string psw = txtPassword.Text.Trim();
            if (!(string.IsNullOrEmpty(usr) & string.IsNullOrEmpty(psw)))
            {
                LogOnLdap(util.StringCoding.Encrypt(usr), util.StringCoding.Encrypt(psw));
            }
            else
            {
                spanLogin.Visible = false;
                string msg = "Su questa postazione è già attiva una sessione per l'utente: <font class=titrosso12>" + sessionInfo.UserInfo.Username + "</font>";
                msg += "<br />Per proseguire scollegare l'utente ed effettuare un nuovo accesso.";
                msg += "<br /><a href='logout.aspx'>Clicca qui per scollegare l'utente.</a>";
                lblMessage.Text = message.HtmlExclamation(msg);
            }
        }

        protected void lnkForceLogOut_Click(object sender, EventArgs e)
        {
            // --> start - crypta le chiavi identificative del sito
            string appName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_AppName"]);
            string domainName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_DomainName"]);
            string userName = util.StringCoding.Encrypt(txtUsername.Text.Trim());
            string hostName = util.StringCoding.Encrypt(HttpContext.Current.Request.UserHostAddress);
            string hostIp = util.StringCoding.Encrypt(HttpContext.Current.Request.UserHostName);
            // --> end


            util.WebApiObject.TokenResponse token = (util.WebApiObject.TokenResponse)Session["token"];

            HttpResponseMessage apiResponse;
            var requestParam = new Dictionary<string, string>() {
                                                      { "appName", WebUtility.UrlEncode(appName) }
                                                    , { "domainName", WebUtility.UrlEncode(domainName) }
                                                    , { "Username", WebUtility.UrlEncode(userName) }
                                                    , { "HostName", WebUtility.UrlEncode(hostName) }
                                                    , { "HostIp", WebUtility.UrlEncode(hostIp) }
                                                                };
            apiResponse = util.WebApiCall.callApiGet(token.AccessToken, requestParam, webconfigkey.GetValue("APIURL_AUTHLDAP_LogoutForce"));
            Session.Abandon();
            Response.Redirect("~/login.aspx");
        }

        private void LogOnLdap(string usr, string psw)
        {
            try
            {
                //--> start - crypta le chiavi identificative del sito
                string authwsAppName = ConfigurationManager.AppSettings["AUTHWS_AppName"];
                string authwsSafetyKey = ConfigurationManager.AppSettings["AUTHWS_SafetyKey"];

                string appName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_AppName"]);
                string domainName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_DomainName"]);
                string groupName = util.StringCoding.Encrypt(ConfigurationManager.AppSettings["AUTHWS_GroupName"]);
                string hostName = util.StringCoding.Encrypt(HttpContext.Current.Request.UserHostName);
                string hostIp = util.StringCoding.Encrypt(HttpContext.Current.Request.UserHostAddress);
                string requestUserAgent = util.StringCoding.Encrypt(HttpContext.Current.Request.UserAgent);
                //--> end

                authb.LdapUser ldapUtente = new authb.LdapUser();
                sessionInfo = new authb.SessionInfo();

                bool result = false;

                HttpResponseMessage apiResponse;

                Dictionary<string, string> requestParam = new Dictionary<string, string>();
                util.WebApiObject.TokenResponse token;

                token = util.WebApiCall.getAccessToken(ConfigurationManager.AppSettings["AUTHWS_AppName"]
                                                        , ConfigurationManager.AppSettings["AUTHWS_SafetyKey"]
                                                        , ConfigurationManager.AppSettings["APIURL_TokenAuthorize"]
                                                        , Session.Timeout.ToString());
                Session["token"] = token;


                if (!String.IsNullOrEmpty(token.AccessToken))
                {
                    if (util.WebApiCall.getUserSessionIsActive(token.AccessToken, appName, usr, psw, ConfigurationManager.AppSettings["APIURL_AUTHINFO_GetUserSessionIsActive"]))
                    {
                        result = false;

                        string msg = "Esiste già una sessione attiva per questo utente: <font class=titrosso12>" + util.StringCoding.Decrypt(usr) + "</font>";
                        msg += "<br />Per proseguire scollegare l'utente ed effettuare un nuovo accesso.";

                        spanLogin.Visible = false;
                        lnkForceLogOut.Visible = true;

                        lblMessage.Text = message.HtmlExclamation(msg);
                    }
                    else
                    {
                        requestParam = new Dictionary<String, String> {
                                                { "appName", WebUtility.UrlEncode(appName)},
                                                { "appTimeOut", Session.Timeout.ToString()},
                                                { "appToken", WebUtility.UrlEncode(ConfigurationManager.AppSettings["AUTHWS_SafetyKey"])},
                                                { "domainName", WebUtility.UrlEncode(domainName)},
                                                { "groupname", WebUtility.UrlEncode(groupName)},
                                                { "UserName", WebUtility.UrlEncode(usr)},
                                                { "Password", WebUtility.UrlEncode(psw)},
                                                { "HostName", WebUtility.UrlEncode(hostName)},
                                                { "HostIp", WebUtility.UrlEncode(hostIp)},
                                                { "requestUserAgent", WebUtility.UrlEncode(requestUserAgent)}
                                                            };

                        apiResponse = util.WebApiCall.callApiGet(token.AccessToken, requestParam, ConfigurationManager.AppSettings["APIURL_AUTHLDAP_Logon"]);
                        string JsonContent = apiResponse.Content.ReadAsStringAsync().Result;

                        JsonContent = it.tools.library.UtilityBased.JsonClear(JsonContent);

                        Dictionary<string, object> ldapResult = JsonConvert.DeserializeObject<Dictionary<string, object>>(JsonContent);


                        if (ldapResult.ContainsKey("statusResponse"))
                        {

                            util.WebApiObject.StatusResponse status = JsonConvert.DeserializeObject<util.WebApiObject.StatusResponse>(ldapResult["statusResponse"].ToString());

                            if (status.MessageShort.StartsWith("OK"))
                            {
                                if (ldapResult.ContainsKey("ldapUser"))
                                {
                                    ldapUtente = JsonConvert.DeserializeObject<authb.LdapUser>(ldapResult["ldapUser"].ToString());

                                    if (ldapUtente.Validate() == "OK")
                                    {
                                        userInfo = JsonConvert.DeserializeObject<authb.UserInfo>(ldapResult["userInfo"].ToString());

                                        if (userInfo.UserID > 0)
                                        {
                                            Session["UserInfo"] = userInfo;

                                            //userInfo.UserID = dbUtente.UserID;
                                            //userInfo.Username = dbUtente.Username;
                                            //userInfo.Nominativo = dbUtente.DisplayName;
                                            //userInfo.TipoUtente = dbUtente.EmployeeType;

                                            sessionInfo.UserInfo = userInfo;
                                            sessionInfo.SessionID = ldapUtente.SessionID;
                                            sessionInfo.SessionTimeOut = Session.Timeout;
                                            sessionInfo.HostName = HttpContext.Current.Request.UserHostName;
                                            sessionInfo.HostIp = HttpContext.Current.Request.UserHostAddress;
                                            sessionInfo.Url = Request.ServerVariables["HTTP_HOST"];
                                            sessionInfo.requestParamBased = new Dictionary<string, string>() { { "sessionID", ldapUtente.SessionID } };

                                            Session["SessionInfo"] = sessionInfo;


                                            if (ldapUtente.CurrentGroup.RoleName.ToLower() == "agente")
                                            {
                                                Session["AgenteGroupID"] = ldapUtente.EmployeeID;
                                                Session["CallCenterID"] = ldapUtente.EmployeeNumber;
                                            }
                                            else if (ldapUtente.CurrentGroup.RoleName.ToLower() == "callcenter")
                                            {
                                                Session["CallCenterID"] = ldapUtente.EmployeeID;
                                            }
                                            else if (ldapUtente.CurrentGroup.RoleName.ToLower() == "commerciale")
                                            {
                                                Session["CommercialeID"] = ldapUtente.EmployeeID;
                                            }


                                            result = true;
                                        }
                                        else
                                        {
                                            result = false;
                                            lblMessage.Text = message.HtmlError("Errore db utente non trovato, se il problema persiste chiedere all'amministratore di sistema di verificare l'account");
                                        }
                                    }
                                    else
                                    {
                                        result = false;
                                        lblMessage.Text = message.HtmlError("Errore informazioni mancanti, se il problema persiste chiedere all'amministratore di sistema di verificare l'account");
                                    }




                                    //    Session["LoginType"] = typeinfo.eTypeLogin.Manuale;



                                }
                                else
                                {
                                    result = false;
                                    lblMessage.Text = "errore interno se il problema persiste contattare l'amministratore di sistema";
                                }
                            }
                            else
                            {
                                result = false;
                                lblMessage.Text = status.MessageShort.Replace(System.Environment.NewLine, "<br/>").ToString();
                            }
                        }
                        else
                        {
                            result = false;
                        }
                    }


                    if (result == true)
                    {
                        //string key = "";

                        //if (userInfo.RoleName.ToLower() == "admin") key = "operatoreID";
                        //else if (userInfo.RoleName.ToLower() == "agente") key = "agenteID";
                        //else if (userInfo.RoleName.ToLower() == "operatore") key = "operatoreID";
                        //else if (userInfo.RoleName.ToLower() == "callcenter") key = "callcenterID";
                        //else if (userInfo.RoleName.ToLower() == "commerciale") key = "commercialeID";

                        requestParam = new Dictionary<string, string> {
                                              { "sessionID", sessionInfo.SessionID }
                                            , { "url", Request.Url.ToString() }
                                            , { "pageName", Request.ServerVariables["script_name"].Substring(1) }
                                            //, { key, userInfo.EmployeeID}
                                                                    };
                        apiResponse = util.WebApiCall.callApiGet(token.AccessToken, requestParam, webconfigkey.GetValue("APIURL_TRACELOG_WebForm"));

                        Response.Redirect(corrispettivi.tools.SystemFunction.SelectUrlAfterLogin(userInfo.RoleName));
                    }
                    //else
                    //{
                    //    Response.Redirect("end.aspx");
                    //}
                }
            }
            catch (Exception ex)
            {
                string a = ex.Message;
            }
        }
    }
}