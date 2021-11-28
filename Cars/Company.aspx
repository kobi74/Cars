<%@ Page Title="" Language="C#" MasterPageFile="~/BackendMasterPage.Master" AutoEventWireup="true" CodeBehind="Company.aspx.cs" Inherits="Cars.Company" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    סוכנות ליסינג
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentBody" runat="server">
    <br />
    <div class="row">
     <div class="col-sm-4">
          <table id="tblCompany" dir="rtl" lang="he">
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblCompanyHeader" class="bg-dark text-white text-center" runat="server" Text="סוכנות ליסינג" Font-Names="Arial" Font-Size="Large" Width="300px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblCompanyName" runat="server" Text="שם סוכנות"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtCompanyName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCompany" runat="server" ErrorMessage="חובה לרשום שם סוכנות" ControlToValidate="txtCompanyName" Display="Dynamic" Font-Bold="True" ForeColor="Red" Font-Names="Arial"></asp:RequiredFieldValidator>
                </td>
            </tr>
              <tr><td></td><td></td></tr>
            <tr>
                <td>
                    <asp:Label ID="lblCompanyPic" runat="server" Text="לוגו סוכנות"></asp:Label>
                </td>
                <td>
                    <asp:FileUpload ID="FileUploadLogo" runat="server" />
                </td>
                <td>
                    &nbsp;</td>
            </tr>
              <tr>
                  <td colspan="2">
                      <asp:Label ID="lblLogoMsg" runat="server" Text="" Font-Bold="True"></asp:Label>
                  </td>
              </tr>
        </table>
          <asp:HiddenField ID="hdnLogo" runat="server" />
          <asp:HiddenField ID="hdnCompany" runat="server" />
         <br />
         <br />
         <table>
             <tr>
                <td colspan="2"><asp:Button ID="btnAddCompany" runat="server" Text="הוספה" class="btn btn-success btn-md" OnClick="btnAddCompany_Click"  OnClientClick="return confirm('הם להוסיף את שם סוכנות הליסינג?')" /></td>
                 <td></td><td></td><td></td><td></td>
                <td colspan="2"><asp:Button ID="btnUpdateCompany" runat="server" Text="עדכון" class="btn btn-info btn-md" OnClick="btnUpdateCompany_Click" OnClientClick="return confirm('הם לעדכן את שם סוכנות הליסינג?')"/></td>
                 <td></td><td></td><td></td><td></td>
                <td colspan="2"><asp:Button ID="btnDeleteCompany" runat="server" Text="מחיקה" class="btn btn-danger btn-md" OnClick="btnDeleteCompany_Click" OnClientClick="return confirm('הם למחוק את שם סוכנות הליסינג?')"/></td>
                <td><asp:Button ID="btnClearForm" runat="server" class="btn btn-md" Text="ביטול" CausesValidation="false" OnClick="btnClearForm_Click"  OnClientClick="return confirm('האם לבטל את הפעולה?')" /></td>
            </tr>
         </table>
     </div><!--End class="col-sm-4" -->
       

     <div class="col-sm-8">
         <asp:Panel ID="pnlSearch" runat="server" Direction="RightToLeft" Font-Names="arial" style="margin-bottom:10px; background-color:aquamarine;width:508px;height:70px">
             <table>
                 <tr>
                     <td><b>חיפוש</b></td>
                 </tr>
                 <tr>
                     <td>
                         <asp:TextBox ID="txtSearch" runat="server" Font-Size="Larger"></asp:TextBox>
                     </td>
                     <td>
                         <asp:Button ID="btnSearch" runat="server" CausesValidation="false" Text="חפש" class="btn-primary" OnClick="btnSearch_Click" />
                     </td>
                     <td>
                         <asp:Button ID="btnClear" runat="server" CausesValidation="false" Text="נקה" ForeColor="White" style="background-color:darkgray;" OnClick="btnClear_Click" />
                     </td>
                 </tr>
             </table>
         </asp:Panel>
         <asp:Panel ID="pnlCompanyAll" runat="server">
             <asp:Label ID="lblTotalAll" runat="server" Text=""></asp:Label>
                 <asp:GridView ID="gvCompany" runat="server" Width="508px" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="CompanyDataSource" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvCompany_SelectedIndexChanged" PageSize="4" OnPreRender="gvCompany_PreRender">
                     <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                     <Columns>
                         <asp:CommandField SelectText="בחר" ShowSelectButton="True" >
                         <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                         </asp:CommandField>
                         <asp:BoundField DataField="Name" HeaderText="שם סוכנות" ReadOnly="True" SortExpression="Name">
                         <ControlStyle Font-Bold="True" Font-Names="Arial" />
                         <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                         <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                         </asp:BoundField>
                         <asp:BoundField DataField="logo" HeaderText="שם תמונה" ReadOnly="True" SortExpression="logo">
                         <ControlStyle Font-Bold="True" Font-Names="Arial" />
                         <HeaderStyle Font-Bold="True" Font-Names="Arial" />
                         <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                         </asp:BoundField>
                 
                         <asp:TemplateField HeaderText="תמונה">
                             <ItemTemplate>
                                 <asp:Image ID="imgLogo" runat="server" Height="100px" Width="100px" ImageUrl='<%# Eval("logo") %>'/>
                             </ItemTemplate>
                             <ControlStyle Width="120px" />
                             <HeaderStyle Font-Bold="True" Font-Names="arial" />
                         </asp:TemplateField>
                
                     </Columns>
                     <EditRowStyle BackColor="#999999" />
                     <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                     <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                     <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                     <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                     <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                     <SortedAscendingCellStyle BackColor="#E9E7E2" />
                     <SortedAscendingHeaderStyle BackColor="#506C8C" />
                     <SortedDescendingCellStyle BackColor="#FFFDF8" />
                     <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                 </asp:GridView>
                 <asp:Label ID="lblPage" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Larger" ForeColor="#284775"></asp:Label>
                 <asp:LinqDataSource ID="CompanyDataSource" runat="server" ContextTypeName="Cars.DBDataContext" EntityTypeName="" OrderBy="Name" Select="new (Name, logo)" TableName="DealerShips" OnSelected="CompanyDataSource_Selected">
                 </asp:LinqDataSource>
         </asp:Panel>
         <asp:Panel ID="pnlFilterCompany" runat="server">
             <asp:Label ID="lblTotalFilter" runat="server" Text=""></asp:Label>
             <asp:GridView ID="gvFilterCompany" Width="508px" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Name" DataSourceID="SqlDataSourceCompanyFilter" EmptyDataText="אין תוצאות" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvFilterCompany_SelectedIndexChanged">

                 <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                 <Columns>
                     <asp:CommandField SelectText="בחר" ShowSelectButton="True">
                     <ItemStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                     </asp:CommandField>
                     <asp:BoundField DataField="Name" HeaderText="שם סוכנות" ReadOnly="True" SortExpression="Name">
                     <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                     <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                     </asp:BoundField>
                     <asp:BoundField DataField="logo" HeaderText="שם תמונה" SortExpression="logo">
                     <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                     </asp:BoundField>
                     <asp:TemplateField HeaderText="תמונה">
                         <ItemTemplate>
                             <asp:Image ID="imgLogoFilter"  runat="server" Height="100px" Width="100px" ImageUrl='<%# Eval("logo") %>' />
                         </ItemTemplate>
                         <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                         <ItemStyle HorizontalAlign="Right" />
                     </asp:TemplateField>
                 </Columns>
                 <EditRowStyle BackColor="#999999" />
                 <EmptyDataRowStyle Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" />
                 <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                 <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                 <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                 <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                 <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                 <SortedAscendingCellStyle BackColor="#E9E7E2" />
                 <SortedAscendingHeaderStyle BackColor="#506C8C" />
                 <SortedDescendingCellStyle BackColor="#FFFDF8" />
                 <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

             </asp:GridView>
             <asp:SqlDataSource ID="SqlDataSourceCompanyFilter" runat="server" ConnectionString="<%$ ConnectionStrings:CarsConnectionString %>" SelectCommand="DealershipSearch" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceCompanyFilter_Selected">
                 <SelectParameters>
                     <asp:ControlParameter ControlID="txtSearch" Name="Dname" PropertyName="Text" Type="String" />
                 </SelectParameters>
             </asp:SqlDataSource>
         </asp:Panel>
     </div><!-- End class="col-sm-8"-->
</div>
</asp:Content>
