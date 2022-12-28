<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="expreport-rip.aspx.cs" Inherits="corrispettivi.web.commerciali.expreport_rip" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

     <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    <link href="~/Styles/font.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        ul.taglist {float: left;width: 100%; list-style-type: none;margin: 0;padding: 0}
        ul.taglist li{float:left; margin:0 2px 7px 0;padding: 0 0 0 10px; background: #E1E1E1 url(image/tagbk.png) no-repeat top left} 
        ul.taglist a{float: left; text-decoration: none;height: 20px;line-height: 20px; padding: 0 10px 0 0;background: url(tagbk.png) no-repeat top right; color: #444;white-space: nowrap}
        ul.taglist a:hover{color:#010159}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="telerikScriptManager" runat="server" />
    <div style="background-color:White">
    
    <br /><br /><br />

    <table border="0" cellpadding="10" cellspacing="10">
        <tr>
            <td><table border="0" cellpadding="0" cellspacing="0" class="testonero12">
                <tr><td align="right"><b>Periodo:</b></td><td><%=Request["x"] %></td></tr>
                <tr><td align="right"><b>Codice:</b></td><td><%=Request["y"] %></td></tr>
                <tr><td align="right"><b>Nominativo:</b></td><td><%=Request["z"] %></td></tr>
                <tr><td colspan="2"><br /><br /><br /></td></tr>
                <tr><td colspan="2"><telerik:RadGrid ID="gvSummary" runat="server" Skin="Simple" AutoGenerateColumns="false" DataSourceID="sdsSummary" CellSpacing="0" GridLines="None" ShowHeader="true" ShowFooter="false" Width="400px" OnItemDataBound="gvSummary_ItemDataBound">
                <HeaderStyle Font-Bold="true" VerticalAlign="Top" HorizontalAlign="Center" />
                <ItemStyle CssClass="testonero12" />
                <AlternatingItemStyle BackColor="White" CssClass="testonero12" />
                <MasterTableView ShowHeadersWhenNoRecords="true" DataKeyNames="Row">
                    <ColumnGroups>
                        <telerik:GridColumnGroup Name="Header" HeaderText="RIEPILOGO FATTURA" HeaderStyle-HorizontalAlign="Center" />
                    </ColumnGroups>
                    <Columns>
                        <telerik:GridBoundColumn DataField="desc"  ItemStyle-Width="220px" ItemStyle-HorizontalAlign="Right" ColumnGroupName="Header" HeaderText="DESCRIZIONE" />
                        <telerik:GridBoundColumn DataField="importo" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" ItemStyle-Width="80px" ColumnGroupName="Header" HeaderText="IMPORTO" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid></td></tr>
        <tr><td colspan="2"><br /><br /><br /></td></tr>
        <tr><td colspan="2"><telerik:RadGrid ID="gvAnticipato" runat="server" Skin="Simple" AutoGenerateColumns="false" DataSourceID="sdsAnticipato" CellSpacing="0" GridLines="None" ShowHeader="true" ShowFooter="true" Width="400px">
                <HeaderStyle Font-Bold="true" VerticalAlign="Top" HorizontalAlign="Center" />
                <ItemStyle CssClass="testonero12" />
                <AlternatingItemStyle BackColor="White" CssClass="testonero12" />
                <FooterStyle CssClass="titnero12"  />
                <MasterTableView ShowHeadersWhenNoRecords="true">
                    <ColumnGroups>
                        <telerik:GridColumnGroup Name="Header" HeaderText="ANTICIPATO IN VALUTA" HeaderStyle-HorizontalAlign="Center" />
                    </ColumnGroups>
                    <Columns>
                        <telerik:GridBoundColumn DataField="Periodo" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Right" ColumnGroupName="Header" HeaderText="PERIODO" />
                        <telerik:GridBoundColumn DataField="NumPag" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="75px" ColumnGroupName="Header" HeaderText="NUM.PAG."  />
                        <telerik:GridBoundColumn DataField="Imponibile" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C}" ItemStyle-Width="75px" ColumnGroupName="Header" HeaderText="IMPONIBILE" Aggregate="Sum" FooterStyle-HorizontalAlign="Right" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid></td></tr>
    </table>
            </td>
        </tr>    
    </table>

    

    <br /><br /><br />
                            
    <asp:SqlDataSource ID="sdsSummary" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="summaryAgenteGroupxPeriodo" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="x" Name="PeriodoRif" />
            <asp:QueryStringParameter QueryStringField="y" Name="AgenteGroupID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsAnticipato" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="anticipatoAgenteGroupxPeriodo" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="x" Name="PeriodoRif" />
            <asp:QueryStringParameter QueryStringField="y" Name="AgenteGroupID" />
        </SelectParameters>
    </asp:SqlDataSource>

    </div>
    </form>
</body>
</html>
