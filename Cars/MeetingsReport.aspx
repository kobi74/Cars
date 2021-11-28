<%@ Page Title="" Language="C#" MasterPageFile="~/BackendMasterPage.Master" AutoEventWireup="true" CodeBehind="MeetingsReport.aspx.cs" Inherits="Cars.MeetingsReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    דוח פגישות
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        body{
            position:relative;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentBody" runat="server">
    <div class="container" style="margin-top:10px;">
        <form>
            <div class="row">
                <div class="form-group">
                    <asp:Label ID="lblFromDate" runat="server" Text="מתאריך"></asp:Label>
                    <asp:TextBox ID="txtFromDate" runat="server"></asp:TextBox>
                    <asp:ImageButton ID="imgbFromDate" runat="server" ImageUrl="~/Images/calendar.png" style="margin-right: 3px;margin-left:10px;" Width="30px" Height="30px" CausesValidation="False" ClientIDMode="Static" OnClick="imgbFromDate_Click" />
                    <asp:Calendar ID="calFromDate" runat="server" Visible="false" FirstDayOfWeek="Sunday" NextMonthText="הבא" PrevMonthText="הקודם" OnSelectionChanged="calFromDate_SelectionChanged"></asp:Calendar>
                </div>

                <div class="form-group">
                <asp:Label ID="lblToDate" runat="server" Text="עד תאריך"></asp:Label>
                <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>
                <asp:ImageButton ID="imgbToDate" ImageUrl="~/Images/calendar.png" style="margin-right:3px;margin-left:10px;" Width="30px" Height="30px" CausesValidation="False" ClientIDMode="Static" runat="server" OnClick="imgbToDate_Click" />
                <asp:Calendar ID="calToDate" runat="server" Visible="false" FirstDayOfWeek="Sunday" NextMonthText="הבא" PrevMonthText="הקודם" OnSelectionChanged="calToDate_SelectionChanged"></asp:Calendar>
                </div>
                <div class="form-group">
                    <asp:Label ID="lblCompanyMeeting" runat="server" Text="סוכנות ליסינג"></asp:Label>
                    <asp:DropDownList ID="ddlCompanyMeeting" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCompanyMeeting_SelectedIndexChanged"></asp:DropDownList>
                    <asp:Label ID="lblCityMeeting" runat="server" Text="סניף של סוכנות"></asp:Label>
                    <asp:DropDownList ID="ddlCityMeeting" runat="server"></asp:DropDownList>
                </div>
                <div class="form-group" style="margin-right:10px;">
                    <asp:Button ID="btnSearch" runat="server" Text="חפש" CausesValidation="false" CssClass="btn btn-primary btn-md" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="נקה" style="margin-right:5px;" CausesValidation="false" CssClass="btn  btn-md" OnClick="btnClear_Click" />
                </div>
            </div>
        </form>
        <br />
        <hr />
        <asp:Panel ID="pnlSearch" runat="server" Visible="false">
            <asp:Label ID="lblTotalMeetings" runat="server" CssClass="bg-dark text-white"></asp:Label>
            <asp:GridView ID="gvSearch" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSourceMeetings" AllowPaging="True" AllowSorting="True" CssClass="table table-striped table-bordered" Width="1175px" OnPreRender="gvSearch_PreRender" EmptyDataText="אין תוצאות" PageSize="8" >
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="מזהה פגישה" ReadOnly="True" SortExpression="id" >
                    <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CustomerFirstName" HeaderText="שם פרטי" SortExpression="CustomerFirstName" >
                    <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="customerLastName" HeaderText="שם משפחה" SortExpression="customerLastName" >
                    <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DateOfMeeting" HeaderText="תאריך פגישה" SortExpression="DateOfMeeting" DataFormatString="{0:d}" >
                    <HeaderStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TimeOfMeeting" HeaderText="שעת פגישה" SortExpression="TimeOfMeeting">
                    <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DealershipName" HeaderText="סוכנות ליסינג" SortExpression="DealershipName" >
                    <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DealrshipSite" HeaderText="סניף" SortExpression="DealrshipSite" >
                    <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="carnumber" HeaderText="מספר רכב" SortExpression="carnumber" >
                    <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="manufacturer_Name_Line" HeaderText="יצרן" SortExpression="manufacturer_Name_Line" >
                    <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="LineName" HeaderText="דגם" SortExpression="LineName" >
                    <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Year" HeaderText="שנה" SortExpression="Year" >
                    <FooterStyle BorderStyle="None" Font-Names="Rod" />
                    <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                </Columns>
                <EmptyDataRowStyle Font-Bold="True" Font-Names="Arial" Font-Size="Larger" ForeColor="Red" HorizontalAlign="Center" />
            </asp:GridView>
            <asp:Label ID="lblMeetingPage" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Larger" ForeColor="#284775"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSourceMeetings" runat="server" ConnectionString="<%$ ConnectionStrings:CarsConnectionString %>" SelectCommand="MeetingReport" OnSelected="SqlDataSourceMeetings_Selected" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtFromDate" DefaultValue="2000-01-01" Name="FromDate" PropertyName="Text" DbType="Date" />
                    <asp:ControlParameter ControlID="txtToDate" DefaultValue="3000-12-31" Name="ToDate" PropertyName="Text" DbType="Date" />
                    <asp:ControlParameter ControlID="ddlCompanyMeeting" Name="Company" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="ddlCityMeeting" Name="Site" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:Panel>
    </div>
</asp:Content>
