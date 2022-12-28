<%@ Page Title="" Language="C#" MasterPageFile="~/uffpersonale/local.master" AutoEventWireup="true" CodeBehind="report.aspx.cs" Inherits="corrispettivi.web.uffpersonale.report" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">
    <h1><b>REPORT AGENTI PER ANNO.</b></h1><hr />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblAction" runat="server" Text="" /></td></tr>
    </table>

    <telerik:RadAjaxManager ID="amInfo" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cmbAnnoRif">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="tbAction" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="imgSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvInfo" LoadingPanelID="apStatus" />
                    <telerik:AjaxUpdatedControl ControlID="tbAction" LoadingPanelID="apStatus" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="apStatus" runat="server" Style="width: 320px;" Height="75px" Width="75px" AnimationDuration="1">
        <img alt="Loading..." src="~/image/Telerik/loading7.gif" style="border:0;" />
    </telerik:RadAjaxLoadingPanel>

    <table border="0" cellpadding="2" cellspacing="2">
        <tr valign="middle">
            <td class="titnero12" nowrap>Selezionare l'anno di riferimento:</td>
            <td><telerik:RadComboBox ID="cmbAnnoRif" runat="server" Width="200px" EmptyMessage="Selezionare un valore..."
                    DataSourceID="sdsAnnoRif" DataTextField="AnnoRif" DataValueField="AnnoRif" AutoPostBack="true" 
                    onselectedindexchanged="cmbAnnoRif_SelectedIndexChanged" /></td>
            <td><asp:ImageButton ID="imgSearch" runat="server" ImageUrl="~/Image/Find.png" onclick="imgSearch_Click" /></td>
            <td width="100%" align="right"><telerik:radtoolbar ID="tbAction" runat="server" Skin="Simple">
                    <Items>
                        <telerik:RadToolBarDropDown Text="Esporta" Font-Bold="True" ImageUrl="~/image/Download-20.png"> 
                            <Buttons>
                                <telerik:RadToolBarButton Text="Csv" ImageUrl="~/image/csv.png" CommandName="expCsv" Value="expreport.aspx?mode=csv&x={0}" />
                                <telerik:RadToolBarButton Text="Excel" ImageUrl="~/image/excel.gif" CommandName="expExcel" Value="expreport.aspx?mode=xls&x={0}" />
                            </Buttons>
                        </telerik:RadToolBarDropDown>
                    </Items>
                </telerik:radtoolbar>
            </td>
        </tr>
    </table>

   <telerik:radgrid ID="gvInfo" runat="server" DataSourceID="sdsInfo" 
        Skin="Simple" AllowSorting="True" AllowFilteringByColumn="true" CellSpacing="0" 
        GridLines="None" Height="550px" ShowFooter="true" 
        AllowMultiRowSelection="true">
        <SelectedItemStyle CssClass="SelectedStyle" />
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" />
        <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
        <FilterMenu Skin="Black" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" >
            <Columns>
                <telerik:GridBoundColumn DataField="CallCenterNome" HeaderText="CallCenter" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center">
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="CallCenterCombo" DataSourceID="sdsCallCenter" DataTextField="CallCenterNome" Skin="Black" Filter="Contains"
                            DataValueField="CallCenterNome" Height="200px" Width="100px" DropDownWidth="200px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("CallCenterNome").CurrentFilterValue %>' 
                            runat="server" OnClientSelectedIndexChanged="CallCenterComboIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="Tutti" />
                            </Items>
                        </telerik:RadComboBox>
                        <telerik:RadScriptBlock ID="rsbCallCenter" runat="server">
                            <script type="text/javascript">
                                function CallCenterComboIndexChanged(sender, args) {
                                    var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                    tableView.filter("CallCenterNome", args.get_item().get_value(), "EqualTo");
                                }
                            </script>
                        </telerik:RadScriptBlock>
                    </FilterTemplate>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AgenteGroupAlias" HeaderText="Agente" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count" FooterStyle-HorizontalAlign="Center">
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="AgentiCombo" DataSourceID="sdsAgenti" DataTextField="AgenteGroupAlias" Skin="Black" Filter="Contains"
                            DataValueField="AgenteGroupAlias" Height="200px" Width="150px" DropDownWidth="300px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("AgenteGroupAlias").CurrentFilterValue %>' 
                            runat="server" OnClientSelectedIndexChanged="AgenteComboIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem Text="Tutti" />
                            </Items>
                        </telerik:RadComboBox>
                        <telerik:RadScriptBlock ID="rsbAgenti" runat="server">
                            <script type="text/javascript">
                                function AgenteComboIndexChanged(sender, args) {
                                    var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                    tableView.filter("AgenteGroupAlias", args.get_item().get_value(), "EqualTo");
                                }
                            </script>
                        </telerik:RadScriptBlock>
                    </FilterTemplate>
                </telerik:GridBoundColumn>

                <telerik:GridHyperLinkColumn HeaderText="GEN" HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" 
                                        DataTextField="GEN_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,GEN_Num,AgenteGroupID"
                                        DataNavigateUrlFormatString="periodo.aspx?x={0}&y={1}&a={2}&p={1}/{0}" />

                <telerik:GridHyperLinkColumn HeaderText="FEB" HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" 
                                        DataTextField="FEB_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,FEB_Num,AgenteGroupID"
                                        DataNavigateUrlFormatString="periodo.aspx?x={0}&y={1}&a={2}&p={1}/{0}" />

                <telerik:GridHyperLinkColumn HeaderText="MAR" HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" 
                                        DataTextField="MAR_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,MAR_Num,AgenteGroupID"
                                        DataNavigateUrlFormatString="periodo.aspx?x={0}&y={1}&a={2}&p={1}/{0}" />

                <telerik:GridHyperLinkColumn HeaderText="APR" HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" 
                                        DataTextField="APR_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,APR_Num,AgenteGroupID"
                                        DataNavigateUrlFormatString="periodo.aspx?x={0}&y={1}&a={2}&p={1}/{0}" />

                <telerik:GridHyperLinkColumn HeaderText="MAG" HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" 
                                        DataTextField="MAG_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,MAG_Num,AgenteGroupID"
                                        DataNavigateUrlFormatString="periodo.aspx?x={0}&y={1}&a={2}&p={1}/{0}" />

                <telerik:GridHyperLinkColumn HeaderText="GIU" HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" AllowFiltering="false"
                                        DataTextField="GIU_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,GIU_Num,AgenteGroupID"
                                        DataNavigateUrlFormatString="periodo.aspx?x={0}&y={1}&a={2}&p={1}/{0}" />

                <telerik:GridHyperLinkColumn HeaderText="LUG" HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" 
                                        DataTextField="LUG_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,LUG_Num,AgenteGroupID"
                                        DataNavigateUrlFormatString="periodo.aspx?x={0}&y={1}&a={2}&p={1}/{0}" />

                <telerik:GridHyperLinkColumn HeaderText="AGO" HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" 
                                        DataTextField="AGO_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,AGO_Num,AgenteGroupID"
                                        DataNavigateUrlFormatString="periodo.aspx?x={0}&y={1}&a={2}&p={1}/{0}" />

                <telerik:GridHyperLinkColumn HeaderText="SET" HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" 
                                        DataTextField="SET_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,SET_Num,AgenteGroupID"
                                        DataNavigateUrlFormatString="periodo.aspx?x={0}&y={1}&a={2}&p={1}/{0}" />

                <telerik:GridHyperLinkColumn HeaderText="OTT" HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" 
                                        DataTextField="OTT_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,OTT_Num,AgenteGroupID"
                                        DataNavigateUrlFormatString="periodo.aspx?x={0}&y={1}&a={2}&p={1}/{0}" />

                <telerik:GridHyperLinkColumn HeaderText="NOV" HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" 
                                        DataTextField="NOV_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,NOV_Num,AgenteGroupID"
                                        DataNavigateUrlFormatString="periodo.aspx?x={0}&y={1}&a={2}&p={1}/{0}" />

                <telerik:GridHyperLinkColumn HeaderText="DIC" HeaderStyle-Width="55px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" 
                                        DataTextField="DIC_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,DIC_Num,AgenteGroupID"
                                        DataNavigateUrlFormatString="periodo.aspx?x={0}&y={1}&a={2}&p={1}/{0}" />
                
                <telerik:GridBoundColumn HeaderText="TOTALE" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" AllowFiltering="false"
                                        DataField="Anno_Totale"  
                                        DataFormatString="{0:N}"
                                        Aggregate="Sum" />
                
            </Columns>
        </MasterTableView>
    </telerik:radgrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotUffPersonalexAnno" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:ControlParameter ControlID="cmbAnnoRif" PropertyName="SelectedValue" Name="AnnoRif" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sdsCallCenter" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsUffPersonaleCallCenter" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

    <asp:SqlDataSource ID="sdsAgenti" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsUffPersonaleAgenti" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

    <asp:SqlDataSource ID="sdsAnnoRif" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsAnnoRifDistinct" ConnectionString="<%$ ConnectionStrings:dbConn%>" />
</asp:Content>