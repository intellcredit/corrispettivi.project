<%@ Page Title="" Language="C#" MasterPageFile="~/settings/ag-ctr/local.master" AutoEventWireup="true" CodeBehind="scheda.aspx.cs" Inherits="corrispettivi.web.settings.ag_ctr.scheda" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <script type="text/javascript">
        function daysInMonth(month, year) {
            return new Date(year, month, 0).getDate();
        }

        function onToolBarClientButtonClicking(sender, args) {
            var button = args.get_item();

            var msg = "";

            //CLOSE
            if (button.get_commandName() == "CloseSelected") {
                args.set_cancel(!confirm('Sicuro di voler uscire senza salvare?'));
            }

        }
    </script>

    <telerik:RadAjaxManager ID="amInfo" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmbOreGiornaliere">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblOreMensili" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="tbAction">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblMessage" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="lblActionMessage" LoadingPanelID="apStatus" />

                    <telerik:AjaxUpdatedControl ControlID="lblPeriodoRif" />
                    <telerik:AjaxUpdatedControl ControlID="lblCallCenter" />
                    <telerik:AjaxUpdatedControl ControlID="lblAgente" />
                    <telerik:AjaxUpdatedControl ControlID="lblDataInizio" />
                    <telerik:AjaxUpdatedControl ControlID="lblDataFine" />
                    <telerik:AjaxUpdatedControl ControlID="cmbOreGiornaliere" />
                    <telerik:AjaxUpdatedControl ControlID="lblOreMensili" />
                    <telerik:AjaxUpdatedControl ControlID="cmbTipoRetribuzioneID" />
                    <telerik:AjaxUpdatedControl ControlID="chkReWorksTab" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="apStatus" runat="server" Style="width: 320px;" Height="75px" Width="75px" AnimationDuration="1">
        <img alt="Loading..." src="~/image/Telerik/loading7.gif" style="border:0;" />
    </telerik:RadAjaxLoadingPanel>


    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr><td align="right"><telerik:radtoolbar ID="tbAction" runat="server" Skin="Simple" onbuttonclick="tbAction_ButtonClick" OnClientButtonClicking="onToolBarClientButtonClicking">
            <Items>
                <telerik:RadToolBarButton Value="btnSave" Text="Salva" ToolTip="Salva dati e torna alla home" Font-Bold="true" ImageUrl="~/image/save.gif" CommandName="SaveSelected" />
                <telerik:RadToolBarButton Value="btnSaveClose" Text="Salva e chiudi" ToolTip="Salva dati e torna alla home" Font-Bold="true" ImageUrl="~/image/saveClose.gif" CommandName="SaveCloseSelected" />
                <telerik:RadToolBarButton Value="sepSave" IsSeparator="true" />
                <telerik:RadToolBarButton Value="btnClose" Text="Chiudi" ToolTip="Esci senza salvare" Font-Bold="true" ImageUrl="~/image/close.png" CommandName="CloseSelected" />
            </Items>
        </telerik:radtoolbar></td></tr>
        <tr bgcolor="white"><td><asp:Label ID="lblMessage" runat="server" Text="" /></td></tr>
        <tr bgcolor="white"><td><asp:Label ID="lblActionMessage" runat="server" Text="" /></td></tr>
    </table>
    <br />
    <table border="0" cellpadding="2" cellspacing="2">

        <tr valign="top">
            <td valign="top" align="right" width="130px"><b>Periodo riferimento</b></td> 
            <td colspan="3"><asp:Label ID="lblPeriodoRif" runat="server" Text="" /></td>
        </tr>

        <tr><td colspan="4"><hr /></td></tr>

        <tr valign="top">
            <td valign="top" align="right"><b>CallCenter</b></td> 
            <td colspan="3"><asp:Label ID="lblCallCenter" runat="server" Text="" /></td>
        </tr>

        <tr><td colspan="4"><hr /></td></tr>

        <tr valign="top">
            <td valign="top" align="right"><b>Agente</b></td> 
            <td colspan="3"><asp:Label ID="lblAgente" runat="server" Text="" /></td>
        </tr>

        <tr><td colspan="4"><hr /></td></tr>

        <tr valign="top">
            <td valign="top" align="right"><b>Data inizio</b></td> 
            <td><asp:Label ID="lblDataInizio" runat="server" Text="" Width="50px" /></td>
            <td valign="top" align="right" width="150px"><b>Data fine</b></td> 
            <td width="100px"><asp:Label ID="lblDataFine" runat="server" Text="" /></td>
        </tr>

        <tr><td colspan="4"><hr /></td></tr>
        
        <tr valign="top">
            <td valign="top" align="right"><b>ore giornaliere</b></td> 
            <td><telerik:RadComboBox ID="cmbOreGiornaliere" runat="server" Width="100px" EmptyMessage="selezionare..." onselectedindexchanged="cmbOreGiornaliere_SelectedIndexChanged" AutoPostBack="true">
                <Items>
                    <telerik:RadComboBoxItem Value="0" Text="non specificato" />
                    <telerik:RadComboBoxItem Value="2" Text="2 ore" />
                    <telerik:RadComboBoxItem Value="4" Text="4 ore" />
                    <telerik:RadComboBoxItem Value="6" Text="6 ore" />
                    <telerik:RadComboBoxItem Value="8" Text="8 ore" />
                </Items>
            </telerik:RadComboBox></td>
            <td valign="top" align="right" width="150px"><b>ore mensili</b></td> 
            <td><asp:Label ID="lblOreMensili" runat="server" Text="" /></td>
        </tr>

        <tr><td colspan="4"><hr /></td></tr>
        
        <tr>
            <td valign="top" align="right" width="100px"><b>tipo retribuzione</b></td>
            <td colspan="3">&nbsp;<telerik:RadComboBox ID="cmbTipoRetribuzioneID" runat="server" Width="235px" EmptyMessage="selezionare un valore" DataSourceID="sdsTipiRetribuzione" DataValueField="TipoRetribuzioneID" DataTextField="Descrizione" /></td>
        </tr>

        <tr id="rowReWorksTab1" runat="server"><td colspan="4"><hr /></td></tr>

        <tr id="rowReWorksTab2" runat="server">
            <td valign="top" align="right" width="100px"><b>rielabora tabulati<br />mese in corso</b></td>
            <td colspan="3">&nbsp;<asp:CheckBox ID="chkReWorksTab" runat="server" /></td>
        </tr>
        
    </table>

    <asp:SqlDataSource ID="sdsTipiRetribuzione" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="sdsTipiRetribuzioneContratti" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

</asp:Content>