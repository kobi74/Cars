using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cars
{
    public partial class Login : System.Web.UI.Page
    {
        DBDataContext dc = new DBDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtUserName.Text = string.Empty;
                txtPassword.Text = string.Empty;
                lblError.Visible = false;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                var theUser = (from user in dc.Users where (user.UserName == txtUserName.Text && user.Password == txtPassword.Text) select user).Count();
                if(theUser == 1)
                {
                    var logUser = (from user in dc.Users where (user.UserName == txtUserName.Text && user.Password == txtPassword.Text) select user);
                    foreach (var item in logUser)
                    {
                        Session["FirstName"] =item.FirstName;
                        Session["LastName"] = item.LastName;
                        Session["Position"] = item.Position;
                    }
                    Response.Redirect("~/manufacturer.aspx");
                }

                else
                {
                    lblError.Text = "פרטי ההזדהות שגויים";
                    lblError.Visible = true;
                }
            } 
        }
    }
}