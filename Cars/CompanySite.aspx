<%@ Page Title="" Language="C#" MasterPageFile="~/BackendMasterPage.Master" AutoEventWireup="true" CodeBehind="CompanySite.aspx.cs" Inherits="Cars.CompanySite" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    סניף של סוכנות
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentBody" runat="server">
    <br />
    <div class="row">
        <div class="col-sm-4">
            <table>
              <tr>
                <td colspan="2">
                    <asp:Label ID="lblCompanyHeader" class="bg-dark text-white text-center" width="300px" runat="server" Text="סניף של סוכנות ליסינג" Font-Names="Arial"></asp:Label>
                </td>
             </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCompany" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="#17A2B8" Text="שם סוכנות"></asp:Label>

                    </td>
                    <td>
                        <asp:DropDownList ID="ddlCompanyName" runat="server" Font-Names="Arial" Font-Size="Large" Width="170px" OnSelectedIndexChanged="ddlCompanyName_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator ID="rfvCompanyName" runat="server" ControlToValidate="ddlCompanyName" Display="Dynamic" ErrorMessage="חובה לבחור שם סוכנות" Font-Names="Arial" Font-Size="Large" ForeColor="Red" InitialValue="-1"></asp:RequiredFieldValidator>

                    </td>
                </tr>
               <tr>
                    <td>
                        <asp:Label ID="lblCity" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="#17A2B8" Text="עיר"></asp:Label>

                    </td>
                    <td>
                        <asp:DropDownList ID="ddlCity" runat="server" Width="170px" OnSelectedIndexChanged="ddlCity_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="ddlCity" Display="Dynamic" ErrorMessage="חובה לבחור שם עיר" Font-Names="Arial" Font-Size="Large" ForeColor="Red" InitialValue="-1"></asp:RequiredFieldValidator>
                    </td>
                </tr>
               <tr>
                    <td>
                        <asp:Label ID="lblAddress" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="#17A2B8" Text="כתובת"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAddress" runat="server" Font-Names="Arial" Font-Size="Large"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAddress" Display="Dynamic" ErrorMessage="חובה לרשום כתובת" Font-Names="Arial" Font-Size="Large" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revAddress" runat="server" ControlToValidate="txtAddress" Display="Dynamic" ErrorMessage="עברית בלבד" Font-Bold="False" Font-Names="Arial" Font-Size="Large" ForeColor="Red" ValidationExpression="^([א-ת0-9 &quot;&quot;])*$"></asp:RegularExpressionValidator>
                    </td>
                </tr>
               <tr>
                    <td>
                        <asp:Label ID="lblPhone" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="#17A2B8" Text="מספר טלפון"></asp:Label>

                    </td>
                    <td>
                        <asp:TextBox ID="txtPhone" runat="server" Font-Names="Arial" Font-Size="Large"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" Display="Dynamic" ErrorMessage="חובה לרשום מספר טלפון" Font-Names="Arial" Font-Size="Large" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
               </table>
               <br />
            <asp:Label ID="lblMessage" runat="server" Font-Bold="True"></asp:Label>
              <asp:HiddenField ID="hdnCity" runat="server" />
            <asp:HiddenField ID="hdnDealerName" runat="server" />
              <br />
            <br />
             <table>
             <tr>
                <td colspan="2"><asp:Button ID="btnAddCompanySite" runat="server" Text="הוספה" class="btn btn-success btn-md" OnClientClick="return confirm('האם להוסיף את הסניף?')" OnClick="btnAddCompanySite_Click"/></td>
                 <td></td><td></td><td></td><td></td>
                <td colspan="2"><asp:Button ID="btnUpdateCompanySite" runat="server" Text="עדכון" class="btn btn-info btn-md" OnClientClick="return confirm('האם לעדכן את הסניף?')"  OnClick="btnUpdateCompanySite_Click"/></td>
                 <td></td><td></td><td></td><td></td>
                <td colspan="2"><asp:Button ID="btnDeleteCompanySite" runat="server" Text="מחיקה" class="btn btn-danger btn-md" OnClientClick="return confirm('האם למחוק את הסניף?')" OnClick="btnDeleteCompanySite_Click"/></td>
                <td></td><td></td>                
                 <td><asp:Button ID="btnClearForm" runat="server" class="btn btn-md" Text="ביטול" CausesValidation="false"  OnClientClick="return confirm('האם לבטל את הפעולה?')" OnClick="btnClearForm_Click" /></td>
            </tr>
         </table>
        </div><!--class="col-sm-4"-->

        <div class="col-sm-8">
            <asp:Panel ID="pnlSearch" runat="server" Direction="RightToLeft" Font-Names="arial" style="margin-bottom:10px; background-color:aquamarine;width:508px;height:70px">
                <table>
                    <tr>
                        <td><b>חיפוש</b></td>
                    </tr>
                    <tr>
                        <td>
                            שם סוכנות: <asp:DropDownList ID="ddlFilterCompany" runat="server" DataTextField="Name" DataValueField="Name" Font-Names="Arial" Font-Size="Large" AutoPostBack="True" OnSelectedIndexChanged="ddlFilterCompany_SelectedIndexChanged"></asp:DropDownList>
                        </td>
                        <td>
                            סניף: <asp:DropDownList ID="ddlFilterCity" runat="server" Font-Names="Arial" Font-Size="Large"></asp:DropDownList>
                        </td>
                        <td>
                            <asp:Button runat="server" CausesValidation="false" Text="חפש" class="btn-primary" OnClick="btnSearch_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnClear" runat="server" CausesValidation="false" Text="נקה" ForeColor="White" style="background-color:darkgray;" OnClick="btnClear_Click" Height="28px" />
                        </td>

                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnlCompanySiteAll" runat="server">
                <asp:Label ID="lblTotalALL" runat="server" Text=""></asp:Label>
            <asp:GridView Width="508px" ID="grvCompanySite" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="dealerShipName,CitySite" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" PageSize="5" OnSelectedIndexChanged="grvCompanySite_SelectedIndexChanged" OnPreRender="grvCompanySite_PreRender" CssClass="eeeeeeeeeeeeee">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:CommandField SelectText="בחר" ShowSelectButton="True">
                    <HeaderStyle Font-Names="Arial" />
                    </asp:CommandField>
                    <asp:BoundField DataField="dealerShipName" HeaderText="שם סוכנות" ReadOnly="True" SortExpression="dealerShipName">
                    <FooterStyle Font-Names="Arial" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CitySite" HeaderText="סניף" ReadOnly="True" SortExpression="CitySite">
                    <HeaderStyle Font-Names="Arial" />
                    </asp:BoundField>
                    <asp:BoundField DataField="address" HeaderText="כתובת" SortExpression="address">
                    <HeaderStyle Font-Names="Arial" />
                    </asp:BoundField>
                    <asp:BoundField DataField="phone" HeaderText="מספר טלפון" SortExpression="phone">
                    <HeaderStyle Font-Names="Arial" />
                    </asp:BoundField>
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CarsConnectionString %>" SelectCommand="SELECT * FROM [DealerShipSites]" OnSelected="SqlDataSource1_Selected"></asp:SqlDataSource>
            </asp:Panel>
            <asp:Panel ID="pnlCompaySiteFilter" runat="server">
                <asp:Label ID="lblTotalFilter" runat="server" Text=""></asp:Label>
                <asp:GridView ID="gvCompanySiteFilter" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="508px" DataKeyNames="dealerShipName,CitySite" DataSourceID="SqlDataSourceFilterCompanySite" EmptyDataText="אין תוצאות"  OnSelectedIndexChanged="gvCompanySiteFilter_SelectedIndexChanged">

                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" SelectText="בחר" >
                        <HeaderStyle Font-Bold="True" Font-Names="ARIAL" HorizontalAlign="Right" />
                        </asp:CommandField>
                        <asp:BoundField DataField="dealerShipName" HeaderText="שם סוכנות" ReadOnly="True" SortExpression="dealerShipName" >
                        <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CitySite" HeaderText="סניף" ReadOnly="True" SortExpression="CitySite" >
                        <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="address" HeaderText="כתובת" SortExpression="address" >
                        <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="phone" HeaderText="טלפון" SortExpression="phone" >
                        <HeaderStyle Font-Bold="True" HorizontalAlign="Right" />
                        </asp:BoundField>
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
                <asp:SqlDataSource ID="SqlDataSourceFilterCompanySite" runat="server" ConnectionString="<%$ ConnectionStrings:CarsConnectionString %>" SelectCommand="DealerShipSitesSearch" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceFilterCompanySite_Selected">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlFilterCompany" Name="Dname" PropertyName="SelectedValue" Type="String" ConvertEmptyStringToNull="False" DefaultValue="" />
                        <asp:ControlParameter ControlID="ddlFilterCity" Name="Dsite" PropertyName="SelectedValue" Type="String" ConvertEmptyStringToNull="False" DefaultValue="" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:Panel>

        </div><!--class="col-sm-8"-->

    </div>
</asp:Content>
