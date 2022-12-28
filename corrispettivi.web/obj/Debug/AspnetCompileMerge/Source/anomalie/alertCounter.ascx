<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="alertCounter.ascx.cs" Inherits="corrispettivi.web.anomalie.WebUserControl2" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<table id="tblAnomalie" runat="server" border="0" cellpadding="1" cellspacing="1" width="100%">
    <tr><td class="titrosso12">Anomalie riscontrate durante l'ultima elaborazione sugli agenti</td></tr>
    <tr>
        <td>
            <telerik:RadGrid ID="gvAnomalieAgenti" runat="server" Skin="Simple" AllowPaging="false" AllowSorting="false" AllowFilteringByColumn="false" CellSpacing="0" GridLines="None" DataSourceID="sdsInfo" ShowFooter="true" Width="500px">
                <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
                <AlternatingItemStyle VerticalAlign="Top" />
                <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
                <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" >
                    <Columns>
                        <telerik:GridHyperLinkColumn HeaderText="Descrizione" HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center" 
                                                DataTextField="Descrizione" DataNavigateUrlFields="TipoAnomaliaID" 
                                                DataNavigateUrlFormatString="repAlertAgenti.aspx?x={0}"
                                                FooterStyle-HorizontalAlign="Right" />
                        <telerik:GridBoundColumn HeaderText="Totale" HeaderStyle-Width="35px" HeaderStyle-HorizontalAlign="Center"
                                    ItemStyle-HorizontalAlign="Center"                        
                                    DataField="Totale"
                                    FooterStyle-HorizontalAlign="Center"                        
                                    FooterAggregateFormatString="{0}"
                                    Aggregate="Sum" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </td>
    </tr>
</table>


<asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" 
    SelectCommand="pivotAnomalieAgentiCount" SelectCommandType="StoredProcedure"
    ConnectionString="<%$ ConnectionStrings:dbConn%>" />