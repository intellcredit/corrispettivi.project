<%@ Page Title="" Language="C#" MasterPageFile="~/settings/bsl-cg/local.master" AutoEventWireup="true" CodeBehind="scheda.aspx.cs" Inherits="corrispettivi.web.settings.bsl_cg.scheda" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <script type="text/javascript">
        function onToolBarClientButtonClicking(sender, args) {
            var button = args.get_item();

            var msg = "";

            //SAVE
            if ((button.get_commandName() == "SaveSelected") || (button.get_commandName() == "SaveCloseSelected")) {

                var ore = document.getElementById('<%=cmbOreContratto.ClientID%>').value;
                if (ore == "")
                    msg = msg.concat("- Selezionare le ore previste da contratto\n");

                var cntMin = document.getElementById('<%=txtCntNumMin.ClientID%>').value;
                var cntMax = document.getElementById('<%=txtCntNumMax.ClientID%>').value;
                if (cntMin >= cntMax)
                    msg = msg.concat("- Verificare i valori impostati in contatti giornalieri\n");

                var comp = document.getElementById('<%=txtCompenso.ClientID%>').value;
                if (comp == "0,00")
                    msg = msg.concat("- Verificare l`importo del compenso\n");

                var dtInizio = document.getElementById('<%=txtDataInizio.ClientID%>').value;
                var dtFine = document.getElementById('<%=txtDataFine.ClientID%>').value;
                if (dtInizio == "")
                    msg = msg.concat("- Selezionare una data di inizio validità\n");
                if ((dtInizio != "") && (dtFine != "") && (dtInizio > dtFine))
                    msg = msg.concat("- Verificare i valori impostati in periodo validità\n");

                if (msg != "") {
                    alert(msg);
                    args.set_cancel("false");
                }
            }

            //DELETE
            if (button.get_commandName() == "DeleteSelected") {
                args.set_cancel(!confirm('Sicuro di voler eliminare questo elemento?'));
            }

            //CLOSE
            if (button.get_commandName() == "CloseSelected") {
                args.set_cancel(!confirm('Sicuro di voler uscire senza salvare?'));
            }
        }
    </script>
    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr><td align="right"><telerik:radtoolbar ID="tbAction" runat="server" Skin="Simple" onbuttonclick="tbAction_ButtonClick" OnClientButtonClicking="onToolBarClientButtonClicking">
            <Items>
                <telerik:RadToolBarButton Value="btnSave" Text="Salva" ToolTip="Salva dati e torna alla home" Font-Bold="true" ImageUrl="~/image/save.gif" CommandName="SaveSelected" />
                <telerik:RadToolBarButton Value="btnSaveClose" Text="Salva e chiudi" ToolTip="Salva dati e torna alla home" Font-Bold="true" ImageUrl="~/image/saveClose.gif" CommandName="SaveCloseSelected" />
                <telerik:RadToolBarButton Value="sepSave" IsSeparator="true" />
                <telerik:RadToolBarButton Value="btnDelete" Text="Elimina" ToolTip="Elimina configurazione" Font-Bold="true" ImageUrl="~/image/delete.png" CommandName="DeleteSelected" />
                <telerik:RadToolBarButton Value="sepDelete" IsSeparator="true" />
                <telerik:RadToolBarButton Value="btnClose" Text="Chiudi" ToolTip="Esci senza salvare" Font-Bold="true" ImageUrl="~/image/close.png" CommandName="CloseSelected" />
            </Items>
        </telerik:radtoolbar></td></tr>
        <tr bgcolor="white"><td><asp:Label ID="lblMessage" runat="server" Text="" /></td></tr>
    </table>
    <br />
    <table border="0" cellpadding="2" cellspacing="2">
        <tr>
            <td align="right"><b>contratto</b></td>
            <td align="right" width="65px">ore:</td>
            <td><telerik:RadComboBox ID="cmbOreContratto" runat="server" Width="700px" EmptyMessage="selezionare un valore">
                <Items>
                    <telerik:RadComboBoxItem Value="2" Text="2 ore" />
                    <telerik:RadComboBoxItem Value="4" Text="4 ore" />
                    <telerik:RadComboBoxItem Value="6" Text="6 ore" />
                    <telerik:RadComboBoxItem Value="8" Text="8 ore" />
                </Items>
            </telerik:RadComboBox></td>
        </tr>
        <tr><td colspan="3"><hr /></td></tr>
        <tr valign="top">
            <td align="right" rowspan="2"><b>contatti<br />giornalieri</b></td> 
            <td align="right" width="65px">minimo:</td>
            <td><telerik:RadNumericTextBox ID="txtCntNumMin" runat="server" MinValue="0" Maxvalue="999" Value="0" NumberFormat-DecimalDigits="0" Width="75px" /></td>
        </tr>
        <tr valign="top">
            <td align="right">massimo:</td>
            <td><telerik:RadNumericTextBox ID="txtCntNumMax" runat="server" MinValue="0" Maxvalue="999" Value="0" NumberFormat-DecimalDigits="0" Width="75px" /></td>
        </tr>
        <tr><td colspan="3"><hr /></td></tr>
        <tr valign="top">
            <td align="right"><b>compenso</b></td>
            <td align="right">importo:</td>
            <td><telerik:RadNumericTextBox ID="txtCompenso" runat="server" MinValue="0" Value="0" NumberFormat-DecimalDigits="2" Width="75px" /></td>
        </tr>
        <tr><td colspan="3"><hr /></td></tr>
        <tr valign="top">
            <td valign="top" align="right" rowspan="2"><b>periodo<br />di validità</b></td> 
            <td align="right">data inizio:</td>
            <td><telerik:RadDatePicker ID="txtDataInizio" runat="server" MinDate="01/01/2016" Width="100px" /></td>
        </tr>
        <tr valign="top">
            <td align="right">data fine:</td>
            <td><telerik:RadDatePicker ID="txtDataFine" runat="server" MinDate="01/01/2016" Width="100px" /></td>
        </tr>
        <tr><td colspan="3"><hr /></td></tr>
        <tr valign="top">
            <td align="right"><b>note:</b></td>
            <td colspan="2"><asp:TextBox ID="txtNote" runat="server" Width="550px" TextMode="MultiLine" Rows="10" Text="" /></td>
        </tr>
    </table>
</asp:Content>