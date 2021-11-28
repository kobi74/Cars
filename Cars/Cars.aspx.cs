using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace Cars
{
    public partial class CarsTest : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CarsConnectionString"].ConnectionString;
        DBDataContext dc = new DBDataContext();
        string insertFailed = "<script> alert('לא ניתן להמשיך. מספר הרכב קיים במערכת') </script>";
        string fileLoaded = "";
        string searchMsg = "<script> alert('חובה לרשום מספר רכב') </script>";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                int year = DateTime.Now.Year;
                ddlLine.Enabled = false;
                ddlCompany.Enabled = false;
                ddlCompanySite.Enabled = false;

                ListItem li = new ListItem("בחר", "-1");
                ddlLine.Items.Insert(0, li);
                ddlCompanySite.Items.Insert(0, li);
                ddlGroup.Items.Insert(0, li);
                ddlFuel.Items.Insert(0, li);
                ddlGearBox.Items.Insert(0, li);
                ddlyear.Items.Insert(0, li);
                //הוסף שנים ל ddlYear
                for (int i = year - 10; i <= year; i++)
                {
                    ListItem liYear = new ListItem(i.ToString());
                    ddlyear.Items.Add(liYear);
                }

                // ****** מתחילים להזין רשימות*******
                //יצרן
                ddlManufacturer.DataSource = GetData("spGetManufacturer", null);
                ddlManufacturer.DataBind();
                ddlManufacturer.Items.Insert(0, li);
                //סוף יצרן

                // סוכנות רכב
                ddlCompany.DataSource = GetData("getDealership", null);
                ddlCompany.DataBind();
                ddlCompany.Items.Insert(0, li);
                // סוף סוכנותרכב
                pnlCarAll.Visible = true;
                pnlCarFilter.Visible = false;
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

        protected void ddlManufacturer_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlManufacturer.SelectedIndex == 0)
            {
                ddlLine.Enabled = false;
                ddlLine.SelectedIndex = 0;
            }

            else
            {
                ddlLine.Enabled = true;
                SqlParameter parm = new SqlParameter("@name", ddlManufacturer.SelectedItem.Text);
                DataSet ds = GetData("spGetLine", parm);
                ddlLine.DataSource = ds;
                ddlLine.DataBind();
                ListItem li = new ListItem("בחר", "-1");
                ddlLine.Items.Insert(0, li);
            }
        }

        protected void ddlLine_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlLine.SelectedIndex == 0)
            {
                ddlCompany.Enabled = false;
                ddlCompany.SelectedIndex = 0;
            }

            else
            {
                ddlCompany.Enabled = true;
            }
        }

        protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCompany.SelectedIndex == 0)
            {
                ddlCompanySite.Enabled = false;
                ddlCompanySite.SelectedIndex = 0;
            }

            else
            {
                ddlCompanySite.Enabled = true;
                SqlParameter param = new SqlParameter("@name", ddlCompany.SelectedItem.ToString());
                DataSet ds = GetData("getDealershipSite", param);
                ddlCompanySite.DataSource = ds;
                ddlCompanySite.DataBind();
                ListItem li = new ListItem("בחר", "-1");
                ddlCompanySite.Items.Insert(0, li);
            }
        }

        protected void btnAddManufacturer_Click(object sender, EventArgs e)
        {
            var carCount = (from c in dc.Cars where c.serialNumber == txtCarNumber.Text select c).Count();
            Response.Write(carCount);
            if (carCount == 0)
            {
                if (Page.IsValid)
                {
                    Car car = new Car();
                    car.serialNumber = txtCarNumber.Text;
                    car.manufacturer_Name_Line = ddlManufacturer.SelectedItem.ToString();
                    car.LineName = ddlLine.SelectedItem.ToString();
                    car.DealershipName = ddlCompany.SelectedItem.ToString();
                    car.DealershipNameSite = ddlCompanySite.SelectedItem.ToString();
                    car.Year = Convert.ToInt32(ddlyear.SelectedItem.ToString());
                    car.Color = txtColor.Text;
                    car.Class = ddlGroup.SelectedItem.ToString();
                    car.Fuel = ddlFuel.SelectedItem.ToString();
                    car.Engine = Convert.ToInt32(txtEngine.Text);
                    car.Gearbox = ddlGearBox.SelectedItem.ToString();
                    car.NumOfKM = Convert.ToInt32(txtNumKM.Text);
                    car.Price = Convert.ToInt32(txtPrice.Text);
                    FileUploadImage.SaveAs(Server.MapPath("~/Uploads/" + FileUploadImage.FileName));
                    car.CarPic = "~/Uploads/" + FileUploadImage.FileName;
                    dc.Cars.InsertOnSubmit(car);// Insert Command
                    dc.SubmitChanges();// Save changes
                    gvCars.DataBind();
                    lblMessage.Text = "מספר רכב " + txtCarNumber.Text + " מסוג " + ddlManufacturer.SelectedItem.ToString() + "  נוסף בהצלחה";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    ClearForm();
                }
            }
            else
            {
                lblMessage.Text = "הפעולה נכשלה. מספר הרכב" + txtCarNumber.Text + " קיים במערכת";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                ClearForm();
            }

        }

        public void ClearForm()
        {
            ListItem li = new ListItem("בחר", "-1");            
            txtCarNumber.Text = "";
            txtColor.Text = "";
            txtEngine.Text = "";
            txtNumKM.Text = "";
            txtPrice.Text = "";
            ddlManufacturer.SelectedIndex = 0;            
            ddlLine.Enabled = false;
            ddlLine.Items.Clear();
            ddlLine.Items.Insert(0, li);
            ddlCompany.Enabled = false;
            ddlCompany.SelectedIndex = 0;
            ddlCompanySite.Enabled = false;
            ddlCompanySite.Items.Clear();
            ddlCompanySite.Items.Insert(0, li);
            ddlGearBox.SelectedIndex = 0;
            ddlFuel.SelectedIndex = 0;
            ddlGroup.SelectedIndex = 0;
            ddlyear.SelectedIndex = 0;
            FileUploadImage.PostedFile.InputStream.Dispose();
            hdnCarNumber.Value = string.Empty;
            hdnPic.Value = string.Empty;
            rfvCarPic.Enabled = true;

        }

        protected void txtCarNumber_TextChanged(object sender, EventArgs e)
        {
            var carCount = (from c in dc.Cars where c.serialNumber == txtCarNumber.Text select c).Count();
            if (carCount > 0)
            {
                //Response.Write(insertFailed);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", insertFailed);
                ClearForm();
            }
        }

        protected void Unnamed1_SelectedIndexChanged(object sender, EventArgs e)
        {
            MySelect();
        }

        public void MySelect()
        {
            if (ddlLine.Enabled == false || ddlCompany.Enabled == false || ddlCompanySite.Enabled == false)
            {
                ddlLine.Enabled = true;
                ddlCompany.Enabled = true;
                ddlCompanySite.Enabled = true;
            }
            rfvCarPic.Enabled = false;
            string line = HttpUtility.HtmlDecode(gvCars.SelectedRow.Cells[3].Text);
            string compaySite = gvCars.SelectedRow.Cells[5].Text;
            int row = gvCars.SelectedRow.RowIndex;// מספר השורה שנלחצה

            txtCarNumber.Text = gvCars.SelectedRow.Cells[1].Text;
            hdnCarNumber.Value = txtCarNumber.Text;
            ddlManufacturer.Text = gvCars.SelectedRow.Cells[2].Text;
            //לתפוס את הדגם
            SqlParameter parm = new SqlParameter("@name", ddlManufacturer.Text);
            DataSet ds = GetData("spGetLine", parm);
            ddlLine.DataSource = ds;
            ddlLine.DataBind();
            ddlLine.SelectedItem.Selected = false;
            ddlLine.Items.FindByText(line).Selected = true;
            //סוף - לתפוס את הדגם
            ddlCompany.Text = gvCars.SelectedRow.Cells[4].Text;
            //תפוס את שם הסניף
            SqlParameter param = new SqlParameter("@name", ddlCompany.Text);
            DataSet ds1 = GetData("getDealershipSite", param);
            ddlCompanySite.DataSource = ds1;
            ddlCompanySite.DataBind();
            ddlCompanySite.SelectedItem.Selected = false;
            ddlCompanySite.Items.FindByText(compaySite).Selected = true;
            //סוף - תפוס שם הסניף
            ddlyear.Text = gvCars.SelectedRow.Cells[6].Text;
            txtColor.Text = gvCars.SelectedRow.Cells[7].Text;
            ddlGroup.Text = HttpUtility.HtmlDecode(gvCars.SelectedRow.Cells[8].Text);
            ddlFuel.Text = gvCars.SelectedRow.Cells[9].Text;
            txtEngine.Text = gvCars.SelectedRow.Cells[10].Text;
            ddlGearBox.Text = gvCars.SelectedRow.Cells[11].Text;
            txtNumKM.Text = gvCars.SelectedRow.Cells[12].Text;
            txtPrice.Text = gvCars.SelectedRow.Cells[13].Text;
            var pic = gvCars.DataKeys[row].Values[1];//get value from the hidden column 'CarPic'
            hdnPic.Value = pic.ToString();//assign pic to the hiddenField 'hdnPic'
            //Response.Write("All row: " + row.ToString()+" " + hdnPic.Value);
        }

        protected void btnUpdateCar_Click(object sender, EventArgs e)
        {  
            var carCount = (from c in dc.Cars where c.serialNumber == txtCarNumber.Text select c).Count();
            var hdnCarCount = (from c in dc.Cars where c.serialNumber == hdnCarNumber.Value select c).Count();
            //Response.Write("carCount = " + carCount + " hdnCarCount= " + hdnCarCount);
            if (hdnCarCount > 0)
            {
                if (FileUploadImage.HasFile)
                {
                    FileUploadImage.SaveAs(Server.MapPath("~/Uploads/" + FileUploadImage.FileName));
                    fileLoaded = "~/Uploads/" + FileUploadImage.FileName;
                }
                else
                {
                    fileLoaded = hdnPic.Value;
                }
                using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlCommand cmd = new SqlCommand("CarsUpdate", con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@SerialNumber",txtCarNumber.Text);
                        cmd.Parameters.AddWithValue("@OldSerialNumber", hdnCarNumber.Value);
                        cmd.Parameters.AddWithValue("@Manufacturer", ddlManufacturer.Text);
                        cmd.Parameters.AddWithValue("@Line",ddlLine.Text);
                        cmd.Parameters.AddWithValue("@Year",Convert.ToInt32(ddlyear.SelectedItem.ToString()));
                        cmd.Parameters.AddWithValue("@Color",txtColor.Text);
                        cmd.Parameters.AddWithValue("@Class", ddlGroup.Text);
                        cmd.Parameters.AddWithValue("@Fuel",ddlFuel.Text);
                        cmd.Parameters.AddWithValue("@Engine",txtEngine.Text);
                        cmd.Parameters.AddWithValue("@Gearbox",ddlGearBox.Text);
                        cmd.Parameters.AddWithValue("@NumOfKM", Convert.ToInt32(txtNumKM.Text));
                        cmd.Parameters.AddWithValue("@Price", Convert.ToInt32(txtPrice.Text));
                        cmd.Parameters.AddWithValue("@Dealership", ddlCompany.SelectedItem.ToString());
                        cmd.Parameters.AddWithValue("@Site", ddlCompanySite.Text);
                        cmd.Parameters.AddWithValue("@CarPic", fileLoaded);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
             }
            ClearForm();
            gvCars.DataBind();
            gvCarFilter.DataBind();
        }

        protected void btnClearForm_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        protected void btnDeleteCar_Click(object sender, EventArgs e)
        {
            var carCount = (from c in dc.Meetings where c.CarNumber ==txtCarNumber.Text select c).Count();//בדוק האם יש פגישה בנוגע לרכב
            if (carCount == 0)
            {
                if (Page.IsValid)
                {
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlCommand cmd = new SqlCommand("CarsDelete", con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@carNumber",txtCarNumber.Text);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    lblMessage.Text = "מספר רכב " + txtCarNumber.Text + " מסוג " + ddlManufacturer.SelectedItem.ToString() + "  נמחק בהצלחה";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
            }

            else
            {
                lblMessage.Text = "לא ניתן למחוק רכב מספר " + txtCarNumber.Text + ". נקבעה פגישה לגביו";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
            ClearForm();
            gvCars.DataBind();
            gvCarFilter.DataBind();
        }

        protected void gvCars_PreRender(object sender, EventArgs e)
        {
            string currentPage = (gvCars.PageIndex + 1).ToString();
            string totalPages = gvCars.PageCount.ToString();
            if (gvCars.PageCount == 0)
            {
                lblPage.Text = string.Empty;
            }
            else
            {
                lblPage.Text = "מציג עמוד " + currentPage + " מתוך " + totalPages;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if(txtCarSearch.Text.Trim() == string.Empty)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "script", searchMsg);
            }

            else
            {
                pnlCarAll.Visible = false;
                pnlCarFilter.Visible = true;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            pnlCarAll.Visible = true;
            pnlCarFilter.Visible = false;
            txtCarSearch.Text = string.Empty;
        }

        protected void gvCarFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlLine.Enabled == false || ddlCompany.Enabled == false || ddlCompanySite.Enabled == false)
            {
                ddlLine.Enabled = true;
                ddlCompany.Enabled = true;
                ddlCompanySite.Enabled = true;
            }
            rfvCarPic.Enabled = false;
            string line = HttpUtility.HtmlDecode(gvCarFilter.SelectedRow.Cells[3].Text);
            string compaySite = gvCarFilter.SelectedRow.Cells[5].Text;
            int row = gvCarFilter.SelectedRow.RowIndex;// מספר השורה שנלחצה

            txtCarNumber.Text = gvCarFilter.SelectedRow.Cells[1].Text;
            hdnCarNumber.Value = txtCarNumber.Text;
            ddlManufacturer.Text = gvCarFilter.SelectedRow.Cells[2].Text;
            //לתפוס את הדגם
            SqlParameter parm = new SqlParameter("@name", ddlManufacturer.Text);
            DataSet ds = GetData("spGetLine", parm);
            ddlLine.DataSource = ds;
            ddlLine.DataBind();
            ddlLine.SelectedItem.Selected = false;
            ddlLine.Items.FindByText(line).Selected = true;
            //סוף - לתפוס את הדגם
            ddlCompany.Text = gvCarFilter.SelectedRow.Cells[4].Text;
            //תפוס את שם הסניף
            SqlParameter param = new SqlParameter("@name", ddlCompany.Text);
            DataSet ds1 = GetData("getDealershipSite", param);
            ddlCompanySite.DataSource = ds1;
            ddlCompanySite.DataBind();
            ddlCompanySite.SelectedItem.Selected = false;
            ddlCompanySite.Items.FindByText(compaySite).Selected = true;
            //סוף - תפוס שם הסניף
            ddlyear.Text = gvCarFilter.SelectedRow.Cells[6].Text;
            txtColor.Text = gvCarFilter.SelectedRow.Cells[7].Text;
            ddlGroup.Text = HttpUtility.HtmlDecode(gvCarFilter.SelectedRow.Cells[8].Text);
            ddlFuel.Text = gvCarFilter.SelectedRow.Cells[9].Text;
            txtEngine.Text = gvCarFilter.SelectedRow.Cells[10].Text;
            ddlGearBox.Text = gvCarFilter.SelectedRow.Cells[11].Text;
            txtNumKM.Text = gvCarFilter.SelectedRow.Cells[12].Text;
            txtPrice.Text = gvCarFilter.SelectedRow.Cells[13].Text;
            var pic = gvCarFilter.DataKeys[row].Values[1];//get value from the hidden column 'CarPic'
            hdnPic.Value = pic.ToString();//assign pic to the hiddenField 'hdnPic'; 
            Response.Write("Filter row: "+row.ToString() + hdnPic.Value);
        }
    }
}