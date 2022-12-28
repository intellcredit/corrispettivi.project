<%@ Page Title="" Language="C#" MasterPageFile="~/contabilita/procuratori/local.master" AutoEventWireup="true" CodeBehind="report.aspx.cs" Inherits="corrispettivi.web.contabilita.procuratori.report" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register src="../../legendStatusFattura.ascx" tagname="legendStatusFattura" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">
    <h1><b>PROCURATORI -> Report per anno</b></h1><hr />
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

    <telerik:RadGrid ID="gvInfo" runat="server" DataSourceID="sdsInfo" Skin="Simple" CellSpacing="0" GridLines="None" Height="550px" ShowFooter="true" OnItemDataBound="gvInfo_ItemDataBound" AllowFiltering="false" >
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Selecting-CellSelectionMode="SingleCell" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" BorderColor="LightGray" BackColor="White" />
        <FooterStyle VerticalAlign="Top" CssClass="titrosso10" Font-Bold="true" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="AgenteGroupID,GEN_CheckFattura,FEB_CheckFattura,MAR_CheckFattura,APR_CheckFattura,MAG_CheckFattura,GIU_CheckFattura,LUG_CheckFattura,AGO_CheckFattura,SET_CheckFattura,OTT_CheckFattura,NOV_CheckFattura,DIC_CheckFattura,GEN_Saldo,FEB_Saldo,MAR_Saldo,APR_Saldo,MAG_Saldo,GIU_Saldo,LUG_Saldo,AGO_Saldo,SET_Saldo,OTT_Saldo,NOV_Saldo,DIC_Saldo">
            <Columns>
                
                <telerik:GridBoundColumn DataField="AgenteGroupNome" HeaderText="Agente" HeaderStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center"
                                        Aggregate="Count"  />

                <telerik:GridHyperLinkColumn HeaderText="Gennaio" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="GEN_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,GEN_Num,CallCenterID,AgenteGroupID,GEN_Totale,GEN_Saldo" 
                                        DataNavigateUrlFormatString="fatture\scheda.aspx?x={0}&y={1}&c={2}&a={3}&ret=r" />

                <telerik:GridHyperLinkColumn HeaderText="Febbraio" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="FEB_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,FEB_Num,CallCenterID,AgenteGroupID,FEB_Totale,FEB_Saldo" 
                                        DataNavigateUrlFormatString="fatture\scheda.aspx?x={0}&y={1}&c={2}&a={3}&ret=r" />

                <telerik:GridHyperLinkColumn HeaderText="Marzo" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="MAR_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,MAR_Num,CallCenterID,AgenteGroupID,MAR_Totale,MAR_Saldo" 
                                        DataNavigateUrlFormatString="fatture\scheda.aspx?x={0}&y={1}&c={2}&a={3}&ret=r" />

                <telerik:GridHyperLinkColumn HeaderText="Aprile" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="APR_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,APR_Num,CallCenterID,AgenteGroupID,APR_Totale,APR_Saldo"  
                                        DataNavigateUrlFormatString="fatture\scheda.aspx?x={0}&y={1}&c={2}&a={3}&ret=r" />

                <telerik:GridHyperLinkColumn HeaderText="Maggio" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="MAG_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,MAG_Num,CallCenterID,AgenteGroupID,MAG_Totale,MAG_Saldo"
                                        DataNavigateUrlFormatString="fatture\scheda.aspx?x={0}&y={1}&c={2}&a={3}&ret=r" />

                <telerik:GridHyperLinkColumn HeaderText="Giugno" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="GIU_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,GIU_Num,CallCenterID,AgenteGroupID,GIU_Totale,GIU_Saldo"
                                        DataNavigateUrlFormatString="fatture\scheda.aspx?x={0}&y={1}&c={2}&a={3}&ret=r" />

                <telerik:GridHyperLinkColumn HeaderText="Luglio" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="LUG_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,LUG_Num,CallCenterID,AgenteGroupID,LUG_Totale,LUG_Saldo" 
                                        DataNavigateUrlFormatString="fatture\scheda.aspx?x={0}&y={1}&c={2}&a={3}&ret=r" />

                <telerik:GridHyperLinkColumn HeaderText="Agosto" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="AGO_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,AGO_Num,CallCenterID,AgenteGroupID,AGO_Totale,AGO_Saldo" 
                                        DataNavigateUrlFormatString="fatture\scheda.aspx?x={0}&y={1}&c={2}&a={3}&ret=r" />

                <telerik:GridHyperLinkColumn HeaderText="Settembre" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="SET_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,SET_Num,CallCenterID,AgenteGroupID,SET_Totale,SET_Saldo" 
                                        DataNavigateUrlFormatString="fatture\scheda.aspx?x={0}&y={1}&c={2}&a={3}&r={1}/{0}&ret=r" />

                <telerik:GridHyperLinkColumn HeaderText="Ottobre" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="OTT_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,OTT_Num,CallCenterID,AgenteGroupID,OTT_Totale,OTT_Saldo"  
                                        DataNavigateUrlFormatString="fatture\scheda.aspx?x={0}&y={1}&c={2}&a={3}&ret=r" />

                <telerik:GridHyperLinkColumn HeaderText="Novembre" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="NOV_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,NOV_Num,CallCenterID,AgenteGroupID,NOV_Totale,NOV_Saldo" 
                                        DataNavigateUrlFormatString="fatture\scheda.aspx?x={0}&y={1}&c={2}&a={3}&ret=r" />

                <telerik:GridHyperLinkColumn HeaderText="Dicembre" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="DIC_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,DIC_Num,CallCenterID,AgenteGroupID,DIC_Totale,DIC_Saldo"  
                                        DataNavigateUrlFormatString="fatture\scheda.aspx?x={0}&y={1}&c={2}&a={3}&ret=r" />
                
                <telerik:GridBoundColumn HeaderText="Totale" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        ItemStyle-CssClass="titrosso10" ItemStyle-Font-Bold="true" ItemStyle-BackColor="BlanchedAlmond" 
                                        DataField="Anno_Totale"  
                                        DataFormatString="{0:N}"
                                        Aggregate="Sum" />

            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <uc1:legendStatusFattura ID="legendStatusFattura1" runat="server" />
                                                                                                       
    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotContabilitaProcuratorixAnno" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:ControlParameter ControlID="cmbAnnoRif" PropertyName="SelectedValue" Name="AnnoRif" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <%--<asp:SqlDataSource ID="sdsAgenti" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommandType="StoredProcedure" SelectCommand="sdsContabilitaProduratori" ConnectionString="<%$ ConnectionStrings:dbConn%>" />--%>

    <asp:SqlDataSource ID="sdsAnnoRif" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommand="sdsContabilitaAnnoRifDistinct" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" />
</asp:Content>