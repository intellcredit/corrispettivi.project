<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="infoAgente.ascx.cs" Inherits="corrispettivi.web.tabulati.agenti.infoAgente" %>
<table border="0" cellpadding="2" cellspacing="2" width="100%">
    <tr bgcolor="white">
        <td id="colPeriodo" runat="server" nowrap><font class="titnero10">Periodo:</font> <asp:Label ID="lblPeriodo" runat="server" Text="" CssClass="titrosso12" /></td>
        <td id="colOre" runat="server" nowrap><font class="titnero10">Ore ctr:</font> <asp:Label ID="lblOreContratto" runat="server" Text="" CssClass="titrosso12" /></td>
        <td id="colGroupID" runat="server" nowrap><font class="titnero10">Codice raggruppamento:</font> <asp:Label ID="lblAgenteGroupID" runat="server" Text="" CssClass="titrosso12" /></td>
        <td id="colGroupName" runat="server" width="100%"><font class="titnero10">Nome:</font> <asp:Label ID="lblAgenteGroupNome" runat="server" Text="" CssClass="titrosso12" /></td>
        <td nowrap><asp:HyperLink ID="hlBack" runat="server" CssClass="titnero10" NavigateUrl="javascript:window.history.back();">TORNA AL REPORT</asp:HyperLink></td>
    </tr>
</table>