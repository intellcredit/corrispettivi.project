<%@ Page Title="" Language="C#" MasterPageFile="~/tabulati/agenti/finemese/local.master" AutoEventWireup="true" CodeBehind="report.aspx.cs" Inherits="corrispettivi.web.tabulati.agenti.finemese.report" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <script type="text/javascript">

        function onToolBarClientButtonClicking(sender, args) {
            var button = args.get_item();

            if (button.get_commandName() == "tabReworks")  {
                args.set_cancel(!confirm('Sicuro di voler rielaborare il periodo selezionato?'));
            }

            if (button.get_commandName() == "setStatusClosed") {
                args.set_cancel(!confirm('Sicuro di voler impostare lo stato chiuso per il periodo selezionato?\n\nRicorda che verranno chiusi soltanto i tabulati con status PUBBLICATO'));
            }
        }
    </script>


    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblAction" runat="server" Text="" /></td></tr>
    </table>

    <telerik:RadAjaxManager ID="amInfo" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmbPeriodoRif">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="tbAction" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="gvInfo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="imgSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="tbAction" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="tbAction">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="apStatus" runat="server" Style="width: 320px;" Height="75px" Width="75px" AnimationDuration="1">
        <img alt="Loading..." src="~/image/Telerik/loading7.gif" style="border:0;" />
    </telerik:RadAjaxLoadingPanel>

    <table border="0" cellpadding="2" cellspacing="2">
        <tr valign="middle">
            <td class="titnero12" nowrap>Selezionare il mese di chiusura tabulati:</td>
            <td><telerik:RadComboBox ID="cmbPeriodoClose" runat="server" Width="200px" EmptyMessage="Selezionare un valore..."
                    DataSourceID="sdsPeriodoClose" DataTextField="PeriodoClose" 
                    DataValueField="PeriodoClose" AutoPostBack="true" 
                    onselectedindexchanged="cmbPeriodoClose_SelectedIndexChanged" /></td>
            <td><asp:ImageButton ID="imgSearch" runat="server" ImageUrl="~/Image/Find.png" onclick="imgSearch_Click" /></td>
            <td width="100%" align="right"><telerik:radtoolbar ID="tbAction" runat="server" Skin="Simple" onbuttonclick="tbAction_ButtonClick" OnClientButtonClicking="onToolBarClientButtonClicking">
                    <Items>
                        <telerik:RadToolBarDropDown Text="Esporta" Font-Bold="True" ImageUrl="~/image/Download-20.png"> 
                            <Buttons>
                                <telerik:RadToolBarButton Text="Report" ImageUrl="~/image/excel.gif" CommandName="expExcel" Value="~/excel.aspx?type=fineMese&rif={0}" />
                            </Buttons>
                        </telerik:RadToolBarDropDown>
                    </Items>
                </telerik:radtoolbar>
               
            </td>
        </tr>
    </table>
    <telerik:RadGrid ID="gvInfo" runat="server" Skin="Simple" CellSpacing="0" GridLines="None" PageSize="100" DataSourceID="sdsInfo" Height="550px" ShowFooter="true">
        <SelectedItemStyle CssClass="SelectedStyle" />
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" />
        <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
        <MasterTableView AutoGenerateColumns="true" TableLayout="Fixed" />
                <ClientSettings>
            <Resizing AllowColumnResize="true" ResizeGridOnColumnResize="false" AllowResizeToFit="true" />
        </ClientSettings>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xAgentiFineMese" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:ControlParameter ControlID="cmbPeriodoClose" PropertyName="SelectedValue" Name="PeriodoClose" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsCallCenter" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsCallCenter" ConnectionString="<%$ ConnectionStrings:dbConn%>" />
    
    <asp:SqlDataSource ID="sdsAgenti" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsAgenti" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

    <asp:SqlDataSource ID="sdsOreContratto" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsOreContratto" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

    <asp:SqlDataSource ID="sdsPeriodoClose" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="Text" SelectCommand="select distinct format(StatusData,'MM/yyyy') as PeriodoClose, YEAR(StatusData) as AnnoClose, MONTH(StatusData) as MeseClose 
        from AgentiBsl where StatusID in (4) order by AnnoClose desc, MeseClose desc" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

    <asp:SqlDataSource ID="sdsStatus" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsStatus" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

</asp:Content>