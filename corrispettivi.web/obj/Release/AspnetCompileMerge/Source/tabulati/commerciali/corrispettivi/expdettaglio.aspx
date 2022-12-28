<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="expdettaglio.aspx.cs" Inherits="corrispettivi.web.tabulati.commerciali.corrispettivi.expdettaglio" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="exportHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="exportMain" Runat="Server">
    <telerik:RadGrid ID="gvInfo" GridLines="None" CellPadding="0" CellSpacing="1" runat="server" ShowHeader="true" Visible="true" DataSourceID="sdsInfo">
        <ExportSettings FileName="Ditte" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" HideStructureColumns="true" >
            <Csv ColumnDelimiter="VerticalBar" RowDelimiter="NewLine" FileExtension="csv" EncloseDataWithQuotes="true" />
            <Excel Format="ExcelML" FileExtension="xls" />
        </ExportSettings>
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" BackColor="LightGray" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed">
            <Columns>
                <telerik:GridBoundColumn DataField="BaseNome" HeaderText="Base" />
                <telerik:GridBoundColumn DataField="CommittenteNome" HeaderText="Sottogruppo" />
                <telerik:GridBoundColumn DataField="PraticaAlias" HeaderText="Pratica" />
                <telerik:GridBoundColumn DataField="Tipo" HeaderText="Tipo" />
                <telerik:GridBoundColumn DataField="Progressivo" HeaderText="Prog" />
                <telerik:GridBoundColumn DataField="FatturaNum" HeaderText="Fatt.cred.num." />
                <telerik:GridBoundColumn DataField="FatturaData" HeaderText="Fatt.data" DataFormatString="{0:d}" />
                <telerik:GridBoundColumn DataField="NotaCreditoNum" HeaderText="Nota cred.num." />
                <telerik:GridBoundColumn DataField="NotaCreditoData" HeaderText="Nota cred.data" DataFormatString="{0:d}" />
                <telerik:GridBoundColumn DataField="Fatturato" HeaderText="Fatturato" DataFormatString="{0:C}" />
                <telerik:GridBoundColumn DataField="Provv1_Imp" HeaderText="Imp.provv.acq." DataFormatString="{0:C}" />
                <telerik:GridBoundColumn DataField="Provv1_Perc" HeaderText="% provv.acq." />
                <telerik:GridBoundColumn DataField="Provv2_Imp" HeaderText="Imp.provv.ass." DataFormatString="{0:C}" />
                <telerik:GridBoundColumn DataField="Provv2_Perc" HeaderText="% provv.ass." />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xCommercialiCorrispettiviPraticheDettaglioPrint" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="CommercialeCorrispettivoID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>