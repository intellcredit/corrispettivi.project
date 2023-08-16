<%@ Page Title="" Language="C#" MasterPageFile="~/tabulati/agenti/corrispettivi/local.master" AutoEventWireup="true" CodeBehind="dettaglio.aspx.cs" Inherits="corrispettivi.web.tabulati.agenti.corrispettivi.dettaglio" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register src="~/tabulati/agenti/infoAgente.ascx" tagname="infoAgente" tagprefix="UC" %>
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
        <GroupHeaderItemStyle Font-Bold="true" ForeColor="#0066ff" />
        <GroupingSettings RetainGroupFootersVisibility="true" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="AgenteCorrispettivoPraticaID" ShowGroupFooter="true" GroupsDefaultExpanded="false">
            <Columns>
                <telerik:GridBoundColumn DataField="CommittenteNome" HeaderText="Committente" HeaderStyle-Width="250px" HeaderStyle-HorizontalAlign="Center">
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="CommittenteCombo" DataSourceID="sdsCommittenti" DataTextField="CommittenteNome" Skin="Black" Filter="Contains"
                            DataValueField="CommittenteNome" Height="200px" Width="250px" DropDownWidth="300px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("CommittenteNome").CurrentFilterValue %>' 
                            runat="server" OnClientSelectedIndexChanged="CommittenteComboIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="TUTTI" />
                            </Items>
                        </telerik:RadComboBox>
                        <telerik:RadScriptBlock ID="rsbCommittenti" runat="server">
                            <script type="text/javascript">
                                function CommittenteComboIndexChanged(sender, args) {
                                    var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                    tableView.filter("CommittenteNome", args.get_item().get_value(), "EqualTo");
                                }
                            </script>
                        </telerik:RadScriptBlock>
                    </FilterTemplate>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PraticaAlias" HeaderText="Pratica" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Aggregate="Count" FooterStyle-HorizontalAlign="Center">
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="PraticaIDCombo" DataSourceID="sdsPraticaID" DataTextField="PraticaAlias" Skin="Black" Filter="Contains"
                            DataValueField="PraticaAlias" Height="200px" Width="140px" DropDownWidth="140px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("PraticaAlias").CurrentFilterValue %>' 
                            runat="server" OnClientSelectedIndexChanged="PraticaIDComboIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="TUTTI" />
                            </Items>
                        </telerik:RadComboBox>
                        <telerik:RadScriptBlock ID="rsbPraticaID" runat="server">
                            <script type="text/javascript">
                                function PraticaIDComboIndexChanged(sender, args) {
                                    var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                    tableView.filter("PraticaAlias", args.get_item().get_value(), "EqualTo");
                                }
                            </script>
                        </telerik:RadScriptBlock>
                    </FilterTemplate>
                </telerik:GridBoundColumn>
                <%--<telerik:GridBoundColumn DataField="Contratto" HeaderText="Contratto" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" >
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="ContrattoCombo" DataSourceID="sdsContratto" DataTextField="Contratto" Skin="Black" Filter="Contains"
                            DataValueField="Contratto" Height="200px" Width="150px" DropDownWidth="150px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("Contratto").CurrentFilterValue %>' 
                            runat="server" OnClientSelectedIndexChanged="ContrattoComboIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="TUTTI" />
                            </Items>
                        </telerik:RadComboBox>
                        <telerik:RadScriptBlock ID="rsbContratto" runat="server">
                            <script type="text/javascript">
                                function ContrattoComboIndexChanged(sender, args) {
                                    var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                    tableView.filter("Contratto", args.get_item().get_value(), "EqualTo");
                                }
                            </script>
                        </telerik:RadScriptBlock>
                    </FilterTemplate>
                </telerik:GridBoundColumn>--%>
                <telerik:GridBoundColumn DataField="DataQuestura" HeaderText="Data<br />questura" HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d}">
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="DataQuesturaCombo" DataSourceID="sdsDataQuestura" DataTextField="DataQuestura" Skin="Black" Filter="Contains"
                            DataValueField="DataQuestura" Height="200px" Width="90px" DropDownWidth="100px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("DataQuestura").CurrentFilterValue %>' 
                            runat="server" OnClientSelectedIndexChanged="DataQuesturaComboIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="TUTTI" />
                            </Items>
                        </telerik:RadComboBox>
                        <telerik:RadScriptBlock ID="rsbDataQuestura" runat="server">
                            <script type="text/javascript">
                                function DataQuesturaComboIndexChanged(sender, args) {
                                    var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                    tableView.filter("DataQuestura", args.get_item().get_value(), "EqualTo");
                                }
                            </script>
                        </telerik:RadScriptBlock>
                    </FilterTemplate>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="DataScadenza" HeaderText="Data<br />scadenza" HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d}">
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="DataScadenzaCombo" DataSourceID="sdsDataScadenza" DataTextField="DataScadenza" Skin="Black" Filter="Contains"
                            DataValueField="DataScadenza" Height="200px" Width="90px" DropDownWidth="100px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("DataScadenza").CurrentFilterValue %>' 
                            runat="server" OnClientSelectedIndexChanged="DataScadenzaComboIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="TUTTI" />
                            </Items>
                        </telerik:RadComboBox>
                        <telerik:RadScriptBlock ID="rsbDataScadenza" runat="server">
                            <script type="text/javascript">
                                function DataScadenzaComboIndexChanged(sender, args) {
                                    var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                    tableView.filter("DataScadenza", args.get_item().get_value(), "EqualTo");
                                }
                            </script>
                        </telerik:RadScriptBlock>
                    </FilterTemplate>
                </telerik:GridBoundColumn>
                <%--<telerik:GridBoundColumn DataField="DebitoreNome" HeaderText="Debitore" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" FooterText=" " FooterStyle-HorizontalAlign="Center" AllowFiltering="false" />--%>
                <telerik:GridBoundColumn DataField="NumPag" HeaderText="Num.<br />pag." HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FooterText=" " Aggregate="Sum" FooterStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="NumServ" HeaderText="Num.<br />serv." HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FooterText=" " Aggregate="Sum" FooterStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Imponibile" HeaderText="Imponibile" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Percentuale" HeaderText="%" HeaderStyle-Width="35px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="ImponibileSurplus" HeaderText="Imponibile plus" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="PercentualeSurplus" HeaderText="% plus" HeaderStyle-Width="35px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="TotProvv" HeaderText="Provvigioni" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="TotFissi" HeaderText="Fissi" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
            </Columns>

            <GroupByExpressions>
                <telerik:GridGroupByExpression>
                    <SelectFields>
                        <telerik:GridGroupByField FieldAlias="Agente" FieldName="AgenteAlias" HeaderValueSeparator=": " />
                    </SelectFields>
                    <GroupByFields>
                        <telerik:GridGroupByField FieldName="AgenteAlias" />
                    </GroupByFields>
                </telerik:GridGroupByExpression>
            </GroupByExpressions>
            
            <DetailTables>
                <telerik:GridTableView Name="Dettaglio" DataKeyNames="AgenteCorrispettivoPraticaDettaglioID" Width="100%" AutoGenerateColumns="false" ShowFooter="true" TableLayout="Fixed" AllowFilteringByColumn="false" SkinID="Balck">
                    <HeaderStyle CssClass="titnero9" ForeColor="DarkRed" Font-Bold="true" HorizontalAlign="Center" BackColor="#ffcc99" />
                    <FooterStyle CssClass="titnero9" ForeColor="DarkRed" Font-Bold="true" BackColor="#ffcc99" />
                    <ColumnGroups>
                        <telerik:GridColumnGroup Name="ImpRec" HeaderText="Importi recuperati" HeaderStyle-HorizontalAlign="Center" />
                    </ColumnGroups>
                    <Columns>
                        <telerik:GridBoundColumn HeaderText="Tipo" DataField="TipoCorrispettivoNome" HeaderStyle-Width="85px" />
                        <telerik:GridBoundColumn HeaderText="Prog" DataField="Progressivo" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="35px" />
                        <telerik:GridBoundColumn HeaderText="Data" DataField="Data" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d}" />
                        <telerik:GridBoundColumn HeaderText="Descrizione" DataField="Descrizione" HeaderStyle-Width="350px" />

                        <telerik:GridBoundColumn HeaderText="Modalità" DataField="TipoPagamento" HeaderStyle-Width="100px" />
                        <telerik:GridBoundColumn HeaderText="Dt pag. ant." DataField="DataAnticipato" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d}" />


                        <telerik:GridBoundColumn DataField="Capitale" HeaderText="Capitale" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" ColumnGroupName="ImpRec" />
                        <telerik:GridBoundColumn DataField="Interessi" HeaderText="Interessi" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" ColumnGroupName="ImpRec" />
                        <telerik:GridBoundColumn DataField="Spese" HeaderText="Spese" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" ColumnGroupName="ImpRec" />
                        <telerik:GridBoundColumn DataField="ProvvImporto" HeaderText="Provvigioni" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                        <telerik:GridBoundColumn DataField="FissoImporto" HeaderText="Fisso" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                    </Columns>
                </telerik:GridTableView>
            </DetailTables>
        </MasterTableView>
    </telerik:RadGrid>

    

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xAgentiCorrispettiviPraticheView" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgenteCorrispettivoID" />
            <asp:QueryStringParameter QueryStringField="y" Name="AgenteGroupID" />
            <asp:QueryStringParameter QueryStringField="x" Name="PeriodoRif" />
        </SelectParameters>
    </asp:SqlDataSource>

    <%--<asp:SqlDataSource ID="sdsInfoDettaglio" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" />--%>

    <asp:SqlDataSource ID="sdsAgenteID" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>"
        SelectCommand="select distinct AgenteID FROM AgentiCorrispettiviPratiche WHERE AgenteCorrispettivoID = @AgenteCorrispettivoID Order by AgenteID">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgenteCorrispettivoID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsSocieta" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommand="select SocietaID, Denominazione, Alias from Societa order by Denominazione" 
        SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

    <asp:SqlDataSource ID="sdsCommittenti" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>"
        SelectCommand="select distinct CommittenteNome FROM AgentiCorrispettiviPratiche WHERE AgenteCorrispettivoID = @AgenteCorrispettivoID Order by CommittenteNome">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgenteCorrispettivoID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsPraticaID" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>"
        SelectCommand="SELECT DISTINCT SocietaID, PraticaID, concat(SocietaID,'-',PraticaID) as PraticaAlias FROM AgentiCorrispettiviPratiche WHERE AgenteCorrispettivoID = @AgenteCorrispettivoID Order by PraticaID">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgenteCorrispettivoID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsContratto" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>"
        SelectCommand="SELECT DISTINCT Contratto FROM AgentiCorrispettiviPratiche WHERE AgenteCorrispettivoID = @AgenteCorrispettivoID order by Contratto">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgenteCorrispettivoID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsDataQuestura" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>"
        SelectCommand="SELECT DISTINCT format(DataQuestura,'dd/MM/yyyy') as DataQuestura FROM AgentiCorrispettiviPratiche WHERE AgenteCorrispettivoID = @AgenteCorrispettivoID Order by DataQuestura">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgenteCorrispettivoID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsDataScadenza" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>"
        SelectCommand="SELECT DISTINCT format(DataScadenza,'dd/MM/yyyy') as DataScadenza FROM AgentiCorrispettiviPratiche WHERE AgenteCorrispettivoID = @AgenteCorrispettivoID order by DataScadenza">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgenteCorrispettivoID" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>