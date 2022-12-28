<%@ Page Title="" Language="C#" MasterPageFile="~/tabulati/agenti/bc/local.master" AutoEventWireup="true" CodeBehind="dettaglio.aspx.cs" Inherits="corrispettivi.web.tabulati.agenti.bc.dettaglio" %>
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
    <telerik:RadGrid ID="gvInfo" runat="server" Skin="Simple" AllowSorting="True" CellSpacing="0" GridLines="None" DataSourceID="sdsInfo" Height="550px" ShowFooter="true" OnDetailTableDataBind="gvInfo_DetailTableDataBind">
        <SelectedItemStyle CssClass="SelectedStyle" />
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" />
        <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
        <FilterMenu Skin="Black" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="AgenteBcPresenzaID">
            <Columns>
                <telerik:GridBoundColumn DataField="DataPresenza" HeaderText="Data" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d}" Aggregate="Count" FooterStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="ContattiEffettivi" HeaderText="Cnt. effettivi" HeaderStyle-Width="65px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="Contatti"  Aggregate="Sum" FooterStyle-HorizontalAlign="Center" />
            </Columns>

            <DetailTables>
                <telerik:GridTableView Name="Dettaglio" DataKeyNames="AgenteBcPresenzaDettaglioID" AutoGenerateColumns="false" ShowFooter="true" TableLayout="Fixed" AllowFilteringByColumn="false" SkinID="Balck">
                    <HeaderStyle CssClass="titnero9" ForeColor="DarkRed" Font-Bold="true" HorizontalAlign="Center" BackColor="#ffcc99" />
                    <FooterStyle CssClass="titnero9" ForeColor="DarkRed" Font-Bold="true" BackColor="#ffcc99" />
                    <Columns>
                        <telerik:GridBoundColumn HeaderText="Codice" DataField="AgenteID" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" />
                        <telerik:GridBoundColumn HeaderText="Pratica" DataField="PraticaAlias" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" />
                        <telerik:GridBoundColumn HeaderText="Cnt" DataField="ContattiEffettivi" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                        <telerik:GridCheckBoxColumn HeaderText="Gen" DataField="ServizioGen" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="35px" />
                        <telerik:GridBoundColumn HeaderText="Cod.Serv." DataField="ServizioCodice" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                        <telerik:GridBoundColumn HeaderText="Cod.Int." DataField="ServzioCodInt" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                    </Columns>
                </telerik:GridTableView>
            </DetailTables>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xAgentiBcPresenzeView" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgenteBcID" />
            <asp:QueryStringParameter QueryStringField="y" Name="AgenteGroupID" />
            <asp:QueryStringParameter QueryStringField="x" Name="PeriodoRif" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>