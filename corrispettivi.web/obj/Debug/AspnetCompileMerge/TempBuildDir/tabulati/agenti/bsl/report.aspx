<%@ Page Title="" Language="C#" MasterPageFile="~/tabulati/agenti/bsl/local.master" AutoEventWireup="true" CodeBehind="report.aspx.cs" Inherits="corrispettivi.web.tabulati.agenti.bsl.report" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <script type="text/javascript">
        function onToolBarClientButtonClicking(sender, args) {
            var button = args.get_item();

            if (button.get_commandName() == "tabReworks")  {
                args.set_cancel(!confirm('Sicuro di voler rielaborare il periodo selezionato?'));
            }

            if (button.get_commandName() == "setStatusClosed") {
                args.set_cancel(!confirm('Sicuro di voler impostare lo stato chiuso per il periodo selezionato?\n\nRicorda che verranno chiusi soltanto i tabulati con status PUBBLICATO'));
            }
        }
    </script>


    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblAction" runat="server" Text="" /></td></tr>
    </table>

    <telerik:RadAjaxManager ID="amInfo" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmbPeriodoRif">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="tbAction" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="gvInfo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="imgSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="tbAction" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="tbAction">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="apStatus" runat="server" Style="width: 320px;" Height="75px" Width="75px" AnimationDuration="1">
        <img alt="Loading..." src="~/image/Telerik/loading7.gif" style="border:0;" />
    </telerik:RadAjaxLoadingPanel>

    <table border="0" cellpadding="2" cellspacing="2">
        <tr valign="middle">
            <td class="titnero12" nowrap>Selezionare il periodo di riferimento:</td>
            <td><telerik:RadComboBox ID="cmbPeriodoRif" runat="server" Width="200px" EmptyMessage="Selezionare un valore..."
                    DataSourceID="sdsPeriodoRif" DataTextField="PeriodoRif" 
                    DataValueField="PeriodoRif" AutoPostBack="true" 
                    onselectedindexchanged="cmbPeriodoRif_SelectedIndexChanged" /></td>
            <td><asp:ImageButton ID="imgSearch" runat="server" ImageUrl="~/Image/Find.png" onclick="imgSearch_Click" /></td>
            <td width="100%" align="right"><telerik:radtoolbar ID="tbAction" runat="server" Skin="Simple" onbuttonclick="tbAction_ButtonClick" OnClientButtonClicking="onToolBarClientButtonClicking">
                    <Items>
                        <telerik:RadToolBarDropDown Text="Azioni" Font-Bold="True" ImageUrl="~/image/application.png"> 
                            <Buttons>
                                <telerik:RadToolBarButton Text="Rielabora" ImageUrl="~/image/sync.png" CommandName="tabReworks" Value="tabReworks" />
                                <telerik:RadToolBarButton Text="Set status chiuso" ImageUrl="~/image/status/4.png" CommandName="setStatusClosed" Value="setStatusClosed" />
                            </Buttons>
                        </telerik:RadToolBarDropDown>

                        <telerik:RadToolBarDropDown Text="Esporta" Font-Bold="True" ImageUrl="~/image/Download-20.png"> 
                            <Buttons>
                                <telerik:RadToolBarButton Text="Report" ImageUrl="~/image/excel.gif" CommandName="expExcel" Value="~/excel.aspx?type=bslReport&rif={0}" />
                            </Buttons>
                        </telerik:RadToolBarDropDown>
                    </Items>
                </telerik:radtoolbar>
                <!-- <telerik:RadToolBarButton Text="Csv" ImageUrl="~/image/csv.png" CommandName="expCsv" Value="expreport.aspx?mode=csv&x={0}" />  -->
                
            </td>
        </tr>
    </table>
    <telerik:RadGrid ID="gvInfo" runat="server" Skin="Simple" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="true" CellSpacing="0" GridLines="None" PageSize="100" DataSourceID="sdsInfo" Height="550px" ShowFooter="true">
        <SelectedItemStyle CssClass="SelectedStyle" />
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" />
        <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="AgenteBslID">
            <Columns>
                <telerik:GridBoundColumn DataField="CallCenterNome" HeaderText="CallCenter" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count" FooterStyle-HorizontalAlign="Center">
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="CallCenterCombo" DataSourceID="sdsCallCenter" DataTextField="CallCenterNome" Skin="Black" Filter="Contains"
                            DataValueField="CallCenterNome" Height="200px" Width="150px" DropDownWidth="400px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("CallCenterNome").CurrentFilterValue %>' 
                            runat="server" OnClientSelectedIndexChanged="CallCenterComboIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="Tutti" />
                            </Items>
                        </telerik:RadComboBox>
                        <telerik:RadScriptBlock ID="rsbCallCenter" runat="server">
                            <script type="text/javascript">
                                function CallCenterComboIndexChanged(sender, args) {
                                    var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                    tableView.filter("CallCenterNome", args.get_item().get_value(), "EqualTo");
                                }
                            </script>
                        </telerik:RadScriptBlock>
                    </FilterTemplate>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AgenteGroupAlias" HeaderText="Agente" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count" FooterStyle-HorizontalAlign="Center">
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="AgentiCombo" DataSourceID="sdsAgenti" DataTextField="AgenteGroupAlias" Skin="Black" Filter="Contains"
                            DataValueField="AgenteGroupAlias" Height="200px" Width="150px" DropDownWidth="400px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("AgenteGroupAlias").CurrentFilterValue %>' 
                            runat="server" OnClientSelectedIndexChanged="AgenteComboIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="Tutti" />
                            </Items>
                        </telerik:RadComboBox>
                        <telerik:RadScriptBlock ID="rsbAgenti" runat="server">
                            <script type="text/javascript">
                                function AgenteComboIndexChanged(sender, args) {
                                    var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                    tableView.filter("AgenteGroupAlias", args.get_item().get_value(), "EqualTo");
                                }
                            </script>
                        </telerik:RadScriptBlock>
                    </FilterTemplate>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="OreContratto" HeaderText="Ore ctr" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="OreContrattoCombo" DataSourceID="sdsOreContratto" DataTextField="OreContratto" Skin="Black" Filter="Contains"
                            DataValueField="OreContratto" Height="100px" Width="55px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("OreContratto").CurrentFilterValue %>'
                            runat="server" OnClientSelectedIndexChanged="OreContrattoComboIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="Tutti" />
                            </Items>
                        </telerik:RadComboBox>
                        <telerik:RadScriptBlock ID="rsbOreContratto" runat="server">
                            <script type="text/javascript">
                                function OreContrattoComboIndexChanged(sender, args) {
                                    var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                    tableView.filter("OreContratto", args.get_item().get_value(), "EqualTo");
                                }
                            </script>
                        </telerik:RadScriptBlock>
                    </FilterTemplate>
                </telerik:GridBoundColumn>               
                <telerik:GridBoundColumn DataField="ImportoMaturato" HeaderText="Maturato" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="ImportoRiconosciuto" HeaderText="Riconosciuto" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="SystemElab" HeaderText="Info elaborazione" HeaderStyle-Width="170px" HeaderStyle-HorizontalAlign="Center" AllowFiltering="false"  ItemStyle-Font-Names="courier new"  />
                <telerik:GridBoundColumn DataField="StatusDescrizione" HeaderText="Status" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="StatusCombo" DataSourceID="sdsStatus" DataTextField="Descrizione" Skin="Black" Filter="Contains"
                            DataValueField="Descrizione" Height="100px" Width="120px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("StatusDescrizione").CurrentFilterValue %>'
                            runat="server" OnClientSelectedIndexChanged="StatusComboIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="Tutti" />
                            </Items>
                        </telerik:RadComboBox>
                        <telerik:RadScriptBlock ID="rsbStatus" runat="server">
                            <script type="text/javascript">
                                function StatusComboIndexChanged(sender, args) {
                                    var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                    tableView.filter("StatusDescrizione", args.get_item().get_value(), "EqualTo");
                                }
                            </script>
                        </telerik:RadScriptBlock>
                    </FilterTemplate>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DATA_ULTIMA_MODIFICA" HeaderText="data ult.mod." HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" />    
                <telerik:GridBoundColumn DataField="UTENTE_MOD" HeaderText="utente ult.mod." HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xAgentiBslView" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:ControlParameter ControlID="cmbPeriodoRif" PropertyName="SelectedValue" Name="PeriodoRif" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsCallCenter" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsCallCenter" ConnectionString="<%$ ConnectionStrings:dbConn%>" />
    
    <asp:SqlDataSource ID="sdsAgenti" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsAgenti" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

    <asp:SqlDataSource ID="sdsOreContratto" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsOreContratto" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

    <asp:SqlDataSource ID="sdsPeriodoRif" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsPeriodoRifBsl" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

    <asp:SqlDataSource ID="sdsStatus" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsStatus" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

</asp:Content>