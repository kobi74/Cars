using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;

namespace Cars
{
    public partial class CarDetail : System.Web.UI.Page
    {
        DBDataContext dc = new DBDataContext();
        string cs = ConfigurationManager.ConnectionStrings["CarsConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
                if (Session["CarNumber"] != null)
                {
                    string carNumber = Session["CarNumber"].ToString();
                    var car = (from c in dc.Cars where c.serialNumber == carNumber select c);
                    foreach (var c in car)
                    {
                        lblHeader.Text = c.manufacturer_Name_Line + "  " + c.LineName + "  מחברת   " + c.DealershipName;
                        lblDcarNum.Text = c.serialNumber;
                        lblDcarName.Text = c.manufacturer_Name_Line;
                        lblDLine.Text = c.LineName;
                        lblDPrice.Text = (c.Price).ToString();
                        lblDyear.Text = (c.Year).ToString();
                        lblDnumKM.Text = (c.NumOfKM).ToString();
                        lblDcarColor.Text = c.Color;
                        lblDgear.Text = c.Gearbox;
                        LblDengine.Text = c.Engine.ToString();
                        imgCar.ImageUrl = c.CarPic;
                        //hlContact.Text = "צור קשר עם נציג " + c.DealershipName;
                        btnContact.Text = "צור קשר עם נציג " + c.DealershipName;
                        lblModalTitle.Text = "טופס יצירת קשר עם חברת " + c.DealershipName;
                        HiddenField1.Value= c.DealershipName;
                        hdnCarNumber.Value = c.serialNumber;
                }
                }

                else
                {
                    Response.Redirect("~/index.aspx");
                }
            if (!IsPostBack)
            {
                CalendarContact.Visible = false;                
                ddlTimeContact.Visible = false;
            }
        }

        protected void imgCalendar_Click(object sender, ImageClickEventArgs e)
        {
            if (CalendarContact.Visible)
            {
                CalendarContact.Visible = false;
            }

            else
            {
                CalendarContact.Visible = true;
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "popup();", true);
        }

        protected void CalendarContact_SelectionChanged(object sender, EventArgs e)
        {
            txtDateControl.Text = CalendarContact.SelectedDate.ToShortDateString();
            CalendarContact.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "popup();", true);
            BindTime();
            ddlTimeContact.Visible = true;
        }

        protected void CalendarContact_VisibleMonthChanged(object sender, MonthChangedEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "popup();", true);
        }

        protected void btnContact_Click(object sender, EventArgs e)
        {
            //lblModalTitle.Text = "טופס יצירת קשר עם חברת" + company;
        }

        protected void CalendarContact_DayRender(object sender, DayRenderEventArgs e)
        {
            if(e.Day.IsOtherMonth || e.Day.Date.DayOfWeek == DayOfWeek.Saturday || e.Day.Date<= DateTime.Now)
            {
                e.Day.IsSelectable = false;
                e.Cell.BackColor = System.Drawing.ColorTranslator.FromHtml("#DC143C");
                e.Cell.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FFF0F5");
                e.Cell.ToolTip = "התאריך עבר";
            }
        }

        private void BindTime()
        {
            string dateString = txtDateControl.Text;//תאריך שנבחר בלוח השנה
            DateTime dateValue = System.Convert.ToDateTime(dateString);//לבדיקה האם נבחר יום שישי
            DateTime end;//שעה אחרונה לפגישה
            DateTime start = DateTime.ParseExact("08:00", "HH:mm", null);//שעת התחלה 08:00
            if ((int)dateValue.DayOfWeek == 5)
            {
                 end = DateTime.ParseExact("13:00", "HH:mm", null);//אם יום שישי שעת סיום 13:00
            }
            else
            {
                 end = DateTime.ParseExact("18:00", "HH:mm", null);//לא יום שישי שעת סיום 18:00
            }

            TimeSpan Interval = new TimeSpan(0, 15, 0);
            ddlTimeContact.Items.Clear();

            while(start <= end)
            {
                ddlTimeContact.Items.Add(start.ToShortTimeString());
                start = start.Add(Interval);
            }
            ListItem li = new ListItem("בחר שעה", "-1");
            ddlTimeContact.Items.Insert(0,li);
        }

        protected void btnSubmitContact_Click(object sender, EventArgs e)
        {
            //Response.Write(txtDateControl.Text);
            IFormatProvider culture = new CultureInfo("he-IL", true);
            Meeting m = new Meeting();
            m.CustomerFirstName = txtFirstNameContact.Text;
            m.customerLastName = txtLastNameContact.Text;
            m.customerPhone = txtPhoneContact.Text;
            //m.DateOfMeeting = DateTime.ParseExact(txtDateControl.Text, "dd/MM/yy", culture);
            m.DateOfMeeting = DateTime.Parse(txtDateControl.Text);
            if (ddlTimeContact.SelectedIndex == 0)
            {
                m.TimeOfMeeting = null;
            }
            else
            {
                m.TimeOfMeeting = TimeSpan.Parse(ddlTimeContact.SelectedItem.ToString());
            }
            m.DealershipName = HiddenField1.Value;
            m.DealrshipSite = ddlCityContact.SelectedItem.ToString();
            m.CarNumber = hdnCarNumber.Value;
            dc.Meetings.InsertOnSubmit(m);
            dc.SubmitChanges();
            ClearContactForm();
        }

        public void ClearContactForm()
        {
            txtFirstNameContact.Text = string.Empty;
            txtLastNameContact.Text = string.Empty;
            txtPhoneContact.Text = string.Empty;
            txtDateControl.Text = string.Empty;
            ddlTimeContact.Visible = false;
        }

        protected void btnCancelSubmit_Click(object sender, EventArgs e)
        {
            ClearContactForm();
        }
    }
}