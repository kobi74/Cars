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
    public partial class index : System.Web.UI.Page
    {
        string msgCompare = "<script> alert('יש לסמן 2 או 3 רכבים בלבד') </script>";
        int year = DateTime.Now.Year;
        ListItem li = new ListItem("בחר", "%");
        ListItem minYear = new ListItem("בחר", "0");
        ListItem maxYear = new ListItem("בחר", "100000000");
        string cs = ConfigurationManager.ConnectionStrings["CarsConnectionString"].ConnectionString;
        DBDataContext dc = new DBDataContext();//open connection

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillDropYears();                
                ddlIndexMinYear.Items.Insert(0, minYear);
                ddlIndexMaxYear.Items.Insert(0, maxYear);
                ddlIndexLine.Items.Insert(0, li);
                ddlIndexGroup.Items.Insert(0, li);
                ddlIndexLine.Enabled = false;
                pnlGridview.Visible = false;
                // ****** מתחילים להזין רשימות*******
                //יצרן
                ddlIndexManufacturer.DataSource = GetData("spGetManufacturer", null);
                ddlIndexManufacturer.DataBind();
                ddlIndexManufacturer.Items.Insert(0, li);
                //סוף יצרן
            }
        }

        public void FillDropYears()
        {
            for(int i= year - 10; i <= year; i++)
            {
                ListItem li = new ListItem(i.ToString());
                ddlIndexMinYear.Items.Add(li);
                ddlIndexMaxYear.Items.Add(li);
            }
        }

        protected void ddlIndexMinYear_SelectedIndexChanged(object sender, EventArgs e)
        {            
            if (ddlIndexMinYear.AutoPostBack == false)
            {
                ddlIndexMinYear.AutoPostBack = true;
            }
            ddlIndexMaxYear.Items.Clear();
            int getYear = Convert.ToInt32(ddlIndexMinYear.SelectedItem.Value);
            for(int i = getYear; i <= year; i++)
            {
                ListItem li = new ListItem(i.ToString());
                ddlIndexMaxYear.Items.Add(li);
            }
            ddlIndexMaxYear.Items.Insert(0, maxYear);
            ddlIndexMinYear.AutoPostBack = false;
        }

        protected void ddlIndexMaxYear_SelectedIndexChanged(object sender, EventArgs e)
        {            
            if (ddlIndexMaxYear.AutoPostBack == false)
            {
                ddlIndexMaxYear.AutoPostBack = true;
            }
            ddlIndexMinYear.Items.Clear();
            int getYear = Convert.ToInt32(ddlIndexMaxYear.SelectedItem.Value);
            for(int i = year - 10; i <= getYear; i++)
            {
                ListItem li = new ListItem(i.ToString());
                ddlIndexMinYear.Items.Add(li);
            }
            ddlIndexMinYear.Items.Insert(0, minYear);
            ddlIndexMaxYear.AutoPostBack = false;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            ClearYears();
        }

        public void ClearYears()
        {
            ddlIndexMinYear.Items.Clear();
            ddlIndexMaxYear.Items.Clear();
            ddlIndexMinYear.AutoPostBack = true;
            ddlIndexMaxYear.AutoPostBack = true;
            FillDropYears();
            ddlIndexMinYear.Items.Insert(0, minYear);
            ddlIndexMaxYear.Items.Insert(0, maxYear);
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

        protected void ddlIndexManufacturer_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlIndexManufacturer.SelectedIndex == 0)
            {
                ddlIndexLine.Enabled = false;
                ddlIndexLine.SelectedIndex = 0;
            }

            else
            {
                ddlIndexLine.Enabled = true;
                SqlParameter parm = new SqlParameter("@name", ddlIndexManufacturer.SelectedItem.Text);
                DataSet ds = GetData("spGetLine", parm);
                ddlIndexLine.DataSource = ds;
                ddlIndexLine.DataBind();
                //ListItem li = new ListItem("בחר", "-1");
                ddlIndexLine.Items.Insert(0, li);
            }
        }

        protected void btnIndexClear_Click(object sender, EventArgs e)
        {
            ddlIndexGroup.SelectedIndex = 0;
            ddlIndexManufacturer.SelectedIndex = 0;
            ddlIndexLine.Enabled = false;
            ddlIndexLine.Items.Clear();
            ddlIndexLine.Items.Insert(0, li);
            txtIndexMaxPrice.Text = string.Empty;
            txtIndexMinPrice.Text = string.Empty;
            ClearYears();
            Response.Redirect("index.aspx");
        }

        protected void btnIndexSearch_Click(object sender, EventArgs e)
        {
            pnlGridview.Visible = true;
            FillSearchLog();
            /*
            string group ="";
            string manufacturer = "";
            string line = "";
            int minYear, maxYear, minPrice, maxPrice;

            if (ddlIndexGroup.SelectedIndex == 0)
            {
                group = "%";
            }
            else
            {
                group = ddlIndexGroup.SelectedItem.Value;
            }

            if (ddlIndexManufacturer.SelectedIndex == 0)
            {
                manufacturer = "%";
            }
            else
            {
                manufacturer = ddlIndexManufacturer.SelectedItem.Value;
            }

            if (ddlIndexLine.SelectedIndex == 0)
            {
                line = "%";
            }
            else
            {
                line = ddlIndexLine.SelectedItem.Value;
            }

            if (ddlIndexMinYear.SelectedIndex == 0)
            {
                minYear = Convert.ToInt32(ddlIndexMinYear.Items[1].Value);
            }
            else
            {
                minYear = Convert.ToInt32(ddlIndexMinYear.Items[ddlIndexMinYear.Items.Count-1].Value);
            }

            if (ddlIndexMaxYear.SelectedIndex == 0)
            {
                maxYear = Convert.ToInt32(ddlIndexMaxYear.Items[ddlIndexMaxYear.Items.Count - 1].Value);
            }
            else
            {
                maxYear = Convert.ToInt32(ddlIndexMaxYear.SelectedItem.Value);
            }

            if (txtIndexMinPrice.Text == string.Empty)
            {
                minPrice = 0;
            }
            else
            {
                minPrice = Convert.ToInt32(txtIndexMinPrice.Text);
            }

            if (txtIndexMaxPrice.Text==string.Empty)
            {
                maxPrice = 100000000;
            }
            else
            {
                maxPrice = Convert.ToInt32(txtIndexMaxPrice.Text);
            }


            pnlGridview.Visible = true;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("MiniSearch", con);
                cmd.CommandType = CommandType.StoredProcedure;
                //cmd.SelectCommand.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@class",group);
                cmd.Parameters.AddWithValue("@manufacturer", manufacturer);
                cmd.Parameters.AddWithValue("@Line",line);
                cmd.Parameters.AddWithValue("@minYear",minYear);
                cmd.Parameters.AddWithValue("@MaxYear",maxYear);
                cmd.Parameters.AddWithValue("@MinPrice",minPrice);
                cmd.Parameters.AddWithValue("@MaxPrice",maxPrice);
                using(SqlDataReader rdr = cmd.ExecuteReader())
                {
                    DataTable dt = new DataTable();
                    DataColumn img = new DataColumn();
                    dt.Columns.Add("מספר רכב");
                    dt.Columns.Add("יצרן");
                    dt.Columns.Add("דגם");
                    dt.Columns.Add("סוכנות ליסינג");
                    dt.Columns.Add("סניף");
                    dt.Columns.Add("שנה");
                    dt.Columns.Add("צבע");
                    dt.Columns.Add("קבוצה");
                    dt.Columns.Add("סוג דלק");
                    dt.Columns.Add("נפח מנוע");
                    dt.Columns.Add("תיבת הילוכים");
                    dt.Columns.Add("קילומטר");
                    dt.Columns.Add("מחיר");
                    dt.Columns.Add("תמונה");

                    while (rdr.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["מספר רכב"] = rdr["serialNumber"];
                        row["יצרן"] = rdr["manufacturer_Name_Line"];
                        row["דגם"] = rdr["LineName"];
                        row["סוכנות ליסינג"] = rdr["DealershipName"];
                        row["סניף"] = rdr["DealershipNameSite"];
                        row["שנה"] = rdr["Year"];
                        row["צבע"] = rdr["Color"];
                        row["קבוצה"] = rdr["Class"];
                        row["סוג דלק"] = rdr["Fuel"];
                        row["נפח מנוע"] = rdr["Engine"];
                        row["תיבת הילוכים"] = rdr["Gearbox"];
                        row["קילומטר"] = rdr["NumOfKM"];
                        row["מחיר"] = rdr["Price"];
                        row["תמונה"] = rdr["CarPic"];
                        dt.Rows.Add(row);

                    }
                    gvIndexSearch.DataSource = dt;
                    gvIndexSearch.DataSourceID = null;
                    gvIndexSearch.DataBind();
                }
            }*/
        }

        protected void gvIndexSearch_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvIndexSearch.PageIndex = e.NewPageIndex;
            gvIndexSearch.DataBind();
            pnlGridview.Visible = true;
        }

        protected void gvIndexSearch_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["CarNumber"] = HttpUtility.HtmlDecode(gvIndexSearch.SelectedRow.Cells[1].Text);
            Response.Redirect("~/CarDetail.aspx");
        }

        protected void btnCompare_Click(object sender, EventArgs e)
        {
            int count = 0;
            List<string> selections = new List<string>();
            foreach(GridViewRow row in gvIndexSearch.Rows)
            {
                CheckBox chk = row.FindControl("cbCarIndex") as CheckBox;
                if (chk.Checked == true)
                {
                    count++;
                    selections.Add(chk.ToolTip.ToString());
                }
            }

            if (count < 2 || count > 3)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", msgCompare);
            }
            else
            {
                Session["selections"] = selections;
                Response.Redirect("~/ComparePrices.aspx");
            }
            
        }

        protected void FillSearchLog()
        {
            SearchLog log = new SearchLog();
            log.ipAddress = Request.UserHostAddress.ToString();
            if (ddlIndexManufacturer.SelectedIndex > 0)
            {
                log.Manufacturer = ddlIndexManufacturer.SelectedValue.ToString();
            }
            if (ddlIndexLine.SelectedIndex > 0)
            {
                log.Line = ddlIndexLine.SelectedValue.ToString();
            }
            if (ddlIndexMinYear.SelectedIndex > 0)
            {
                log.FromYear = Convert.ToInt32(ddlIndexMinYear.SelectedValue.ToString());
            }
            if (ddlIndexMaxYear.SelectedIndex > 0)
            {
                log.ToYear = Convert.ToInt32(ddlIndexMaxYear.SelectedValue.ToString());
            }

            if(txtIndexMinPrice.Text != string.Empty)
            {
                log.fromPrice = Convert.ToInt32(txtIndexMinPrice.Text);
            }

            if (txtIndexMaxPrice.Text != string.Empty)
            {
                log.ToPrice = Convert.ToInt32(txtIndexMaxPrice.Text);
            }

            dc.SearchLogs.InsertOnSubmit(log);
            dc.SubmitChanges();

        }
    }
}