using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace Cars
{
    public partial class _default : System.Web.UI.Page
    {
        string insertSuccess = "<script> alert('שם יצרן נוסף למערכת') </script>";
        string insertFailed = "<script> alert('פעולה נכשלה. שם יצרן קיים במערכת') </script>";
        string updateSuccess = "<script> alert('שם יצרן עודכן בהצלחה') </script>";
        string updateFail = "<script> alert('פעולה נכשלה.לא ניתן לבצע עדכון עבור היצרן או שהיצרן קיים במערכת') </script>";
        string deleteSuccess = "<script> alert('שם יצרן נמחק בהצלחה') </script>";
        string deleteFail = "<script> alert('פעולה נכשלה. היצרן מקושר לדגם.') </script>";
        string searchMsg = "<script> alert('חובה לרשום שם יצרן') </script>";

        DBDataContext dc = new DBDataContext();

        public void ClearForm()
        {
            txtManufacturer.Text = "";
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlAll.Visible = true;
                pnlGridSearch.Visible = false;
            }
        }

        protected void btnAddManufacturer_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                //בדוק האם היצרן קיים במערכת
                var manCount = (from ma in dc.Manufacturers where ma.Name == txtManufacturer.Text select ma).Count();
                if (manCount == 0)
                {
                    Manufacturer m = new Manufacturer();
                    m.Name = txtManufacturer.Text;
                    dc.Manufacturers.InsertOnSubmit(m);//insert command
                    dc.SubmitChanges();// Save changes
                    //Response.Write(insertSuccess);
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", insertSuccess);
                    ClearForm();
                    gvManufacturer.DataBind();
                }

                else
                {
                    //Response.Write(insertFailed);
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", insertFailed);
                    ClearForm();
                    gvManufacturer.DataBind();
                    gvManufacturerSearch.DataBind();
                }
            }
        }

        protected void gvManufacturer_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtManufacturer.Text = gvManufacturer.SelectedRow.Cells[1].Text;
            hdnManufacturer.Value = txtManufacturer.Text;
        }

        protected void btnUpdateManufacturer_Click(object sender, EventArgs e)
        {
            //Manufacturer manufacturer = (from m in dc.Manufacturers where m.Name == hdnManufacturerHeader.Value select m).Single();
            //var sql = from m in dc.Manufacturers where m.Name == hdnManufacturer.Value select m;
            //foreach(var s in sql)
            //{
            //  //s.Name = txtManufacturer.Text;
            //  //A member defining the identity of the object cannot be changed.
            //  // Consider adding a new object with new identity and deleting the existing one instead.
            //  Response.Write(hdnManufacturer.Value+"<br>");
            //  Response.Write(s.Name + "<br>");
            //  Response.Write(txtManufacturer.Text);
            //}
            // dc.SubmitChanges();
            //  Response.Write(updateSuccess);
            //  ClearForm();
            //  gvManufacturer.DataBind();
            if (Page.IsValid)
            {
                var manCount = (from ma in dc.Manufacturers where ma.Name == txtManufacturer.Text select ma).Count();
                var hdnCount = (from ma in dc.Manufacturers where ma.Name == hdnManufacturer.Value select ma).Count();

                if (manCount == 0 && hdnCount > 0)
                {
                    string cs = ConfigurationManager.ConnectionStrings["CarsConnectionString"].ConnectionString;
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlCommand cmd = new SqlCommand("spUpdateManufacturer", con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@newName", txtManufacturer.Text);
                        cmd.Parameters.AddWithValue("@oldName", hdnManufacturer.Value);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    //Response.Write(updateSuccess);
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", updateSuccess);
                    ClearForm();
                    gvManufacturer.DataBind();
                    gvManufacturerSearch.DataBind();
                }

                else
                {
                    //Response.Write(updateFail);
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", updateFail);
                    ClearForm();
                    gvManufacturer.DataBind();
                    gvManufacturerSearch.DataBind();
                }
            }

        }

        protected void btnDeleteManufacturer_Click(object sender, EventArgs e)
        {
            if (this.Page.IsValid)
            {
                var manCount = (from ma in dc.Lines where ma.ManufacturerName == txtManufacturer.Text select ma).Count();
                if (manCount == 0)
                {
                    string cs = ConfigurationManager.ConnectionStrings["CarsConnectionString"].ConnectionString;
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlCommand cmd = new SqlCommand("deleteManufacturer",con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@name",txtManufacturer.Text);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    //Response.Write(deleteSuccess);
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", deleteSuccess);
                    ClearForm();
                    gvManufacturer.DataBind();
                    gvManufacturerSearch.DataBind();
                }
                else
                {
                    //Response.Write(deleteFail);
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", deleteFail);
                    ClearForm();
                    gvManufacturer.DataBind();
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (txtSearch.Text == string.Empty)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "script", searchMsg);
            }
            else
            {
                pnlAll.Visible = false;
                pnlGridSearch.Visible = true;

                string cs = ConfigurationManager.ConnectionStrings["CarsConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    /*SqlCommand cmd = new SqlCommand("spSearchManufacturer", con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    if (txtManufacturer.Text.Trim() != "")
                    {
                        SqlParameter prm = new SqlParameter("@name", txtManufacturer.Text);
                        cmd.Parameters.Add(prm); 
                    }
                    con.Open();*/
                    SqlDataAdapter da = new SqlDataAdapter("spSearchManufacturer", con);
                    da.SelectCommand.CommandType = CommandType.StoredProcedure;
                    da.SelectCommand.Parameters.AddWithValue("@name", txtManufacturer.Text);
                    DataTable ds = new DataTable();
                    da.Fill(ds);

                    gvManufacturer.DataSource = ds;
                    gvManufacturer.DataSourceID = null;
                    gvManufacturer.DataBind();
                }
            }
        }

        protected void btnSearch_Click1(object sender, EventArgs e)
        {

        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            gvManufacturer.DataSourceID = "SqlDataSourceAll";
            pnlAll.Visible = true;
            pnlGridSearch.Visible = false;            
        }

        protected void gvManufacturerSearch_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtManufacturer.Text = gvManufacturerSearch.SelectedRow.Cells[1].Text;
            hdnManufacturer.Value = txtManufacturer.Text;
        }

        protected void gvManufacturer_PreRender(object sender, EventArgs e)
        {
            string currentPage = (gvManufacturer.PageIndex + 1).ToString();
            string totalPages = gvManufacturer.PageCount.ToString();
            if (gvManufacturer.PageCount == 0)
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

        protected void SqlDataSourceAll_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void SqlDataSourceFilter_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            lblTotalFilter.Text = string.Empty;
            if (e.AffectedRows > 0)
            {
                lblTotalFilter.Text = "נמצאו " + e.AffectedRows.ToString() + " תוצאות ";
            }
        }

        protected void SqlDataSourceAll_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows > 0)
            {
                lblTotalAll.Text = "נמצאו " + e.AffectedRows.ToString() + " תוצאות ";
            }
        }
    }
}