using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cars
{
    public partial class BackendMasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["FirstName"]!=null && Session["LastName"] != null && Session["Position"] != null)
            {
                lblHello.Text = ("ברוך הבא " + Session["FirstName"].ToString() + " " + Session["LastName"].ToString());
                if(Session["Position"].ToString() != "מנהל")
                {
                    hlReports.Visible = false;
                }
            }

            else
            {
                Response.Redirect("~/login.aspx");
            }
        }
    }
}