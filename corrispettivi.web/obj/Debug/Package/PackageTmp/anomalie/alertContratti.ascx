<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="alertContratti.ascx.cs" Inherits="corrispettivi.web.anomalie.WebUserControl1" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<table id="tblAnomalie" runat="server" border="0" cellpadding="1" cellspacing="1" width="100%">
    <tr><td class="titrosso12">Anomalie riscontrate sui contratti agente</td></tr>
    <tr>
        <td>
            <telerik:RadGrid ID="gvAnomalieAgenti" runat="server" Skin="Simple" AllowPaging="false" AllowSorting="false" AllowFilteringByColumn="false" CellSpacing="0" GridLines="None" DataSourceID="sdsInfo" ShowFooter="true" Width="500px">
                <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
                <AlternatingItemStyle VerticalAlign="Top" />
                <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
                <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" >
                    <Columns>
                        <telerik:GridHyperLinkColumn AllowFiltering="False" AllowSorting="False" HeaderText="" ImageUrl="~/image/Modify.png" DataNavigateUrlFields="AgenteContrattoID" DataNavigateUrlFormatString="~/settings/ag-ctr/scheda.aspx?id={0}" HeaderStyle-Width="30px" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center" />
                        <telerik:GridBoundColumn HeaderText="Periodo" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="PeriodoRif" />
                        <telerik:GridBoundColumn HeaderText="Callcenter" HeaderStyle-Width="200px" DataField="CallCenterNome" />
                        <telerik:GridBoundColumn HeaderText="Agente" HeaderStyle-Width="200px" DataField="AgenteGroupAlias" />
                        <telerik:GridBoundColumn HeaderText="Messaggio" HeaderStyle-Width="400px" DataField="Messaggio" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </td>
    </tr>
</table>

<asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" 
    SelectCommand="xAgentiContrattiAlertView" 
    SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>" >

</asp:SqlDataSource>