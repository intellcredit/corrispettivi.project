<%@ Page Title="" Language="C#" MasterPageFile="~/contabilita/callcenter/local.master" AutoEventWireup="true" CodeBehind="scheda.aspx.cs" Inherits="corrispettivi.web.contabilita.callcenter.fatture.scheda" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">
    <h1><b>CALL CENTER. REGISTRAZIONE FATTURE.</b></h1><hr />

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

                var num = document.getElementById('<%=txtNumero.ClientID%>').value;
                if (num == "")
                    msg = msg.concat("- Digitare il numero di fattura\n");

                var data = document.getElementById('<%=txtData.ClientID%>').value;
                if (data == "")
                    msg = msg.concat("- Selezionare la data fattura\n");

                var imp = document.getElementById('<%=txtImporto.ClientID%>').value;
                if (imp == "")
                    msg = msg.concat("- Digitare l'importo della fattura\n");

                if (msg != "") {
                    alert(msg);
                    args.set_cancel("false");
                }
            }

            //DELETE
            if (button.get_commandName() == "DeleteSelected") {
                args.set_cancel(!confirm('Sicuro di voler eliminare questo elemento?'));
            }

            //DELETEALL
            if (button.get_commandName() == "DeleteAllSelected") {
                args.set_cancel(!confirm('Sicuro di voler eliminare tutte le fatture registrate?'));
            }

            //CLOSE
            if (button.get_commandName() == "CloseSelected") {
                args.set_cancel(!confirm('Sicuro di voler uscire senza salvare?'));
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblAction" runat="server" Text="" /></td></tr>
    </table>

    <telerik:RadAjaxManager ID="amInfo" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tbAction2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvFatture" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="txtNumero" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="txtData" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="txtImporto" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="lblMessage" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="lblResiduo" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="gvFatture">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvFatture" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="lblMessage" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="lblResiduo" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="txtImporto" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="apStatus" runat="server" Style="width: 320px;" Height="75px" Width="75px" AnimationDuration="1">
        <img alt="Loading..." src="~/image/Telerik/loading7.gif" style="border:0;" />
    </telerik:RadAjaxLoadingPanel>

    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr><td align="right"><telerik:radtoolbar ID="tbAction1" runat="server" Skin="Simple" onbuttonclick="tbAction1_ButtonClick">
            <Items>
                <telerik:RadToolBarButton Value="btnClose" Text="Chiudi" ToolTip="Esci senza salvare" Font-Bold="true" ImageUrl="~/image/close.png" CommandName="CloseSelected" />
            </Items>
        </telerik:radtoolbar></td></tr>
        <tr bgcolor="white"><td><asp:Label ID="lblMessage" runat="server" Text="" /></td></tr>
    </table>
    <br />

    <table border="0" cellpadding="2" cellspacing="2" width="100%">
        <tr>
            <td align="right"><b>callcenter</b></td>
            <td colspan="2"><telerik:RadComboBox ID="cmbCallCenter" runat="server" Width="550px" EmptyMessage="selezionare un valore" DataSourceID="sdsCallCenter" DataTextField="Nominativo" DataValueField="CallCenterID" Filter="Contains">
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
            <td rowspan="10" align="right" valign="top"><telerik:RadGrid ID="gvSummary" runat="server" Skin="Simple" AutoGenerateColumns="false" DataSourceID="sdsSummary" BorderWidth="1" CellSpacing="0" CellPadding="0" GridLines="Both" ShowHeader="true" ShowFooter="false" Width="100%" OnItemDataBound="gvSummary_ItemDataBound">
                    <HeaderStyle Font-Bold="true" VerticalAlign="Top" HorizontalAlign="Center" />
                    <ItemStyle CssClass="testonero12" />
                    <AlternatingItemStyle BackColor="White" CssClass="testonero12" />
                    <MasterTableView ShowHeadersWhenNoRecords="true" DataKeyNames="Row">
                        <NoRecordsTemplate>Nessun record trovato</NoRecordsTemplate>
                        <ColumnGroups>
                            <telerik:GridColumnGroup Name="Header" HeaderText="RIEPILOGO COMPENSI" HeaderStyle-HorizontalAlign="Center" />
                        </ColumnGroups>
                        <Columns>
                            <telerik:GridBoundColumn DataField="desc"  ItemStyle-Width="220px" ItemStyle-HorizontalAlign="Right" ColumnGroupName="Header" HeaderText="DESCRIZIONE" />
                            <telerik:GridBoundColumn DataField="importo" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" ItemStyle-Width="80px" ColumnGroupName="Header" HeaderText="IMPORTO" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid></td>
        </tr>
        <tr><td colspan="3"><hr /></td></tr>
        <tr valign="top">
            <td valign="top" align="right" rowspan="2" width="90px"><b>periodo<br />di riferimento</b></td> 
            <td align="right" width="65px">anno:</td>
            <td><telerik:RadComboBox ID="cmbAnnoRif" runat="server" Width="150px" EmptyMessage="selezionare un valore" DataSourceID="sdsAnnoRif" DataTextField="AnnoRif" DataValueField="AnnoRif" Filter="Contains" /></td>
        </tr>
        <tr valign="top">
            <td align="right">mese:</td>
            <td><telerik:RadComboBox ID="cmbMeseRif" runat="server" Width="150px" EmptyMessage="selezionare un valore" Filter="Contains">
                <Items>
                    <telerik:RadComboBoxItem Value="1" Text="Gennaio" />
                    <telerik:RadComboBoxItem Value="2" Text="Febbraio" />
                    <telerik:RadComboBoxItem Value="3" Text="Marzo" />
                    <telerik:RadComboBoxItem Value="4" Text="Aprile" />
                    <telerik:RadComboBoxItem Value="5" Text="Maggio" />
                    <telerik:RadComboBoxItem Value="6" Text="Giugno" />
                    <telerik:RadComboBoxItem Value="7" Text="Luglio" />
                    <telerik:RadComboBoxItem Value="8" Text="Agosto" />
                    <telerik:RadComboBoxItem Value="9" Text="Settembre" />
                    <telerik:RadComboBoxItem Value="10" Text="Ottobre" />
                    <telerik:RadComboBoxItem Value="11" Text="Novembre" />
                    <telerik:RadComboBoxItem Value="12" Text="Dicembre" />
                </Items>
            </telerik:RadComboBox></td>
        </tr>
        <tr><td colspan="3"><hr /></td></tr>
        <tr valign="top">
            <td valign="top" align="right" rowspan="3" width="90px"><b>info<br />fattura</b><br /><br /><div style="background-color:BlanchedAlmond"><font class="titrosso10">residuo da fatturare:<br /><asp:Label ID="lblResiduo" runat="server" Text="" /></font></div></td>
            <td align="right" width="65px">numero:</td>
            <td colspan="2"><asp:TextBox ID="txtNumero" runat="server" Width="100px" Text="" MaxLength="20" /></td>
        </tr>
        <tr valign="top">
            <td align="right" width="65px">data:</td>
            <td colspan="2"><telerik:RadDatePicker ID="txtData" runat="server" MinDate="01/01/2017" Width="100px" /></td>
        </tr>
        <tr valign="top">
            <td align="right" width="65px">importo:</td>
            <td><telerik:RadNumericTextBox ID="txtImporto" runat="server" MinValue="0" Value="0" NumberFormat-DecimalDigits="2" Width="100px" /></td>
        </tr>        
        <tr><td colspan="3"><hr /></td></tr>
        <tr valign="top">
            <td align="right"><b>note:</b></td>
            <td colspan="2"><asp:TextBox ID="txtNote" runat="server" Width="550px" TextMode="MultiLine" Rows="3" Text="" MaxLength="255" /></td>
        </tr>
    </table>
    <br />
    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr><td align="right"><telerik:radtoolbar ID="tbAction2" runat="server" Skin="Simple" onbuttonclick="tbAction2_ButtonClick" OnClientButtonClicking="onToolBarClientButtonClicking">
            <Items>
                <telerik:RadToolBarButton Value="btnAdd" Text="Aggiungi" ToolTip="Aggiungi fattura" Font-Bold="true" ImageUrl="~/image/Add.png" CommandName="SaveSelected" />
                <telerik:RadToolBarButton Value="sep" IsSeparator="true" />
                <telerik:RadToolBarButton Value="btnDeleteAll" Text="Elimina fatture" ToolTip="Elimina tutte le fatture registrate" Font-Bold="true" ImageUrl="~/image/delete.png" CommandName="DeleteAllSelected" />
                <telerik:RadToolBarButton Value="sep" IsSeparator="true" />
                <telerik:RadToolBarButton Text="Excel" ImageUrl="~/image/excel.gif" CommandName="ExportSelected" Value="expfatture.aspx?x={0}&y={1}&c={2}" />
            </Items>
        </telerik:radtoolbar></td></tr>
    </table>
    <telerik:RadGrid ID="gvFatture" runat="server" DataSourceID="sdsInfo" Skin="Simple" CellSpacing="0" GridLines="None" Height="350px" ShowFooter="true" AllowFiltering="false" OnItemCommand="gvFatture_ItemCommand">
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Selecting-CellSelectionMode="SingleCell" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" />
        <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="FatturaID">
            <Columns>
                <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" HeaderText="" HeaderStyle-Width="20px">
                    <ItemTemplate><asp:ImageButton ID="btnDelete" runat="server" ImageUrl="~/Image/delete.png" CommandName="Delete" OnClientClick="javascript:return confirm('Sicuro di voler eliminare questa fattura?');" /></ItemTemplate>
                </telerik:GridTemplateColumn>
                
                <telerik:GridBoundColumn HeaderText="Periodo" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center"
                                        DataField="PeriodoRif" />

                <telerik:GridBoundColumn HeaderText="Numero" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center"
                                        DataField="Numero" />
                <telerik:GridBoundColumn HeaderText="Data" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center"
                                        DataField="Data" 
                                        DataFormatString="{0:d}" />
                <telerik:GridBoundColumn HeaderText="Importo" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"
                                        DataField="Importo"
                                        DataFormatString="{0:C}"
                                        Aggregate="Sum" />
                <telerik:GridBoundColumn HeaderText="Note" HeaderStyle-Width="300px" HeaderStyle-HorizontalAlign="Center" 
                                        DataField="Note" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xFattureView" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="c" Name="CallCenterID" />
            <asp:QueryStringParameter QueryStringField="x" Name="AnnoRif" />
            <asp:QueryStringParameter QueryStringField="y" Name="MeseRif" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sdsAnnoRif" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommand="sdsAnnoRifDistinct" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

    <asp:SqlDataSource ID="sdsCallCenter" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommand="xCallCenterView" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

        <asp:Label ID="lblPeriodoRif" runat="server" Text="" hidden />

    <asp:SqlDataSource ID="sdsSummary" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="summaryContabilitaCallCenterxPeriodo" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="c" Name="CallCenterID" />
            <asp:ControlParameter ControlID="lblPeriodoRif" Name="PeriodoRif" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>