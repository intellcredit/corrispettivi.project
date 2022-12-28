using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Corrispettivi.Library
{
    public class Message
    {
        public static string HtmlInfo(string _msg)
        {
            string _wm = null;
            _wm = "<div id=\"MessageInfo\"><p>###</p></div>";
            _wm = _wm.Replace("###", _msg);
            return _wm;
        }
        public static string HtmlInfo2(string _msg)
        {
            string _wm = null;
            _wm = "<div id=\"MessageInfo2\">###</div>";
            _wm = _wm.Replace("###", _msg);
            return _wm;
        }
        public static string HtmlError(string _msg)
        {
            string _wm = null;
            _wm = "<div id=\"MessageError\"><p>###</p></div>";
            _wm = _wm.Replace("###", _msg);
            return _wm;
        }
        public static string HtmlLicenze(string _msg)
        {
            string _wm = null;
            _wm = "<div id=\"MessageLicenze\" align=\"center\"><p>###</p></div>";
            _wm = _wm.Replace("###", _msg);
            return _wm;
        }
        public static string HtmlExclamation(string _msg)
        {
            string _wm = null;
            _wm = "<div id=\"MessageExclamation\"><p>###</p></div>";
            _wm = _wm.Replace("###", _msg);
            return _wm;
        }
        public static string HtmlSaved(string _msg)
        {
            string _wm = null;
            _wm = "<div id=\"MessageSaved\"><p>###</p></div>";
            _wm = _wm.Replace("###", _msg);
            return _wm;
        }
    }
}