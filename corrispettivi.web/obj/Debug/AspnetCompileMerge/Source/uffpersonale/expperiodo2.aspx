<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="expperiodo2.aspx.cs" Inherits="corrispettivi.web.uffpersonale.expperiodo2" %>

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
                <telerik:GridBoundColumn DataField="CallCenterNome"  HeaderText="Call Center" />
                <telerik:GridBoundColumn DataField="AgenteGroupAlias"  HeaderText="Agente" />
                <telerik:GridBoundColumn DataField="OreContratto"  HeaderText="Ore contratto" />
                <telerik:GridBoundColumn DataField="Importo" HeaderText="Importo" />
                <telerik:GridBoundColumn DataField="StatusDesc" HeaderText="Status" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotUffPersonalexPeriodo2" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="x" Name="PeriodoRif" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>