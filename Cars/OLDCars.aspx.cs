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
    public partial class WebForm1 : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["CarsConnectionString"].ConnectionString;
        DBDataContext dc = new DBDataContext();
        string insertFailed = "<script> alert('לא ניתן להמשיך. מספר הרכב קיים במערכת') </script>";
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
                for(int i= year - 10; i <= year; i++)
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
            }
        }

        private DataSet GetData(string spName, SqlParameter spParameter)
        {
                SqlConnection con = new SqlConnection(cs);
                SqlDataAdapter da = new SqlDataAdapter(spName,con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                if(spParameter != null)
                {
                    da.SelectCommand.Parameters.Add(spParameter);
                }

                DataSet ds = new DataSet();
                da.Fill(ds);

                return ds;
        }

        protected void ddlManufacturer_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddlManufacturer.SelectedIndex == 0)
            {
                ddlLine.Enabled = false;
                ddlLine.SelectedIndex = 0;
            }

            else
            {
                ddlLine.Enabled = true;
                SqlParameter parm = new SqlParameter("@name", ddlManufacturer.SelectedItem.Text);
                DataSet ds= GetData("spGetLine", parm);
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
                SqlParameter param = new SqlParameter("@name",ddlCompany.SelectedItem.ToString());
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
                    car.CarPic = "~/Uploads/" + FileUploadImage.FileName;
                    dc.Cars.InsertOnSubmit(car);// Insert Command
                    dc.SubmitChanges();// Save changes
                    lblMessage.Text = "מספר רכב " + txtCarNumber.Text + " מסוג " + ddlManufacturer.SelectedItem.ToString() + " נרשם נוסף בהצלחה";
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
            txtCarNumber.Text = "";
            txtCarNumber.Text = "";
            txtColor.Text = "";
            txtEngine.Text = "";
            txtNumKM.Text = "";
            txtPrice.Text = "";
            ddlManufacturer.SelectedIndex = 0;
            ddlLine.SelectedIndex = 0;
            ddlLine.Enabled = false;
            ddlCompany.SelectedIndex = 0;
            ddlCompany.Enabled = false;
            ddlCompanySite.SelectedIndex = 0;
            ddlCompanySite.Enabled = false;
            ddlGearBox.SelectedIndex = 0;
            ddlFuel.SelectedIndex = 0;
            ddlGroup.SelectedIndex = 0;
            ddlyear.SelectedIndex = 0;
            FileUploadImage.PostedFile.InputStream.Dispose();

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
    }
}