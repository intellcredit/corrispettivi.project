<%@ Page Title="" Language="C#" MasterPageFile="~/settings/bsl-cg/local.master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="corrispettivi.web.settings.bsl_cg._default" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblAction" runat="server" Text="" /></td></tr>
    </table>
    <br />
    <telerik:RadGrid ID="gvInfo" runat="server" Skin="Simple" AllowPaging="True" AllowSorting="True" CellSpacing="0" GridLines="None" PageSize="25" DataSourceID="sdsInfo" Height="650px">
        <SelectedItemStyle CssClass="SelectedStyle" />
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="paramBslCompensoGiornalieroID">
            <ColumnGroups>
                <telerik:GridColumnGroup Name="Contatti" HeaderText="Numero contatti" HeaderStyle-HorizontalAlign="Center" />
                <telerik:GridColumnGroup Name="Validita" HeaderText="Periodo di validità" HeaderStyle-HorizontalAlign="Center" />
            </ColumnGroups>
            <Columns>
                <telerik:GridHyperLinkColumn AllowFiltering="False" AllowSorting="False" HeaderText="" ImageUrl="~/image/Modify.png" DataNavigateUrlFields="paramBslCompensoGiornalieroID" DataNavigateUrlFormatString="scheda.aspx?id={0}" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="OreContratto" HeaderText="Ore contrattuali" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="CntNumMin" HeaderText="minimo" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Top" ColumnGroupName="Contatti" ItemStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="CntNumMax" HeaderText="massimo" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Top" ColumnGroupName="Contatti" ItemStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="Compenso" HeaderText="Compenso" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}"  />
                <telerik:GridBoundColumn DataField="DataInizio" HeaderText="Inizio validità" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d}" ColumnGroupName="Validita" />
                <telerik:GridBoundColumn DataField="DataFine" HeaderText="Fine validità" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d}" ColumnGroupName="Validita" />
                <telerik:GridBoundColumn DataField="DATA_ULTIMA_MODIFICA" HeaderText="Data ult.mod." HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
            </Columns>
            <GroupByExpressions>
                <telerik:GridGroupByExpression>
                    <SelectFields>
                        <telerik:GridGroupByField FieldAlias="Ore" FieldName="OreContratto" HeaderValueSeparator=" " />
                    </SelectFields>
                    <GroupByFields>
                        <telerik:GridGroupByField FieldName="OreContratto" />
                    </GroupByFields>
                </telerik:GridGroupByExpression>
            </GroupByExpressions>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xParamBslCompensiGiornalieriView" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" />
</asp:Content>