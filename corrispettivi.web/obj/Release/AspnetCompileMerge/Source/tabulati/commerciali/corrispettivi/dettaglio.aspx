<%@ Page Title="" Language="C#" MasterPageFile="~/tabulati/commerciali/corrispettivi/local.master" AutoEventWireup="true" CodeBehind="dettaglio.aspx.cs" Inherits="corrispettivi.web.tabulati.commerciali.corrispettivi.dettaglio" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register src="~/tabulati/agenti/infoAgente.ascx" tagname="infoAgente" tagprefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblAction" runat="server" Text="" /></td></tr>
    </table>
    
    
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
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="CommercialeCorrispettivoPraticaID" ShowGroupFooter="true" GroupsDefaultExpanded="false">
            <ColumnGroups>
                <telerik:GridColumnGroup Name="Fatt" HeaderText="Fattura" HeaderStyle-HorizontalAlign="Center" />
                <telerik:GridColumnGroup Name="NotaCred" HeaderText="Nota di credito" HeaderStyle-HorizontalAlign="Center" />
                <telerik:GridColumnGroup Name="ProvvAcq" HeaderText="Acquisizione" HeaderStyle-HorizontalAlign="Center" />
                <telerik:GridColumnGroup Name="ProvvAss" HeaderText="Assistenza" HeaderStyle-HorizontalAlign="Center" />
            </ColumnGroups>

            <Columns>
                <telerik:GridBoundColumn DataField="CommittenteNome" HeaderText="Sottogruppo" HeaderStyle-Width="250px" HeaderStyle-HorizontalAlign="Center">
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
                <telerik:GridBoundColumn DataField="NumPag" HeaderText="Num.<br />pag." HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FooterText=" " Aggregate="Sum" FooterStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="NumServ" HeaderText="Num.<br />serv." HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FooterText=" " Aggregate="Sum" FooterStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="TotProvv" HeaderText="Totale<br />provvigioni" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
            </Columns>
            
            <GroupByExpressions>
                <telerik:GridGroupByExpression>
                    <SelectFields>
                        <telerik:GridGroupByField FieldAlias="Committente" FieldName="BaseNome" HeaderValueSeparator=": " />
                    </SelectFields>
                    <GroupByFields>
                        <telerik:GridGroupByField FieldName="BaseNome" />
                    </GroupByFields>
                </telerik:GridGroupByExpression>
            </GroupByExpressions>

            <DetailTables>
                <telerik:GridTableView Name="Dettaglio" DataKeyNames="CommercialeCorrispettivoPraticaDettaglioID" Width="100%" AutoGenerateColumns="false" ShowFooter="true" TableLayout="Fixed" AllowFilteringByColumn="false" SkinID="Balck">
                    <HeaderStyle CssClass="titnero9" ForeColor="DarkRed" Font-Bold="true" HorizontalAlign="Center" BackColor="#ffcc99" />
                    <FooterStyle CssClass="titnero9" ForeColor="DarkRed" Font-Bold="true" BackColor="#ffcc99" />
                    <Columns>
                        <telerik:GridBoundColumn HeaderText="Tipo" DataField="TipoCorrispettivoNome" HeaderStyle-Width="85px" />
                        <telerik:GridBoundColumn HeaderText="Prog" DataField="Progressivo" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="35px" />
                        
                        <telerik:GridBoundColumn HeaderText="fatt. data" DataField="FatturaData" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d}" ColumnGroupName="Fatt" />
                        <telerik:GridBoundColumn HeaderText="fatt. num." DataField="FatturaNum" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="Fatt" />

                        <telerik:GridBoundColumn HeaderText="nota cred. data" DataField="NotaCreditodata" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d}" ColumnGroupName="NotaCred"  />
                        <telerik:GridBoundColumn HeaderText="nota cred. num." DataField="NotaCreditoNum" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="NotaCred" />

                        <telerik:GridBoundColumn DataField="Provv1_Perc" HeaderText="acq. %" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="ProvvAcq" />
                        <telerik:GridBoundColumn DataField="Provv1_Imp" HeaderText="acq.imp." HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" ColumnGroupName="ProvvAcq" />

                        <telerik:GridBoundColumn DataField="Provv2_Perc" HeaderText="ass. %" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="ProvvAss" />
                        <telerik:GridBoundColumn DataField="Provv2_Imp" HeaderText="ass.imp." HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" ColumnGroupName="ProvvAss" />
                    </Columns>
                </telerik:GridTableView>
            </DetailTables>
        </MasterTableView>
    </telerik:RadGrid>
        
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xCommercialiCorrispettiviPraticheView" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="CommercialeCorrispettivoID" />
            <asp:QueryStringParameter QueryStringField="y" Name="CommercialeID" />
            <asp:QueryStringParameter QueryStringField="x" Name="PeriodoRif" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsSocieta" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommand="select SocietaID, Denominazione, Alias from Societa order by Denominazione" 
        SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

    <asp:SqlDataSource ID="sdsCommittenti" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>"
        SelectCommand="select distinct CommittenteNome FROM CommercialiCorrispettiviPratiche WHERE CommercialeCorrispettivoID = @CommercialeCorrispettivoID Order by CommittenteNome">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="CommercialeCorrispettivoID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsPraticaID" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>"
        SelectCommand="SELECT DISTINCT SocietaID, PraticaID, concat(SocietaID,'-',PraticaID) as PraticaAlias FROM CommercialiCorrispettiviPratiche WHERE CommercialeCorrispettivoID = @CommercialeCorrispettivoID Order by PraticaID">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="CommercialeCorrispettivoID" />
        </SelectParameters>
    </asp:SqlDataSource>
    
</asp:Content>