
namespace Corrispettivi.Library
{
    public static class typeinfo
    {
        public struct InfoUser
        {
            public int ID;
            public string Login;
            public string Password;
            public string Codice;
            public int CodiceRaggruppamento;
            public string Nominativo;
            public InfoTipoUtente TipoUtente;
            public string TipoAgente;
            public bool IsSubAgente;
            public int InternoTelefonico;
            public int IDTipoLayout;
            public string PathHome;
            public bool SearchSimple;
            public bool SearchGroup;
            public bool SearchAll;
            public bool ListSpecial;
            public int IDSupervisore;
            public System.DateTime FirstAccess;
            public System.DateTime LastAccess;
            public bool InitPsw;
            public bool ForceChangePsw;
            public bool ModuloOreLavorate;
            public System.DateTime DataFineRapporto;

            public bool IsClosed;
            public bool IsLoad;

            public InfoUser(int _id, string _login, string _password, string _codice, string _nominativo, InfoTipoUtente _tiput, string _tipag, int _tiplayout, bool _issubage, int _internotelefonico, bool _searchsimple, bool _searchgroup, bool _searchall, bool _listspecial, int _idsupervisore, System.DateTime _firstaccess, System.DateTime _lastaccess, int _codiceragg, bool _initpsw, bool _forcechangepsw, System.DateTime _datafinerapporto, bool _isclosed)
            {
                ID = _id;
                Login = _login;
                Password = _password;
                Codice = _codice;
                CodiceRaggruppamento = _codiceragg;
                Nominativo = _nominativo;
                TipoUtente = _tiput;
                TipoAgente = _tipag;
                InternoTelefonico = _internotelefonico;
                IsSubAgente = _issubage;
                IDTipoLayout = _tiplayout;
                PathHome = "";
                SearchSimple = _searchsimple;
                SearchGroup = _searchgroup;
                SearchAll = _searchall;
                ListSpecial = _listspecial;
                IDSupervisore = _idsupervisore;
                FirstAccess = _firstaccess;
                LastAccess = _lastaccess;
                InitPsw = _initpsw;
                ForceChangePsw = _forcechangepsw;
                ModuloOreLavorate = false;
                DataFineRapporto = _datafinerapporto;
                IsClosed = _isclosed;
                IsLoad = true;
            }

            //public InfoUser(int _id, string _login, string _nome, InfoTipoUtente _tiput, int _codiceragg)
            //{
            //    ID = _id;
            //    Login = _login;
            //    Password = "";
            //    Codice = 0;
            //    CodiceRaggruppamento = 0;
            //    Nominativo = _nome;
            //    TipoUtente = _tiput;
            //    TipoAgente = "";
            //    InternoTelefonico = 0;
            //    IsSubAgente = false;
            //    IDTipoLayout = 0;
            //    PathHome = "";
            //    CodiceRaggruppamento = _codiceragg;
            //    SearchSimple = true;
            //    SearchGroup = false;
            //    SearchAll = false;
            //    ListSpecial = false;
            //    IDSupervisore = 0;
            //    FirstAccess = now();
            //    LastAccess = _lastaccess;
            //    InitPsw = _initpsw;
            //    ForceChangePsw = _forcechangepsw;
            //    ModuloOreLavorate = false;
            //    DataFineRapporto = _datafinerapporto;
            //    IsClosed = _isclosed;
            //    IsLoad = true;
            //}
        }

        public struct InfoCallCenter
        {
            public int ID;

            public string Nominativo;
            public InfoCallCenter(int _id, string _nominativo)
            {
                ID = _id;
                Nominativo = _nominativo;
            }
        }

        //public struct InfoSession
        //{
        //    public InfoUser User;
        //    public InfoCallCenter CallCenter;
        //    //************************************
        //    public string Application;
        //    //************************************
        //    public string RemoteAddress;
        //    public string WorkstationID;
        //    public string Url;
        //    public int UrlPort;
        //    public string ReturnPage;
        //    public string HomePage;
        //    //************************************
        //    public eTypeView TypeView;
        //    //************************************
        //    public string SessionID;
        //    public int SessionTimeOut;
        //    //************************************
        //    public string ListSpecialDesc;
        //    public string ListSpecialStored;
        //    //************************************

        //    public int IDWebSite;

        //    public InfoSession(InfoUser _iu, InfoCallCenter _icc, string _application)
        //    {
        //        User = _iu;
        //        CallCenter = _icc;
        //        //************************************
        //        Application = _application;
        //        //************************************
        //        RemoteAddress = "";
        //        WorkstationID = "";
        //        Url = "";
        //        UrlPort = 80;
        //        ReturnPage = "";
        //        HomePage = "";
        //        //************************************
        //        TypeView = eTypeView.All;
        //        //************************************
        //        SessionID = "";
        //        SessionTimeOut = 0;
        //        //************************************
        //        ListSpecialDesc = "";
        //        ListSpecialStored = "";
        //        //************************************
        //        IDWebSite = 0;
        //    }
        //}

        public struct InfoTipoUtente
        {
            public int ID;
            public string Descrizione;
            public string Sigla;

            public InfoTipoUtente(int _id, string _descrizione, string _sigla)
            {
                ID = _id;
                Descrizione = _descrizione;
                Sigla = _sigla;
            }
        }

        public enum eTypeView
        {
            All = 1
        }

        public enum eTypeLogin
        {
            Manuale = 1,
            Automatico = 2
        }

        public struct InfoPratica
        {
            public int IDSocieta;
            public int IDPratica;
            public string TipoTelefono;

            public string Telefono;
            public InfoPratica(int idsoc, int idprat, string tipo = "", string tel = "")
            {
                IDSocieta = idsoc;
                IDPratica = idprat;
                TipoTelefono = tipo;
                Telefono = tel;
            }
        }
    }
}