<%@ Page Title="" Language="C#" MasterPageFile="~/FrontendMasterPage.Master" AutoEventWireup="true" CodeBehind="CarDetail.aspx.cs" Inherits="Cars.CarDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentBody" runat="server">
    <div id="header" style="width:912px;height:30px;background-color:darkgray;font-weight:bold;margin:10px;">
        <asp:Label style="margin-right:50px;" ID="lblHeader" runat="server" Text="" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> 
        <asp:HiddenField ID="HiddenField1" runat="server" />
        <asp:HiddenField ID="hdnCarNumber" runat="server" />
    </div>
    <div class="row">
        <div class="col-sm-4">
            <table id="carDetail" dir="rtl" lang="he">
                <tr>
                    <td align="right"><asp:Label ID="lblCarNum" runat="server" Text="מספר רכב" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                    <td></td><td></td><td></td>
                    <td align="left"><asp:Label ID="lblDcarNum" runat="server" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                </tr>
                <tr>
                    <td align="right"><asp:Label ID="lblCarName" runat="server" Text="יצרן" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                    <td></td><td></td><td></td>
                    <td align="left"><asp:Label ID="lblDcarName" runat="server" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                </tr>
                <tr>
                    <td align="right"><asp:Label ID="lblLine" runat="server" Text="דגם" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                    <td></td><td></td><td></td>
                    <td align="left"><asp:Label ID="lblDLine" runat="server" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                </tr>
                <tr>
                    <td align="right"><asp:Label ID="lblPrice" runat="server" Text="מחיר" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                    <td></td><td></td><td></td>
                    <td align="left"><asp:Label ID="lblDPrice" runat="server" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                </tr>
                <tr>
                    <td align="right"><asp:Label ID="lblYear" runat="server" Text="שנה" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                    <td></td><td></td><td></td>
                    <td align="left"><asp:Label ID="lblDyear" runat="server" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                </tr>
                <tr>
                    <td align="right"><asp:Label ID="lblNumKM" runat="server" Text="מס' קילומטר" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                    <td></td><td></td><td></td>
                    <td align="left"><asp:Label ID="lblDnumKM" runat="server" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                </tr>
                <tr>
                    <td align="right"><asp:Label ID="lblCarColor" runat="server" Text="צבע" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                    <td></td><td></td><td></td>
                    <td align="left"><asp:Label ID="lblDcarColor" runat="server" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                </tr>
                <tr>
                    <td align="right"><asp:Label ID="lblGear" runat="server" Text="תיבת הילוכים" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                    <td></td><td></td><td></td>
                    <td align="left"><asp:Label ID="lblDgear" runat="server" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                </tr>
                <tr>
                    <td align="right"><asp:Label ID="lblEngine" runat="server" Text="נפח מנוע" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                    <td></td><td></td><td></td>
                    <td align="left"><asp:Label ID="LblDengine" runat="server" ForeColor="Black" Font-Names="Arial" Font-Size="Large"></asp:Label> </td>
                </tr>
            </table>
        </div>

        <div class="col-sm-8">
            <asp:Image ID="imgCar" runat="server" Width="300px" Height="200" class="img-thumbnail" />
            <div id="Contact" style="width:300px;height:50px;background-color:darkgray">
                
                <asp:Button ID="btnContact" data-target="#contactModal" OnClientClick="popup();return false;" runat="server" Text="" CssClass="btn btn-primary" Height="50" Width="300" />
            </div>
       </div>
    </div>
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
                    <form id="modalForm" style="background-color:white;">
                        <div class="form-group">
                            <label for="inputFirstName">שם פרטי</label>
                            <asp:TextBox ID="txtFirstNameContact" class="form-control" runat="server" required oninput="setCustomValidity('')" oninvalid="this.setCustomValidity('חובה לרשום שם פרטי')"></asp:TextBox>
                        </div>
                        <div class="form-group"></div>
                            <label for="inputLastName">שם משפחה</label>
                            <asp:TextBox ID="txtLastNameContact" class="form-control" runat="server" required oninput="setCustomValidity('')" oninvalid="this.setCustomValidity('חובה לרשום שם משפחה')"></asp:TextBox>
                        <div class="form-group">
                           <label for="inputPhone">מספר טלפון</label>
                            <asp:TextBox ID="txtPhoneContact" class="form-control" runat="server" type="number" oninput="setCustomValidity('')" oninvalid="this.setCustomValidity('מספרים בלבד')" MaxLength="10"></asp:TextBox>
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
                    <asp:Button ID="btnSubmitContact" class="btn btn-primary" runat="server" Text="שלח" style="margin-left: 15px;" OnClick="btnSubmitContact_Click" />
                    <asp:Button ID="btnCancelSubmit" class="btn btn-primary" runat="server" data-dismiss="modal" Text="בטל" CausesValidation="False" />
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
