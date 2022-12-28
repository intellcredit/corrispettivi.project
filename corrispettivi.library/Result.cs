using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Corrispettivi.Library
{
    public class Result
    {
        public class Default
        {
            public int ID { get; set; }
            public string DESC { get; set; }

            public Default()
            {
                ID = 0;
                DESC = "";
            }
        }
    }

    public enum eWebResult
    {
        Saved,
        Deleted,
        Duplicated
    }
}