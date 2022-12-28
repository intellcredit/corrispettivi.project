<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="expAlertAgenti.aspx.cs" Inherits="corrispettivi.web.anomalie.WebForm1" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="exportHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="exportMain" Runat="Server">
    <telerik:RadGrid ID="gvInfo" GridLines="None" CellPadding="0" CellSpacing="1" runat="server" ShowHeader="true" Visible="true" DataSourceID="sdsInfo">
        <ExportSettings FileName="Bsl" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" HideStructureColumns="true" >
            <Csv ColumnDelimiter="VerticalBar" RowDelimiter="NewLine" FileExtension="csv" EncloseDataWithQuotes="true" />
            <Excel Format="ExcelML" FileExtension="xls" />
        </ExportSettings>
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" BackColor="LightGray" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" AllowSorting="false">
            <Columns>
                <telerik:GridBoundColumn DataField="AgenteGroupID" HeaderText="ID" />
                <telerik:GridBoundColumn DataField="AgenteGroupAlias"  HeaderText="Agente" />
                <telerik:GridBoundColumn DataField="Anomalia"  HeaderText="Anomalia" />
                <telerik:GridBoundColumn DataField="Messaggio"  HeaderText="Messaggio" />
                <telerik:GridBoundColumn DataField="Anzianita"  HeaderText="Anzianita" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotAnomalieAgenti" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="x" Name="TipoAnomaliaID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>