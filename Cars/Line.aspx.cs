using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Globalization;

namespace Cars
{
    public partial class Line1 : System.Web.UI.Page
    {
        string insertSuccess = "<script> alert('הדגם נוסף למערכת') </script>";
        string insertFailed = "<script> alert('פעולה נכשלה. הדגם קיים במערכת') </script>";
        string updateSuccess = "<script> alert('הדגם עודכן בהצלחה') </script>";
        string updateFail = "<script> alert('פעולה נכשלה.לא ניתן לבצע עדכון עבור הדגם או שהדגם קיים במערכת') </script>";
        string deleteSuccess = "<script> alert('הדגם נמחק בהצלחה') </script>";
        string deleteFail = "<script> alert('פעולה נכשלה. הדגם רשום בטבלת רכבים ו/או נקבעה עבורו פגישה.') </script>";
        string searchMsg = "<script> alert('חובה לרשום שם יצרן או שם דגם') </script>";

        string cs = ConfigurationManager.ConnectionStrings["CarsConnectionString"].ConnectionString;
        DBDataContext dc = new DBDataContext();//open connection
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListItem li = new ListItem("בחר", "-1");
                ddlManufacturer.Items.Insert(0, li);

                var ans = from c in dc.Manufacturers select c;
                foreach (var a in ans)
                {
                    ddlManufacturer.Items.Add(a.Name);
                }
                //Response.Write("Current Culture is " + CultureInfo.CurrentCulture.EnglishName);
                pnlLineAll.Visible = true;
                pnlFilterLine.Visible = false;
            }

        }

        protected void btnAddManufacturer_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                //בדוק האם היצרן קיים במערכת
                var lineCount = (from line in dc.Lines where (line.ManufacturerName == ddlManufacturer.Text && line.Line1==txtLine.Text) select line).Count();
                if (lineCount == 0)
                {
                    Line l = new Line();
                    l.ManufacturerName = ddlManufacturer.Text;
                    l.Line1 = txtLine.Text;
                    dc.Lines.InsertOnSubmit(l);//insert command
                    dc.SubmitChanges();// Save changes
                    Response.Write(insertSuccess);
                    ClearForm();
                    gvLine.DataBind();
                }

                else
                {
                    Response.Write(insertFailed);
                    ClearForm();
                    gvLine.DataBind();
                    gvFilterLine.DataBind();
                }
            }
        }

        protected void gvLine_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlManufacturer.Text = gvLine.SelectedRow.Cells[1].Text;
            txtLine.Text = HttpUtility.HtmlDecode(gvLine.SelectedRow.Cells[2].Text);
            hdnLine.Value = txtLine.Text;
            hdnManufacturer.Value = ddlManufacturer.Text;
        }

        public void ClearForm()
        {
            txtLine.Text = "";
            ddlManufacturer.SelectedIndex = 0;
            hdnLine.Value = "";
            hdnManufacturer.Value = "";
        }

        protected void btnUpdateManufacturer_Click(object sender, EventArgs e)
        {
            
            var lineCount = (from line in dc.Lines where (line.ManufacturerName == ddlManufacturer.Text && line.Line1 == txtLine.Text) select line).Count();
            //var hdnCount = (from line in dc.Lines where (line.ManufacturerName == hdnManufacturer.Value && line.Line1 == txtLine.Text) select line).Count();
            if (Page.IsValid)
            {
                if (lineCount == 0 && (hdnManufacturer.Value.ToString() != "" && hdnLine.Value.ToString() != "") )
                {
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlCommand cmd = new SqlCommand("spLineUpdate", con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@NewManufacturer", ddlManufacturer.Text);
                        cmd.Parameters.AddWithValue("@OldManufacturer", hdnManufacturer.Value);
                        cmd.Parameters.AddWithValue("@NewLine", txtLine.Text);
                        cmd.Parameters.AddWithValue("@OldLine", hdnLine.Value);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    Response.Write(updateSuccess);
                }

                else
                {
                    Response.Write(updateFail);
                }
              ClearForm();
              gvLine.DataBind();
              gvFilterLine.DataBind();
            }
        }

        protected void btnDeleteManufacturer_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                var carsCount = (from s in dc.Cars where (s.manufacturer_Name_Line == ddlManufacturer.SelectedValue && s.LineName == txtLine.Text) select s).Count();
                var meetingCount = (from s in dc.vmMeetingsReports where(s.manufacturer_Name_Line == ddlManufacturer.SelectedValue && s.LineName == txtLine.Text) select s).Count();
                if (carsCount > 0 || meetingCount > 0)
                {
                    Response.Write(deleteFail);
                }
                else
                {
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlCommand cmd = new SqlCommand("spLineDelete", con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ManufacturerDelete", ddlManufacturer.Text);
                        cmd.Parameters.AddWithValue("@lineDelete", txtLine.Text);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    Response.Write(deleteSuccess);
                    ClearForm();
                    gvLine.DataBind();
                    gvFilterLine.DataBind();
                }
            }
        }

 /*       protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {

        }
*/

        protected void btnClear_Click(object sender, EventArgs e)
        {
            pnlLineAll.Visible = true;
            pnlFilterLine.Visible = false;
            txtFilterManufacturer.Text = string.Empty;
            txtFilterLine.Text = string.Empty;
        }

        protected void gvFilterLine_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlManufacturer.Text = gvFilterLine.SelectedRow.Cells[1].Text;
            txtLine.Text = HttpUtility.HtmlDecode(gvFilterLine.SelectedRow.Cells[2].Text);
            hdnLine.Value = txtLine.Text;
            hdnManufacturer.Value = ddlManufacturer.Text;
        }

        protected void btnSearch_Click1(object sender, EventArgs e)
        {
            if (txtFilterLine.Text.Trim() == "" && txtFilterManufacturer.Text.Trim() == "")
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "script", searchMsg);
            }
            else
            {
                pnlLineAll.Visible = false;
                pnlFilterLine.Visible = true;
            }
        }

        protected void gvLine_PreRender(object sender, EventArgs e)
        {
            string currentPage = (gvLine.PageIndex + 1).ToString();
            string totalPages = gvLine.PageCount.ToString();
            if (gvLine.PageCount == 0)
            {
                lblPage.Text = "";
            }
            else
            {
                lblPage.Text = "מציג עמוד " + currentPage + " מתוך " + totalPages;
            }
        }

        protected void btnClearForm_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        protected void LineDataSource_Selected(object sender, LinqDataSourceStatusEventArgs e)
        {
            if (e.TotalRowCount > 0)
            {
                lblTotalAll.Text = "נמצאו " + e.TotalRowCount.ToString() + " תוצאות ";
            }
        }

        protected void SqlDataSourceLineFilter_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            lblTotalFilter.Text = string.Empty;
            if(e.AffectedRows > 0)
            {
                lblTotalFilter.Text = "נמצאו " + e.AffectedRows.ToString() + " תוצאות ";
            }
        }
    }
}