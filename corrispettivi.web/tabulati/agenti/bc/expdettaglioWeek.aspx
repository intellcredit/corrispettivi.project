<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="expdettaglioWeek.aspx.cs" Inherits="corrispettivi.web.tabulati.agenti.bc.expdettaglioWeek" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="exportHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="exportMain" Runat="Server">
    <telerik:RadGrid ID="gvInfo" GridLines="None" CellPadding="0" CellSpacing="1" runat="server" ShowHeader="true" Visible="true" 
            DataSourceID="sdsInfo" OnItemCommand="gvInfo_ItemCommand" OnExcelExportCellFormatting="gvInfo_ExportCellFormatting">
        <ExportSettings FileName="Presenze" ExportOnlyData="true" IgnorePaging="true" OpenInNewWindow="true" HideStructureColumns="true">
            <Csv ColumnDelimiter="VerticalBar" RowDelimiter="NewLine" FileExtension="csv" EncloseDataWithQuotes="true" />
            <Excel Format="ExcelML" FileExtension="xls" />
        </ExportSettings>
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" BackColor="LightGray" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed">
            <Columns>
                <telerik:GridBoundColumn DataField="WeekNum" HeaderText="Settimana" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" Aggregate="Count" />
                <telerik:GridBoundColumn DataField="WeekStart" HeaderText="Inizio" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="WeekEnd" HeaderText="Fine" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="CntGgPresenze" HeaderText="Giorni." HeaderStyle-Width="65px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Aggregate="Sum" FooterStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="CntPratCont" HeaderText="Pratiche" HeaderStyle-Width="65px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Aggregate="Sum" FooterStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="CntCont" HeaderText="Contatti" HeaderStyle-Width="65px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Aggregate="Sum" FooterStyle-HorizontalAlign="Center" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xAgentiBcPresenzeViewWeek" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="key" Name="AgenteBcID" />
            <asp:QueryStringParameter QueryStringField="x" Name="PeriodoRif" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>