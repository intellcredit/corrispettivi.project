using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using it.tools.library;

namespace Corrispettivi.Library
{
    public class Societa
    {
        public static Hashtable view()
        {
            Hashtable value = new Hashtable();
            value.Add(1, "INTELLCREDIT");
            value.Add(2, "JANUS");
            value.Add(3, "TELKOM");
            value.Add(5, "INNOVACION");
            return value;
        }
    }
}