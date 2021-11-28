<%@ Page Title="" Language="C#" MasterPageFile="~/FrontendMasterPage.Master" AutoEventWireup="true" CodeBehind="ComparePrices.aspx.cs" Inherits="Cars.ComparePrices" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentBody" runat="server">
    <h1>השוואת מחירים</h1>
    <hr />
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <asp:Table ID="tblCompare" runat="server" CssClass = "table table-bordered table-responsive-md table-striped text-center">

    </asp:Table>

    <!-- MODAL -->
    <div class="col-xs-12">
        <div class="modal" data-keyboard="false" id="contactModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                 <div class="modal-header">
                   <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title pull-right">
                        <asp:Label ID="lblModalTitle" runat="server" Text=""></asp:Label>
                    </h4>

                </div>
                <div class="modal-body">
                    <form style="background-color:white;">
                        <div class="form-group">
                            <label for="inputFirstName">שם פרטי</label>
                            <asp:TextBox ID="txtFirstNameContact" class="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group"></div>
                            <label for="inputLastName">שם משפחה</label>
                            <asp:TextBox ID="txtLastNameContact" class="form-control" runat="server"></asp:TextBox>
                        <div class="form-group">
                           <label for="inputPhone">מספר טלפון</label>
                            <asp:TextBox ID="txtPhoneContact" class="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="inputDate">תאריך</label>
                            <asp:TextBox ID="txtDateControl" runat="server"></asp:TextBox><asp:ImageButton ID="imgCalendar" runat="server" ImageUrl="~/Images/calendar.png" style="margin-right: 3px;" Width="30px" Height="30px" CausesValidation="False" ClientIDMode="Static" OnClick="imgCalendar_Click" />
                            <asp:Calendar ID="CalendarContact" runat="server" OnSelectionChanged="CalendarContact_SelectionChanged" ClientIDMode="Static" OnVisibleMonthChanged="CalendarContact_VisibleMonthChanged" FirstDayOfWeek="Sunday" OnDayRender="CalendarContact_DayRender" NextMonthText="הבא" PrevMonthText="הקודם"></asp:Calendar>
                            <asp:DropDownList ID="ddlTimeContact" runat="server"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="inputDate">בסניף</label>
                            <asp:DropDownList ID="ddlCityContact" runat="server" DataSourceID="LinqDataSource1" DataTextField="CitySite" DataValueField="CitySite"></asp:DropDownList>
                            <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="Cars.DBDataContext" EntityTypeName="" Select="new (CitySite)" TableName="DealerShipSites" Where="dealerShipName == @dealerShipName">
                                <WhereParameters>
                                    <asp:ControlParameter ControlID="HiddenField1" Name="dealerShipName" PropertyName="Value" Type="String" />
                                </WhereParameters>
                            </asp:LinqDataSource>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSubmitContact" class="btn btn-primary" runat="server" Text="שלח" style="margin-left: 15px;" />
                    <asp:Button ID="btnCancelSubmit" class="btn btn-primary" runat="server" data-dismiss="modal" Text="בטל" />
                </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function popup() {
            $('[id*="contactModal"]').modal('show');
            }
    </script>
</asp:Content>
