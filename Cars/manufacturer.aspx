<%@ Page Title="" Language="C#" MasterPageFile="~/BackendMasterPage.Master" AutoEventWireup="true" CodeBehind="manufacturer.aspx.cs" Inherits="Cars._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    יצרן
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentBody" runat="server">
    
    <br />
    <div class="row">
        <div class="col-sm-4">
    <table id="tblManufacturer" dir="rtl" lang="he">
        <asp:HiddenField ID="hdnManufacturer" runat="server" />
        <tr>
            <td colspan="2">
                <asp:Label ID="lblManufacturerHeader" class="bg-dark text-white text-center" style="margin-bottom:12px;" width="300px" Font-Size="Large" runat="server" Text="יצרן" Font-Names="Arial"></asp:Label>
            </td>
        </tr>
        
        <tr>
            <td>
                <asp:Label ID="lblManufacturer" runat="server" Text="שם יצרן" Font-Names="Arial"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtManufacturer" runat="server" class="form-control" Width="182px" Font-Size="Large"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvManufacturer" runat="server" ErrorMessage="חובה לרשום שם יצרן" ControlToValidate="txtManufacturer" Display="Dynamic" Font-Bold="True" Font-Names="Arial" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
            &nbsp;<asp:RegularExpressionValidator ID="revManufacturer" runat="server" ControlToValidate="txtManufacturer" Display="Dynamic" ErrorMessage="שם יצרן בעברית" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" ValidationExpression="^[א-ת\s]*$"></asp:RegularExpressionValidator>
&nbsp;</td>
        </tr>
    </table>
    <br />
    <table id="tblButtons" dir="rtl" lang="he">
            <tr>
                <td><asp:Button ID="btnAddManufacturer" runat="server" Text="הוספה" class="btn btn-success btn-md" OnClientClick="return confirm('האם להוסיף את היצרן?')" OnClick="btnAddManufacturer_Click"/></td>
                <td></td><td></td>
                <td><asp:Button ID="btnUpdateManufacturer" runat="server" Text="עדכון" class="btn btn-info btn-md" OnClientClick="return confirm('האם לעדכן את היצרן?')" OnClick="btnUpdateManufacturer_Click"/></td>
                <td></td><td></td>
                <td><asp:Button ID="btnDeleteManufacturer" runat="server" Text="מחיקה" class="btn btn-danger btn-md" OnClientClick="return confirm('האם למחוק את היצרן?')" OnClick="btnDeleteManufacturer_Click"/></td>
                <td colspan="4"></td>
                <td><asp:Button ID="btnClearForm" runat="server" class="btn btn-md" Text="ביטול" CausesValidation="false" OnClick="btnClearForm_Click" /> </td>
        </tr>

    </table>
       </div><!-- end class="col-sm-4"-->
        <div class="col-sm-8">
            <asp:Panel ID="pnlSearch" runat="server" Direction="RightToLeft" Font-Names="arial">
                <asp:TextBox ID="txtSearch" runat="server" Font-Size="Larger"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" CausesValidation="False" class="btn-primary" OnClick="btnSearch_Click" Text="חפש" />
                &nbsp;<asp:Button ID="btnClear" runat="server" ForeColor="White" style="background-color:darkgray;" CausesValidation="False" OnClick="btnClear_Click" Text="נקה" />
            </asp:Panel>
            <hr />
            <asp:Panel ID="pnlAll" runat="server">
                <asp:Label ID="lblTotalAll" runat="server" Text=""></asp:Label>
                <asp:GridView ID="gvManufacturer" runat="server" width="508px" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Name" DataSourceID="SqlDataSourceAll" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvManufacturer_SelectedIndexChanged" OnPreRender="gvManufacturer_PreRender">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" SelectText="בחר" />
                        <asp:BoundField DataField="Name" HeaderText="יצרן" ReadOnly="True" SortExpression="Name" >
                        <HeaderStyle Font-Bold="True" Font-Names="Arial" />
                        </asp:BoundField>
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Font-Names="Arial" HorizontalAlign="Right" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
                <asp:Label ID="lblPage" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Larger" ForeColor="#284775"></asp:Label>
                <asp:SqlDataSource ID="SqlDataSourceAll" runat="server" ConnectionString="<%$ ConnectionStrings:CarsConnectionString %>" SelectCommand="SELECT * FROM [Manufacturer]" OnSelected="SqlDataSourceAll_Selected"></asp:SqlDataSource>
            </asp:Panel>
            <asp:Panel ID="pnlGridSearch" runat="server">
                <asp:Label ID="lblTotalFilter" runat="server" Text=""></asp:Label>
                <asp:GridView ID="gvManufacturerSearch" runat="server" Width="508px" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Name" DataSourceID="SqlDataSourceFilter" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvManufacturerSearch_SelectedIndexChanged" EmptyDataText="אין תוצאות">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:CommandField SelectText="בחר" ShowSelectButton="True" />
                        <asp:BoundField DataField="Name" HeaderText="יצרן" ReadOnly="True" SortExpression="Name" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <EmptyDataRowStyle Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Font-Names="Arial" HorizontalAlign="Right" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSourceFilter" runat="server" ConnectionString="<%$ ConnectionStrings:CarsConnectionString %>" SelectCommand="SELECT [Name] FROM [Manufacturer] WHERE ([Name] = @Name)" OnSelected="SqlDataSourceFilter_Selected">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtSearch" Name="Name" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
