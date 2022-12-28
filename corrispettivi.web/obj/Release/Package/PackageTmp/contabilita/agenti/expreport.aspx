<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="expreport.aspx.cs" Inherits="corrispettivi.web.contabilita.agenti.expreport" %>
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
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="AgenteGroupID" AllowSorting="false">
            <Columns>
                <telerik:GridBoundColumn DataField="AgenteGroupNome" HeaderText="Agente" />
                <telerik:GridBoundColumn DataField="GEN_Totale"  HeaderText="Gennaio" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                <telerik:GridBoundColumn DataField="FEB_Totale"  HeaderText="Febbraio" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                <telerik:GridBoundColumn DataField="MAR_Totale"  HeaderText="Marzo" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                <telerik:GridBoundColumn DataField="APR_Totale"  HeaderText="Aprile" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                <telerik:GridBoundColumn DataField="MAG_Totale"  HeaderText="Maggio" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                <telerik:GridBoundColumn DataField="GIU_Totale"  HeaderText="Giugno" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                <telerik:GridBoundColumn DataField="LUG_Totale"  HeaderText="Luglio" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                <telerik:GridBoundColumn DataField="AGO_Totale"  HeaderText="Agosto" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                <telerik:GridBoundColumn DataField="SET_Totale"  HeaderText="Settembre" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                <telerik:GridBoundColumn DataField="OTT_Totale"  HeaderText="Ottobre" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                <telerik:GridBoundColumn DataField="NOV_Totale"  HeaderText="Novembre" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                <telerik:GridBoundColumn DataField="DIC_Totale"  HeaderText="Dicembre" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                <telerik:GridBoundColumn DataField="Anno_Totale" HeaderText="Totale" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotContabilitaAgentixAnno" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="x" Name="AnnoRif" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>