<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="expreport.aspx.cs" Inherits="corrispettivi.web.tabulati.agenti.premi.expreport" %>
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
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="AgentePremioID">
            <Columns>
                <telerik:GridBoundColumn DataField="CallCenterNome" HeaderText="Call center" />
                <telerik:GridBoundColumn DataField="AgenteGroupAlias" HeaderText="Agente" />
                <telerik:GridBoundColumn DataField="OreContratto" HeaderText="Ore contratto" />
                <telerik:GridBoundColumn DataField="ImportoMaturato" HeaderText="Importo maturato" DataFormatString="{0:C}" />
                <%--<telerik:GridBoundColumn DataField="ImportoRiconosciuto" HeaderText="Importo riconosciuto" DataFormatString="{0:C}" />--%>
                <telerik:GridBoundColumn DataField="StatusDescrizione" HeaderText="Status" />
                <telerik:GridBoundColumn DataField="DataElaborazione" HeaderText="Data elab." /> 
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xAgentiPremiView" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="x" Name="PeriodoRif" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>