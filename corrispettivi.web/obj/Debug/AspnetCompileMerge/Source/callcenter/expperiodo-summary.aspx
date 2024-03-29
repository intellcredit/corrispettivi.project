﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteExport.master" AutoEventWireup="true" CodeBehind="expperiodo-summary.aspx.cs" Inherits="corrispettivi.web.callcenter.expperiodo_summary" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="exportHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="exportMain" Runat="Server">

    <telerik:RadGrid ID="gvInfo" GridLines="None" CellPadding="0" CellSpacing="1" runat="server" ShowHeader="true" Visible="true" DataSourceID="sdsInfo" OnPreRender="gvInfo_PreRender">
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" BackColor="LightGray" />
        <ExportSettings ExportOnlyData="true" OpenInNewWindow="true" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed">
            <Columns>
                <telerik:GridTemplateColumn ItemStyle-CssClass="testonero12" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="400px">
                    <ItemTemplate>
                        <table border="0" style="border-color:White" cellpadding="1" cellspacing="1" class="testonero12" width="400px" >
                            <colgroup><col width="100px"/><col width="300px" /></colgroup> 
                            <tr><td align="right"><b>Periodo:</b></td><td><%# Eval("PeriodoRif") %></td></tr>
                            <tr><td align="right"><b>Codice:</b></td><td><%# Eval("AgenteGroupID")%></td></tr>
                            <tr><td align="right"><b>Nominativo:</b></td><td><%# Eval("AgenteGroupNome")%></td></tr>
                        </table>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>

            <NestedViewTemplate>
                <asp:Panel runat="server" ID="InnerContainer" CssClass="viewWrap">
                    <asp:Label ID="lblPeriodoRif" Text='<%# Eval("PeriodoRif") %>' Visible="false" runat="server" />
                    <asp:Label ID="lblAgenteGroupID" Text='<%# Eval("AgenteGroupID") %>' Visible="false" runat="server" />

                    <table border="0" style="border-color:White" cellpadding="20" cellspacing="20" class="testonero12" width="400px">
                        <colgroup><col /></colgroup>
                        <tr>
                            <td>
                                <telerik:RadGrid ID="gvSummary" runat="server" Skin="Simple" AutoGenerateColumns="false" DataSourceID="sdsSummary" CellPadding="0" CellSpacing="0" BorderWidth="0px" GridLines="Horizontal" ShowHeader="true" ShowFooter="false" OnItemDataBound="gvSummary_ItemDataBound">
                                    <HeaderStyle Font-Bold="true" VerticalAlign="Top" HorizontalAlign="Center" BackColor="LightGray" />
                                    <ItemStyle CssClass="testonero12" BackColor="White" />
                                    <AlternatingItemStyle BackColor="White" CssClass="testonero12" />
                                    <MasterTableView ShowHeadersWhenNoRecords="true" DataKeyNames="Row" GridLines="Both" CellPadding="0" CellSpacing="0">
                                        <NoRecordsTemplate>Nessun record</NoRecordsTemplate>
                                        <ColumnGroups>
                                            <telerik:GridColumnGroup Name="Header" HeaderText="RIEPILOGO COMPENSI" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="LightGray" />
                                        </ColumnGroups>
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="desc"  ItemStyle-Width="220px" ColumnGroupName="Header" HeaderText="DESCRIZIONE" HeaderStyle-BackColor="LightGray" />
                                            <telerik:GridBoundColumn DataField="importo" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" ItemStyle-Width="80px" ColumnGroupName="Header" HeaderText="IMPORTO" HeaderStyle-BackColor="LightGray" />
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadGrid ID="gvAnticipato" runat="server" Skin="Simple" AutoGenerateColumns="false" DataSourceID="sdsAnticipato" CellSpacing="0" GridLines="None" ShowHeader="true" ShowFooter="true">
                                    <HeaderStyle Font-Bold="true" VerticalAlign="Top" HorizontalAlign="Center" BackColor="LightGray" />
                                    <ItemStyle CssClass="testonero12" BackColor="White" />
                                    <AlternatingItemStyle BackColor="White" CssClass="testonero12" />
                                    <FooterStyle VerticalAlign="Top" BackColor="LightGray" Font-Bold="true" />
                                    <MasterTableView ShowHeadersWhenNoRecords="true" GridLines="Both" CellPadding="0" CellSpacing="0">
                                        <NoRecordsTemplate>Nessun record</NoRecordsTemplate>
                                        <ColumnGroups>
                                            <telerik:GridColumnGroup Name="Header" HeaderText="RIEPILOGO ANTICIPATO IN VALUTA" HeaderStyle-HorizontalAlign="Center" />
                                        </ColumnGroups>
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="Periodo" ItemStyle-Width="200px" ColumnGroupName="Header" HeaderText="PERIODO" FooterText="Totale" FooterStyle-Font-Bold="true" />
                                            <telerik:GridBoundColumn DataField="NumPag" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="75px" ColumnGroupName="Header" HeaderText="NUM.PAG." Aggregate="Sum" FooterStyle-HorizontalAlign="Center" FooterText=" " />
                                            <telerik:GridBoundColumn DataField="Imponibile" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" ItemStyle-Width="75px" ColumnGroupName="Header" HeaderText="IMPONIBILE" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                        <tr><td align="center"><font class="testonero8">dati aggiornati al <%=DateTime.Now.ToShortDateString()%></font> </td></tr>
                    </table>

                    <asp:SqlDataSource ID="sdsSummary" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="summaryAgenteGroupxPeriodo" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblPeriodoRif" PropertyName="Text" Type="String" Name="PeriodoRif" />
                            <asp:ControlParameter ControlID="lblAgenteGroupID" PropertyName="Text" Type="String" Name="AgenteGroupID" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="sdsAnticipato" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="anticipatoAgenteGroupxPeriodo" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblPeriodoRif" PropertyName="Text" Type="String" Name="PeriodoRif" />
                            <asp:ControlParameter ControlID="lblAgenteGroupID" PropertyName="Text" Type="String" Name="AgenteGroupID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </asp:Panel>
                <?hard-pagebreak?> 
            </NestedViewTemplate>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" ConnectionString="<%$ ConnectionStrings:dbConn%>" SelectCommandType="Text" 
                        SelectCommand="select AgenteGroupID, AgenteGroupNome, @PeriodoRif as PeriodoRif from CallCenterJoinAgenti where CallCenterID = @CallCenterID">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="x" Name="PeriodoRif" />
            <asp:QueryStringParameter QueryStringField="y" Name="CallCenterID" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>