<%@ Page Title="" Language="C#" MasterPageFile="~/BackendMasterPage.Master" AutoEventWireup="true" CodeBehind="SearchReport.aspx.cs" Inherits="Cars.SearchReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    דוח חיפושים
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        div.form-group > span{
            font-family="arial";
        }
       h1#searchHeader{
            text-align: center;
           background-color:black;
            color:white;
            width:50%;
            margin-top: 5px;
            margin-right: auto;
            margin-bottom: 15px;
            margin-left: auto;
        }

    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentBody" runat="server">
    <div class="container" style="margin-top:10px;">
        <h1 id="searchHeader">דוח חיפושים</h1>
        <form>
            <div class="row" >
                <div class="form-group">
                    <asp:label runat="server" text="יצרן" id="lblSerManufacturer"></asp:label> 
                    <asp:dropdownlist runat="server" id="ddlSerManufacturer" ></asp:dropdownlist>
                </div>
                 <div class="form-group">
                    <asp:label runat="server" text="דגם" id="lblSerLine"></asp:label> 
                    <asp:dropdownlist runat="server" id="ddlSerLine" ></asp:dropdownlist>
                </div>

                <div class="form-group">
                    <asp:label runat="server" text="נפח מנוע" id="lblSerEngine"></asp:label> 
                    <asp:dropdownlist runat="server" id="ddlSerEngine" ></asp:dropdownlist>
                </div>

                <div class="form-group">
                    <asp:label runat="server" text="תיבת הילוכים" id="lblSerGearbox"></asp:label> 
                    <asp:dropdownlist runat="server" id="ddlSerGearbox" ></asp:dropdownlist>
                </div>
            </div>
        </form>
        <form>
            <div class="row">
                <div class="form-group">
                    <asp:label runat="server" text="משנה" id="lblSerFromYear"></asp:label> 
                    <asp:dropdownlist runat="server" id="ddlSerFromYear" ></asp:dropdownlist>
                </div>
                <div class="form-group">
                    <asp:label runat="server" text="עד שנה" id="lblSerToYear"></asp:label> 
                    <asp:dropdownlist runat="server" id="ddlSerToYear" ></asp:dropdownlist>
                </div>
                <div class="form-group">
                    <asp:label runat="server" text="ממחיר" id="lblSerFromPrice"></asp:label> 
                    <asp:TextBox ID="txtFromPrice" runat="server"></asp:TextBox>
                </div>
               <div class="form-group">
                    <asp:label runat="server" text="ממחיר" id="lblSerToPrice"></asp:label> 
                    <asp:TextBox ID="txtToPrice" runat="server"></asp:TextBox>
                </div>
                <div class="form-group" style="margin-right:10px;">
                    <asp:Button ID="btnSearch" runat="server" Text="חפש" CausesValidation="false" CssClass="btn btn-primary btn-md" />
                    <asp:Button ID="btnClear" runat="server" Text="נקה" style="margin-right:5px;" CausesValidation="false" CssClass="btn  btn-md" />
                </div>
            </div>
        </form>
    </div>
</asp:Content>
