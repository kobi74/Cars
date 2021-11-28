<%@ Page Title="" Language="C#" MasterPageFile="~/FrontendMasterPage.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Cars.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    דף הבית
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
      <style type="text/css">
            .pager span {
                color:#333333;
                background-color:white;
                padding:5px;
                font-weight:bold;
            }
            a:hover{
                font-weight:bold;
            }
     </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentBody" runat="server">
    <div class="container-fluid">
        <h1 id="Header">חיפוש רכב</h1>
        <hr style="border:1px solid #546E7A" />
        <table id="indexSearch" dir="rtl">
            <tr>
                <td><h4>קבוצה</h4></td>
                <td><asp:DropDownList runat="server" ID="ddlIndexGroup">
                    <asp:ListItem>קטנות</asp:ListItem>
                    <asp:ListItem>משפחתי</asp:ListItem>
                    <asp:ListItem>מנהלים</asp:ListItem>
                    <asp:ListItem>מיניוואן</asp:ListItem>
                    <asp:ListItem>ג&#39;יפ</asp:ListItem>
                    </asp:DropDownList></td>
                <td><h4>יצרן</h4></td>
                <td><asp:DropDownList runat="server" ID="ddlIndexManufacturer" AutoPostBack="True" DataTextField="Name" DataValueField="Name" OnSelectedIndexChanged="ddlIndexManufacturer_SelectedIndexChanged"></asp:DropDownList></td>
                <td><h4>דגם</h4></td>
                <td><asp:DropDownList runat="server" ID="ddlIndexLine" DataTextField="Line" DataValueField="Line"></asp:DropDownList></td>
            </tr>
            <tr>
                <td><h4>משנת</h4></td>
                <td><asp:DropDownList runat="server" ID="ddlIndexMinYear" AutoPostBack="True" OnSelectedIndexChanged="ddlIndexMinYear_SelectedIndexChanged"></asp:DropDownList></td>
                <td><h4>עד שנת</h4></td>
                <td><asp:DropDownList runat="server" ID="ddlIndexMaxYear" AutoPostBack="True"></asp:DropDownList></td>
                <td><h4>ממחיר</h4></td>
                <td><asp:TextBox ID="txtIndexMinPrice" runat="server" type="number" min="0" oninvalid="this.setCustomValidity('מספר בלבד')"
    oninput="this.setCustomValidity('')"></asp:TextBox></td>
                <td><h4>עד מחיר</h4></td>
                <td><asp:TextBox ID="txtIndexMaxPrice" runat="server" type="number" min="0" oninvalid="this.setCustomValidity('מספר בלבד')"
    oninput="this.setCustomValidity('')"></asp:TextBox></td>
                <td><asp:CompareValidator ID="CompareValidatorPrice" runat="server" ErrorMessage="הזינו טווח חוקי" ControlToCompare="txtIndexMinPrice" ControlToValidate="txtIndexMaxPrice" Display="Dynamic" Font-Names="Arial" ForeColor="Red" Operator="GreaterThanEqual" Type="Integer"></asp:CompareValidator></td>
                <td><asp:CompareValidator ID="CompareValidatorMaxPrice" runat="server" ErrorMessage="חובה לרשום מספר" ControlToValidate="txtIndexMaxPrice" Operator="DataTypeCheck" Display="Dynamic" Font-Names="Arial" ForeColor="Red" Type="Integer" ToolTip="חובה לרשום מספר"></asp:CompareValidator></td>
                <td><asp:CompareValidator ID="CompareValidatorMinPrice" runat="server" ErrorMessage="חובה לרשום מספר" ControlToValidate="txtIndexMinPrice" Operator="DataTypeCheck" Display="Dynamic" Font-Names="Arial" ForeColor="Red" Type="Integer"></asp:CompareValidator></td>
                <td><asp:Button ID="btnIndexSearch" runat="server" Text="חפש" OnClick="btnIndexSearch_Click" /></td>
                <td></td>
                <td><asp:Button ID="btnIndexClear" runat="server" Text="נקה" OnClick="btnIndexClear_Click" CausesValidation="False" EnableViewState="False" /></td>
            </tr>
            <tr>
                <td colspan="2"><asp:Button ID="btnClearYears" runat="server" Text=" נקה שנים" OnClick="Button1_Click" CausesValidation="False" /></td>
            </tr>

        </table>
 <br /><br />

        <asp:Panel ID="pnlGridview" runat="server">
            <div class="container">
                <asp:Button ID="btnCompare" runat="server" Text="השוואת מחירים" class="btn btn-secondary" style="position:absolute;left:50px;" CausesValidation="False" OnClick="btnCompare_Click" />
                <asp:Button ID="btnQuote" runat="server" Text="הצעת מחיר" class="btn btn-dark" style="position:absolute;left: 222px;" CausesValidation="False" Visible="False"/>
                <asp:Label ID="lblGridTitle" runat="server" Text="תוצאות חיפוש" ForeColor="Black" Font-Bold="true" Font-Names="Arial" style="font-size:35px;"></asp:Label>
            </div>
            <asp:GridView ID="gvIndexSearch" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="serialNumber" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" EmptyDataText="לא נמצאו תוצאות" CssClass="table table-bordered table-responsive-md table-striped text-center" PageSize="5" OnSelectedIndexChanged="gvIndexSearch_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="בחר">
                        <ItemTemplate>
                            <asp:CheckBox ID="cbCarIndex" runat="server" ToolTip='<%# Eval("serialNumber") %>'  onclick="CheckBoxCount();"/>
                        </ItemTemplate>
                        <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="serialNumber" HeaderText="מספר רכב" ReadOnly="True" SortExpression="serialNumber" >
                    <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="manufacturer_Name_Line" HeaderText="יצרן" SortExpression="manufacturer_Name_Line" >
                    <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="LineName" HeaderText="דגם" SortExpression="LineName" >
                    <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Year" HeaderText="שנה" SortExpression="Year" >
                    <FooterStyle Font-Bold="False" />
                    <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Color" HeaderText="צבע" SortExpression="Color" >
                    <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Class" HeaderText="קבוצה" SortExpression="Class" >
                    <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Fuel" HeaderText="מנוע" SortExpression="Fuel" >
                    <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Engine" HeaderText="נפח מנוע" SortExpression="Engine" />
                    <asp:BoundField DataField="Gearbox" HeaderText="תיבת הילוכים" SortExpression="Gearbox" >
                    <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="NumOfKM" HeaderText="ק&quot;מ" SortExpression="NumOfKM" >
                    <HeaderStyle Font-Bold="True" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Price" HeaderText="מחיר" SortExpression="Price" >
                    <HeaderStyle Font-Bold="True" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DealershipName" HeaderText="סוכנות ליסינג" SortExpression="DealershipName" >
                    <HeaderStyle Font-Bold="True" Font-Names="Arial" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DealershipNameSite" HeaderText="סניף" SortExpression="DealershipNameSite" >
                    <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CarPic" HeaderText="תמונה" SortExpression="CarPic" Visible="false" >
                    <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="תמונה">
                        <ItemTemplate>
                            <asp:Image runat="server" ID="imgIndexImage" Height="100px" Width="100px" ImageUrl='<%# Eval("CarPic") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:CommandField SelectText="לחץ" ShowSelectButton="True" HeaderText="פרטים">
                    <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" Font-Underline="False"/>
                    <ItemStyle Font-Names="Arial" Font-Underline="True" ForeColor="#0033FF" />
                    </asp:CommandField>

                </Columns>
                <PagerStyle BackColor="#00FFCC" Font-Bold="false" CssClass="pager" />
                <EmptyDataRowStyle Font-Names="Arial" Font-Size="Large" ForeColor="Red" />
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                <SortedAscendingCellStyle BackColor="#FDF5AC" />
                <SortedAscendingHeaderStyle BackColor="#4D0000" />
                <SortedDescendingCellStyle BackColor="#FCF6C0" />
                <SortedDescendingHeaderStyle BackColor="#820000" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CarsConnectionString %>" SelectCommand="MiniSearch" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlIndexGroup" Name="Class" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="ddlIndexManufacturer" Name="manufacturer" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="ddlIndexLine" Name="Line" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="ddlIndexMinYear" Name="minYear" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlIndexMaxYear" Name="MaxYear" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="txtIndexMinPrice" DefaultValue="0" Name="MinPrice" PropertyName="Text" Type="Int32" />
                    <asp:ControlParameter ControlID="txtIndexMaxPrice" DefaultValue="1000000" Name="MaxPrice" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:Panel>


<%--        <script type="text/javascript">
            function CheckBoxCount() {
                var gv = document.getElementById("<%=gvIndexSearch.ClientID%>");
                var inputList = gv.getElementsByTagName("input");
                var count = 0;
                for (i = 0; i < inputList.length; i++)
                {
                    if (inputList[i].type == "checkbox")
                    {
                        if (inputList[i].checked) {
                            count++;
                        }

                        else if(inputList[i].checked=false) {
                            count--;
                        }
                                               
                    }
                }
               // alert(count);
            }--%>

<%--            function getManfacturer() {
                var m = document.getElementById("<%=ddlIndexManufacturer.ClientID%>");
                var str = " ";
                if (m.selectedIndex > 0) {
                    str = m.options[m.selectedIndex].value;
                }
                document.getElementById("Header").innerText = " קניית רכב" + " " + str;
            }
        </script>--%>
    </div>
    <br /><br /><br />

</asp:Content>
