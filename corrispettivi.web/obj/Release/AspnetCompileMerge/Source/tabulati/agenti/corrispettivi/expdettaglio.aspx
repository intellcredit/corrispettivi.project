<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="expdettaglio.aspx.cs" Inherits="corrispettivi.web.tabulati.agenti.corrispettivi.expdettaglio" %>
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
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="AgenteCorrispettivoID">
            <Columns>
                <telerik:GridBoundColumn DataField="PraticaAlias" HeaderText="Pratica" />
                <telerik:GridBoundColumn DataField="CommittenteNome" HeaderText="Committente" />
                <telerik:GridBoundColumn DataField="Contratto" HeaderText="Contratto" />
                <telerik:GridBoundColumn DataField="DataQuestura" HeaderText="Data questura" DataFormatString="{0:d}" />
                <telerik:GridBoundColumn DataField="DataScadenza" HeaderText="Data scadenza" DataFormatString="{0:d}" />
                <telerik:GridBoundColumn DataField="MandatoDataInizio" HeaderText="Mandato data inizio" DataFormatString="{0:d}" />
                <telerik:GridBoundColumn DataField="MandatoDataFine" HeaderText="Mandato data fine" DataFormatString="{0:d}" />
                <telerik:GridBoundColumn DataField="Tipo" HeaderText="Tipo" />
                <telerik:GridBoundColumn DataField="Progressivo" HeaderText="Prog" />
                <telerik:GridBoundColumn DataField="Data" HeaderText="Data" DataFormatString="{0:d}" />
                <telerik:GridBoundColumn DataField="Descrizione" HeaderText="Descrizione" />
                <telerik:GridBoundColumn DataField="Capitale" HeaderText="Capitale" DataFormatString="{0:C}" />
                <telerik:GridBoundColumn DataField="Interessi" HeaderText="Interessi" DataFormatString="{0:C}" />
                <telerik:GridBoundColumn DataField="Spese" HeaderText="Spese" DataFormatString="{0:C}" />
                <telerik:GridBoundColumn DataField="Imponibile" HeaderText="Imponibile" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Percentuale" HeaderText="%" HeaderStyle-Width="35px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="ImponibileSurplus" HeaderText="Imponibile plus" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="PercentualeSurplus" HeaderText="% plus" HeaderStyle-Width="35px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="ProvvImporto" HeaderText="Provvigione" DataFormatString="{0:C}" />
                <telerik:GridBoundColumn DataField="FissoImporto" HeaderText="Fisso" DataFormatString="{0:C}" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xAgentiCorrispettiviPraticheDettaglioPrint" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgenteCorrispettivoID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

