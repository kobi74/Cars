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
    public partial class ComparePrices : System.Web.UI.Page
    {
        string msgCompare = "<script> alert('הנך מועבר לבחירת רכבים') </script>";
        string cs = ConfigurationManager.ConnectionStrings["CarsConnectionString"].ConnectionString;
        DBDataContext dc = new DBDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["selections"] != null)
            {
                CreateTable();
            }

            else
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "script", msgCompare);
                Response.Redirect("~/index.aspx");
            }
            if (!IsPostBack)
            {
                CalendarContact.Visible = false;
                ddlTimeContact.Visible = false;
            }

        }

        protected void CreateTable()
        {
            var selections = Session["selections"] as List<string>;
            int size = selections.Count;
            //for (int i = 0; i < size; i++)
            //{
                
            //    cars.Add(car);
            //    //Response.Write(selections[i].ToString() + "<br/>");
            //    ///**********************/
            //    //foreach(var c in cars)
            //    //{
            //    //    Response.Write(c.manufacturer_Name_Line + "<br/>");
            //    //}
            //}

            // שורה 1 - תא ראשון ריק
            TableRow tr = new TableRow();
            TableCell cell = new TableCell();
            cell.Text = " ";
            tr.Cells.Add(cell);
            

            //שורה 1 - לרשום את שמות היצרן + דגם
            for(int i = 0; i < size; i++)
            {
                cell = new TableCell();
                var car = (from c in dc.Cars where c.serialNumber == selections[i] select c);
                foreach (var c in car)
                {
                    cell.Text = c.manufacturer_Name_Line + " " + c.LineName;
                }
                tr.Cells.Add(cell);
            }
            tblCompare.Rows.Add(tr);//הוספת שורה 1 לטבלה

            // שורה 2 - תא ראשון כותרת תמונה
             tr = new TableRow();
             cell = new TableCell();
            cell.Text = "תמונה";
            tr.Cells.Add(cell);

            for (int i = 0; i < size; i++)
            {
                cell = new TableCell();
                var car = (from c in dc.Cars where c.serialNumber == selections[i] select c);
                foreach (var c in car)
                {
                    Image img = new Image();
                    img.ImageUrl = c.CarPic;
                    img.Width = 100;
                    img.Height = 100;
                    img.ToolTip= c.manufacturer_Name_Line + " " + c.LineName;
                    img.AlternateText = c.manufacturer_Name_Line + " " + c.LineName;
                    img.CssClass = "img-thumbnail";
                    cell.Controls.Add(img);
                }
                tr.Cells.Add(cell);
            }
            tblCompare.Rows.Add(tr);//הוספת שורה 2 לטבלה

            //שורה 3 - תא ראשון : שנה
            tr = new TableRow();
            cell = new TableCell();
            cell.Text = "שנה";
            tr.Cells.Add(cell);

            //שורה 3 - לרשום את שנת הרכבים
            for (int i = 0; i < size; i++)
            {
                cell = new TableCell();
                var car = (from c in dc.Cars where c.serialNumber == selections[i] select c);
                foreach (var c in car)
                {
                    cell.Text = c.Year.ToString();
                }
                tr.Cells.Add(cell);
            }
            tblCompare.Rows.Add(tr);//הוספת שורה 3 לטבלה

            //שורה 4 - תא ראשון : שם סוכנות
            tr = new TableRow();
            cell = new TableCell();
            cell.Text = "שם סוכנות";
            tr.Cells.Add(cell);

            //שורה 4 - לרשום את שם סוכנות 
            for (int i = 0; i < size; i++)
            {
                cell = new TableCell();
                var car = (from c in dc.Cars where c.serialNumber == selections[i] select c);
                foreach (var c in car)
                {
                    cell.Text = c.DealershipName;
                }
                tr.Cells.Add(cell);
            }
            tblCompare.Rows.Add(tr);//הוספת שורה 4 לטבלה

            //שורה 5 - תא ראשון :  מחיר
            tr = new TableRow();
            cell = new TableCell();
            cell.Text = "מחיר";
            tr.Cells.Add(cell);

            //שורה 5 - לרשום את המחיר 
            for (int i = 0; i < size; i++)
            {
                cell = new TableCell();
                var car = (from c in dc.Cars where c.serialNumber == selections[i] select c);
                foreach (var c in car)
                {
                    cell.Text = c.Price.ToString("C0");
                }
                tr.Cells.Add(cell);
            }
            tblCompare.Rows.Add(tr);//הוספת שורה 5 לטבלה

            //שורה 6 - תא ראשון :  מספר ק"מ
            tr = new TableRow();
            cell = new TableCell();
            cell.Text = "מספר קמ'";
            tr.Cells.Add(cell);

            //שורה6- לרשום את ק"מ 
            for (int i = 0; i < size; i++)
            {
                cell = new TableCell();
                var car = (from c in dc.Cars where c.serialNumber == selections[i] select c);
                foreach (var c in car)
                {
                    cell.Text = c.NumOfKM.ToString();
                }
                tr.Cells.Add(cell);
            }
            tblCompare.Rows.Add(tr);//הוספת שורה 6 לטבלה

            //שורה 7 - תא ראשון :  מספר גיר
            tr = new TableRow();
            cell = new TableCell();
            cell.Text = "גיר";
            tr.Cells.Add(cell);

            //שורה 7  - לרשום את ק"מ 
            for (int i = 0; i < size; i++)
            {
                cell = new TableCell();
                var car = (from c in dc.Cars where c.serialNumber == selections[i] select c);
                foreach (var c in car)
                {
                    cell.Text = c.Gearbox;
                }
                tr.Cells.Add(cell);
            }
            tblCompare.Rows.Add(tr);//הוספת שורה 7 לטבלה

            //שורה 8 - תא ראשון :  נפח מנוע
            tr = new TableRow();
            cell = new TableCell();
            cell.Text = "נפח מנוע";
            tr.Cells.Add(cell);

            //שורה 8- לרשום את ק"מ 
            for (int i = 0; i < size; i++)
            {
                cell = new TableCell();
                var car = (from c in dc.Cars where c.serialNumber == selections[i] select c);
                foreach (var c in car)
                {
                    cell.Text = c.Engine.ToString();
                }
                tr.Cells.Add(cell);
            }
            tblCompare.Rows.Add(tr);//הוספת שורה 8 לטבלה

            //שורה 9 - הצעת מחיר - תא ראשון ריק
            tr = new TableRow();
            cell = new TableCell();
            cell.Text = "";
            tr.Cells.Add(cell);

            //שורה 9 - הצעת מחיר - הוספת הקישורים
            for(int i = 0; i < size; i++)
            {
                cell = new TableCell();
                var car = (from c in dc.Cars where c.serialNumber == selections[i] select c);
                foreach (var c in car)
                {
                    LinkButton lb = new LinkButton();
                    lb.Text = "הצעת מחיר";
                    lb.ToolTip= c.DealershipName;
                    lb.Attributes.Add("data-target", "#contactModal");
                    lb.OnClientClick = "popup();return false;";
                    lblModalTitle.Text = "טופס יצירת קשר עם חברת " + c.DealershipName;
                    lb.Click += new EventHandler(DealerNameHidden);
                    cell.Controls.Add(lb);
                }
                tr.Cells.Add(cell);
            }
            tblCompare.Rows.Add(tr);
            
            //שורה 10- מפרט רכב - תא ראשון ריק 
            tr = new TableRow();
            cell = new TableCell();
            cell.Text = " ";
            tr.Cells.Add(cell);

            //שורה 10 - מפרט רכב - קישור
            for (int i = 0; i < size; i++)
            {
                cell = new TableCell();
                var car = (from c in dc.Cars where c.serialNumber == selections[i] select c);
                foreach (var c in car)
                {
                    LinkButton link = new LinkButton();
                    link.Text = "מפרט רכב";
                    link.ToolTip= c.serialNumber;
                    link.Click += new EventHandler(CarDetails);
                    cell.Controls.Add(link);
                }
                tr.Cells.Add(cell);
            }
            tblCompare.Rows.Add(tr);//הוספת שורה 10 לטבלה

        }

        protected void CarDetails(object sender, EventArgs e)
        {
            LinkButton carNum = sender as LinkButton;
            Session["CarNumber"] = carNum.ToolTip.ToString();
            Response.Redirect("~/CarDetail.aspx");
        }

        protected void DealerNameHidden(object sender, EventArgs e)
        {
            LinkButton company = sender as LinkButton;
            HiddenField1.Value = company.ToolTip.ToString();
            //Response.Write(HiddenField1.Value.ToString());
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
            txtDateControl.Text = CalendarContact.SelectedDate.ToLongDateString();
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
            if (e.Day.IsOtherMonth || e.Day.Date.DayOfWeek == DayOfWeek.Saturday || e.Day.Date <= DateTime.Now)
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

            while (start <= end)
            {
                ddlTimeContact.Items.Add(start.ToShortTimeString());
                start = start.Add(Interval);
            }
            ListItem li = new ListItem("בחר שעה", "-1");
            ddlTimeContact.Items.Insert(0, li);
        }
    }
}