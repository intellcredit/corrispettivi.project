<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="corrispettivi.web.login" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Corrispettivi - Login</title>
   
    <link rel="stylesheet" href="styles/login.css" media="screen" type="text/css" />
    <link rel="stylesheet" href="styles/font.css" media="screen" type="text/css" />
</head>
<body>
    <div class="login-card">
        <h1><b>Corrispettivi</b></h1><br>
        <form id="form1" runat="server">
            <span runat="server" id="spanLogin">
            <asp:TextBox runat="server" ID="txtUsername" placeholder="Username" />
            <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" placeholder="Password" />
            <asp:Button runat="server" ID="btnLogin" CssClass="login login-submit" Text="login" OnClick="btnLogin_Click" />    
            </span>
            <asp:Label runat="server" ID="lblMessage" />
            <asp:LinkButton runat="server" id="lnkForceLogOut" Visible="false" OnClick="lnkForceLogOut_Click">Clicca qui per scollegare l'utente</asp:LinkButton>
        </form>
    </div>
 </body>
</html>