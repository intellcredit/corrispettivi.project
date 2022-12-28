<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="repAlertAgenti.aspx.cs" Inherits="corrispettivi.web.anomalie.WebForm2" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="masterMain" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblAction" runat="server" Text="" /></td></tr>
    </table>

    <table border="0" cellpadding="2" cellspacing="2">
        <tr valign="middle">
            <td class="titnero12" nowrap>Selezionare: Anomalia:</td>
            <td><telerik:RadComboBox ID="cmbTipoAnomalia" runat="server" Width="400px" EmptyMessage="Selezionare un valore..."
                    DataSourceID="sdsTipiAnomalia" DataTextField="Descrizione" DataValueField="TipoAnomaliaID" AutoPostBack="true" AppendDataBoundItems="true" 
                    onselectedindexchanged="cmbTipoAnomalia_SelectedIndexChanged" /></td>
            <td><asp:ImageButton ID="imgSearch" runat="server" ImageUrl="~/Image/Find.png" onclick="imgSearch_Click" /></td>
            <td width="100%" align="right"><telerik:radtoolbar ID="tbAction" runat="server" Skin="Simple">
                    <Items>
                        <telerik:RadToolBarDropDown Text="Esporta" Font-Bold="True" ImageUrl="~/image/Download-20.png"> 
                            <Buttons>
                                <telerik:RadToolBarButton Text="Csv" ImageUrl="~/image/csv.png" CommandName="expCsv" Value="~/anomalie/expAlertAgenti.aspx?mode=csv&x={0}&y={1}" />
                                <telerik:RadToolBarButton Text="Excel" ImageUrl="~/image/excel.gif" CommandName="expExcel" Value="~/anomalie/expAlertAgenti.aspx?mode=xls&x={0}&y={1}" />
                            </Buttons>
                        </telerik:RadToolBarDropDown>
                    </Items>
                </telerik:radtoolbar></td>
        </tr>
    </table>

    <telerik:RadGrid ID="gvInfo" runat="server" Skin="Simple" AllowPaging="false" AllowSorting="True" AllowFilteringByColumn="true" CellSpacing="0" GridLines="None" PageSize="100" DataSourceID="sdsInfo" Height="550px" ShowFooter="true">
        <SelectedItemStyle CssClass="SelectedStyle" />
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" />
        <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" >
            <Columns>
                <telerik:GridBoundColumn DataField="AgenteGroupID" HeaderText="ID" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="AgenteGroupAlias" HeaderText="Agente" HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count" FooterStyle-HorizontalAlign="Center">
                    <FilterTemplate>
                        <telerik:RadComboBox RenderMode="Lightweight" ID="AgentiCombo" DataSourceID="sdsAgenti" DataTextField="AgenteGroupAlias" Skin="Black" Filter="Contains"
                            DataValueField="AgenteGroupAlias" Height="200px" Width="400px" DropDownWidth="400px" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("AgenteGroupAlias").CurrentFilterValue %>' 
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
                <telerik:GridBoundColumn DataField="Messaggio"  HeaderText="Messaggio" HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Anzianita"  HeaderText="Anzianita" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" AllowFiltering="false" />
            </Columns>
            <GroupByExpressions>
                <telerik:GridGroupByExpression>
                    <SelectFields>
                        <telerik:GridGroupByField FieldAlias="Anomalia" FieldName="Anomalia" HeaderValueSeparator=": " />
                    </SelectFields>
                    <GroupByFields>
                        <telerik:GridGroupByField FieldName="Anomalia" />
                    </GroupByFields>
                </telerik:GridGroupByExpression>
            </GroupByExpressions>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotAnomalieAgenti" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:ControlParameter ControlID="cmbTipoAnomalia" PropertyName="SelectedValue" Name="TipoAnomaliaID" Type="Int32" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sdsTipiAnomalia" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="Text" SelectCommand="select * from TipiAnomalia" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

    <asp:SqlDataSource ID="sdsAgenti" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsAgenti" ConnectionString="<%$ ConnectionStrings:dbConn%>" />
</asp:Content>