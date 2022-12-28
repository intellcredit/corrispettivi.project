<%@ Page Title="" Language="C#" MasterPageFile="~/settings/callcenter/local.master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="corrispettivi.web.settings.callcenter._default" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblAction" runat="server" Text="" /></td></tr>
    </table>
    <br />
    <telerik:RadGrid ID="gvInfo" runat="server" Skin="Simple" AllowPaging="True" AllowSorting="True" CellSpacing="0" GridLines="None" PageSize="25" DataSourceID="sdsInfo" Height="700px">
        <SelectedItemStyle CssClass="SelectedStyle" />
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="paramCallCenterID">
            <ColumnGroups>
                <telerik:GridColumnGroup Name="Tabulato" HeaderText="Elabora tabulato" HeaderStyle-HorizontalAlign="Center" />
                <telerik:GridColumnGroup Name="Profilo" HeaderText="Visibile ai profili" HeaderStyle-HorizontalAlign="Center" />
                <telerik:GridColumnGroup Name="Validita" HeaderText="Periodo di validità" HeaderStyle-HorizontalAlign="Center" />
                <telerik:GridColumnGroup Name="Import" HeaderText="Dati importati" HeaderStyle-HorizontalAlign="Center" />
            </ColumnGroups>
            <Columns>
                <telerik:GridHyperLinkColumn AllowFiltering="False" AllowSorting="False" HeaderText="" ImageUrl="~/image/Modify.png" DataNavigateUrlFields="paramCallCenterID" DataNavigateUrlFormatString="scheda.aspx?id={0}" HeaderStyle-Width="30px" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="CallCenterID" HeaderText="ID" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="Nominativo" HeaderText="Call center" HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center" />

                <telerik:GridCheckBoxColumn DataField="execAgentiCorrispettivi" HeaderText="Corrisp." HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="Tabulato" />
                <telerik:GridCheckBoxColumn DataField="execAgentiPremi" HeaderText="Premi" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="Tabulato" />
                <telerik:GridCheckBoxColumn DataField="execAgentiIntegrazioni" HeaderText="B.P." HeaderTooltip="Bonus provvigionali" HeaderStyle-Width="45px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="Tabulato" />
                <telerik:GridCheckBoxColumn DataField="execAgentiSpese" HeaderText="Spese" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="Tabulato" />
                <telerik:GridCheckBoxColumn DataField="execAgentiBc" HeaderText="B.C." HeaderTooltip="Bonus contatti" HeaderStyle-Width="45px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="Tabulato" />
                <telerik:GridCheckBoxColumn DataField="execAgentiBsl" HeaderText="B.S.L." HeaderTooltip="Bonus salva lavoro" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="Tabulato" />
                <telerik:GridCheckBoxColumn DataField="execAgentiOreStraordinarie" HeaderText="O.S." HeaderTooltip="Ore straordinarie" HeaderStyle-Width="45px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="Tabulato" />

                <telerik:GridCheckBoxColumn DataField="viewAmministratore" HeaderText="Admin" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="Profilo" />
                <telerik:GridCheckBoxColumn DataField="viewDirezione" HeaderText="Direzione" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="Profilo" />
                <telerik:GridCheckBoxColumn DataField="viewContabilita" HeaderText="Contabilita" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="Profilo" />
                <telerik:GridCheckBoxColumn DataField="viewUffPersonale" HeaderText="Uff. personale" HeaderStyle-Width="65px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="Profilo" />

                <telerik:GridCheckBoxColumn DataField="viewOreLavorative" HeaderText="Ore ctr" HeaderStyle-Width="65px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ColumnGroupName="Import" />

                <telerik:GridBoundColumn DataField="DataInizio" HeaderText="Inizio" HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:MM/yyyy}" ColumnGroupName="Validita" />
                <telerik:GridBoundColumn DataField="DataFine" HeaderText="Fine" HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:MM/yyyy}" ColumnGroupName="Validita" />
                <telerik:GridBoundColumn DataField="DATA_ULTIMA_MODIFICA" HeaderText="Data ult. modifica" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
            </Columns>
            <GroupByExpressions>
                <telerik:GridGroupByExpression>
                    <SelectFields>
                        <telerik:GridGroupByField FieldAlias="CallCenter" FieldName="Nominativo" HeaderValueSeparator=": " />
                    </SelectFields>
                    <GroupByFields>
                        <telerik:GridGroupByField FieldName="Nominativo" />
                    </GroupByFields>
                </telerik:GridGroupByExpression>
            </GroupByExpressions>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xParamCallCenterView" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" />
</asp:Content>