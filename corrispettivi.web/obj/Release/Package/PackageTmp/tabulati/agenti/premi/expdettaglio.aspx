<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="expdettaglio.aspx.cs" Inherits="corrispettivi.web.tabulati.agenti.premi.expdettaglio" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="exportHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="exportMain" Runat="Server">
    <telerik:RadGrid ID="gvInfo" GridLines="None" CellPadding="0" CellSpacing="1" runat="server" ShowHeader="true" ShowFooter="true" Visible="true" DataSourceID="sdsInfo">
        <ExportSettings FileName="Ditte" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" HideStructureColumns="true" >
            <Csv ColumnDelimiter="VerticalBar" RowDelimiter="NewLine" FileExtension="csv" EncloseDataWithQuotes="true" />
            <Excel Format="ExcelML" FileExtension="xls" />
        </ExportSettings>
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" BackColor="LightGray" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="AgentePremioID">
            <Columns>
                <telerik:GridBoundColumn DataField="ContrattoDescrizione" HeaderText="Contratto" />
                <telerik:GridBoundColumn DataField="IMPONIBILE_PREMIO" HeaderText="Imponibile premio" DataFormatString="{0:C}" />
                <telerik:GridBoundColumn DataField="PREMIO" HeaderText="% premio" />
                <telerik:GridBoundColumn DataField="IMPORTO_PREMIO" HeaderText="Importo premio" DataFormatString="{0:C}" />
                <telerik:GridBoundColumn DataField="TIPO_PREMIO" HeaderText="Descrizione" />
                <telerik:GridBoundColumn DataField="OB1_RISULTATO" HeaderText="OB1 risultato" />
                <telerik:GridBoundColumn DataField="OB1_FASCIA_DA" HeaderText="OB1 inizio fascia" />
                <telerik:GridBoundColumn DataField="OB1_FASCIA_A" HeaderText="OB1 fine fascia" />
                <telerik:GridBoundColumn DataField="OB2_RISULTATO" HeaderText="OB2 risultato" />
                <telerik:GridBoundColumn DataField="OB2_FASCIA_DA" HeaderText="OB2 inizio fascia" />
                <telerik:GridBoundColumn DataField="OB2_FASCIA_A" HeaderText="OB2 fine fascia" />
                <telerik:GridBoundColumn DataField="OB3_RISULTATO" HeaderText="OB3 risultato" />
                <telerik:GridBoundColumn DataField="OB3_FASCIA_DA" HeaderText="OB3 inizio fascia" />
                <telerik:GridBoundColumn DataField="OB3_FASCIA_A" HeaderText="OB3 fine fascia" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xAgentiPremiContrattiDettaglioPrint" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgentePremioID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>