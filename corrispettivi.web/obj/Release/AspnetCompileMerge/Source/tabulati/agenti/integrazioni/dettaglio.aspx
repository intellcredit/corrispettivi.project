<%@ Page Title="" Language="C#" MasterPageFile="~/tabulati/agenti/integrazioni/local.master" AutoEventWireup="true" CodeBehind="dettaglio.aspx.cs" Inherits="corrispettivi.web.tabulati.agenti.integrazioni.dettaglio" %>
<%@ Register src="~/tabulati/agenti/infoAgente.ascx" tagname="infoAgente" tagprefix="UC" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblAction" runat="server" Text="" /></td></tr>
    </table>
    <UC:infoAgente ID="infoAgente1" runat="server" width="100%" />
    <%--<table border="0" cellpadding="2" cellspacing="2" width="100%">
        <tr bgcolor="white">
            <td nowrap><font class="titnero10">Periodo:</font> <asp:Label ID="lblPeriodo" runat="server" Text="" CssClass="titrosso12" /></td>
            <td nowrap><font class="titnero10">Ore ctr:</font> <asp:Label ID="lblOreContratto" runat="server" Text="" CssClass="titrosso12" /></td>
            <td nowrap><font class="titnero10">Codice raggruppamento:</font> <asp:Label ID="lblAgenteGroupID" runat="server" Text="" CssClass="titrosso12" /></td>
            <td width="100%"><font class="titnero10">Nome:</font> <asp:Label ID="lblAgenteGroupNome" runat="server" Text="" CssClass="titrosso12" /></td>
            <td nowrap><asp:HyperLink ID="hlBack" runat="server" CssClass="titnero10" NavigateUrl="report.aspx?x={0}">TORNA AL REPORT</asp:HyperLink></td>
        </tr>
    </table>--%>
    <telerik:RadGrid ID="gvInfo" runat="server" Skin="Simple" AllowFilteringByColumn="true" AllowSorting="True" GridLines="None" CellPadding="0" CellSpacing="1" BorderColor="Black" DataSourceID="sdsInfo" Height="550px" ShowFooter="true" OnDetailTableDataBind="gvInfo_DetailTableDataBind">
        <SelectedItemStyle CssClass="SelectedStyle" />
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" />
        <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
        <FilterMenu Skin="Black" />
        
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="AgenteIntegrazioneContrattoID" ShowGroupFooter="true" GroupsDefaultExpanded="false">
            <ColumnGroups>
                <telerik:GridColumnGroup Name="PREMIO" HeaderText="PREMIO" HeaderStyle-HorizontalAlign="Center" />
                <telerik:GridColumnGroup Name="OB1" HeaderText="Obbiettivo1" HeaderStyle-HorizontalAlign="Center" />
                <telerik:GridColumnGroup Name="OB2" HeaderText="Obbiettivo2" HeaderStyle-HorizontalAlign="Center" />
                <telerik:GridColumnGroup Name="OB3" HeaderText="Obbiettivo3" HeaderStyle-HorizontalAlign="Center" />
            </ColumnGroups>

            <Columns>
                <telerik:GridBoundColumn DataField="AgenteAlias" HeaderText="Agente" HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center">
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="AgenteCombo" DataSourceID="sdsAgenti" DataTextField="AgenteAlias" Skin="Black" Filter="Contains"
                            DataValueField="AgenteAlias" Height="200px" Width="180px" DropDownWidth="250px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("AgenteAlias").CurrentFilterValue %>' 
                            runat="server" OnClientSelectedIndexChanged="AgenteComboIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="TUTTI" />
                            </Items>
                        </telerik:RadComboBox>
                        <telerik:RadScriptBlock ID="rsbAgenti" runat="server">
                            <script type="text/javascript">
                                function AgenteComboIndexChanged(sender, args) {
                                    var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                    tableView.filter("AgenteAlias", args.get_item().get_value(), "EqualTo");
                                }
                            </script>
                        </telerik:RadScriptBlock>
                    </FilterTemplate>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ContrattoDescrizione" HeaderText="Contratto" HeaderStyle-Width="250px" HeaderStyle-HorizontalAlign="Center">
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="ContrattoCombo" DataSourceID="sdsContratti" DataTextField="ContrattoDescrizione" Skin="Black" Filter="Contains"
                            DataValueField="ContrattoDescrizione" Height="200px" Width="240px" DropDownWidth="350px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("ContrattoDescrizione").CurrentFilterValue %>' 
                            runat="server" OnClientSelectedIndexChanged="ContrattoComboIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="TUTTI" />
                            </Items>
                        </telerik:RadComboBox>
                        <telerik:RadScriptBlock ID="rsbContratti" runat="server">
                            <script type="text/javascript">
                                function ContrattoComboIndexChanged(sender, args) {
                                    var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                    tableView.filter("ContrattoDescrizione", args.get_item().get_value(), "EqualTo");
                                }
                            </script>
                        </telerik:RadScriptBlock>
                    </FilterTemplate>
                </telerik:GridBoundColumn>

                <telerik:GridBoundColumn DataField="IMPONIBILE_PREMIO" HeaderText="Imponibile" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" ColumnGroupName="PREMIO" />
                <telerik:GridBoundColumn DataField="PREMIO" HeaderText="%" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" AllowFiltering="false"  ColumnGroupName="PREMIO" />
                <telerik:GridBoundColumn DataField="IMPORTO_PREMIO" HeaderText="Importo" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" FooterStyle-HorizontalAlign="Right" AllowFiltering="false"  ColumnGroupName="PREMIO" />

                <telerik:GridTemplateColumn HeaderText="fascia" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" ColumnGroupName="OB1">
                    <ItemTemplate><%# Eval("OB1_FASCIA_DA")%> - <%# Eval("OB1_FASCIA_A")%></ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="OB1_RISULTATO" HeaderText="% risultato" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" ColumnGroupName="OB1" />

                <telerik:GridTemplateColumn HeaderText="fascia" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" ColumnGroupName="OB2">
                    <ItemTemplate><%# Eval("OB2_FASCIA_DA")%> - <%# Eval("OB2_FASCIA_A")%></ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="OB2_RISULTATO" HeaderText="% risultato" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" ColumnGroupName="OB2" />

                <telerik:GridTemplateColumn HeaderText="fascia" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" ColumnGroupName="OB3">
                    <ItemTemplate><%# Eval("OB3_FASCIA_DA")%> - <%# Eval("OB3_FASCIA_A")%></ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="OB3_RISULTATO" HeaderText="% risultato" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" ColumnGroupName="OB3" />
            </Columns>

            <DetailTables>
                <telerik:GridTableView Name="Dettaglio" DataKeyNames="AgenteIntegrazioneContrattoDettaglioID" Width="100%" AutoGenerateColumns="false" ShowFooter="true" TableLayout="Fixed" AllowFilteringByColumn="false" SkinID="Balck">
                    <HeaderStyle CssClass="titnero9" ForeColor="DarkRed" Font-Bold="true" HorizontalAlign="Center" BackColor="#ffcc99" />
                    <FooterStyle CssClass="titnero9" ForeColor="DarkRed" Font-Bold="true" BackColor="#ffcc99" />
                    <ColumnGroups>
                        <telerik:GridColumnGroup Name="DATA" HeaderText="Data" HeaderStyle-HorizontalAlign="Center" />
                        <telerik:GridColumnGroup Name="IMP" HeaderText="Importo" HeaderStyle-HorizontalAlign="Center" />
                    </ColumnGroups>
                    <Columns>
                        <telerik:GridBoundColumn HeaderText="Committente" DataField="CommittenteNome" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="200px" />
                        <telerik:GridBoundColumn HeaderText="Pratica" DataField="PraticaAlias" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Aggregate="Count" FooterStyle-HorizontalAlign="Right" />
                        <telerik:GridBoundColumn HeaderText="Contratto" DataField="Contratto" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                        <%--<telerik:GridBoundColumn DataField="DebitoreNome" HeaderText="Debitore" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" />--%>
                        <telerik:GridBoundColumn HeaderText="Affidamento" DataField="DataQuestura" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d}" ColumnGroupName="DATA" />
                        <telerik:GridBoundColumn HeaderText="Scadenza" DataField="DataScadenza" HeaderStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d}" ColumnGroupName="DATA" />
                        <telerik:GridBoundColumn DataField="ImpAff" HeaderText="Affidato" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" ColumnGroupName="IMP" />
                        <telerik:GridBoundColumn DataField="ImpRec" HeaderText="Recuperato" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" ColumnGroupName="IMP" />
                    </Columns>
                </telerik:GridTableView>
            </DetailTables>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xAgentiIntegrazioniContrattiView" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgenteIntegrazioneID" />
            <asp:QueryStringParameter QueryStringField="y" Name="AgenteGroupID" />
            <asp:QueryStringParameter QueryStringField="x" Name="PeriodoRif" />
        </SelectParameters>
    </asp:SqlDataSource>

    <%--<asp:SqlDataSource ID="sdsInfoDettaglio" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" />--%>

    <asp:SqlDataSource ID="sdsAgenti" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>"
        SelectCommand="SELECT DISTINCT concat(AgenteNome,' (',AgenteID,')') as AgenteAlias FROM AgentiIntegrazioniContratti WHERE AgenteIntegrazioneID = @AgenteIntegrazioneID Order by AgenteAlias">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgenteIntegrazioneID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsContratti" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>"
        SelectCommand="select distinct ContrattoDescrizione FROM AgentiIntegrazioniContratti WHERE AgenteIntegrazioneID = @AgenteIntegrazioneID Order by ContrattoDescrizione">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgenteIntegrazioneID" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>