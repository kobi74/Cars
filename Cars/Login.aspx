<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Cars.Login" %>

<!DOCTYPE html>

<html dir="rtl">
<head runat="server">
    <title>כניסה לעובדי CARS</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

    <style>
        #loginDiv{
            width:700px;
            height:500px;
            margin:0 auto;
        }

        #imgLogin{
            margin:0 auto;
            width:100px;
            height:100px;
        }

        #loginTitle{
             background-color:darkgray;
             margin-bottom:20px;
             border:1px solid black;
        }

        #loginForm{
            border:1px solid black;
            height:340px;
        }

        #btnSubmit{
            margin-bottom:10px;
            width:200px;
        }

        #footer{
            bottom: 0;
            position:fixed;
            width:100%;
            right:0;
        }
        #lblError{
            color:white;
            position:fixed;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="main" class="container-fluid">
            <div class="bg-dark text-white">
                <h1 class="display-3 font-weight-bold text-center"> לקנות רכב מליסינג Cars <span><a href="index.aspx"><img src="../images/car.png" class="img-thumbnail float-right" /></a></span> </h1>
            </div>
            <div id="loginDiv">
                <div id="loginTitle">
                    <center><h3>כניסה לעובדים</h3></center>
                </div>

               <center>
                   <div id="loginForm">
                       <div id="image" style="margin-top: 5px;">
                           <asp:Image ID="imgLogin" class="img-responsive" runat="server" ImageUrl="~/images/password.png"/>
                       </div> 
                        <br />
                        <asp:TextBox class="form-control" ID="txtUserName" required oninput="setCustomValidity('')" oninvalid="this.setCustomValidity('חובה לרשום שם משתמש')" placeholder="שם משתמש" runat="server" Width="200"></asp:TextBox>
                        <br />
                        <asp:TextBox class="form-control" ID="txtPassword" required oninput="setCustomValidity('')" oninvalid="this.setCustomValidity('חובה לרשום סיסמא')" placeholder="סיסמא" runat="server" TextMode="Password" Width="200"></asp:TextBox>
                        <br />
                        <asp:Button ID="btnSubmit" runat="server" Text="כניסה למערכת" class=" btn btn-primary" OnClick="btnSubmit_Click" />
                       <asp:Label ID="lblError" runat="server" CssClass="text-left bg-danger" Text="ssss"></asp:Label>
                       <br />
                       <table>
                           <tr>
                               <td>
                                   <a href="#" class="text-primary" onclick="return alert('פנה למנהל המערכת')">שכחתי סיסמא</a>
                               </td>

                               <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                               <td>
                                   <a class="text-primary" href="index.aspx">יציאה</a>
                               </td>
                           </tr>
                       </table>
                   </div>
              </center>
            </div>
          <footer id="footer" class="page-footer bg-dark blue" style="bottom: 0;position: fixed; width: 100%;">
          <!-- Copyright -->
               <div class="text-white footer-copyright text-center py-3">האתר נבנה ע"י:
                <a class="text-white" href="#"> קובי נבון</a>
              </div>
          <!-- Copyright -->
        </footer>
        </div>
    </form>
</body>
</html>
