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
    public partial class CompanySite : System.Web.UI.Page
    {
        DBDataContext dc = new DBDataContext();//open connection
        string cs = ConfigurationManager.ConnectionStrings["CarsConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlCompanySiteAll.Visible = true;
                pnlCompaySiteFilter.Visible = false;

                #region Read company name from DB
                ListItem li = new ListItem("בחר", "-1");
                ddlCompanyName.Items.Insert(0,li);

                var ans = from c in dc.DealerShips select c;
                foreach(var a in ans)
                {
                    ddlCompanyName.Items.Add(a.Name);
                }
                #endregion

                #region Read from XML
                DataSet ds = new DataSet();
                ds.ReadXml(Server.MapPath("Cities.xml"));
                ddlCity.DataTextField = "CityName";
                ddlCity.DataValueField = "CityID";
                ddlFilterCity.DataTextField = "CityName";
                ddlFilterCity.DataValueField = "CityID";

                ddlCity.DataSource = ds;
                ddlCity.DataBind();
                //ddlFilterCity.DataSource = ds;
                //ddlFilterCity.DataBind();
               /* ListItem liCity = new ListItem("בחר", "-1");
                ddlCity.Items.Insert(0, liCity);
                */
                List<ListItem> list = new List<ListItem>();
                foreach (ListItem item in ddlCity.Items)
                {
                    list.Add(item);
                }
                ddlCity.Items.Clear();
               // ddlFilterCity.Items.Clear();
                foreach (ListItem item in list.OrderBy(item => item.Text))
                {
                    ddlCity.Items.Add(item);
                    ddlFilterCity.Items.Add(item);
                }
                ListItem liCity = new ListItem("בחר", "-1");
                ddlCity.Items.Insert(0, liCity);
                ListItem filter = new ListItem(string.Empty, "%");
                ddlFilterCity.Items.Insert(0,filter);
                #endregion

                ddlCity.Enabled = false;
                // סוכנות רכב
                ddlFilterCompany.DataSource = GetData("getDealership", null);
                ddlFilterCompany.DataBind();
                ddlFilterCompany.Items.Insert(0, filter);
                // סוף סוכנות רכב
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

        protected void btnAddCompanySite_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                DealerShipSite site = new DealerShipSite();
                site.dealerShipName = ddlCompanyName.Text;
                site.CitySite = ddlCity.SelectedItem.ToString();
                site.address = txtAddress.Text;
                site.phone = txtPhone.Text;
                dc.DealerShipSites.InsertOnSubmit(site);
                dc.SubmitChanges();
                lblMessage.Text = "סניף סוכנות " + ddlCompanyName.Text + " נוסף בצלחה";
                lblMessage.ForeColor = System.Drawing.Color.Green;

                ClearForm();
                grvCompanySite.DataBind();
                gvCompanySiteFilter.DataBind();
            }
        }

        public void ClearForm()
        {
            ddlCompanyName.SelectedIndex = 0;
            ddlCity.SelectedIndex = 0;
            ddlCity.Enabled = false;
            txtAddress.Text = "";
            txtPhone.Text = "";
            hdnCity.Value = "";
            hdnDealerName.Value = "";
        }

        //כפילות אבל לא למחוק
        protected void ddlCompanyName_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCompanyName.SelectedIndex == 0)
            {
                ddlCity.Enabled = false;
                ddlCity.SelectedIndex = 0;
            }

            else
            {
                ddlCity.Enabled = true;
            }
        }
        

        protected void btnDeleteCompanySite_Click(object sender, EventArgs e)
        {
            var siteCarCount = (from s in dc.Cars where (s.DealershipName == ddlCompanyName.SelectedValue && s.DealershipNameSite == ddlCity.SelectedValue) select s).Count();
            var siteMeetingrCount = (from s in dc.Meetings where (s.DealershipName == ddlCompanyName.SelectedValue && s.DealrshipSite == ddlCity.SelectedValue) select s).Count();
            if (siteCarCount > 0 || siteMeetingrCount > 0)
            {
                lblMessage.Text = " לא ניתן למחוק את  " + ddlCompanyName.Text + " " + ddlCity.Text + " . הסניף קשור לרכב";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("DealerShipSitesDelete", con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@OldDealerName", ddlCompanyName.Text);
                    cmd.Parameters.AddWithValue("@OldCity", ddlCity.SelectedItem.ToString());
                    con.Open();
                    cmd.ExecuteNonQuery();
                    ClearForm();
                    grvCompanySite.DataBind();
                    gvCompanySiteFilter.DataBind();

                    lblMessage.Text = ddlCompanyName.Text + " סניף " + ddlCity.SelectedItem.ToString() + " נמחק בהצלחה";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
            }
        }

        protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCompanyName.SelectedIndex==0)
            {
                ddlCity.Enabled = false;
                ddlCity.SelectedIndex = 0;
            }

            else
            {
                ddlCity.Enabled = true;
            }
        }

        protected void btnUpdateCompanySite_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("DealerShipSitesUpdate",con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@OldDealerName",hdnDealerName.Value);
                cmd.Parameters.AddWithValue("@OldCity", hdnCity.Value);
                cmd.Parameters.AddWithValue("@NewDealerName",ddlCompanyName.Text);
                cmd.Parameters.AddWithValue("@NewCity",ddlCity.SelectedItem.ToString());
                cmd.Parameters.AddWithValue("@NewAddress",txtAddress.Text);
                cmd.Parameters.AddWithValue("@NewPhone",txtPhone.Text);
                con.Open();
                cmd.ExecuteNonQuery();
                lblMessage.Text = "העדכון בוצע בהצלחה";
                lblMessage.ForeColor = System.Drawing.Color.Green;

                ClearForm();
                grvCompanySite.DataBind();
                gvCompanySiteFilter.DataBind();
            }
        }
        
        protected void grvCompanySite_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCity.Enabled == false)
            {
                ddlCity.Enabled = true;
            }
            string city = grvCompanySite.SelectedRow.Cells[2].Text;
            ddlCompanyName.Text = grvCompanySite.SelectedRow.Cells[1].Text;
            hdnDealerName.Value = ddlCompanyName.Text;
            ddlCity.SelectedItem.Selected = false;
            ddlCity.Items.FindByText(city).Selected = true;
            hdnCity.Value = city;
            txtAddress.Text = HttpUtility.HtmlDecode(grvCompanySite.SelectedRow.Cells[3].Text);
            txtPhone.Text = grvCompanySite.SelectedRow.Cells[4].Text;
        }

        protected void grvCompanySite_PreRender(object sender, EventArgs e)
        {
            string currentPage = (grvCompanySite.PageIndex + 1).ToString();
            string totalPages = grvCompanySite.PageCount.ToString();
            if (grvCompanySite.PageCount == 0)
            {
                lblPage.Text = "";
            }
            else
            {
                lblPage.Text = "מציג עמוד " + currentPage + " מתוך " + totalPages;
            }
        }

        protected void ddlFilterCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlFilterCompany.SelectedIndex == 0)
            {
                ddlFilterCity.SelectedIndex = 0;
                DataSet ds = new DataSet();
                ds.ReadXml(Server.MapPath("Cities.xml"));
                ddlFilterCity.DataTextField = "CityName";
                ddlFilterCity.DataValueField = "CityID";
                ddlFilterCity.DataSource = ds;
                ddlFilterCity.DataBind();

                List<ListItem> list = new List<ListItem>();
                foreach (ListItem item in ddlFilterCity.Items)
                {
                    list.Add(item);
                }
                ddlFilterCity.Items.Clear();
                foreach (ListItem item in list.OrderBy(item => item.Text))
                {
                    ddlFilterCity.Items.Add(item);
                }
                ListItem liCity = new ListItem("", "%");
                ddlFilterCity.Items.Insert(0, liCity);
                ddlFilterCity.SelectedIndex = 0;
            }

            else
            {
                //Response.Write("company" + ddlFilterCompany.SelectedIndex.ToString());
                ddlFilterCity.DataTextField = "CitySite";//רשימה חדשה מהטבלה
                ddlFilterCity.DataValueField = "CitySite";//רשימה חדשה מהטבלה
                ddlFilterCity.DataSource = string.Empty;//מחק את הרשימה המלאה
                SqlParameter param = new SqlParameter("@name", ddlFilterCompany.SelectedItem.ToString());
                DataSet ds = GetData("getDealershipSite", param);
                ddlFilterCity.DataSource = ds;
                ddlFilterCity.DataBind();
                ListItem li = new ListItem("", "%");
                ddlFilterCity.Items.Insert(0,li);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //Response.Write("עיר: " + ddlFilterCity.SelectedValue + " סוכנות: " + ddlFilterCompany.SelectedValue);
            if (ddlFilterCompany.SelectedIndex == 0 && ddlFilterCity.SelectedIndex == 0)
            {
                pnlCompanySiteAll.Visible = true;
                pnlCompaySiteFilter.Visible = false;
            }

            else
            {
                string company = "";
                string city = "";
                if (ddlFilterCompany.SelectedIndex == 0)
                {
                    company = "%%";
                }
                else
                {
                    company = ddlFilterCompany.SelectedItem.ToString();
                }
                if (ddlFilterCity.SelectedIndex == 0)
                {
                    city = "%%";
                }
                else
                {
                    city = ddlFilterCity.SelectedItem.ToString();
                }
                //Response.Write("city is: " + ddlFilterCity.SelectedItem.ToString());
               /* using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlDataAdapter da = new SqlDataAdapter("DealershipSitesSearch", con);
                    da.SelectCommand.CommandType = CommandType.StoredProcedure;
                    da.SelectCommand.Parameters.AddWithValue("@Dname",company);
                    da.SelectCommand.Parameters.AddWithValue("@Dsite",city);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    // gvCompanySiteFilter.DataSourceID = null;
                   // Response.Write(company + " " + city);
                    gvCompanySiteFilter.DataSource = dt;
                    gvCompanySiteFilter.DataBind();
                }*/
                pnlCompanySiteAll.Visible = false;
                pnlCompaySiteFilter.Visible = true;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            pnlCompanySiteAll.Visible = true;
            pnlCompaySiteFilter.Visible = false;
            ddlFilterCompany.SelectedIndex = 0;
            ddlFilterCity.SelectedIndex = 0;
            DataSet ds = new DataSet();
            ds.ReadXml(Server.MapPath("Cities.xml"));
            ddlFilterCity.DataTextField = "CityName";
            ddlFilterCity.DataValueField = "CityID";
            ddlFilterCity.DataSource = ds;
            ddlFilterCity.DataBind();

            List<ListItem> list = new List<ListItem>();
            foreach (ListItem item in ddlFilterCity.Items)
            {
                list.Add(item);
            }
            ddlFilterCity.Items.Clear();
            foreach (ListItem item in list.OrderBy(item => item.Text))
            {
                ddlFilterCity.Items.Add(item);
            }
            ListItem liCity = new ListItem("", "-1");
            ddlFilterCity.Items.Insert(0, liCity);
            ddlFilterCity.SelectedIndex = 0;
            Response.Redirect("~/CompanySite.aspx");
        }

        protected void btnClearForm_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                lblTotalALL.Text = "נמצאו " + e.AffectedRows.ToString() + " תוצאות ";
            }
        }

        protected void SqlDataSourceFilterCompanySite_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            lblTotalFilter.Text = string.Empty;
            if (e.AffectedRows > 0)
            {
                lblTotalFilter.Text = "נמצאו " + e.AffectedRows.ToString() + " תוצאות ";
            }
        }

        protected void gvCompanySiteFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCity.Enabled == false)
            {
                ddlCity.Enabled = true;
            }
            string city = gvCompanySiteFilter.SelectedRow.Cells[2].Text;
            ddlCompanyName.Text = gvCompanySiteFilter.SelectedRow.Cells[1].Text;
            hdnDealerName.Value = ddlCompanyName.Text;
            ddlCity.SelectedItem.Selected = false;
            ddlCity.Items.FindByText(city).Selected = true;
            hdnCity.Value = city;
            txtAddress.Text = HttpUtility.HtmlDecode(gvCompanySiteFilter.SelectedRow.Cells[3].Text);
            txtPhone.Text = gvCompanySiteFilter.SelectedRow.Cells[4].Text;
        }
    }
}