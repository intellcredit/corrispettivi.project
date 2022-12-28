<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="corrispettivi.web.WebForm1" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="masterHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="masterMain" Runat="Server">
    
    <telerik:RadComboBox ID="cmbPeriodoRif" runat="server" Width="200px" EmptyMessage="Selezionare un valore..." />
    
    <telerik:RadGrid ID="gvInfo" runat="server" DataSourceID="sdsInfo" Skin="Simple" AllowSorting="True" AllowFilteringByColumn="true" CellSpacing="0" GridLines="None" Height="550px" ShowFooter="true" OnDetailTableDataBind="gvInfo_DetailTableDataBind" OnItemDataBound="gvInfo_ItemDataBound" AllowMultiRowSelection="true">
        <SelectedItemStyle CssClass="SelectedStyle" />
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" />
        <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
        <FilterMenu Skin="Black" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="CallCenterID,OreContratto,AgenteGroupID">
            <ColumnGroups>
            <telerik:GridColumnGroup Name="Importi" HeaderText="Importi" HeaderStyle-HorizontalAlign="Center" />
        </ColumnGroups>
        
            <Columns>
                <telerik:GridBoundColumn DataField="CallCenterNome" HeaderText="CallCenter" HeaderStyle-Width="250px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count" FooterStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="AgenteGroupAlias" HeaderText="Agente" HeaderStyle-Width="250px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count" FooterStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="OreContratto" HeaderText="Ore ctr" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="ImportoMaturato" HeaderText="maturato" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" ColumnGroupName="Importi" />
                <telerik:GridBoundColumn DataField="ImportoRiconosciuto" HeaderText="riconosciuto" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" ColumnGroupName="Importi" />
            </Columns>

            <NestedViewTemplate>
                <telerik:RadTabStrip runat="server" ID="LoadTabStip" MultiPageID="LoadMultipage" SelectedIndex="0" Orientation="HorizontalTop">
                    <Tabs runat="server">
                        <telerik:RadTab runat="server" Text="Details" PageViewID="RadPageViewDetails" />
                        <telerik:RadTab runat="server" Text="Compartments" PageViewID="RadPageViewCompartments" />
                        <telerik:RadTab runat="server" Text="Products" PageViewID="RadPageViewProducts" />
                    </Tabs>
                </telerik:RadTabStrip>
                <telerik:RadMultiPage runat="server" ID="LoadMultipage" SelectedIndex="0" RenderSelectedPageOnly="false" OnTabClick="LoadTabStip_TabClick">
                    <telerik:RadPageView runat="server" ID="RadPageViewDetails">
                    <p>prova1</p>
                </telerik:RadPageView>
                    <telerik:RadPageView runat="server" ID="RadPageViewCompartments">
                    <p>prova2</p>
                </telerik:RadPageView>
                    <telerik:RadPageView runat="server" ID="RadPageViewProducts">
                        <p>prova3</p>
                        <telerik:RadGrid ID="gvDetails" runat="server" AutoGenerateColumns="false">
                            <HeaderStyle CssClass="titnero9" ForeColor="DarkRed" Font-Bold="true" HorizontalAlign="Center" BackColor="#ffcc99" />
                            <FooterStyle CssClass="titnero9" ForeColor="DarkRed" Font-Bold="true" BackColor="#ffcc99" />
                            <MasterTableView ShowHeadersWhenNoRecords="true">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="TipoTabulatoUrlView" Visible="false" />
                                    <telerik:GridBoundColumn DataField="TipoTabulatoUrlExport" Visible="false" />
                                    <telerik:GridHyperLinkColumn AllowSorting="False" HeaderText="" ImageUrl="~/image/list.png" DataNavigateUrlFields="PeriodoRif,AgenteGroupID,AgenteGroupNome,OreContratto,SourceID,TipoTabulatoID" DataNavigateUrlFormatString="~/redirectView.aspx?x={0}&y={1}&z={2}&o={3}&key={4}&type={5}" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center" target="_blank" UniqueName="view" />
                                    <telerik:GridHyperLinkColumn AllowSorting="False" HeaderText="" ImageUrl="~/image/excel.gif" DataNavigateUrlFields="PeriodoRif,AgenteGroupID,AgenteGroupNome,OreContratto,SourceID,TipoTabulatoID" DataNavigateUrlFormatString="~/redirectExport.aspx?x={0}&y={1}&z={2}&o={3}&key={4}&type={5}&mode=xls" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center" UniqueName="export" />
                                    <telerik:GridBoundColumn DataField="TipoTabulatoDesc" HeaderText="Tabulato" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" />
                                    <telerik:GridBoundColumn DataField="ImportoMaturato" HeaderText="Imp.maturato" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                                    <telerik:GridBoundColumn DataField="ImportoRiconosciuto" HeaderText="Imp.riconosciuto" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                                    <telerik:GridBoundColumn DataField="SystemInfo" HeaderText="Info" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="200px" />
                                    <telerik:GridBoundColumn DataField="StatusDesc" HeaderText="Status" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" />
                                    <telerik:GridBoundColumn DataField="DataElaborazione" HeaderText="Data elab." HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" />
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </NestedViewTemplate>
        </MasterTableView>
        <ClientSettings>
            <Scrolling AllowScroll="true" />
        </ClientSettings>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xTabulatiView" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:ControlParameter ControlID="cmbPeriodoRif" PropertyName="SelectedValue" Name="PeriodoRif" Type="String" DefaultValue="07/2017" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

