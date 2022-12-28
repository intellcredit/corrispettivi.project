<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="legendStatusTabulato.ascx.cs" Inherits="corrispettivi.web.legendStatusTabulato" %>
<br /><br />
<table border="0" cellpadding="2" cellspacing="2" width="100%">
    <tr>
        <td align="center">
            <table border="0" cellpadding="1" cellspacing="1" style="font-weight:bold">
                <tr id="legend" runat="server">
                    <td>LEGGENDA STATO TABULATO:</td>
                    <td width="120px" align="center"><asp:label ID="lbl0" runat="server" Text="Non disponibile" Width="100%" /></td>    
                    <td width="120px" align="center"><asp:label ID="lbl1" runat="server" Text="Provvisorio" Width="100%" /></td>    
                    <td width="120px" align="center"><asp:label ID="lbl2" runat="server" Text="In approvazione" Width="100%" /></td>    
                    <td width="120px" align="center"><asp:label ID="lbl3" runat="server" Text="Pubblicato" Width="100%" /></td>    
                    <td width="120px" align="center"><asp:label ID="lbl4" runat="server" Text="Chiuso" Width="100%" /></td>
                </tr>
            </table>
        </td>
    </tr>
</table>