<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="expperiodo-tabulati-all.aspx.cs" Inherits="corrispettivi.web.uffpersonale.expperiodo_tabulati_all" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="exportHead" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="exportMain" Runat="Server">
    <telerik:RadGrid ID="gvInfo" GridLines="None" CellPadding="0" CellSpacing="1" runat="server" ShowHeader="true" ShowFooter="true" DataSourceID="sdsInfo"  OnExcelExportCellFormatting="gvInfo_ExportCellFormatting">
        <ExportSettings FileName="Presenze" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" HideStructureColumns="true">
            <Csv ColumnDelimiter="VerticalBar" RowDelimiter="NewLine" FileExtension="csv" EncloseDataWithQuotes="true" />
            <Excel Format="ExcelML" FileExtension="xls" />
        </ExportSettings>
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" BackColor="LightGray" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed">
            <Columns>
                <telerik:GridBoundColumn DataField="CallCenterNome" HeaderText="CallCenter" />
                <telerik:GridBoundColumn DataField="TipoTabulatoDesc"  HeaderText="Tabulato" />
                <telerik:GridBoundColumn DataField="Importo"  HeaderText="Totale" DataFormatString="{0:C}" />
                <telerik:GridBoundColumn DataField="StatusDesc"  HeaderText="Status" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotContabilitaxPeriodo_ExportTabulati" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="x" Name="PeriodoRif" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>