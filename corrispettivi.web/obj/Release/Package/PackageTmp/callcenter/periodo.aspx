<%@ Page Title="" Language="C#" MasterPageFile="~/callcenter/local.master" AutoEventWireup="true" CodeBehind="periodo.aspx.cs" Inherits="corrispettivi.web.callcenter.periodo" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register src="~/legendStatusTabulato.ascx" tagname="legend" tagprefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <h1><b>Report per periodo</b></h1><hr />
    
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

            <telerik:AjaxSetting AjaxControlID="imgSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="tbAction" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="gvInfo" EventName="gvInfo_ItemCommand">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="InnerContainer" LoadingPanelID="apStatus" />
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
            <td width="100%" align="right"><telerik:radtoolbar ID="tbAction" runat="server" Skin="Simple">
                <Items>
                    <telerik:RadToolBarDropDown Text="Esporta" Font-Bold="True" ImageUrl="~/image/Download-20.png"> 
                        <Buttons>
                            <telerik:RadToolBarButton Text="Riepilogo tabulati in CSV" ImageUrl="~/image/csv.png" CommandName="expCsv" Value="expperiodo-tabulati.aspx?x={0}&y={1}&mode=csv" />
                            <telerik:RadToolBarButton Text="Riepilogo tabulati in Excel" ImageUrl="~/image/excel.gif" CommandName="expExcel" Value="expperiodo-tabulati.aspx?x={0}&y={1}&mode=xls" />
                            <telerik:RadToolBarButton Text="Riepilogo compensi/anticipato in valuta in pdf" ImageUrl="~/image/pdf.png" CommandName="expPdf" Value="expperiodo-summary.aspx?x={0}&y={1}&mode=pdf" />
                        </Buttons>
                    </telerik:RadToolBarDropDown>
                </Items>
            </telerik:radtoolbar></td>
        </tr>
    </table>

    <telerik:RadGrid ID="gvInfo" runat="server" DataSourceID="sdsInfo" Skin="Simple" AllowSorting="True" AllowFilteringByColumn="true" CellSpacing="0" GridLines="None" Height="550px" ShowFooter="true" OnItemDataBound="gvInfo_ItemDataBound" OnItemCommand="gvInfo_ItemCommand">
        <SelectedItemStyle CssClass="SelectedStyle" />
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" CssClass="testonero10" />
        <AlternatingItemStyle VerticalAlign="Top" CssClass="testonero10" />
        <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
        <FilterMenu Skin="Black" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="PeriodoRif,AgenteGroupID,CallCenterID,StatusID">
            <ColumnGroups>
                <telerik:GridColumnGroup Name="Importi" HeaderText="Importi" HeaderStyle-HorizontalAlign="Center" />
            </ColumnGroups>
            <ItemStyle CssClass="testonero10" />
            <AlternatingItemStyle CssClass="testonero10" />
            <Columns>
                <telerik:GridBoundColumn DataField="AgenteGroupAlias" HeaderText="Agente" HeaderStyle-Width="300px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count" FooterStyle-HorizontalAlign="Center">
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="AgentiCombo" DataSourceID="sdsAgenti" DataTextField="AgenteGroupAlias" Skin="Black" Filter="Contains"
                            DataValueField="AgenteGroupAlias" Height="200px" Width="250px" DropDownWidth="300px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("AgenteGroupAlias").CurrentFilterValue %>' 
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
                <telerik:GridBoundColumn DataField="StatusDesc" HeaderText="Status complessivo" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="ImportoMaturato" HeaderText="maturato" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" ColumnGroupName="Importi" />
                <telerik:GridBoundColumn DataField="ImportoRiconosciuto" HeaderText="riconosciuto" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" ColumnGroupName="Importi" />
            </Columns>

            <NestedViewTemplate>
                <asp:Panel runat="server" ID="InnerContainer" CssClass="viewWrap">
                <telerik:RadTabStrip runat="server" ID="LoadTabStip" Skin="Simple" MultiPageID="LoadMultipage" SelectedIndex="0" Orientation="HorizontalTop" >
                <Tabs runat="server">
                    <telerik:RadTab runat="server" Text="Tabulati" PageViewID="rpvTabulati" Selected="true" />
                    <telerik:RadTab runat="server" Text="Riepilogo compensi/anticipato in valuta" PageViewID="rpvSummary" />
                </Tabs>
                </telerik:RadTabStrip>
                    <telerik:RadMultiPage runat="server" ID="LoadMultipage" SelectedIndex="0" RenderSelectedPageOnly="false">
                        <telerik:RadPageView runat="server" ID="rpvTabulati"> 
                            <asp:Label ID="lblPeriodoRif" Text='<%# Eval("PeriodoRif") %>' Visible="false" runat="server" />
                            <asp:Label ID="lblAgenteGroupID" Text='<%# Eval("AgenteGroupID") %>' Visible="false" runat="server" />
                            <asp:Label ID="lblCallCenterID" Text='<%# Eval("CallCenterID") %>' Visible="false" runat="server" />
                            <asp:Label ID="lblOreContratto" Text='<%# Eval("OreContratto") %>' Visible="false" runat="server" />
                            
                            <telerik:RadGrid ID="gvTabulati" runat="server"  Skin="Simple" AutoGenerateColumns="false" CellSpacing="0" GridLines="None" ShowFooter="true" OnItemDataBound="gvTabulati_ItemDataBound" >
                                <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
                                <ItemStyle VerticalAlign="Top" />
                                <AlternatingItemStyle VerticalAlign="Top" />
                                <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
                                <MasterTableView ShowHeadersWhenNoRecords="true" DataKeyNames="StatusID">
                                    <Columns>                                      
                                        <telerik:GridHyperLinkColumn AllowSorting="False" HeaderText="" ImageUrl="~/image/list.png" DataNavigateUrlFields="PeriodoRif,AgenteGroupID,AgenteGroupNome,OreContratto,SourceID,TipoTabulatoID" DataNavigateUrlFormatString="~/redirectView.aspx?x={0}&y={1}&z={2}&o={3}&key={4}&type={5}&area=1" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center" target="_blank" UniqueName="view" />
                                        <telerik:GridHyperLinkColumn AllowSorting="False" HeaderText="" ImageUrl="~/image/excel.gif" DataNavigateUrlFields="PeriodoRif,AgenteGroupID,AgenteGroupNome,OreContratto,SourceID,TipoTabulatoID" DataNavigateUrlFormatString="~/redirectExport.aspx?x={0}&y={1}&z={2}&o={3}&key={4}&type={5}&area=1&mode=xls" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center" UniqueName="export" />
                                        <telerik:GridBoundColumn DataField="TipoTabulatoDesc" HeaderText="Tabulato" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" />
                                        <telerik:GridBoundColumn DataField="ImportoMaturato" HeaderText="Imp.maturato" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                                        <telerik:GridBoundColumn DataField="ImportoRiconosciuto" HeaderText="Imp.riconosciuto" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                                        <telerik:GridBoundColumn DataField="SystemInfo" HeaderText="Info" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="200px" />
                                        <telerik:GridBoundColumn DataField="StatusDesc" HeaderText="Status" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" />
                                        <telerik:GridBoundColumn DataField="DataElaborazione" HeaderText="Data elab." HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" />
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                            <asp:SqlDataSource ID="sdsTabulati" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="tabulatiAgenteGroupxPeriodo" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblPeriodoRif" PropertyName="Text" Type="String" Name="PeriodoRif" />
                                    <asp:ControlParameter ControlID="lblAgenteGroupID" PropertyName="Text" Type="String" Name="AgenteGroupID" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </telerik:RadPageView>
                        <telerik:RadPageView runat="server" ID="rpvSummary">
                            <table border="0" cellpadding="0" cellspacing="0" width="700px">
                                <tr>
                                    <td width="350px" valign="top">
                                        <%--DataSourceID="sdsSummary" --%>
                                        <telerik:RadGrid ID="gvSummary" runat="server" Skin="Simple" AutoGenerateColumns="false" CellSpacing="0" GridLines="None" ShowHeader="true" ShowFooter="false" Width="100%" OnItemDataBound="gvSummary_ItemDataBound">
                                            <HeaderStyle Font-Bold="true" VerticalAlign="Top" HorizontalAlign="Center" />
                                            <ItemStyle CssClass="testonero12" />
                                            <AlternatingItemStyle BackColor="White" CssClass="testonero12" />
                                            <MasterTableView ShowHeadersWhenNoRecords="true" DataKeyNames="Row">
                                                <ColumnGroups>
                                                    <telerik:GridColumnGroup Name="Header" HeaderText="RIEPILOGO COMPENSI" HeaderStyle-HorizontalAlign="Center" />
                                                </ColumnGroups>
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="desc"  ItemStyle-Width="220px" ItemStyle-HorizontalAlign="Right" ColumnGroupName="Header" HeaderText="DESCRIZIONE" />
                                                    <telerik:GridBoundColumn DataField="importo" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" ItemStyle-Width="80px" ColumnGroupName="Header" HeaderText="IMPORTO" />
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                    <td width="15px"></td>
                                    <td width="350px" valign="top">
                                        <%--DataSourceID="sdsAnticipato" --%>
                                        <telerik:RadGrid ID="gvAnticipato" runat="server" Skin="Simple" AutoGenerateColumns="false" CellSpacing="0" GridLines="None" ShowHeader="true" ShowFooter="true" Width="100%">
                                            <HeaderStyle Font-Bold="true" VerticalAlign="Top" HorizontalAlign="Center" />
                                            <ItemStyle CssClass="testonero12" />
                                            <AlternatingItemStyle BackColor="White" CssClass="testonero12" />
                                            <FooterStyle CssClass="titrosso12" />
                                            <MasterTableView ShowHeadersWhenNoRecords="true">
                                                <ColumnGroups>
                                                    <telerik:GridColumnGroup Name="Header" HeaderText="RIEPILOGO ANTICIPATO IN VALUTA" HeaderStyle-HorizontalAlign="Center" />
                                                </ColumnGroups>
                                                <Columns>
                                                    <telerik:GridBoundColumn DataField="Periodo" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Right" ColumnGroupName="Header" HeaderText="PERIODO" FooterText="Totale" FooterStyle-HorizontalAlign="Right" />
                                                    <telerik:GridBoundColumn DataField="NumPag" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="75px" ColumnGroupName="Header" HeaderText="NUM.PAG." Aggregate="Sum" FooterStyle-HorizontalAlign="Center" FooterText=" " />
                                                    <telerik:GridBoundColumn DataField="Imponibile" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" ItemStyle-Width="75px" ColumnGroupName="Header" HeaderText="IMPONIBILE" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                    <td width="15px"></td>
                                    <td width="100px" valign="top"><telerik:radtoolbar ID="tbAction" runat="server" Skin="Simple">
                                            <Items>
                                                <telerik:RadToolBarButton Text="Genera PDF" Font-Bold="True" ImageUrl="~/image/pdf2.png" NavigateUrl='~/agenti/expsummary.aspx?x={0}&y={1}&mode=pdf' Target="_blank" CommandName="Pdf" />
                                            </Items>
                                        </telerik:radtoolbar></td>
                                </tr>
                            </table>

                            <asp:SqlDataSource ID="sdsSummary" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="summaryAgenteGroupxPeriodo" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblPeriodoRif" PropertyName="Text" Type="String" Name="PeriodoRif" />
                                    <asp:ControlParameter ControlID="lblAgenteGroupID" PropertyName="Text" Type="String" Name="AgenteGroupID" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="sdsAnticipato" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="anticipatoAgenteGroupxPeriodo" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblPeriodoRif" PropertyName="Text" Type="String" Name="PeriodoRif" />
                                    <asp:ControlParameter ControlID="lblAgenteGroupID" PropertyName="Text" Type="String" Name="AgenteGroupID" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </telerik:RadPageView>
                    </telerik:RadMultiPage>
                </asp:Panel>
            </NestedViewTemplate>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotCallCenterxPeriodo" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:SessionParameter SessionField="CallCenterID" Name="CallCenterID" Type="String" DefaultValue="" />
            <asp:ControlParameter ControlID="cmbPeriodoRif" PropertyName="SelectedValue" Name="PeriodoRif" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsAgenti" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="sdsAgenti" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>">
        <SelectParameters>
            <asp:SessionParameter SessionField="CallCenterID" Name="CallCenterID" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="sdsPeriodoRif" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="sdsPeriodoRifbyCallCenter" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:SessionParameter SessionField="CallCenterID" Name="CallCenterID" Type="Int16" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <UC:legend ID="cLegends" runat="server" />

</asp:Content>