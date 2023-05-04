<%@ Page Title="" Language="C#" MasterPageFile="~/tabulati/agenti/manuale/local.master" AutoEventWireup="true" CodeBehind="scheda.aspx.cs" Inherits="corrispettivi.web.tabulati.agenti.manuale.scheda" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">

     <%--<script type="text/javascript">

         function onToolBarClientButtonClicking(sender, args) {
             var button = args.get_item();

             alert('ciao');

             if (button.get_commandName() == "tabReworks") {
                 args.set_cancel(!confirm('Sicuro di voler rielaborare il periodo selezionato?'));
             }

             if (button.get_commandName() == "setStatusClosed") {
                 args.set_cancel(!confirm('Sicuro di voler impostare lo stato chiuso per il periodo selezionato?\n\nRicorda che verranno chiusi soltanto i tabulati con status PUBBLICATO'));
             }
         }
    </script>--%>

    <telerik:RadAjaxManager ID="amInfo" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmbPeriodoRif">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblMessage" />
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="tbAction" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="cmbAgenteGroupID">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblMessage" />
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="tbAction" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="gvInfo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="tbAction">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblMessage" />
                    <telerik:AjaxUpdatedControl ControlID="lblActionMessage" />
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="apStatus" runat="server" Style="width: 320px;" Height="75px" Width="75px" AnimationDuration="1">
        <img alt="Loading..." src="../../../image/Telerik/loading7.gif" style="border:0;" />
    </telerik:RadAjaxLoadingPanel>

    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblMessage" runat="server" Text="" /></td></tr>
    </table>
    <br />
    <table border="0" cellpadding="2" cellspacing="2">
        <tr valign="top">
            <td align="right"><b>periodo<br />riferimento</b></td> 
            <td><telerik:RadComboBox ID="cmbPeriodoRif" runat="server" Height="200px" Width="200px" DropDownWidth="200px" EmptyMessage="Selezionare un valore..."
                    DataSourceID="sdsPeriodoRif" DataTextField="PeriodoRif" DataValueField="PeriodoRif" AutoPostBack="true" onselectedindexchanged="cmbPeriodoRif_SelectedIndexChanged" /></td>
            <td align="right"><b>agente</b></td>
            <td><telerik:RadComboBox ID="cmbAgenteGroupID" runat="server" Height="200px" Width="500px" DropDownWidth="700px" EmptyMessage="selezionare un valore" 
                    DataSourceID="sdsAgenti" DataTextField="AgenteGroupAlias" DataValueField="AgenteGroupID" Filter="Contains" AppendDataBoundItems="true"
                    AutoPostBack="true" onselectedindexchanged="cmbAgenteGroupID_SelectedIndexChanged" /></td>
        </tr>
        <tr><td colspan="4" id="sep1" runat="server"><hr /></td></tr>
        <tr>
            <td colspan="3"><asp:Label ID="lblActionMessage" runat="server" Text="" CssClass="titrosso12" /></td>
            <td colspan="1" align="right"><telerik:radtoolbar ID="tbAction" runat="server" Skin="Simple" onbuttonclick="tbAction_ButtonClick">
                <Items>
                    <telerik:RadToolBarButton Text="Refresh" Value="btnRefresh" CommandName="RefreshSelected" ImageUrl="~/image/Sync.png" />    
                    <telerik:RadToolBarDropDown Text="Rielaborazione" ToolTip="Scegli con quale status impostare i tabulati" ImageUrl="~/image/tab/elab_24x24.png" DropDownWidth="300px">
                        <Buttons>
                            <telerik:RadToolBarButton Text="Rielabora ed imposta stato provvisorio" Value="btnReWorksProvisional" CommandName="ReWorksProvisionalSelected" />
                            <telerik:RadToolBarButton Text="Rielabora ed imposta stato approvato" Value="btnReWorksApproved" CommandName="ReWorksAprovedSelected" />
                            <telerik:RadToolBarButton Text="Rielabora ed imposta stato pubblicato" Value="btnReWorksPublished" CommandName="ReWorksPublishedSelected" />
                        </Buttons>
                    </telerik:RadToolBarDropDown>
                    <telerik:RadToolBarDropDown Text="Chiusura" ToolTip="Scegli in che modo chiudere i tabulati" ImageUrl="~/image/tab/close_24x24.png" DropDownWidth="250px">
                        <Buttons>
                            <telerik:RadToolBarButton Text="Rielabora e chiudi" Value="btnReWorksClose" CommandName="ReWorksCloseSelected" />
                            <telerik:RadToolBarButton Text="Chiudi senza rielaborare" Value="btnClose" CommandName="CloseSelected" />
                        </Buttons>
                    </telerik:RadToolBarDropDown>
                </Items>
            </telerik:radtoolbar>
        </td></tr>
        <tr>
            <td colspan="4">
                <telerik:RadGrid ID="gvInfo" runat="server" Skin="Simple" CellSpacing="0" GridLines="None" DataSourceID="sdsInfo" Width="1000px" ShowFooter="true" Font-Names="courier new">
                    <SelectedItemStyle CssClass="SelectedStyle" />
                    <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                    <AlternatingItemStyle VerticalAlign="Top" />
                    <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
                    <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed">
                        <Columns>
                            <telerik:GridBoundColumn DataField="TipoTabulatoDesc" HeaderText="Tabulato" HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center" />
                            <telerik:GridBoundColumn DataField="Importo" HeaderText="Importo" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                            <telerik:GridBoundColumn DataField="SystemElab" HeaderText="Info elaborazione" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" AllowFiltering="false" ItemStyle-Font-Names="courier new"  />
                            <telerik:GridBoundColumn DataField="StatusDesc" HeaderText="Status" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" />
                            <telerik:GridBoundColumn DataField="StatusData" HeaderText="Data" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" />    
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="sdsAgenti" runat="server" ProviderName="System.Data.SqlClient" ConnectionString="<%$ ConnectionStrings:dbConn%>" SelectCommandType="StoredProcedure"  SelectCommand="sdsAgenti" />       

    <asp:SqlDataSource ID="sdsPeriodoRif" runat="server" ProviderName="System.Data.SqlClient" ConnectionString="<%$ ConnectionStrings:dbConn%>" SelectCommandType="StoredProcedure" SelectCommand="sdsPeriodoRif" />

    <asp:SqlDataSource ID="sdsStatus" runat="server" ProviderName="System.Data.SqlClient" ConnectionString="<%$ ConnectionStrings:dbConn%>" SelectCommandType="Text" SelectCommand="select StatusID, Descrizione from Status order by StatusID" />       

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xAgentiReportSingleExec" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:ControlParameter ControlID="cmbPeriodoRif" PropertyName="SelectedValue" Name="PeriodoRif" Type="String" DefaultValue="" />
            <asp:ControlParameter ControlID="cmbAgenteGroupID" PropertyName="SelectedValue" Name="AgenteGroupID" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <%--<asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="select * from ReportTabulatiAll 
    where PeriodoRif = @PeriodoRif and AgenteGroupID = @AgenteGroupID order by TipoTabulatoOrdine" SelectCommandType="Text" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:ControlParameter ControlID="cmbPeriodoRif" PropertyName="SelectedValue" Name="PeriodoRif" Type="String" DefaultValue="" />
            <asp:ControlParameter ControlID="cmbAgenteGroupID" PropertyName="SelectedValue" Name="AgenteGroupID" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
</asp:Content>