<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="exprepagexanno.aspx.cs" Inherits="corrispettivi.web.admin.exprepagexanno" %>
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
                <telerik:GridBoundColumn DataField="GEN_Totale"  HeaderText="Gennaio" />
                <telerik:GridBoundColumn DataField="FEB_Totale"  HeaderText="Febbraio" />
                <telerik:GridBoundColumn DataField="MAR_Totale"  HeaderText="Marzo" />
                <telerik:GridBoundColumn DataField="APR_Totale"  HeaderText="Aprile" />
                <telerik:GridBoundColumn DataField="MAG_Totale"  HeaderText="Maggio" />
                <telerik:GridBoundColumn DataField="GIU_Totale"  HeaderText="Giugno" />
                <telerik:GridBoundColumn DataField="LUG_Totale"  HeaderText="Luglio" />
                <telerik:GridBoundColumn DataField="AGO_Totale"  HeaderText="Agosto" />
                <telerik:GridBoundColumn DataField="SET_Totale"  HeaderText="Settembre" />
                <telerik:GridBoundColumn DataField="OTT_Totale"  HeaderText="Ottobre" />
                <telerik:GridBoundColumn DataField="NOV_Totale"  HeaderText="Novembre" />
                <telerik:GridBoundColumn DataField="DIC_Totale"  HeaderText="Dicembre" />
                <telerik:GridBoundColumn DataField="Anno_Totale"  HeaderText="Totale" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotAdminxAgentixAnno" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="x" Name="AnnoRif" />
            <asp:QueryStringParameter QueryStringField="id" Name="CallCenterID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>