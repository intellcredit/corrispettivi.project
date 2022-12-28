<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="expperiodo-tabulati.aspx.cs" Inherits="corrispettivi.web.callcenter.expperiodo_tabulati" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="exportHead" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="exportMain" Runat="Server">
    <telerik:RadGrid ID="gvInfo" GridLines="None" CellPadding="0" CellSpacing="1" runat="server" ShowHeader="true" ShowFooter="true" DataSourceID="sdsInfo" OnExcelExportCellFormatting="gvInfo_ExportCellFormatting">
        <ExportSettings FileName="Presenze" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" HideStructureColumns="true">
            <Csv ColumnDelimiter="VerticalBar" RowDelimiter="NewLine" FileExtension="csv" EncloseDataWithQuotes="true" />
            <Excel Format="ExcelML" FileExtension="xls" />
        </ExportSettings>
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" BackColor="LightGray" />
        <MasterTableView AutoGenerateColumns="true" TableLayout="Fixed">
           
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotCallCenterxPeriodo_ExportTabulati" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="x" Name="PeriodoRif" />
            <asp:QueryStringParameter QueryStringField="y" Name="CallCenterID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>