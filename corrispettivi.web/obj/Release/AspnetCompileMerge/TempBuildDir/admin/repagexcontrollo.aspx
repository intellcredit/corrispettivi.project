﻿<%@ Page Title="" Language="C#" MasterPageFile="~/admin/local.master" AutoEventWireup="true" CodeBehind="repagexcontrollo.aspx.cs" Inherits="corrispettivi.web.admin.repagexcontrollo" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">
    <h1><b>REPORT AGENTI PER CONTROLLO COMPENSI.</b></h1><hr />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
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
                        <telerik:RadToolBarDropDown Text="Esporta" Font-Bold="True" ImageUrl="~/image/Download-20.png"> 
                            <Buttons>
                                <telerik:RadToolBarButton Text="Excel" ImageUrl="~/image/excel.gif" CommandName="expExcel" Value="~/excel.aspx?type=controlReport&rif={0}" />
                            </Buttons>
                        </telerik:RadToolBarDropDown>
                    </Items>
                </telerik:radtoolbar></td>
        </tr>
    </table>
    <telerik:RadGrid ID="gvInfo" runat="server" Skin="Simple" AllowPaging="false" AllowSorting="True" AllowFilteringByColumn="false" CellSpacing="0" GridLines="None" PageSize="100" DataSourceID="sdsInfo" Height="550px" ShowFooter="true">
        <SelectedItemStyle CssClass="SelectedStyle" />
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" />
        <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="Codice">
            <Columns>
                <telerik:GridBoundColumn DataField="CallCenter" HeaderText="CallCenter" HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Codice" HeaderText="Codice" HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Aggregate="Count" FooterStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Agente" HeaderText="Agente" HeaderStyle-Width="120px" HeaderStyle-HorizontalAlign="Center" AllowFiltering="false" />

                <telerik:GridBoundColumn DataField="Corrispettivi"  HeaderText="Corrispettivi" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Bonus provvigionali"  HeaderText="Bonus provvigionali" HeaderStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Premi"  HeaderText="Premi" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Bonus contatti"  HeaderText="Bonus contatti" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                
                <telerik:GridBoundColumn DataField="Ore ctr" HeaderText="Ore ctr" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Ore log" HeaderText="Ore log" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" />

                <telerik:GridBoundColumn DataField="Tipo retribuzione" HeaderText="Tipo retribuzione" HeaderStyle-Width="80px" AllowFiltering="false" />

                <telerik:GridBoundColumn DataField="Imp.min. + integr."  HeaderText="Imp.min. + integr." HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}"  FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Bonus salva lavoro"  HeaderText="Bonus salva lavoro" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}"  FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Bonus extra"  HeaderText="Bonus extra" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}"  FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="Totale" HeaderText="Totale" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}"  FooterStyle-HorizontalAlign="Right" AllowFiltering="false" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="xAgentiReportControllo" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:ControlParameter ControlID="cmbPeriodoRif" PropertyName="SelectedValue" Name="PeriodoRif" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsCallCenter" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsCallCenter" ConnectionString="<%$ ConnectionStrings:dbConn%>" />
    
    <asp:SqlDataSource ID="sdsPeriodoRif" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsPeriodoRif" ConnectionString="<%$ ConnectionStrings:dbConn%>" />
</asp:Content>