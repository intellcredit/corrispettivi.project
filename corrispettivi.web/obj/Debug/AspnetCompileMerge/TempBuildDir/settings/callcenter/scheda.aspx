<%@ Page Title="" Language="C#" MasterPageFile="~/settings/callcenter/local.master" AutoEventWireup="true" CodeBehind="scheda.aspx.cs" Inherits="corrispettivi.web.settings.callcenter.scheda" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <style type="text/css">
        .rcbHeader ul, .rcbFooter ul, .rcbItem ul, .rcbHovered ul, .rcbDisabled ul
        {
	        width: 100%;
	        display: inline-block;
	        margin: 0;
	        padding: 0;
	        list-style-type: none;
        }
        
        .colCodice
        {
	        float: left;
	        width: 70px;
	        margin: 0;
	        padding: 0 2px 0 0;
	        line-height: 14px;
        }
        .colDenominazione
        {
	        float: left;
	        width: 590px;
	        margin: 0;
	        padding: 0 2px 0 0;
	        line-height: 14px;
        }
        
        .listCodice
        {
	        float: left;
	        text-align: right;
	        width: 50px;
	        margin: 0;
	        padding: 0 5px 0 0;
	        line-height: 14px;
	        display: inline;
        }
        .listDenominazione
        {
	        float: left;
	        width: 600px;
	        margin: 0;
	        padding: 0 0 0 5px;
	        line-height: 14px;
        }
    </style>
    <script type="text/javascript">
        function onToolBarClientButtonClicking(sender, args) {
            var button = args.get_item();

            var msg = "";

            //SAVE
            if ((button.get_commandName() == "SaveSelected") || (button.get_commandName() == "SaveCloseSelected")) {

                var cc = document.getElementById('<%=cmbCallCenter.ClientID%>').value;
                if (cc == "")
                    msg = msg.concat("- Selezionare il call center\n");

                var y = document.getElementById('<%=cmbAnnoInizio.ClientID%>').value;
                var m = document.getElementById('<%=cmbMeseInizio.ClientID%>').value;
                var dtInizio = new Date(y, m - 1, 1);
                //alert(dtInizio.format("yyyy-MM-dd"));

                y = document.getElementById('<%=cmbAnnoFine.ClientID%>').value;
                m = document.getElementById('<%=cmbMeseFine.ClientID%>').value;
                var dtFine = new Date(y, m, 0);
                //alert(dtFine.format("yyyy-MM-dd"));

                if (dtInizio.format("yyyy-MM-dd") == "1899-12-01")
                    msg = msg.concat("- Selezionare una data di inizio validità\n");
                if ((dtInizio.format("yyyy-MM-dd") != "1899-12-01") && (dtFine.format("yyyy-MM-dd") != "1899-12-31") && (dtInizio > dtFine))
                    msg = msg.concat("- Selezionare una data fine maggiore di data inizio\n");


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

    <table border="0" cellpadding="2" cellspacing="2" width="800px">
        <tr>
            <td align="right" width="100px"><b>callcenter</b></td>
            <td colspan="5"><telerik:RadComboBox ID="cmbCallCenter" runat="server" Width="500px" EmptyMessage="selezionare un valore" DataSourceID="sdsCallCenter" DataTextField="Nominativo" DataValueField="CallCenterID" Filter="Contains">
                <HeaderTemplate>
                    <ul>
                        <li class="colCodice"><b>Codice</b></li>
                        <li class="colDenominazione"><b>Nominativo</b></li>
                    </ul>
                </HeaderTemplate>
                <ItemTemplate>
                    <ul>
                        <li class="colCodice"><%# DataBinder.Eval(Container.DataItem, "CallCenterID") %></li>
                        <li class="colDenominazione"><%# DataBinder.Eval(Container.DataItem, "Nominativo")%></li>
                    </ul>
                </ItemTemplate>
            </telerik:RadComboBox></td>
        </tr>

        <tr><td colspan="6"><hr /></td></tr>

        <tr valign="top">
            <td valign="top" align="right" rowspan="2"><b>periodo<br />di validità</b></td> 
            <td align="right" nowrap width="100px">data inizio:</td>
            <td><telerik:RadComboBox ID="cmbAnnoInizio" runat="server" Width="150px" EmptyMessage="selezionare un valore">
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
            <td colspan="3"><telerik:RadComboBox ID="cmbMeseInizio" runat="server" Width="150px" EmptyMessage="selezionare un valore">
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
            <td><telerik:RadComboBox ID="cmbAnnoFine" runat="server" Width="150px" EmptyMessage="selezionare un valore">
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
            <td colspan="4"><telerik:RadComboBox ID="cmbMeseFine" runat="server" Width="150px" EmptyMessage="selezionare un valore">
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

        <tr><td colspan="6"><hr /></td></tr>
        
        <tr>
            <td valign="top" align="right"  width="100px"><b>tipo<br />elaborazoine</b></td> 
            <td width="250px" colspan="5">&nbsp;<telerik:RadComboBox ID="cmbTipoElaborazioneID" runat="server" Width="235px" EmptyMessage="selezionare un valore" DataSourceID="sdsTipiElaborazione" DataValueField="TipoElaborazioneID" DataTextField="Descrizione" /></td>
        </tr>

        <tr><td colspan="6"><hr /></td></tr>

        <tr valign="top">
            <td valign="top" align="right" rowspan="7" width="100px"><b>abilita<br />tabulati</b></td> 
            <td>&nbsp;<asp:CheckBox ID="chkAgentiCorrispettivi" runat="server" checked="true" Text="corrispettivi" TextAlign="Right" /></td>
            <td valign="top" align="right" rowspan="7" width="100px"><b>abilita<br />profili<br />consultazione</b></td> 
            <td>&nbsp;<asp:CheckBox ID="chkAdmin" runat="server" checked="true" Text="Amministratore" TextAlign="Right" Enabled="false" /></td>
            <td valign="top" align="right" rowspan="7" width="100px"><b>abilita<br />importazione<br />dati</b></td> 
            <td>&nbsp;<asp:CheckBox ID="chkOreLavorative" runat="server" checked="true" Text="Ore contratto" TextAlign="Right" /></td>
        </tr>
        <tr valign="top">
            <td colspan="2">&nbsp;<asp:CheckBox ID="chkAgentiPremi" runat="server" checked="true" Text="premi" TextAlign="Right" /></td>
            <td colspan="2">&nbsp;<asp:CheckBox ID="chkDirezione" runat="server" checked="true" Text="direzione" TextAlign="Right" Enabled="false" /></td>
        </tr>
        <tr valign="top">
            <td colspan="2">&nbsp;<asp:CheckBox ID="chkAgentiIntegrazioni" runat="server" checked="true" Text="integrazioni" TextAlign="Right" /></td>
            <td colspan="2">&nbsp;<asp:CheckBox ID="chkUffPersonale" runat="server" Text="ufficio del personale" TextAlign="Right" /></td>
        </tr>
        <tr valign="top">
            <td colspan="2">&nbsp;<asp:CheckBox ID="chkAgentiSpese" runat="server" checked="true" Text="spese" TextAlign="Right" /></td>
            <td colspan="2">&nbsp;<asp:RadioButton ID="chkContabilitaCallCenter" runat="server" Text="contabilita callcenter" TextAlign="Right" GroupName="contab" /></td>
        </tr>
        <tr valign="top">
            <td colspan="2">&nbsp;<asp:CheckBox ID="chkAgentiBc" runat="server" checked="true" Text="bonus contatti" TextAlign="Right" AutoPostBack="true" oncheckedchanged="chkAgentiBc_CheckedChanged" /></td>
            <td colspan="2">&nbsp;<asp:RadioButton ID="chkContabilitaAgenti" runat="server" Text="contabilita agenti" TextAlign="Right" GroupName="contab" /></td>
        </tr>
        <tr valign="top">
            <td colspan="2">&nbsp;<asp:CheckBox ID="chkAgentiBsl" runat="server" checked="true" Text="bonus salva lavoro" TextAlign="Right" /></td>
            <td colspan="2">&nbsp;<asp:RadioButton ID="chkContabilitaProcuratori" runat="server" Text="contabilita procuratori" TextAlign="Right" GroupName="contab" /></td>
        </tr>
        <tr valign="top">
            <td colspan="2">&nbsp;<asp:CheckBox ID="cbkAgentiOreStraordinarie" runat="server" checked="true" Text="Ore straordinarie" TextAlign="Right" /></td>
            <td colspan="2">&nbsp;</td>
        </tr>
    </table>
    <table border="0" cellpadding="2" cellspacing="2" width="800px">
        <tr><td colspan="3"><hr /></td></tr>
        <tr valign="top">
            <td align="right" width="100px"><b>note:</b></td>
            <td><asp:TextBox ID="txtNote" runat="server" Width="550px" TextMode="MultiLine" Rows="10" Text="" /></td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sdsCallCenter" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xCallCenterView" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" />
    <asp:SqlDataSource ID="sdsTipiElaborazione" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="sdsTipiElaborazione" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" />
</asp:Content>