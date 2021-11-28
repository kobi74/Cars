<%@ Page Title="" Language="C#" MasterPageFile="~/BackendMasterPage.Master" AutoEventWireup="true" CodeBehind="ManufacturerReport.aspx.cs" Inherits="Cars.ManufacturerReport" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentBody" runat="server">
    <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" Height="600px" RightToLeft="Yes" Width="800px">
    <Titles>
        <asp:Title Text="תרשים רכבים"></asp:Title>
    </Titles>
    <series>
        <asp:Series Name="Series1" XValueMember="שם יצרן" YValueMembers="כמות" IsValueShownAsLabel="true" LabelBackColor="Blue" LabelForeColor="White">
        </asp:Series>
    </series>
    <chartareas>
        <asp:ChartArea Name="ChartArea1">
            <AxisX Interval="1"></AxisX>
        </asp:ChartArea>
    </chartareas>
        <Titles>
            <asp:Title Name="כמות רכבים">
            </asp:Title>
        </Titles>
</asp:Chart>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CarsConnectionString %>" SelectCommand="SELECT * FROM [vwCountManufacturer]"></asp:SqlDataSource>
</asp:Content>
