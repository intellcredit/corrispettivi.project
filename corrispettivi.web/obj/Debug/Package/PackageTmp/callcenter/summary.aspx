<%@ Page Title="" Language="C#" MasterPageFile="~/callcenter/local.master" AutoEventWireup="true" CodeBehind="summary.aspx.cs" Inherits="corrispettivi.web.callcenter.summary" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <h1><b>Report per fattura</b></h1><hr />

    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblAction" runat="server" Text="" /></td></tr>
    </table>

    <telerik:RadAjaxManager ID="amInfo" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmbPeriodoRif">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvSummary" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="gvAnticipato" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="gvFatture" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="tbAction" LoadingPanelID="apStatus" />

                    
                    <telerik:AjaxUpdatedControl ControlID="tblStatus" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="imgSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvSummary" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="gvAnticipato" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="tbAction" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="gvSummary">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvSummary" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="gvAnticipato">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvAnticipato" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="apStatus" runat="server" Style="width: 320px;" Height="75px" Width="75px" AnimationDuration="1">
        <img alt="Loading..." src="~/image/Telerik/loading7.gif" style="border:0;" />
    </telerik:RadAjaxLoadingPanel>

    <table border="0" cellpadding="2" cellspacing="2">
        <tr valign="middle">
            <td class="titnero12" nowrap>Selezionare il periodo di riferimento:</td>
            <td><telerik:RadComboBox ID="cmbPeriodoRif" runat="server" Width="200px" EmptyMessage="Selezionare un valore..."
                    DataSourceID="sdsPeriodoRif" DataTextField="PeriodoRif" 
                    DataValueField="PeriodoRif" AutoPostBack="true" 
                    onselectedindexchanged="cmbPeriodoRif_SelectedIndexChanged" /></td>
            <td><asp:ImageButton ID="imgSearch" runat="server" ImageUrl="~/Image/Find.png" onclick="imgSearch_Click" /></td>
            <td width="100%" align="right"><telerik:radtoolbar ID="tbAction" runat="server" Skin="Simple">
                    <Items>
                        <telerik:RadToolBarButton Text="Genera PDF" Font-Bold="True" ImageUrl="~/image/pdf2.png" NavigateUrl="" Value="expsummary.aspx?x={0}&y={1}&mode=pdf" Target="_blank" CommandName="expPdf" />
                    </Items>
                </telerik:radtoolbar></td>
        </tr>
    </table>

    


    <table border="0" cellpadding="3" cellspacing="3" width="700px">
        <tr><td colspan="2"><table id="tblStatus" runat="server" border="0" style="border-color:White" cellpadding="1" cellspacing="1" class="testonero14" width="100%">
                <tr><td align="right"><b>Status:</b></td><td><asp:Label ID="lblStatusDesc" runat="server" /></td></tr>
                <tr><td align="right"><b>Info:</b></td><td><asp:Label ID="lblStatusInfo" runat="server" /></td></tr>
            </table></td></tr>
        <tr>
            <td width="350px" valign="top">
                <telerik:RadGrid ID="gvSummary" runat="server" Skin="Simple" AutoGenerateColumns="false" DataSourceID="sdsSummary" BorderWidth="0" CellSpacing="0" CellPadding="0" GridLines="Both" ShowHeader="true" ShowFooter="false" Width="100%" OnItemDataBound="gvSummary_ItemDataBound">
                    <HeaderStyle Font-Bold="true" VerticalAlign="Top" HorizontalAlign="Center" />
                    <ItemStyle CssClass="testonero12" />
                    <AlternatingItemStyle BackColor="White" CssClass="testonero12" />
                    <MasterTableView ShowHeadersWhenNoRecords="true" DataKeyNames="Row">
                        <NoRecordsTemplate>Nessun record trovato</NoRecordsTemplate>
                        <ColumnGroups>
                            <telerik:GridColumnGroup Name="Header" HeaderText="RIEPILOGO COMPENSI" HeaderStyle-HorizontalAlign="Center" />
                        </ColumnGroups>
                        <Columns>
                            <telerik:GridBoundColumn DataField="desc"  ItemStyle-Width="220px" ItemStyle-HorizontalAlign="Right" ColumnGroupName="Header" HeaderText="Descrizione" />
                            <telerik:GridBoundColumn DataField="importo" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" ItemStyle-Width="80px" ColumnGroupName="Header" HeaderText="Importo" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
            <td width="350px" valign="top">
                <telerik:RadGrid ID="gvAnticipato" runat="server" Skin="Simple" AutoGenerateColumns="false" DataSourceID="sdsAnticipato" BorderWidth="0" CellSpacing="0" CellPadding="0" GridLines="Both" ShowHeader="true" ShowFooter="true" Width="100%">
                    <HeaderStyle Font-Bold="true" VerticalAlign="Top" HorizontalAlign="Center" />
                    <ItemStyle CssClass="testonero12" />
                    <AlternatingItemStyle BackColor="White" CssClass="testonero12" />
                    <FooterStyle CssClass="titrosso12" />
                    <MasterTableView ShowHeadersWhenNoRecords="true">
                        <NoRecordsTemplate>Nessun record trovato</NoRecordsTemplate>
                        <ColumnGroups>
                            <telerik:GridColumnGroup Name="Header" HeaderText="RIEPILOGO ANTICIPATO IN VALUTA" HeaderStyle-HorizontalAlign="Center" />
                        </ColumnGroups>
                        <Columns>
                            <telerik:GridBoundColumn DataField="Periodo" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Right" ColumnGroupName="Header" HeaderText="Periodo" FooterText="Totale" FooterStyle-HorizontalAlign="Right"  />
                            <telerik:GridBoundColumn DataField="NumPag" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="75px" ColumnGroupName="Header" HeaderText="Num.pag." Aggregate="Sum" FooterStyle-HorizontalAlign="Center" FooterText=" " />
                            <telerik:GridBoundColumn DataField="Imponibile" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" ItemStyle-Width="75px" ColumnGroupName="Header" HeaderText="Imponibile" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="sdsSummary" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="summaryCallCenterxPeriodoWithFatture" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:SessionParameter SessionField="CallCenterID" Name="CallCenterID" />
            <asp:ControlParameter ControlID="cmbPeriodoRif" PropertyName="SelectedValue" Name="PeriodoRif" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsAnticipato" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="anticipatoCallCenterxPeriodo" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:SessionParameter SessionField="CallCenterID" Name="CallCenterID" />
            <asp:ControlParameter ControlID="cmbPeriodoRif" PropertyName="SelectedValue" Name="PeriodoRif" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="summaryCallCenterInfoxPeriodo" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:SessionParameter SessionField="CallCenterID" Name="CallCenterID" />
            <asp:ControlParameter ControlID="cmbPeriodoRif" PropertyName="SelectedValue" Name="PeriodoRif" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsPeriodoRif" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="sdsPeriodoRifbyCallCenter" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:SessionParameter SessionField="CallCenterID" Name="CallCenterID" Type="Int16" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>