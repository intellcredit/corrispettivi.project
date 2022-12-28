
using System.Configuration;
using System.Drawing;

namespace corrispettivi.tools
{
    public static class SystemFunction
    {
        public static string GetWindowName()
        {
            return System.Web.HttpContext.Current.Session["WindowName"].ToString();
        }


        public static string SelectUrlAfterLogin(string type)
        {
            string _result;

            switch (type)
            {
                case "SUPERADMIN":      //SUPERADMIN
                    _result = ConfigurationManager.AppSettings["startPageSuperAdmin"].ToString();
                    break;
                case "ADMIN":       //ADMIN
                    _result = ConfigurationManager.AppSettings["startPageAdmin"].ToString();
                    break;
                case "AGENTE":      //AGENTE
                    _result = ConfigurationManager.AppSettings["startPageAgenti"].ToString();
                    break;
                case "CALLCENTER":  //CALLCENTER
                    _result = ConfigurationManager.AppSettings["startPageCallCenter"].ToString();
                    break;
                case "COMMERCIALE":  //COMMERCIALE
                    _result = ConfigurationManager.AppSettings["startPageCommerciali"].ToString();
                    break;
                case "CONTABILITA":   //CONTABILITA
                    _result = ConfigurationManager.AppSettings["startPageContabilita"].ToString();
                    break;
                case "DIREZIONE":   //DIREZIONE
                    _result = ConfigurationManager.AppSettings["startPageDirezione"].ToString();
                    break;
                case "UFFICIOPERSONALE":  //UFFICIO DEL PERSONALE
                    _result = ConfigurationManager.AppSettings["startPageUffPersonale"].ToString();
                    break;
                default:
                    _result = "~/end.aspx";
                    break;
            }

            return _result;
        }

        public static string SelectMasterPage(string type)
        {
            string _result;

            switch (type)
            {
                case "SUPERADMIN":   //SUPERADMIN
                    _result = ConfigurationManager.AppSettings["masterPageSuperAdmin"].ToString();
                    break;
                case "ADMIN":   //ADMIN
                    _result = ConfigurationManager.AppSettings["masterPageAdmin"].ToString();
                    break;
                case "AGENTE":   //AGENTE
                    _result = ConfigurationManager.AppSettings["masterPageAgenti"].ToString();
                    break;
                case "CALLCENTER":  //CALLCENTER
                    _result = ConfigurationManager.AppSettings["masterPageCallCenter"].ToString();
                    break;
                case "COMMERCIALE":  //COMMERCIALE
                    _result = ConfigurationManager.AppSettings["masterPageCommerciali"].ToString();
                    break;
                case "CONTABILITA":   //CONTABILITA
                    _result = ConfigurationManager.AppSettings["masterPageContabilita"].ToString();
                    break;
                case "DIREZIONE":   //DIREZIONE
                    _result = ConfigurationManager.AppSettings["masterPageDirezione"].ToString();
                    break;
                case "UFFICIOPERSONALE":  //UFFICIO DEL PERSONALE
                    _result = ConfigurationManager.AppSettings["masterPageUffPersonale"].ToString();
                    break;
                default:
                    _result = "blank.master";
                    break;
            }

            return _result;
        }

        public static bool CheckAccessArea(string type, string area)
        {
            bool _result = false;

            if (type.ToUpper() == "AGENTE" && area.ToUpper() == "AGENTI")
                _result = true;
            else if (type.ToUpper() == "CONTABILITA" && area.ToUpper() == "CONTABILITA")
                _result = true;
            else if (type.ToUpper() == "UFFICIOPERSONALE" && area.ToUpper() == "UFFICIO DEL PERSONALE")
                _result = true;
            else if (type.ToUpper() == "CALLCENTER" && area.ToUpper() == "CALLCENTER")
                _result = true;
            else if (type.ToUpper() == "COMMERCIALE" && area.ToUpper() == "COMMERCIALI")
                _result = true;
            else if (type.ToUpper() == "SUPERADMIN" || type.ToUpper() == "ADMIN")
                _result = true;
        
            return _result;
        }

        public static string GetMonthPrefix(int col)
        {
            string ret = "";

            switch (col - 2)
            {
                case 1:
                    ret = "GEN";
                    break;
                case 2:
                    ret = "FEB";
                    break;
                case 3:
                    ret = "MAR";
                    break;
                case 4:
                    ret = "APR";
                    break;
                case 5:
                    ret = "MAG";
                    break;
                case 6:
                    ret = "GIU";
                    break;
                case 7:
                    ret = "LUG";
                    break;
                case 8:
                    ret = "AGO";
                    break;
                case 9:
                    ret = "SET";
                    break;
                case 10:
                    ret = "OTT";
                    break;
                case 11:
                    ret = "NOV";
                    break;
                case 12:
                    ret = "DIC";
                    break;
            }

            return ret;
        }

        public static Color GetTabulatoStatusColor(int id)
        {
            Color ret = Color.LightGray;

            switch (id)
            {
                case 1: //provvisorio
                    ret = Color.Pink;
                    break;
                case 2: //approvazoine
                    ret = Color.Yellow;
                    break;
                case 3: //pubblicazione
                    ret = Color.LightGreen;
                    break;
                case 4: //chiuso
                    ret = Color.LightBlue;
                    break;
            }

            return ret;
        }

        public static Color GetFatturaStatusColor(int id)
        {
            Color ret = Color.LightGray;

            switch (id)
            {
                case 1: //no fattura
                    ret = Color.FromArgb(255, 204, 0);
                    //ret = Color.LightSalmon;
                    break;
                case 2: //fattura/e parziali
                    ret = Color.FromArgb(255, 255, 153);
                    //ret = Color.LightYellow;
                    break;
                case 3: //fatturato
                    ret = Color.FromArgb(0, 230, 77);
                    //ret = Color.LightSeaGreen;
                    break;
            }

            return ret;
        }
    }
}