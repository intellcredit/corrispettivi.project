<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="azioni.aspx.cs" Inherits="corrispettivi.web.azioni" %>
<asp:Content ID="Content1" ContentPlaceHolderID="masterHead" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="masterMain" Runat="Server">
    <h1><b>Azioni.</b></h1>
    <table border="0" cellpadding="0" cellspacing="0" bgcolor="black" width="100%" Height="30px">
        <tr><td></td></tr>
    </table>
    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblAction" runat="server" Text="" /></td></tr>
    </table>
    <table border="0" cellpadding="2" cellspacing="2">
        <tr>
            <td align="right"><asp:CheckBox ID="chkCorrispettivi" runat="server" Text="Corrispettivi" TextAlign="Left" /></td>
            <td></td>
        </tr>
        <tr>
            <td align="right"><asp:CheckBox ID="chkPremi" runat="server" Text="Premi" TextAlign="Left" /></td>
            <td colspan="2"></td>
        </tr>
        <tr>
            <td align="right"><asp:CheckBox ID="chkIntegrazioni" runat="server"  Text="Integrazioni" TextAlign="Left" /></td>
            <td colspan="2"></td>
        </tr>
        <tr>
            <td align="right"><asp:CheckBox ID="chkBonusContatti" runat="server" Text="Bonus contatti" TextAlign="Left" /></td>
            <td colspan="2"></td>
        </tr>
        <tr>
            <td align="right"><asp:CheckBox ID="chkBonusExtra" runat="server" Text="Bonus extra" TextAlign="Left" /></td>
            <td colspan="2"></td>
        </tr>
    </table>
</asp:Content>