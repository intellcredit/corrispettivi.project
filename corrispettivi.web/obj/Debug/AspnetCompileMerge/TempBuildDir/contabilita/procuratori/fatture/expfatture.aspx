<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="expfatture.aspx.cs" Inherits="corrispettivi.web.contabilita.procuratori.fatture.expfatture" %>
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
                <telerik:GridBoundColumn HeaderText="Periodo" DataField="PeriodoRif" />
                <telerik:GridBoundColumn HeaderText="Numero" DataField="Numero" />
                <telerik:GridBoundColumn HeaderText="Data" DataField="Data" />
                <telerik:GridBoundColumn HeaderText="Importo" DataField="Importo" />
                <telerik:GridBoundColumn HeaderText="Note" DataField="Note" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xFattureView" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="c" Name="CallCenterID" />
            <asp:QueryStringParameter QueryStringField="a" Name="AgenteGroupID" />
            <asp:QueryStringParameter QueryStringField="x" Name="AnnoRif" />
            <asp:QueryStringParameter QueryStringField="y" Name="MeseRif" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>