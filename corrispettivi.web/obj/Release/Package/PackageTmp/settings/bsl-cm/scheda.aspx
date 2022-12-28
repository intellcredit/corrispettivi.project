<%@ Page Title="" Language="C#" MasterPageFile="~/settings/bsl-cm/local.master" AutoEventWireup="true" CodeBehind="scheda.aspx.cs" Inherits="corrispettivi.web.settings.bsl_cm.scheda" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">
    
</asp:Content>
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

                var ore = document.getElementById('<%=cmbOreContratto.ClientID%>').value;
                if (ore == "")
                    msg = msg.concat("- Ore. Selezionare le ore giornaliere\n");

                var oreMensCtr = document.getElementById('<%=txtOreMensCtr.ClientID%>').value;
                var oreMensMax = document.getElementById('<%=txtOreMensMax.ClientID%>').value;
                
                if (oreMensMax == "0")
                    msg = msg.concat("- Ore. Inserire il numero di ore massimo mensile (ore contratto + ore straordinarie)\n");

                if (parseInt(oreMensMax) < parseInt(oreMensCtr))
                    msg = msg.concat("- Ore. Verificare il numero di ore massimo mensile.\n  Non possono essere inferiori al numero di ore mensili previste da contratto\n");

                var impMinMens = document.getElementById('<%=txtImpMinMensile.ClientID%>').value;
                if (impMinMens == "0,00")
                    msg = msg.concat("- Compenso. Verificare l`importo minimo mensile\n");

                var impOrario = document.getElementById('<%=txtImpOrario.ClientID%>').value;
                if (impOrario == "0,00")
                    msg = msg.concat("- Compenso. Verificare l`importo orario\n");

                var impPenOra = document.getElementById('<%=txtImpPenaleOraria.ClientID%>').value;
                if (impPenOra == "0,00")
                    msg = msg.concat("- Compenso. Verificare l`importo penale oraria\n");

                var y = document.getElementById('<%=cmbAnnoInizio.ClientID%>').value;
                var m = document.getElementById('<%=cmbMeseInizio.ClientID%>').value;
                var dtInizio = new Date(y, m - 1, 1);
                //alert(dtInizio.format("yyyy-MM-dd"));

                y = document.getElementById('<%=cmbAnnoFine.ClientID%>').value;              
                m = document.getElementById('<%=cmbMeseFine.ClientID%>').value;
                var dtFine = new Date(y, m, 0);
                //alert(dtFine.format("yyyy-MM-dd"));

                if (dtInizio.format("yyyy-MM-dd") == "1899-12-01")
                    msg = msg.concat("- Periodo di validità. Selezionare una data di inizio\n");
                if ((dtInizio.format("yyyy-MM-dd") != "1899-12-01") && (dtFine.format("yyyy-MM-dd") != "1899-12-31") && (dtInizio > dtFine))
                    msg = msg.concat("- Periodo di validità. Selezionare una data fine maggiore di data inizio\n");

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
            <td align="right" width="100px"><b>contratto</b></td>
            <td align="right" width="120px">tipo retribuzione:</td>
            <td colspan="8"><telerik:RadComboBox ID="cmbTipoRetribuzione" runat="server" Width="300px" EmptyMessage="selezionare un valore" DataSourceID="sdsTipiRetribuzione" DataTextField="Descrizione" Filter="Contains" DataValueField="TipoRetribuzioneID" DropDownWidth="300px" /></td>
        </tr>

        <tr><td colspan="10"><hr /></td></tr>
        <tr>
            <td align="right" width="100px"><b>ore</b></td>
            <td align="right" width="120px">giornaliere:</td>
            <td width="100px"><telerik:RadComboBox ID="cmbOreContratto" runat="server" Width="100px" EmptyMessage="selezionare..." onselectedindexchanged="cmbOreContratto_SelectedIndexChanged" AutoPostBack="true">
                <Items>
                    <telerik:RadComboBoxItem Value="2" Text="2 ore" />
                    <telerik:RadComboBoxItem Value="4" Text="4 ore" />
                    <telerik:RadComboBoxItem Value="6" Text="6 ore" />
                    <telerik:RadComboBoxItem Value="8" Text="8 ore" />
                </Items>
            </telerik:RadComboBox></td>
            <td align="right" width="50px">mensili:</td>
            <td><telerik:RadNumericTextBox ID="txtOreMensCtr" runat="server" MinValue="0" Value="0" NumberFormat-DecimalDigits="0" Width="50px" Enabled="false" BackColor="#e6e6e6" Font-Bold="true" /></td>
            <td align="right" width="150px">massimo mensile:</td>
            <td><telerik:RadNumericTextBox ID="txtOreMensMax" runat="server" MinValue="0" Value="0" NumberFormat-DecimalDigits="0" Width="50px" /></td>
            <td align="right" width="100px">franchigia:</td>
            <td><telerik:RadNumericTextBox ID="txtOreMensFranchigia" runat="server" MinValue="0" Value="0" NumberFormat-DecimalDigits="0" Width="50px" /></td>
        </tr>


        <tr><td colspan="10"><hr /></td></tr>
        <tr valign="top">
            <td align="right"><b>compenso</b></td>
            <td colspan="6">
                <table border="0" cellpadding="2" cellspacing="2" width="100%">
                    <tr>
                        <td align="right" width="120px">min.mensile:</td>
                        <td><telerik:RadNumericTextBox ID="txtImpMinMensile" runat="server" MinValue="0" Value="0" NumberFormat-DecimalDigits="2" Width="75px" /></td>
                        <td align="right" width="100px">orario:</td>
                        <td><telerik:RadNumericTextBox ID="txtImpOrario" runat="server" MinValue="0" Value="0" NumberFormat-DecimalDigits="2" Width="75px" /></td>
                        <td align="right" width="100px">penale oraria:</td>
                        <td><telerik:RadNumericTextBox ID="txtImpPenaleOraria" runat="server" MinValue="0" Value="0" NumberFormat-DecimalDigits="2" Width="75px" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr><td colspan="10"><hr /></td></tr>
        <tr valign="top">
            <td valign="top" align="right" rowspan="2"><b>periodo<br />di validità</b></td> 
            <td align="right" nowrap>data inizio:</td>
            <td><telerik:RadComboBox ID="cmbAnnoInizio" runat="server" Width="100px" EmptyMessage="seleziona...">
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
            <td ><telerik:RadComboBox ID="cmbMeseInizio" runat="server" Width="100px" EmptyMessage="seleziona...">
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
        <tr valign="top">
            <td align="right">data fine:</td>
            <td><telerik:RadComboBox ID="cmbAnnoFine" runat="server" Width="100px" EmptyMessage="seleziona...">
                <Items>
                    <telerik:RadComboBoxItem Value="" Text="" />
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
            <td><telerik:RadComboBox ID="cmbMeseFine" runat="server" Width="100px" EmptyMessage="seleziona...">
                <Items>
                    <telerik:RadComboBoxItem Value="" Text="" />
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
        <tr><td colspan="10"><hr /></td></tr>
        <tr valign="top">
            <td align="right"><b>note:</b></td>
            <td colspan="10"><asp:TextBox ID="txtNote" runat="server" Width="550px" TextMode="MultiLine" Rows="10" Text="" /></td>
        </tr>
    </table>

    <asp:SqlDataSource ID="sdsTipiRetribuzione" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="sdsTipiRetribuzione" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

</asp:Content>