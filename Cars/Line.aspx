<%@ Page Title="" Language="C#" MasterPageFile="~/BackendMasterPage.Master" AutoEventWireup="true" CodeBehind="Line.aspx.cs" Inherits="Cars.Line1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    דגם של יצרן
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentBody" runat="server">
    <br />
    <div class="row">
      <div class="col-sm-4">
          <asp:Label ID="lblLine" runat="server" class="bg-dark text-white text-center" Text="דגם" Width="300px" Font-Names="Arial"></asp:Label>
          <br />
          <br />
          <table>
              <tr>
                  <td>שם יצרן</td>
                  <td>
                      <asp:DropDownList ID="ddlManufacturer" runat="server" Width="183px" CssClass="form-control"></asp:DropDownList>

                      <asp:RequiredFieldValidator ID="rfvMaunfacturer" runat="server" ControlToValidate="ddlManufacturer" Display="Dynamic" ErrorMessage="חובה לבחור שם יצרן" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" InitialValue="-1"></asp:RequiredFieldValidator>

                  </td>
              </tr>
              <tr>
                  <td>שם דגם </td>
                  <td>
                      <asp:TextBox ID="txtLine" runat="server" Width="183px"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="rfvLine" runat="server" ControlToValidate="txtLine" Display="Dynamic" ErrorMessage="חובה לרשום דגם" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red"></asp:RequiredFieldValidator>
&nbsp;</td>
              </tr>
          </table>
          &nbsp;
          <asp:HiddenField ID="hdnManufacturer" runat="server" />
          <asp:HiddenField ID="hdnLine" runat="server" />
          <br />
          <br />
          <table id="tblButtons">
              <tr>
                <td><asp:Button ID="btnAddManufacturer" runat="server" Text="הוספה" class="btn btn-success btn-md" OnClientClick="return confirm('האם להוסיף את הדגם?')" OnClick="btnAddManufacturer_Click"/></td>
                <td></td><td></td>
                <td><asp:Button ID="btnUpdateManufacturer" runat="server" Text="עדכון" class="btn btn-info btn-md" OnClientClick="return confirm('האם לעדכן את הדגם?')" OnClick="btnUpdateManufacturer_Click" Width="72px"/></td>
                <td></td><td></td>
                <td><asp:Button ID="btnDeleteManufacturer" runat="server" Text="מחיקה" class="btn btn-danger btn-md" OnClientClick="return confirm('האם למחוק את הדגם?')" OnClick="btnDeleteManufacturer_Click"/></td>
                  <td></td><td></td>
                <td><asp:Button ID="btnClearForm" runat="server" class="btn btn-md" Text="ביטול" CausesValidation="false" OnClientClick="return confirm('האם לבטל את הפעולה?')" OnClick="btnClearForm_Click" /> </td>
              </tr>
          </table>
      </div>
      <div class="col-sm-8">
          <asp:Panel ID="pnlFilter" runat="server" style="margin-bottom:10px; background-color:aquamarine;width:508px;height:70px">
              <table>
                  <tr><td colspan="4" class="auto-style1"><b>חיפוש</b></td></tr>
                  <tr>
                      <td>
                         יצרן: <asp:TextBox ID="txtFilterManufacturer" runat="server"></asp:TextBox>
                      </td>
                      <td colspan="2"></td>
                      <td>
                         דגם:  <asp:TextBox ID="txtFilterLine" runat="server"></asp:TextBox>
                      </td>
                      <td>
                          <asp:Button id="btnSearch" runat="server" Text="חפש" ForeColor="White" style="background-color:blue; width: 46px;" CausesValidation="false" OnClick="btnSearch_Click1" />
                      </td>
                      <td>
                          <asp:Button ID="btnClear" runat="server" Text="נקה" ForeColor="White" style="background-color:darkgray;" CausesValidation="false" OnClick="btnClear_Click" />
                      </td>
                  </tr>
              </table>
          </asp:Panel>
          <asp:Panel runat="server" ID="pnlLineAll" Width="508px">
              <asp:Label ID="lblTotalAll" runat="server" Text=" "></asp:Label>
              <asp:GridView ID="gvLine" Width="508px" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="LineDataSource" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvLine_SelectedIndexChanged" OnPreRender="gvLine_PreRender">
              <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
              <Columns>
                  <asp:CommandField SelectText="בחר" ShowSelectButton="True" >
                  <ItemStyle HorizontalAlign="Right" />
                  </asp:CommandField>
                  <asp:BoundField DataField="ManufacturerName" HeaderText="שם יצרן" ReadOnly="True" SortExpression="ManufacturerName" >
                  <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                  <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                  </asp:BoundField>
                  <asp:BoundField DataField="Line1" HeaderText="דגם" ReadOnly="True" SortExpression="Line1" >
                  <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                  <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
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
              <asp:LinqDataSource ID="LineDataSource" runat="server" ContextTypeName="Cars.DBDataContext" EntityTypeName="" OrderBy="ManufacturerName, Line1" Select="new (ManufacturerName, Line1)" TableName="Lines" OnSelected="LineDataSource_Selected">
              </asp:LinqDataSource>
          </asp:Panel>

          <asp:Panel runat="server" ID="pnlFilterLine" Width="508px">
              <asp:Label ID="lblTotalFilter" runat="server" Text=" "></asp:Label>
              <asp:GridView ID="gvFilterLine" Width="508px" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ManufacturerName,Line" DataSourceID="SqlDataSourceLineFilter" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvFilterLine_SelectedIndexChanged" EmptyDataText="אין תוצאות">
                  <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                  <Columns>
                      <asp:CommandField SelectText="בחר" ShowSelectButton="True">
                      <ItemStyle Font-Names="Arial" />
                      </asp:CommandField>
                      <asp:BoundField DataField="ManufacturerName" HeaderText="יצרן" ReadOnly="True" SortExpression="ManufacturerName">
                      <FooterStyle Font-Names="Arial" />
                      <HeaderStyle HorizontalAlign="Right" />
                      <ItemStyle HorizontalAlign="Right" />
                      </asp:BoundField>
                      <asp:BoundField DataField="Line" HeaderText="דגם" ReadOnly="True" SortExpression="Line">
                      <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                      <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
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
              <asp:SqlDataSource ID="SqlDataSourceLineFilter" runat="server" ConnectionString="<%$ ConnectionStrings:CarsConnectionString %>" SelectCommand="LineSearch" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceLineFilter_Selected">
                  <SelectParameters>
                      <asp:ControlParameter ControlID="txtFilterManufacturer" ConvertEmptyStringToNull="False" DefaultValue="" Name="Manufacturer" PropertyName="Text" Type="String" />
                      <asp:ControlParameter ControlID="txtFilterLine" ConvertEmptyStringToNull="False" DefaultValue="" Name="Line" PropertyName="Text" Type="String" />
                  </SelectParameters>
              </asp:SqlDataSource>
          </asp:Panel>
      </div>
</div>
</asp:Content>
