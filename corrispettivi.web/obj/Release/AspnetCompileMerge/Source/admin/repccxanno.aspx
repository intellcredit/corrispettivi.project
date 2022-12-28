<%@ Page Title="" Language="C#" MasterPageFile="~/admin/local.master" AutoEventWireup="true" CodeBehind="repccxanno.aspx.cs" Inherits="corrispettivi.web.admin.repccxanno" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" Runat="Server">
    <h1><b>REPORT CALL CENTER PER ANNO.</b></h1><hr />
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
                                <telerik:RadToolBarButton Text="Csv" ImageUrl="~/image/csv.png" CommandName="expCsv" Value="exprepccxanno.aspx?mode=csv&x={0}" />
                                <telerik:RadToolBarButton Text="Excel" ImageUrl="~/image/excel.gif" CommandName="expExcel" Value="exprepccxanno.aspx?mode=xls&x={0}" />
                            </Buttons>
                        </telerik:RadToolBarDropDown>
                    </Items>
                </telerik:radtoolbar>
            </td>
        </tr>
    </table>

    <telerik:RadGrid ID="gvInfo" runat="server" DataSourceID="sdsInfo" Skin="Simple" CellSpacing="0" GridLines="None" Height="550px" ShowFooter="true" AllowFiltering="false" >
        <ClientSettings EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" Selecting-CellSelectionMode="SingleCell" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" />
        <FooterStyle CssClass="titrosso10" Font-Bold="true" Width="100%" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="CallCenterID">
            <Columns>
                
                <telerik:GridHyperLinkColumn HeaderText="CallCenter" HeaderStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center"
                                        DataTextField="CallCenterNome"
                                        DataNavigateUrlFields="AnnoRif,CallCenterID"  
                                        DataNavigateUrlFormatString="repagexanno.aspx?x={0}&cc={1}" />

                <telerik:GridHyperLinkColumn HeaderText="Gennaio" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="GEN_Totale"
                                        DataTextFormatString="{0:N}"
                                        DataNavigateUrlFields="AnnoRif,GEN_Num,CallCenterID" 
                                        DataNavigateUrlFormatString="repagexperiodo.aspx?x={0}&y={1}&cc={2}" />

                <telerik:GridHyperLinkColumn HeaderText="Febbraio" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="FEB_Totale"
                                        DataTextFormatString="{0:N}"
                                        DataNavigateUrlFields="AnnoRif,FEB_Num,CallCenterID"
                                        DataNavigateUrlFormatString="repagexperiodo.aspx?x={0}&y={1}&cc={2}" />

                <telerik:GridHyperLinkColumn HeaderText="Marzo" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="MAR_Totale"
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,MAR_Num,CallCenterID"
                                        DataNavigateUrlFormatString="repagexperiodo.aspx?x={0}&y={1}&cc={2}" />

                <telerik:GridHyperLinkColumn HeaderText="Aprile" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="APR_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,APR_Num,CallCenterID" 
                                        DataNavigateUrlFormatString="repagexperiodo.aspx?x={0}&y={1}&cc={2}" />

                <telerik:GridHyperLinkColumn HeaderText="Maggio" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="MAG_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,MAG_Num,CallCenterID"
                                        DataNavigateUrlFormatString="repagexperiodo.aspx?x={0}&y={1}&cc={2}" />

                <telerik:GridHyperLinkColumn HeaderText="Giugno" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="GIU_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,GIU_Num,CallCenterID"
                                        DataNavigateUrlFormatString="repagexperiodo.aspx?x={0}&y={1}&cc={2}" />

                <telerik:GridHyperLinkColumn HeaderText="Luglio" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="LUG_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,LUG_Num,CallCenterID"
                                        DataNavigateUrlFormatString="repagexperiodo.aspx?x={0}&y={1}&cc={2}" />

                <telerik:GridHyperLinkColumn HeaderText="Agosto" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="AGO_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,AGO_Num,CallCenterID"
                                        DataNavigateUrlFormatString="repagexperiodo.aspx?x={0}&y={1}&cc={2}" />

                <telerik:GridHyperLinkColumn HeaderText="Settembre" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="SET_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,SET_Num,CallCenterID"
                                        DataNavigateUrlFormatString="repagexperiodo.aspx?x={0}&y={1}&cc={2}" />

                <telerik:GridHyperLinkColumn HeaderText="Ottobre" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="OTT_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,OTT_Num,CallCenterID" 
                                        DataNavigateUrlFormatString="repagexperiodo.aspx?x={0}&y={1}&cc={2}" />

                <telerik:GridHyperLinkColumn HeaderText="Novembre" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="NOV_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,NOV_Num,CallCenterID"
                                        DataNavigateUrlFormatString="repagexperiodo.aspx?x={0}&y={1}&cc={2}" />

                <telerik:GridHyperLinkColumn HeaderText="Dicembre" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataTextField="DIC_Totale"                       
                                        DataTextFormatString="{0:N}" 
                                        DataNavigateUrlFields="AnnoRif,DIC_Num,CallCenterID" 
                                        DataNavigateUrlFormatString="repagexperiodo.aspx?x={0}&y={1}&cc={2}" />
                
                <telerik:GridBoundColumn HeaderText="Totale" HeaderStyle-Width="75px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" 
                                        DataField="Anno_Totale"  
                                        DataFormatString="{0:N}"
                                        Aggregate="Sum" />

            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="pivotAdminxCallCenterxAnno" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:ControlParameter ControlID="cmbAnnoRif" PropertyName="SelectedValue" Name="AnnoRif" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sdsAnnoRif" runat="server" ProviderName="System.Data.SqlClient" 
        SelectCommand="sdsAnnoRifDistinct" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" />
</asp:Content>