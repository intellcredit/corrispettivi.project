<%@ Page Title="" Language="C#" MasterPageFile="~/agenti/local.master" AutoEventWireup="true" CodeBehind="report.aspx.cs" Inherits="corrispettivi.web.agenti.report" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register src="~/legendStatusTabulato.ascx" tagname="legend" tagprefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <asp:Label ID="lblAgenteGroupID" runat="server" Text="" Visible="false"></asp:Label>
    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblAction" runat="server" Text="" /></td></tr>
    </table>

    <telerik:RadGrid ID="gvInfo" runat="server" DataSourceID="sdsInfo" Skin="Simple" AllowSorting="True" AllowFilteringByColumn="true" CellSpacing="0" GridLines="None" Height="550px" ShowFooter="true" OnItemDataBound="gvInfo_ItemDataBound">
        <SelectedItemStyle CssClass="SelectedStyle" />
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle CssClass="testonero10" />
        <AlternatingItemStyle CssClass="testonero10" />
        <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
        <FilterMenu Skin="Black" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="PeriodoRif,AgenteGroupID,OreContratto,CallCenterID,StatusID">
              <NestedViewTemplate>
                <asp:Panel runat="server" ID="InnerContainer" CssClass="viewWrap">
                <telerik:RadTabStrip runat="server" ID="LoadTabStip" Skin="Simple" MultiPageID="LoadMultipage" SelectedIndex="0" Orientation="HorizontalTop" >
                <Tabs runat="server">
                    <telerik:RadTab runat="server" Text="Tabulati" PageViewID="rpvTabulati" Selected="true" />
                    <telerik:RadTab runat="server" Text="Riepilogo" PageViewID="rpvSummary" />
                </Tabs>
                </telerik:RadTabStrip>
                    <telerik:RadMultiPage runat="server" ID="LoadMultipage" SelectedIndex="0" RenderSelectedPageOnly="false">
                        <telerik:RadPageView runat="server" ID="rpvTabulati"> 
                            <asp:Label ID="lblAgenteGroupID" Text='<%# Eval("AgenteGroupID") %>' Visible="false" runat="server" />
                            <asp:Label ID="lblPeriodoRif" Text='<%# Eval("PeriodoRif") %>' Visible="false" runat="server" />
                            <asp:Label ID="lblCallCenterID" Text='<%# Eval("CallCenterID") %>' Visible="false" runat="server" />
                            <asp:Label ID="lblOreContratto" Text='<%# Eval("OreContratto") %>' Visible="false" runat="server" />
                            <telerik:RadGrid ID="gvTabulati" runat="server"  Skin="Simple" AutoGenerateColumns="false" DataSourceID="sdsTabulati" CellSpacing="0" GridLines="None" ShowFooter="true" OnItemDataBound="gvTabulati_ItemDataBound" >
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
                            <telerik:radtoolbar ID="tbAction" runat="server" Skin="Simple">
                                <Items>
                                    <telerik:RadToolBarButton Text="Genera PDF" Font-Bold="True" ImageUrl="~/image/pdf2.png" NavigateUrl='expsummary.aspx?x={0}&y={1}&mode=pdf' Target="_blank" CommandName="Pdf" />
                                </Items>
                            </telerik:radtoolbar>
                            <table border="0" cellpadding="3" cellspacing="3" width="600px">
                                <tr>
                                    <td width="350px" valign="top">
                                        <telerik:RadGrid ID="gvSummary" runat="server" Skin="Simple" AutoGenerateColumns="false" DataSourceID="sdsSummary" CellSpacing="0" GridLines="None" ShowHeader="true" ShowFooter="false" Width="100%" OnItemDataBound="gvSummary_ItemDataBound">
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
                                    <td width="350px" valign="top">
                                        <telerik:RadGrid ID="gvAnticipato" runat="server" Skin="Simple" AutoGenerateColumns="false" DataSourceID="sdsAnticipato" CellSpacing="0" GridLines="None" ShowHeader="true" ShowFooter="true" Width="100%">
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

            <ColumnGroups>
                <telerik:GridColumnGroup Name="Importi" HeaderText="Importi" HeaderStyle-HorizontalAlign="Center" />
            </ColumnGroups>

            <Columns>
                <telerik:GridBoundColumn DataField="AnnoRif" HeaderText="Anno" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" AllowFiltering="true" />
                <telerik:GridBoundColumn DataField="MeseRif" HeaderText="Mese" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" AllowFiltering="true" />
                <telerik:GridBoundColumn DataField="StatusDesc" HeaderText="Status complessivo" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="ImportoMaturato" HeaderText="maturato" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" ColumnGroupName="Importi" />
                <telerik:GridBoundColumn DataField="ImportoRiconosciuto" HeaderText="riconosciuto" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" ColumnGroupName="Importi" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotAgentexAnno" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:ControlParameter ControlID="lblAgenteGroupID" PropertyName="Text" Name="AgenteGroupID" Type="Int32" DefaultValue="" />
            <%--<asp:SessionParameter SessionField="UserInfo.EmployeeID" Name="AgenteGroupID"  />--%>
        </SelectParameters>
    </asp:SqlDataSource>
       
    <UC:legend ID="cLegends" runat="server" />
</asp:Content>