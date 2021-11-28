<%@ Page Title="" Language="C#" MasterPageFile="~/BackendMasterPage.Master" AutoEventWireup="true" CodeBehind="Cars.aspx.cs" Inherits="Cars.CarsTest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Cars
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentBody" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-3 col-md-6 col-lg-4">
                <h1 style="color:white;background-color:darkgreen;display:none;">Kobi</h1>
             <asp:Label ID="lblCarsHeader" runat="server" class="bg-dark text-white text-center" Text="רכבים" Width="300px" Font-Names="Arial" ></asp:Label>
            <table id="tblCars" class="auto-style5">
                <!--tr>
                    <td class="auto-style1">
                        
                    </td>
                </tr-->

                <tr>
                    <td class="auto-style1">
                        <asp:label id="lblCarNumber" runat="server" font-names="Arial" font-size="Large" text="מספר רכב"></asp:label>
                    </td>
                    <td class="auto-style2">

                        <asp:TextBox ID="txtCarNumber" runat="server" Font-Names="Arial" Font-Size="Large" Width="200px" MaxLength="7" OnTextChanged="txtCarNumber_TextChanged"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="rfvCarNum" runat="server" ControlToValidate="txtCarNumber" Display="Dynamic" ErrorMessage="חובה לרשום מספר רכב" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revCarNum" runat="server" ErrorMessage="7 ספרות בלבד" ControlToValidate="txtCarNumber" Display="Dynamic" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" ValidationExpression="^\d{7}$"></asp:RegularExpressionValidator>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="lblManufacturer" runat="server" Font-Names="Arial" Font-Size="Large" Text="יצרן"></asp:Label>
                    </td>
                    <td class="auto-style2">

                        <asp:DropDownList ID="ddlManufacturer" runat="server" Font-Names="Arial" Font-Size="Large" Width="200px" DataTextField="Name" DataValueField="Name" OnSelectedIndexChanged="ddlManufacturer_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator ID="rfvManufacturer" runat="server" ControlToValidate="ddlManufacturer" Display="Dynamic" ErrorMessage="חובה לבחור יצרן" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" InitialValue="-1"></asp:RequiredFieldValidator>

                    </td>
                </tr>

                <tr>
                    <td class="auto-style3">
                        <asp:Label ID="lblLine" runat="server" Font-Names="Arial" Font-Size="Large" Text="דגם"></asp:Label>
                    </td>
                    <td class="auto-style4">
                        <asp:DropDownList ID="ddlLine" runat="server" Font-Names="Arial" Font-Size="Large" Width="200px" DataTextField="Line" DataValueField="Line" AutoPostBack="True" OnSelectedIndexChanged="ddlLine_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvLine" runat="server" ControlToValidate="ddlLine" Display="Dynamic" ErrorMessage="חובה לבחור דגם" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" InitialValue="-1"></asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="lblCompany" runat="server" Font-Names="Arial" Font-Size="Large" Text="סוכנות ליסינג"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:DropDownList ID="ddlCompany" runat="server" Font-Names="Arial" Font-Size="Large" Width="200px" AutoPostBack="True" DataTextField="Name" DataValueField="Name" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvCompany" runat="server" ControlToValidate="ddlCompany" Display="Dynamic" ErrorMessage="חובה לבחור סוכנות ליסינג" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" InitialValue="-1"></asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="lblCompanyLine" runat="server" Font-Names="Arial" Font-Size="Large" Text="סניף"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:DropDownList ID="ddlCompanySite" runat="server" Font-Names="Arial" Font-Size="Large" Width="200px" AutoPostBack="True" DataTextField="CitySite" DataValueField="CitySite">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvCompanySite" runat="server" ControlToValidate="ddlCompanySite" Display="Dynamic" ErrorMessage="חובה לבחור סניף" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" InitialValue="-1"></asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="lblYear" runat="server" Font-Names="Arial" Font-Size="Large" Text="שנה"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:DropDownList ID="ddlyear" runat="server" Font-Names="Arial" Font-Size="Large" Width="200px">
                        </asp:DropDownList>
                        &nbsp;
                        <asp:RequiredFieldValidator ID="rfvYear" runat="server" ControlToValidate="ddlyear" Display="Dynamic" ErrorMessage="חובה לרשום שנה" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" InitialValue="-1"></asp:RequiredFieldValidator>
                        
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="lblColor" runat="server" Font-Names="Arial" Font-Size="Large" Text="צבע"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtColor" runat="server" Font-Names="Arial" Font-Size="Large" Width="200px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvColor" runat="server" ControlToValidate="txtColor" Display="Dynamic" ErrorMessage="חובה לרשום צבע" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red"></asp:RequiredFieldValidator>
                        
                    &nbsp;<asp:RegularExpressionValidator ID="revColor" runat="server" ControlToValidate="txtColor" Display="Dynamic" ErrorMessage="עברית בלבד" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" ValidationExpression="^[א-ת\s]*$"></asp:RegularExpressionValidator>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="lblGroup" runat="server" Font-Names="Arial" Font-Size="Large" Text="קבוצה"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:DropDownList ID="ddlGroup" runat="server" Font-Names="Arial" Font-Size="Large" Width="200px" AutoPostBack="True">
                            <asp:ListItem>קטנות</asp:ListItem>
                            <asp:ListItem>משפחתי</asp:ListItem>
                            <asp:ListItem>מנהלים</asp:ListItem>
                            <asp:ListItem>מיניוואן</asp:ListItem>
                            <asp:ListItem>ג&#39;יפ</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvGroup" runat="server" ControlToValidate="ddlGroup" Display="Dynamic" ErrorMessage="חובה לבחור קבוצה" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" InitialValue="-1"></asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="lblFuel" runat="server" Font-Names="Arial" Font-Size="Large" Text="סוג דלק"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:DropDownList ID="ddlFuel" runat="server" Font-Names="Arial" Font-Size="Large" Width="200px" AutoPostBack="True">
                            <asp:ListItem>בנזין</asp:ListItem>
                            <asp:ListItem>דיזל</asp:ListItem>
                            <asp:ListItem>היברידית</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvFuel" runat="server" ControlToValidate="ddlFuel" Display="Dynamic" ErrorMessage="חובה לבחור סוג דלק" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" InitialValue="-1"></asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="lblEngine" runat="server" Font-Names="Arial" Font-Size="Large" Text="נפח מנוע"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtEngine" runat="server" Font-Names="Arial" Font-Size="Large" Width="200px" MaxLength="4"></asp:TextBox>
                        <asp:CompareValidator ID="CompareValidatorEngine" runat="server" ControlToValidate="txtEngine" Display="Dynamic" ErrorMessage="מספר בלבד" Font-Bold="True" Font-Names="arial" Font-Size="Large" ForeColor="Red" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
&nbsp;<asp:RequiredFieldValidator ID="rfvEngine" runat="server" ControlToValidate="txtEngine" Display="Dynamic" ErrorMessage="חובה לרשום נפח מנוע" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red"></asp:RequiredFieldValidator>
                    &nbsp;<asp:RangeValidator ID="RangeValidatorEngine" runat="server" ControlToValidate="txtEngine" Display="Dynamic" ErrorMessage="נפח מנוע בין 900 - 3000" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" MaximumValue="3000" MinimumValue="900" Type="Integer"></asp:RangeValidator>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="lblGear" runat="server" Font-Names="Arial" Font-Size="Large" Text="תיבת הילוכים"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:DropDownList ID="ddlGearBox" runat="server" Font-Names="Arial" Font-Size="Large" Width="200px" AutoPostBack="True">
                            <asp:ListItem>אוטמטי</asp:ListItem>
                            <asp:ListItem>ידני</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvGearBox" runat="server" ControlToValidate="ddlGearBox" Display="Dynamic" ErrorMessage="חובה לבחור תיבת הילוכים" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" InitialValue="-1"></asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="lblNumKM" runat="server" Font-Names="Arial" Font-Size="Large" Text="קילומטר"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtNumKM" runat="server" Font-Names="Arial" Font-Size="Large" Width="200px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNumKM" runat="server" ControlToValidate="txtNumKM" Display="Dynamic" ErrorMessage="חובה לרשום מספר ק&quot;מ" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red"></asp:RequiredFieldValidator>
                    &nbsp;<asp:RangeValidator ID="RangeValidatorKM" runat="server" ControlToValidate="txtNumKM" Display="Dynamic" ErrorMessage="מספר ק&quot;מ בין 0-300000" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" MaximumValue="300000" MinimumValue="0" Type="Integer"></asp:RangeValidator>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="lblPrice" runat="server" Font-Names="Arial" Font-Size="Large" Text="מחיר"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtPrice" runat="server" Font-Names="Arial" Font-Size="Large" Width="200px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice" Display="Dynamic" ErrorMessage="חובה לרשום מחיר" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red"></asp:RequiredFieldValidator>
&nbsp;<asp:CompareValidator ID="CompareValidatorPrice" runat="server" ControlToValidate="txtPrice" Display="Dynamic" ErrorMessage="מחיר שלם וגדול מאפס" Font-Bold="True" Font-Names="ARIAL" Font-Size="Large" ForeColor="Red" Operator="GreaterThan" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="lblCarPic" runat="server" Font-Names="Arial" Font-Size="Large" Text="תמונה"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:FileUpload ID="FileUploadImage" runat="server" Font-Names="Arial" Font-Size="Large" />
                        <asp:RegularExpressionValidator ID="revCarPic" runat="server" ControlToValidate="FileUploadImage" Display="Dynamic" ErrorMessage="רק קבצי .jpg .jpeg .gif .png" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.gif|.jpeg)$"></asp:RegularExpressionValidator>
&nbsp;<asp:RequiredFieldValidator ID="rfvCarPic" runat="server" ControlToValidate="FileUploadImage" Display="Dynamic" ErrorMessage="RequiredFieldValidator" Font-Bold="True" Font-Names="Arial" Font-Size="Large" ForeColor="Red">חובה לצרף תמונה</asp:RequiredFieldValidator>
                    </td>
                </tr>

            </table>
            <asp:Label ID="lblMessage" runat="server" Text="" Font-Bold="true" Font-Names="Arial" Font-Size ="Large"></asp:Label>
           <br />
                <table id="tblButtons" dir="rtl" lang="he">
                        <tr>
                            <td><asp:Button ID="btnAddCar" runat="server" Text="הוספה" class="btn btn-success btn-md" OnClientClick="return confirm('האם להוסיף את הרכב?')" OnClick="btnAddManufacturer_Click"/></td>
                            <td></td><td></td>
                            <td><asp:Button ID="btnUpdateCar" runat="server" Text="עדכון" class="btn btn-info btn-md" OnClientClick="return confirm('האם לעדכן את פרטי הרכב?')" OnClick="btnUpdateCar_Click"/></td>
                            <td></td><td></td>
                            <td><asp:Button ID="btnDeleteCar" runat="server" Text="מחיקה" class="btn btn-danger btn-md" OnClientClick="return confirm('האם למחוק את הרכב?')" OnClick="btnDeleteCar_Click"/></td>
                            <td></td><td></td><td></td>
                            <td><asp:Button ID="btnClearForm" runat="server" class="btn btn-md" Text="בטל"  OnClientClick="return confirm('האם לבטל?')" OnClick="btnClearForm_Click" CausesValidation="False"/></td>
                    </tr>
                </table>
            </div><!-- End div col-sm-3 -->

            <div class="col-sm-9 col-md-6 col-lg-8">
                <asp:HiddenField ID="hdnPic" runat="server" />
                <asp:HiddenField ID="hdnCarNumber" runat="server" />
                
                <asp:Panel ID="pnlSearch" runat="server" Direction="RightToLeft" Font-Names="arial" style="margin-bottom:10px; background-color:aquamarine;width:508px;height:70px">
                    <table>
                        <tr><td><b>חיפוש</b></td></tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtCarSearch" runat="server" MaxLength="7"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Button ID="btnSearch" runat="server" CausesValidation="false" Text="חפש" class="btn-primary" OnClick="btnSearch_Click"/>
                            </td>
                            <td>
                                <asp:Button ID="btnClear" runat="server" CausesValidation="false" Text="נקה" ForeColor="White" style="background-color:darkgray;" OnClick="btnClear_Click" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="pnlCarAll" runat="server">
                     <asp:Gridview runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="serialNumber,CarPic" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" ID="gvCars" OnSelectedIndexChanged="Unnamed1_SelectedIndexChanged" PageSize="5" OnPreRender="gvCars_PreRender">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                         <PagerSettings mode="NumericFirstLast" FirstPageText="ראשון"  LastPageText="אחרון"/>
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" SelectText="בחר" >
                            <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:CommandField>
                            <asp:BoundField DataField="serialNumber" HeaderText="מספר רכב" ReadOnly="True" SortExpression="serialNumber" >
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="manufacturer_Name_Line" HeaderText="יצרן" SortExpression="manufacturer_Name_Line" >
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LineName" HeaderText="דגם" SortExpression="LineName" >
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DealershipName" HeaderText="סוכנות ליסינג" SortExpression="DealershipName" >
                            <HeaderStyle Font-Names="Arial" />
                            <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DealershipNameSite" HeaderText="סניף" SortExpression="DealershipNameSite" >
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Year" HeaderText="שנה" SortExpression="Year" >
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Color" HeaderText="צבע" SortExpression="Color" >
                            <FooterStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Class" HeaderText="קבוצה" SortExpression="Class" />
                            <asp:BoundField DataField="Fuel" HeaderText="מנוע" SortExpression="Fuel" >
                            <FooterStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Engine" HeaderText="נפח" SortExpression="Engine" >
                            <FooterStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Gearbox" HeaderText="הילוכים" SortExpression="Gearbox" >
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NumOfKM" HeaderText="ק&quot;מ" SortExpression="NumOfKM">
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Price" HeaderText="מחיר" SortExpression="Price"   HtmlEncode="false" ItemStyle-HorizontalAlign="Right">
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="תמונה">
                                <ItemTemplate>
                                    <asp:Image ID="imgCar" runat="server" Height="100px" Width="100px" ImageUrl='<%# Eval("CarPic") %>' />
                                </ItemTemplate>
                                <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="CarPic" HeaderText="CarPic" ReadOnly="True" SortExpression="CarPic" Visible="false" />
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
                    </asp:Gridview>
                    <asp:Label ID="lblPage" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Larger" ForeColor="#284775"></asp:Label>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CarsConnectionString %>" SelectCommand="SELECT * FROM [Cars]"></asp:SqlDataSource>
                </asp:Panel>

                <asp:Panel ID="pnlCarFilter" runat="server">
                    <asp:GridView ID="gvCarFilter" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="serialNumber,CarPic" DataSourceID="SqlDataSourceFilter" ForeColor="#333333" GridLines="None" EmptyDataText="אין תוצאות" OnSelectedIndexChanged="gvCarFilter_SelectedIndexChanged">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" SelectText="בחר" >
                            <HeaderStyle Font-Bold="True" Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:CommandField>
                            <asp:BoundField DataField="serialNumber" HeaderText="מספר רכב" ReadOnly="True" SortExpression="serialNumber" >
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="manufacturer_Name_Line" HeaderText="יצרן" SortExpression="manufacturer_Name_Line" >
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LineName" HeaderText="דגם" SortExpression="LineName" >
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DealershipName" HeaderText="סוכנות ליסינג" SortExpression="DealershipName" >
                            <HeaderStyle Font-Names="Arial" />
                            <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DealershipNameSite" HeaderText="סניף" SortExpression="DealershipNameSite" >
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Year" HeaderText="שנה" SortExpression="Year" >
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Color" HeaderText="צבע" SortExpression="Color" >
                            <FooterStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Class" HeaderText="קבוצה" SortExpression="Class" />
                            <asp:BoundField DataField="Fuel" HeaderText="מנוע" SortExpression="Fuel" >
                            <FooterStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Engine" HeaderText="נפח" SortExpression="Engine" >
                            <FooterStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Gearbox" HeaderText="הילוכים" SortExpression="Gearbox" >
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NumOfKM" HeaderText="ק&quot;מ" SortExpression="NumOfKM">
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Price" HeaderText="מחיר" SortExpression="Price"   HtmlEncode="false" ItemStyle-HorizontalAlign="Right">
                            <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            <ItemStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="תמונה">
                                <ItemTemplate>
                                    <asp:Image ID="imgCar" runat="server" Height="100px" Width="100px" ImageUrl='<%# Eval("CarPic") %>' />
                                </ItemTemplate>
                                <HeaderStyle Font-Names="Arial" HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="CarPic" HeaderText="CarPic" ReadOnly="True" SortExpression="CarPic" Visible="false" />
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
                    <asp:SqlDataSource ID="SqlDataSourceFilter" runat="server" ConnectionString="<%$ ConnectionStrings:CarsConnectionString %>" SelectCommand="SearchCarNumber" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtCarSearch" Name="carnumber" PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </asp:Panel> 
            </div><!-- end div col-sm-9 -->
        </div>
    </div>


</asp:Content>
