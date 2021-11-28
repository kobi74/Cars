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
    public partial class Company : System.Web.UI.Page
    {
        string fileLoaded = "";
        //string success = "<script> alert('שם הסוכנות והתמונה נוספו למערכת') </script>";
        string searchMsg = "<script> alert('חובה לרשום שם סוכנות') </script>";

        DBDataContext dc = new DBDataContext();
        string cs = ConfigurationManager.ConnectionStrings["CarsConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlCompanyAll.Visible = true;
                pnlFilterCompany.Visible = false;
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
        }

        protected void btnAddCompany_Click(object sender, EventArgs e)
        {
            var dealerCount = (from ma in dc.DealerShips  where ma.Name == txtCompanyName.Text select ma).Count();
            if (dealerCount == 0)
            {
                if (FileUploadLogo.HasFile)
                {
                    string extension = System.IO.Path.GetExtension(FileUploadLogo.FileName);//get fie extention
                                                                                            //Response.Write(extension);
                    if (extension.ToLower() != ".jpg" && extension.ToLower() != ".jpeg" && extension.ToLower() != ".gif" && extension.ToLower() != ".png")
                    {
                        lblLogoMsg.Text = "רק קבצי .jpg .jpeg .gif .png";
                        lblLogoMsg.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        int fileSize = FileUploadLogo.PostedFile.ContentLength;//get the size of the file
                        if (fileSize > 2097152)
                        {
                            lblLogoMsg.Text = "לא ניתן להעלות קובץ מעל 2 מגה";
                            lblLogoMsg.ForeColor = System.Drawing.Color.Red;
                        }
                        else
                        {
                            DealerShip d = new DealerShip();

                            FileUploadLogo.SaveAs(Server.MapPath("~/Uploads/" + FileUploadLogo.FileName));
                            fileLoaded = "~/Uploads/" + FileUploadLogo.FileName;
                            lblLogoMsg.Text = "שם הסוכנות " + txtCompanyName.Text + " והתמונה נוספו למערכת";
                            lblLogoMsg.ForeColor = System.Drawing.Color.Green;
                            d.Name = txtCompanyName.Text;
                            d.logo = fileLoaded;
                            dc.DealerShips.InsertOnSubmit(d);
                            dc.SubmitChanges();
                            // Response.Write(success);
                            ClearForm();
                            gvCompany.DataBind();
                            gvFilterCompany.DataBind();
                        }
                    }
                }

                else
                {
                    lblLogoMsg.Text = "בחר תמונה";
                    lblLogoMsg.ForeColor = System.Drawing.Color.Red;
                }
            }

            else
            {
                lblLogoMsg.Text = "הפעולה נכשלה. שם הסוכנות קיים במערכת.";
                lblLogoMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        public void ClearForm()
        {
            txtCompanyName.Text = "";
            FileUploadLogo.PostedFile.InputStream.Dispose();
            fileLoaded = "";
            hdnLogo.Value = "";
            hdnCompany.Value = "";
        }

        protected void gvCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtCompanyName.Text = HttpUtility.HtmlDecode(gvCompany.SelectedRow.Cells[1].Text);
            hdnCompany.Value = txtCompanyName.Text;//שם סוכנות ישן
            hdnLogo.Value = gvCompany.SelectedRow.Cells[2].Text;//לוגו ישן
        }

        protected void btnUpdateCompany_Click(object sender, EventArgs e)
        {
            var dealerCount = (from ma in dc.DealerShips where ma.Name == txtCompanyName.Text select ma).Count();
            var hdnCount = (from ma in dc.DealerShips where ma.Name == hdnCompany.Value select ma).Count();
            if (hdnCount > 0)
            {
                //עדכן תמונה ו/או שם סוכנות
                if (FileUploadLogo.HasFile)
                {
                    string extension = System.IO.Path.GetExtension(FileUploadLogo.FileName);//get fie extention
                    if (extension.ToLower() != ".jpg" && extension.ToLower() != ".jpeg" && extension.ToLower() != ".gif" && extension.ToLower() != ".png")
                    {
                        lblLogoMsg.Text = "רק קבצי .jpg .jpeg .gif .png";
                        lblLogoMsg.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        int fileSize = FileUploadLogo.PostedFile.ContentLength;//get the size of the file
                        if (fileSize > 2097152)
                        {
                            lblLogoMsg.Text = "לא ניתן להעלות קובץ מעל 2 מגה";
                            lblLogoMsg.ForeColor = System.Drawing.Color.Red;
                        }
                        else
                        {
                            FileUploadLogo.SaveAs(Server.MapPath("~/Uploads/" + FileUploadLogo.FileName));
                            fileLoaded = "~/Uploads/" + FileUploadLogo.FileName;
                            lblLogoMsg.Text = "שם הסוכנות " + txtCompanyName.Text + " והתמונה עודכנו בהצלחה";
                            lblLogoMsg.ForeColor = System.Drawing.Color.Green;
                            using (SqlConnection con = new SqlConnection(cs))
                            {
                                SqlCommand cmd = new SqlCommand("spDealershipUpdate", con);
                                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@NewName", txtCompanyName.Text);
                                cmd.Parameters.AddWithValue("@OldName", hdnCompany.Value);
                                cmd.Parameters.AddWithValue("@NewLogo", fileLoaded);
                                cmd.Parameters.AddWithValue("@OldLogo", hdnLogo.Value);
                                con.Open();
                                cmd.ExecuteNonQuery();
                            }
                        }
                    }
                }//5555

                // עדכן שם סוכנות בלבד
                else
                {
                    fileLoaded = hdnLogo.Value;
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlCommand cmd = new SqlCommand("spDealershipUpdate", con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@NewName", txtCompanyName.Text);
                        cmd.Parameters.AddWithValue("@OldName", hdnCompany.Value);
                        cmd.Parameters.AddWithValue("@NewLogo", fileLoaded);
                        cmd.Parameters.AddWithValue("@OldLogo", hdnLogo.Value);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    lblLogoMsg.Text = "שם הסוכנות " + txtCompanyName.Text + " והתמונה עודכנו בהצלחה";
                    lblLogoMsg.ForeColor = System.Drawing.Color.Green;
                }
            }

            else
            {
                if (hdnCount == 0)
                {
                    lblLogoMsg.Text = "פעולה נכשלה. ניתן לבצע עדכון רק לאחר בחירה מהטבלה.";
                    lblLogoMsg.ForeColor = System.Drawing.Color.Red;
                }
                if (dealerCount > 0)
                {
                    lblLogoMsg.Text = "הפעולה נכשלה. שם הסוכנות קיים במערכת.";
                    lblLogoMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
            ClearForm();
            gvCompany.DataBind();
            gvFilterCompany.DataBind();
        }

        protected void gvCompany_PreRender(object sender, EventArgs e)
        {
            string currentPage = (gvCompany.PageIndex + 1).ToString();
            string totalPages = gvCompany.PageCount.ToString();
            if (gvCompany.PageCount == 0)
            {
                lblPage.Text = "";
            }
            else
            {
                lblPage.Text = "מציג עמוד " + currentPage + " מתוך " + totalPages;
            }
        }

        protected void btnDeleteCompany_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                var companyCount = (from co in dc.DealerShipSites where co.dealerShipName == txtCompanyName.Text select co).Count();
                if (companyCount == 0)
                {
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlCommand cmd = new SqlCommand("DealershipDelete", con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@DealerName", txtCompanyName.Text);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    lblLogoMsg.Text = "שם הסוכנות " + txtCompanyName.Text + " והתמונה נמחקו בהצלחה";
                    lblLogoMsg.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblLogoMsg.Text = "לא ניתן למחוק את  " + txtCompanyName.Text + ". שם הסוכנות מקושר לסניף";
                    lblLogoMsg.ForeColor = System.Drawing.Color.Red;
                }
                ClearForm();
                gvCompany.DataBind();
                gvFilterCompany.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (txtSearch.Text.Trim() == string.Empty)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "script", searchMsg);
            }
            else
            {
                pnlCompanyAll.Visible = false;
                pnlFilterCompany.Visible = true;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            pnlCompanyAll.Visible = true;
            pnlFilterCompany.Visible = false;
            txtSearch.Text = string.Empty;
        }

        protected void gvFilterCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtCompanyName.Text = HttpUtility.HtmlDecode(gvFilterCompany.SelectedRow.Cells[1].Text);
            hdnCompany.Value = txtCompanyName.Text;//שם סוכנות ישן
            hdnLogo.Value = gvFilterCompany.SelectedRow.Cells[2].Text;//לוגו ישן
        }

        protected void btnClearForm_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        protected void CompanyDataSource_Selected(object sender, LinqDataSourceStatusEventArgs e)
        {
            if (e.TotalRowCount > 0)
            {
                lblTotalAll.Text = "נמצאו " + e.TotalRowCount.ToString() + " תוצאות ";
            }
        }

        protected void SqlDataSourceCompanyFilter_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            lblTotalFilter.Text = string.Empty;
            if (e.AffectedRows > 0)
            {
                lblTotalFilter.Text = "נמצאו " + e.AffectedRows.ToString() + " תוצאות ";
            }
        }
    }
}