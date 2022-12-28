<%@ Page Title="" Language="C#" MasterPageFile="~/tabulati/agenti/be/local.master" AutoEventWireup="true" CodeBehind="scheda.aspx.cs" Inherits="corrispettivi.web.tabulati.agenti.be.scheda" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <script type="text/javascript">
        function daysInMonth(month, year) {
            return new Date(year, month, 0).getDate();
        }

        function onToolBarClientButtonClicking(sender, args) {
            var button = args.get_item();

            var msg = "";

            //SAVE
            if ((button.get_commandName() == "SaveSelected") || (button.get_commandName() == "SaveCloseSelected")) {

                var ageid = document.getElementById('<%=cmbAgenteGroupID.ClientID%>').value;
                if (ageid == "")
                    msg = msg.concat("- Selezionare l`agente\n");

                var comp = document.getElementById('<%=txtCompenso.ClientID%>').value;
                if (comp == "0,00")
                    msg = msg.concat("- Verificare l`importo del compenso\n");

                var anno = document.getElementById('<%=cmbAnnoRif.ClientID%>').value;
                if (anno == "")
                    msg = msg.concat("- Selezionare l`anno\n");

                var mese = document.getElementById('<%=cmbMeseRif.ClientID%>').value;
                if (mese == "")
                    msg = msg.concat("- Selezionare il mese\n");

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
            <td align="right"><b>agente</b></td>
            <td align="right" width="100px">nominativo:</td>
            <td colspan="3"><telerik:RadComboBox ID="cmbAgenteGroupID" runat="server" DataSourceID="sdsAgenti" DataTextField="AgenteGroupAlias" Filter="Contains"
                DataValueField="AgenteGroupID" Height="200px" Width="700px" DropDownWidth="700px" AppendDataBoundItems="true" EmptyMessage="selezionare un valore" /></td>
        </tr>
        <tr><td colspan="5"><hr /></td></tr>
        <tr valign="top">
            <td align="right"><b>importo</b></td>
            <td align="right">riconosciuto:</td>
            <td colspan="3"><telerik:RadNumericTextBox ID="txtCompenso" runat="server" Value="0" NumberFormat-DecimalDigits="2" Width="75px" /></td>
        </tr>
        <tr><td colspan="5"><hr /></td></tr>
        <tr valign="top">
            <td align="right"><b>tipo costo:</b></td>
            <td align="right">attività recupero</td>
            <td colspan="3"><asp:CheckBox ID="chkAttivitaRecupero" runat="server" Checked=true /></td>
        </tr>
        <tr><td colspan="5"><hr /></td></tr>
        <tr valign="top">
            <td valign="top" align="right"><b>periodo<br />riferimento</b></td> 
            <td align="right" nowrap>anno:</td>
            <td><telerik:RadComboBox ID="cmbAnnoRif" runat="server" Width="150px" EmptyMessage="selezionare un valore">
                <Items>
                    <telerik:RadComboBoxItem Value="2016" Text="2016" />
                    <telerik:RadComboBoxItem Value="2017" Text="2017" />
                    <telerik:RadComboBoxItem Value="2018" Text="2018" />
                    <telerik:RadComboBoxItem Value="2019" Text="2019" />
                    <telerik:RadComboBoxItem Value="2020" Text="2020" />
                    <telerik:RadComboBoxItem Value="2021" Text="2021" />
                    <telerik:RadComboBoxItem Value="2022" Text="2022" />
                    <telerik:RadComboBoxItem Value="2023" Text="2023" />
                    <telerik:RadComboBoxItem Value="2024" Text="2024" />
                    <telerik:RadComboBoxItem Value="2025" Text="2025" />
                    <telerik:RadComboBoxItem Value="2026" Text="2026" />
                    <telerik:RadComboBoxItem Value="2027" Text="2027" />
                    <telerik:RadComboBoxItem Value="2028" Text="2028" />
                    <telerik:RadComboBoxItem Value="2029" Text="2029" />
                    <telerik:RadComboBoxItem Value="2030" Text="2030" />
                    <telerik:RadComboBoxItem Value="2031" Text="2031" />
                    <telerik:RadComboBoxItem Value="2032" Text="2032" />
                    <telerik:RadComboBoxItem Value="2033" Text="2033" />
                    <telerik:RadComboBoxItem Value="2034" Text="2034" />
                    <telerik:RadComboBoxItem Value="2035" Text="2035" />
                    <telerik:RadComboBoxItem Value="2036" Text="2036" />
                    <telerik:RadComboBoxItem Value="2037" Text="2037" />
                    <telerik:RadComboBoxItem Value="2038" Text="2038" />
                    <telerik:RadComboBoxItem Value="2039" Text="2039" />
                    <telerik:RadComboBoxItem Value="2040" Text="2040" />
                </Items>
            </telerik:RadComboBox></td>
            <td align="right" nowrap>mese:</td>
            <td width="75%"><telerik:RadComboBox ID="cmbMeseRif" runat="server" Width="150px" EmptyMessage="selezionare un valore">
                <Items>
                    <telerik:RadComboBoxItem Value="1"  Text="01" />
                    <telerik:RadComboBoxItem Value="2"  Text="02" />
                    <telerik:RadComboBoxItem Value="3"  Text="03" />
                    <telerik:RadComboBoxItem Value="4"  Text="04" />
                    <telerik:RadComboBoxItem Value="5"  Text="05" />
                    <telerik:RadComboBoxItem Value="6"  Text="06" />
                    <telerik:RadComboBoxItem Value="7"  Text="07" />
                    <telerik:RadComboBoxItem Value="8"  Text="08" />
                    <telerik:RadComboBoxItem Value="9"  Text="09" />
                    <telerik:RadComboBoxItem Value="10" Text="10" />
                    <telerik:RadComboBoxItem Value="11" Text="11" />
                    <telerik:RadComboBoxItem Value="12" Text="12" />
                </Items>
            </telerik:RadComboBox></td>
        </tr>
        <tr><td colspan="5"><hr /></td></tr>
        <tr valign="top">
            <td align="right"><b>note:</b></td>
            <td></td>
            <td colspan="3"><asp:TextBox ID="txtNote" runat="server" Width="550px" TextMode="MultiLine" Rows="10" Text="" /></td>
        </tr>
        <tr><td colspan="5"><hr /></td></tr>
        <tr>
            <td align="right"><b>status</b></td>
            <td align="right"></td>
            <td colspan="3"><telerik:RadComboBox ID="cmbStatusID" runat="server" DataSourceID="sdsStatus" DataTextField="Descrizione" Filter="Contains"
                DataValueField="StatusID" Height="200px" Width="700px" DropDownWidth="700px" Enabled="false" /></td>
        </tr>
    </table>

    <asp:SqlDataSource ID="sdsAgenti" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>" 
        SelectCommand="select distinct AgenteGroupID, Nominativo as AgenteGroupNome, concat(Nominativo, ' (',AgenteGroupID,')') as AgenteGroupAlias 
            from Agenti A inner join AgentiSocieta [AS] on A.AgenteGroupID = [AS].COD_RAGG
            inner join paramCallCenter PCC on [AS].ID_CALLCENTER = PCC.CallCenterID order by AgenteGroupNome" />       

    <asp:SqlDataSource ID="sdsStatus" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>" 
            SelectCommand="select StatusID, Descrizione from Status order by StatusID" />       

</asp:Content>