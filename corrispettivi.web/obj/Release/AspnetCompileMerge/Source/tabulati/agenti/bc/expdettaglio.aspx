<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="expdettaglio.aspx.cs" Inherits="corrispettivi.web.tabulati.agenti.bc.expdettaglio" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="exportHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="exportMain" Runat="Server">
    <telerik:RadGrid ID="gvInfo" GridLines="None" CellPadding="0" CellSpacing="1" runat="server" ShowHeader="true" Visible="true" DataSourceID="sdsInfo" OnItemCommand="gvInfo_ItemCommand" OnExcelExportCellFormatting="gvInfo_ExportCellFormatting">
        <ExportSettings FileName="Presenze" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" HideStructureColumns="true">
            <Csv ColumnDelimiter="VerticalBar" RowDelimiter="NewLine" FileExtension="csv" EncloseDataWithQuotes="true" />
            <Excel Format="ExcelML" FileExtension="xls" />
        </ExportSettings>
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" BackColor="LightGray" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="AgenteBcPresenzaID">
            <Columns>
                <telerik:GridBoundColumn DataField="DataPresenza" HeaderText="Data" DataFormatString="{0:d}" />
                <telerik:GridBoundColumn DataField="ContattiEffettivi" HeaderText="cnt. effettivi" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xAgentiBcPresenzeView" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgenteBcID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>