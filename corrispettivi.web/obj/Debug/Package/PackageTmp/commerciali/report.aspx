<%@ Page Title="" Language="C#" MasterPageFile="~/commerciali/local.master" AutoEventWireup="true" CodeBehind="report.aspx.cs" Inherits="corrispettivi.web.commerciali.report" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register src="~/legendStatusTabulato.ascx" tagname="legend" tagprefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
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
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="PeriodoRif,CommercialeID,StatusID">
  
            <ColumnGroups>
                <telerik:GridColumnGroup Name="Importi" HeaderText="Importi" HeaderStyle-HorizontalAlign="Center" />
            </ColumnGroups>

            <Columns>
                <telerik:GridHyperLinkColumn AllowSorting="False" HeaderText="" ImageUrl="~/image/list.png" DataNavigateUrlFields="PeriodoRif,CommercialeID,CommercialeNome,SourceID,TipoTabulatoID" DataNavigateUrlFormatString="~/redirectView.aspx?x={0}&y={1}&z={2}&key={3}&type=1&area=2" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center" target="_blank" UniqueName="view" AllowFiltering="false" />
                <telerik:GridHyperLinkColumn AllowSorting="False" HeaderText="" ImageUrl="~/image/excel.gif" DataNavigateUrlFields="PeriodoRif,CommercialeID,CommercialeNome,SourceID,TipoTabulatoID" DataNavigateUrlFormatString="~/redirectExport.aspx?x={0}&y={1}&z={2}&&key={3}&type=1&area=2&mode=xls" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center" UniqueName="export" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="AnnoRif" HeaderText="Anno" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" AllowFiltering="true" />
                <telerik:GridBoundColumn DataField="MeseRif" HeaderText="Mese" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" AllowFiltering="true" />
                <telerik:GridBoundColumn DataField="StatusDesc" HeaderText="Status" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="ImportoMaturato" HeaderText="maturato" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" ColumnGroupName="Importi" />
                <telerik:GridBoundColumn DataField="ImportoRiconosciuto" HeaderText="riconosciuto" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" ColumnGroupName="Importi" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotCommercialexAnno" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:SessionParameter SessionField="CommercialeID" Name="CommercialeID" />
        </SelectParameters>
    </asp:SqlDataSource>
       
    <UC:legend ID="cLegends" runat="server" />
</asp:Content>