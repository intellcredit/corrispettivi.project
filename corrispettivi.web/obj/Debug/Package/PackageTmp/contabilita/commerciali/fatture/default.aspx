<%@ Page Title="" Language="C#" MasterPageFile="~/contabilita/commerciali/local.master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="corrispettivi.web.contabilita.commerciali.fatture._default" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register src="~/legendStatusFattura.ascx" tagname="legendStatusFattura" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">
    <h1><b>COMMERCIALI. REPORT FATTURE.</b></h1><hr />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblAction" runat="server" Text="" /></td></tr>
    </table>

    <table border="0" cellpadding="2" cellspacing="2">
        <tr valign="middle">
            <td class="titnero12" nowrap>Selezionare: Anno:</td>
            <td><telerik:RadComboBox ID="cmbAnnoRif" runat="server" Width="150px" EmptyMessage="Selezionare un valore..."
                    DataSourceID="sdsAnnoRif" DataTextField="AnnoRif" DataValueField="AnnoRif" AutoPostBack="true" 
                    onselectedindexchanged="cmbAnnoRif_SelectedIndexChanged" /></td>
            <td class="titnero12" nowrap>Mese:</td>
            <td><telerik:RadComboBox ID="cmbMeseRif" runat="server" Width="150px" EmptyMessage="Selezionare un valore..." AutoPostBack="true" 
                    onselectedindexchanged="cmbMeseRif_SelectedIndexChanged" >
                    <Items>
                        <telerik:RadComboBoxItem Value="0" Text="Tutti" Selected />
                        <telerik:RadComboBoxItem Value="1" Text="Gennaio" />
                        <telerik:RadComboBoxItem Value="2" Text="Febbraio" />
                        <telerik:RadComboBoxItem Value="3" Text="Marzo" />
                        <telerik:RadComboBoxItem Value="4" Text="Aprile" />
                        <telerik:RadComboBoxItem Value="5" Text="Maggio" />
                        <telerik:RadComboBoxItem Value="6" Text="Giugno" />
                        <telerik:RadComboBoxItem Value="7" Text="Luglio" />
                        <telerik:RadComboBoxItem Value="8" Text="Agosto" />
                        <telerik:RadComboBoxItem Value="9" Text="Settembre" />
                        <telerik:RadComboBoxItem Value="10" Text="Ottobre" />
                        <telerik:RadComboBoxItem Value="11" Text="Novembre" />
                        <telerik:RadComboBoxItem Value="12" Text="Dicembre" />
                    </Items>
                </telerik:RadComboBox></td>
            <td class="titnero12" nowrap>Stato:</td>
            <td><telerik:RadComboBox ID="cmbStatusFattura" runat="server" Width="200px" EmptyMessage="Selezionare un valore..."
                    AutoPostBack="true" onselectedindexchanged="cmbStatusFattura_SelectedIndexChanged" >
                        <Items>
                            <telerik:RadComboBoxItem Value="0" Text="Tutti" Selected />
                            <telerik:RadComboBoxItem Value="1" Text="Non fatturato" />
                            <telerik:RadComboBoxItem Value="2" Text="Parzialmente Fatturato" />
                            <telerik:RadComboBoxItem Value="3" Text="Fatturato" />
                        </Items>
                    </telerik:RadComboBox></td>
            <td><asp:ImageButton ID="imgSearch" runat="server" ImageUrl="~/Image/Find.png" onclick="imgSearch_Click" /></td>
            <td width="100%" align="right"><telerik:radtoolbar ID="tbAction" runat="server" Skin="Simple">
                    <Items>
                        <telerik:RadToolBarDropDown Text="Esporta" Font-Bold="True" ImageUrl="~/image/Download-20.png"> 
                            <Buttons>
                                <telerik:RadToolBarButton Text="Csv" ImageUrl="~/image/csv.png" CommandName="expCsv" Value="expdeault.aspx?mode=csv&x={0}&fatt={1}" />
                                <telerik:RadToolBarButton Text="Excel" ImageUrl="~/image/excel.gif" CommandName="expExcel" Value="expdefault.aspx?mode=xls&x={0}&chkFatt={1}" />
                            </Buttons>
                        </telerik:RadToolBarDropDown>
                    </Items>
                </telerik:radtoolbar></td>
        </tr>
    </table>

    <telerik:RadGrid ID="gvInfo" runat="server" Skin="Simple" AllowPaging="false" AllowSorting="True" AllowFilteringByColumn="true" CellSpacing="0" GridLines="None" PageSize="100" DataSourceID="sdsInfo" Height="550px" ShowFooter="true" OnItemDataBound="gvInfo_ItemDataBound">
        <SelectedItemStyle CssClass="SelectedStyle" />
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" />
        <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="CommercialeID ,AnnoRif,MeseRif,StatusFatturaID">
            <Columns>
                <telerik:GridHyperLinkColumn AllowFiltering="False" AllowSorting="False" HeaderText="" ImageUrl="~/image/Modify.png" DataNavigateUrlFields="AnnoRif,MeseRif,CommercialeID"  DataNavigateUrlFormatString="scheda.aspx?x={0}&y={1}&c={2}&ret=f" HeaderStyle-Width="20px" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="MeseDesc"  HeaderText="Mese" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="CommercialeNome" HeaderText="CallCenter" HeaderStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count" FooterStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Totale"  HeaderText="Totale" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="StatusFatturaDesc"  HeaderText="Status" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Fatturato" HeaderText="Fatturato" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Saldo"  HeaderText="Saldo" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
            </Columns>
            <GroupByExpressions>
                <telerik:GridGroupByExpression>
                    <SelectFields>
                        <telerik:GridGroupByField FieldAlias="Commerciale" FieldName="CommercialeNome" HeaderValueSeparator=": " />
                    </SelectFields>
                    <GroupByFields>
                        <telerik:GridGroupByField FieldName="CommercialeNome" />
                    </GroupByFields>
                </telerik:GridGroupByExpression>
            </GroupByExpressions>
        </MasterTableView>
    </telerik:RadGrid>

    <uc1:legendStatusFattura ID="legendStatusFattura1" runat="server" />

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotContabilitaCommercialiFatturexAnno" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:ControlParameter ControlID="cmbAnnoRif" PropertyName="SelectedValue" Name="AnnoRif" Type="String" DefaultValue="" />
            <asp:ControlParameter ControlID="cmbMeseRif" PropertyName="SelectedValue" Name="MeseRif" Type="String" DefaultValue="" />
            <asp:ControlParameter ControlID="cmbStatusFattura" PropertyName="SelectedValue" Name="StatusFatturaID" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sdsAnnoRif" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommand="sdsAnnoRifDistinct" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" />
</asp:Content>