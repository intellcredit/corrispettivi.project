<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="legendStatusFattura.ascx.cs" Inherits="corrispettivi.web.legendStatusFattura" %>
<br /><br />
<table border="0" cellpadding="2" cellspacing="2" width="100%">
    <tr>
        <td align="center">
            <table border="0" cellpadding="1" cellspacing="1" style="font-weight:bold">
                <tr id="legend" runat="server">
                    <td>LEGGENDA STATO FATTURAZIONE:</td>
                    <td width="200px" align="center"><asp:label ID="lbl0" runat="server" Text="Non deve emettere fattura" Width="100%" /></td>
                    <td width="120px" align="center"><asp:label ID="lbl1" runat="server" Text="Non fatturato" Width="100%" /></td>    
                    <td width="150px" align="center"><asp:label ID="lbl2" runat="server" Text="Parzialmente fatturato" Width="100%" /></td>
                    <td width="120px" align="center"><asp:label ID="lbl3" runat="server" Text="Fatturato" Width="100%" /></td>    
                </tr>
            </table>
        </td>
    </tr>
</table>