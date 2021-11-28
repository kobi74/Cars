<%@ Page Title="" Language="C#" MasterPageFile="~/BackendMasterPage.Master" AutoEventWireup="true" CodeBehind="OLDCars.aspx.cs" Inherits="Cars.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    רכבים
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
        <style type="text/css">
        .auto-style1 {
            width: 129px;
        }
        .auto-style2 {
            width: 503px;
        }
        .auto-style3 {
            width: 129px;
            height: 29px;
        }
        .auto-style4 {
            width: 503px;
            height: 29px;
        }
        .auto-style5 {
            height: 475px;
            width: 527px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentBody" runat="server">
    <br />
    <div id="row">
        <div class="col-sm-4">
            <asp:Label ID="lblCarsHeader" runat="server" class="bg-dark text-white text-center" Text="רכבים" Width="300px" Font-Names="Arial" ></asp:Label>
            <table id="tblCars" class="auto-style5">
                <!--tr>
                    <td class="auto-style1">
                        
                    </td>
                </tr-->

                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="lblCarNumber" runat="server" Font-Names="Arial" Font-Size="Large" Text="מספר רכב"></asp:Label>
                    </td>
                    <td class="auto-style2">

                        <asp:TextBox ID="txtCarNumber" runat="server" Font-Names="Arial" Font-Size="Large" Width="200px" MaxLength="7" AutoPostBack="True" OnTextChanged="txtCarNumber_TextChanged"></asp:TextBox>

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
                            <asp:ListItem>דלק</asp:ListItem>
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
          <br />
          <table id="tblButtons">
              <tr>
                <td><asp:Button ID="btnAddManufacturer" runat="server" Text="הוספה" class="btn btn-success btn-md" OnClick="btnAddManufacturer_Click"/></td>
                <td></td><td></td>
                <td><asp:Button ID="btnUpdateManufacturer" runat="server" Text="עדכון" class="btn btn-info btn-md"/></td>
                <td></td><td></td>
              <td><asp:Button ID="btnDeleteManufacturer" runat="server" Text="מחיקה" class="btn btn-danger btn-md"/></td>
              </tr>
          </table>
        </div><!-- end div class="col-sm-4"-->
        <div class="col-sm-8">
            hello
        </div><!-- end div class="col-sm-8"-->
    </div>
</asp:Content>
