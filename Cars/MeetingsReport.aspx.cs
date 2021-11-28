using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Cars
{
    public partial class MeetingsReport : System.Web.UI.Page
    {
        DBDataContext dc = new DBDataContext();//open connection
        string cs = ConfigurationManager.ConnectionStrings["CarsConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                #region Read company name from DB
                ListItem li = new ListItem("בחר", "%");
                var ans = from c in dc.DealerShips select c;
                foreach (var a in ans)
                {
                    ddlCompanyMeeting.Items.Add(a.Name);
                }
                ddlCompanyMeeting.Items.Insert(0, li);
                #endregion

                #region Read from XML
                DataSet ds = new DataSet();
                ds.ReadXml(Server.MapPath("Cities.xml"));
                ddlCityMeeting.DataTextField = "CityName";
                ddlCityMeeting.DataValueField = "CityID";

                ddlCityMeeting.DataSource = ds;
                ddlCityMeeting.DataBind();
                List<ListItem> list = new List<ListItem>();
                foreach (ListItem item in ddlCityMeeting.Items)
                {
                    list.Add(item);
                }
                ddlCityMeeting.Items.Clear();
                foreach (ListItem item in list.OrderBy(item => item.Text))
                {
                    ddlCityMeeting.Items.Add(item);
                }
                ListItem liCity = new ListItem("בחר", "%");
                ddlCityMeeting.Items.Insert(0, liCity);
                #endregion

            }
        }

        protected void imgbFromDate_Click(object sender, ImageClickEventArgs e)
        {
            if (calFromDate.Visible == false)
            {
                calFromDate.Visible = true;
            }
            else
            {
                calFromDate.Visible = false;
            }

            if (calToDate.Visible == true)
            {
                calToDate.Visible = false;
            }
        }

        protected void imgbToDate_Click(object sender, ImageClickEventArgs e)
        {
            if (calToDate.Visible == false)
            {
                calToDate.Visible = true;
            }
            else
            {
                calToDate.Visible = false;
            }

            if (calFromDate.Visible == true)
            {
                calFromDate.Visible = false;
            }
        }

        protected void calFromDate_SelectionChanged(object sender, EventArgs e)
        {
            txtFromDate.Text = calFromDate.SelectedDate.ToShortDateString();
            calFromDate.Visible = false;
        }

        protected void calToDate_SelectionChanged(object sender, EventArgs e)
        {
            txtToDate.Text = calToDate.SelectedDate.ToShortDateString();
            calToDate.Visible = false;
        }

        protected void ddlCompanyMeeting_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCompanyMeeting.SelectedIndex == 0)
            {
                ddlCityMeeting.SelectedIndex = 0;
                DataSet ds = new DataSet();
                ds.ReadXml(Server.MapPath("Cities.xml"));
                ddlCityMeeting.DataTextField = "CityName";
                ddlCityMeeting.DataValueField = "CityID";
                ddlCityMeeting.DataSource = ds;
                ddlCityMeeting.DataBind();

                List<ListItem> list = new List<ListItem>();
                foreach (ListItem item in ddlCityMeeting.Items)
                {
                    list.Add(item);
                }
                ddlCityMeeting.Items.Clear();
                foreach (ListItem item in list.OrderBy(item => item.Text))
                {
                    ddlCityMeeting.Items.Add(item);
                }
                ListItem liCity = new ListItem("", "%");
                ddlCityMeeting.Items.Insert(0, liCity);
                ddlCityMeeting.SelectedIndex = 0;
            }

            else
            {
                //Response.Write("company" + ddlCompanyMeeting.SelectedIndex.ToString());
                ddlCityMeeting.DataTextField = "CitySite";//רשימה חדשה מהטבלה
                ddlCityMeeting.DataValueField = "CitySite";//רשימה חדשה מהטבלה
                ddlCityMeeting.DataSource = string.Empty;//מחק את הרשימה המלאה
                SqlParameter param = new SqlParameter("@name", ddlCompanyMeeting.SelectedItem.ToString());
                DataSet ds = GetData("getDealershipSite", param);
                ddlCityMeeting.DataSource = ds;
                ddlCityMeeting.DataBind();
                ListItem li = new ListItem("", "%");
                ddlCityMeeting.Items.Insert(0, li);
            }
        }

        private DataSet GetData(string spName, SqlParameter spParameter)
        {
            SqlConnection con = new SqlConnection(cs);
            SqlDataAdapter da = new SqlDataAdapter(spName, con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            if (spParameter != null)
            {
                da.SelectCommand.Parameters.Add(spParameter);
            }

            DataSet ds = new DataSet();
            da.Fill(ds);

            return ds;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtFromDate.Text = string.Empty;
            txtToDate.Text = string.Empty;
            ddlCompanyMeeting.SelectedIndex = 0;
            ddlCityMeeting.SelectedIndex = 0;
            DataSet ds = new DataSet();
            ds.ReadXml(Server.MapPath("Cities.xml"));
            ddlCityMeeting.DataTextField = "CityName";
            ddlCityMeeting.DataValueField = "CityID";
            ddlCityMeeting.DataSource = ds;
            ddlCityMeeting.DataBind();

            List<ListItem> list = new List<ListItem>();
            foreach (ListItem item in ddlCityMeeting.Items)
            {
                list.Add(item);
            }
            ddlCityMeeting.Items.Clear();
            foreach (ListItem item in list.OrderBy(item => item.Text))
            {
                ddlCityMeeting.Items.Add(item);
            }
            ListItem liCity = new ListItem("בחר", "%");
            ddlCityMeeting.Items.Insert(0, liCity);
            ddlCityMeeting.SelectedIndex = 0;

            pnlSearch.Visible = false;
            Response.Redirect("~/MeetingsReport.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        { 
            //using (SqlConnection con = new SqlConnection(cs))
            //{
            //   // SqlCommand cmd = new SqlCommand("select * from vmMeetingsReport");
            //    SqlDataAdapter da = new SqlDataAdapter("select * from vmMeetingsReport", con);
            //    DataSet ds = new DataSet();
            //    da.Fill(ds);
            //    gvSearch.DataSource = ds;
            //    gvSearch.DataBind();
            //}

            pnlSearch.Visible = true;
            //Response.Write("From date: "+txtFromDate.Text + ", To Date: " + txtToDate.Text);
        }

        protected void gvSearch_PreRender(object sender, EventArgs e)
        {
            string currentPage = (gvSearch.PageIndex + 1).ToString();
            string totalPages = gvSearch.PageCount.ToString();
            if (gvSearch.PageCount == 0)
            {
                lblMeetingPage.Text = string.Empty;
            }
            else
            {
                lblMeetingPage.Text = "מציג עמוד " + currentPage + " מתוך " + totalPages;
            }
        }

        protected void SqlDataSourceMeetings_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            lblTotalMeetings.Text = string.Empty;
            if(e.AffectedRows > 0)
            {
                lblTotalMeetings.Text = "נמצאו " + e.AffectedRows.ToString() + " תוצאות ";
            }

        }
    }
}