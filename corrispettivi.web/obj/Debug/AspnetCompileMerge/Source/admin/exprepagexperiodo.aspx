<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="exprepagexperiodo.aspx.cs" Inherits="corrispettivi.web.admin.exprepagexperiodo" %>
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
                <telerik:GridBoundColumn DataField="AgenteGroupNome"  HeaderText="Agente" />
                <telerik:GridBoundColumn DataField="AgentiBc" HeaderText="Bonus contatti" />
                <telerik:GridBoundColumn DataField="AgentiCorrispettivi"  HeaderText="Corrispettivi" />
                <telerik:GridBoundColumn DataField="AgentiPremi"  HeaderText="Premi" />
                <telerik:GridBoundColumn DataField="AgentiIntegrazioni"  HeaderText="Bonus provvigionali" />
                <telerik:GridBoundColumn DataField="AgentiBe"  HeaderText="Bonus salva lavoro" />
                <telerik:GridBoundColumn DataField="Totale" HeaderText="Totale" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotAdminxAgentixPeriodo" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="x" Name="PeriodoRif" />
            <asp:QueryStringParameter QueryStringField="id" Name="CallCenterID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>