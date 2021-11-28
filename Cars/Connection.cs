using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Cars
{
    public class Connection
    {
        public static string connectionString = "Data Source=NAVON-PC\\SQLEXPRESSKOBI;Initial Catalog=MatchMeData;Integrated Security=True";//connection string
        public static DBDataContext db = new DBDataContext(connectionString);//open connection
    }
}