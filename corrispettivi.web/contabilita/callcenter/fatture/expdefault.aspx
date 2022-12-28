<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="expdefault.aspx.cs" Inherits="corrispettivi.web.contabilita.callcenter.fatture.expdefault" %>
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
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="CallCenterID" AllowSorting="false">
            <Columns>
                <telerik:GridBoundColumn DataField="PeriodoRif"  HeaderText="Periodo" />
                <telerik:GridBoundColumn DataField="CallCenterNome" HeaderText="CallCenter" />
                <telerik:GridBoundColumn DataField="Totale"  HeaderText="Totale" DataFormatString="{0:C}" />
                <telerik:GridBoundColumn DataField="StatusFatturaDesc"  HeaderText="Status" />
                <telerik:GridBoundColumn DataField="Fatturato"  HeaderText="Fatturato" DataFormatString="{0:C}" />
                <telerik:GridBoundColumn DataField="Saldo"  HeaderText="Saldo" DataFormatString="{0:C}" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotContabilitaCallCenterFatturexAnno" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="x" Name="AnnoRif" />
            <asp:QueryStringParameter QueryStringField="chkFatt" Name="StatusFatturaID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>