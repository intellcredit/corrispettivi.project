<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ccrequestreport.aspx.cs" Inherits="corrispettivi.web.tabulati.agenti.ccrequestreport" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="masterMain" Runat="Server">
    <script type="text/javascript">
        function check() {

            var msg = "";

            var cmb = document.getElementById('<%=cmbCallCenter.ClientID%>').value;
            if (cmb == "")
                msg = msg.concat("- Selezionare il call center\n");
                
            var cmb = document.getElementById('<%=cmbPeriodoRif.ClientID%>').value;
            if (cmb == "")
                msg = msg.concat("- Selezionare il periodo di riferimento\n");

            var txt = document.getElementById('<%=txtMailTo.ClientID%>').value;
            if (txt == "")
                msg = msg.concat("- Digitare l'indirizzo email del destinatario\n");

            if (msg != "") {
                alert(msg);
                return false;
            }
        }
    </script>

    <h1><b>Richiesta inoltro report riepilogativo tabulati per email</b></h1><hr />


    <table border="0" cellpadding="0" cellspacing="0" bgcolor="#cccccc" width="100%">
        <tr bgcolor="white"><td><asp:Label ID="lblAction" runat="server" Text="" /></td></tr>
    </table>

    
    <table border="0" cellpadding="2" cellspacing="2">
        <tr>
            <td width="100px" align="right"><b>Call center:</b></td>
            <td><telerik:RadComboBox ID="cmbCallCenter" runat="server" Width="260px" EmptyMessage="seleziona" DataSourceID="sdsCallCenter" DataTextField="CallCenterNome" DataValueField="CallCenterID" Filter="Contains" /></td>

            <td width="150px" align="right"><b>Periodo di riferimento:</b></td>
            <td><telerik:RadComboBox ID="cmbPeriodoRif" runat="server" Width="80px" EmptyMessage="seleziona" DataSourceID="sdsPeriodoRif" DataTextField="PeriodoRif" DataValueField="PeriodoRif" Filter="Contains" /></td>

            <td width="100px" align="right"><b>Destinatario:</b></td>
            <td><asp:TextBox id="txtMailTo" runat="server" Width="400px" /></td>

            <td><asp:Button ID="btnAccoda" runat="server" Text="Accoda" CssClass="testonero12" 
                    onclick="btnAccoda_Click" OnClientClick="javascript:return check();" /></td>
        </tr>
    </table>

    <table border="0" cellpadding="2" cellspacing="2" width="100%">
        <tr><td colspan="6"><hr /></td></tr>
    </table>

    <telerik:RadGrid ID="gvInfo" runat="server" DataSourceID="sdsInfo" Skin="Simple" CellSpacing="0" GridLines="None" Height="550px" ShowFooter="true"  OnItemCommand="gvInfo_ItemCommand" OnItemDataBound="gvInfo_ItemDataBound">
        <ClientSettings EnableRowHoverStyle="true" Scrolling-UseStaticHeaders="True" Scrolling-AllowScroll="True" />
        <HeaderStyle Font-Bold="true" VerticalAlign="Top" />
        <ItemStyle VerticalAlign="Top" />
        <AlternatingItemStyle VerticalAlign="Top" BorderColor="LightGray" BackColor="White" />
        <FooterStyle VerticalAlign="Top" CssClass="titrosso10" Font-Bold="true" />
        <MasterTableView AutoGenerateColumns="false" TableLayout="Fixed" DataKeyNames="CallCenterRequestReportID">
            <Columns>
                <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" HeaderText="" HeaderStyle-Width="20px">
                    <ItemTemplate><asp:ImageButton ID="btnDelete" runat="server" ImageUrl="~/Image/delete.png" CommandName="Delete" OnClientClick="javascript:return confirm('Sicuro di voler eliminare questa richiesta?');" /></ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="CallCenterNome"  HeaderText="Call center" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count" FooterStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="PeriodoRif"  HeaderText="Periodo" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" Aggregate="Count" FooterStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="MailTo"  HeaderText="Destinatario" HeaderStyle-Width="200px" HeaderStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="DataRichiesta"  HeaderText="Data richiesta" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" />
                <telerik:GridBoundColumn DataField="DataInvio"  HeaderText="Data invio" HeaderStyle-Width="100px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" AllowFiltering="false" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <asp:SqlDataSource ID="sdsInfo" runat="server" ProviderName="System.Data.SqlClient" ConnectionString="<%$ ConnectionStrings:dbConn%>"
            SelectCommand="SELECT RR.*, CC.Nominativo as CallCenterNome FROM CallCenterRequestReport RR
                            inner join CallCenter CC on CC.CallCenterID = RR.CallCenterID" SelectCommandType="Text" 
            insertcommand="insert into CallCenterRequestReport (CallCenterID,PeriodoRif,MailTo) VALUES (@CallCenterID,@PeriodoRif,@MailTo)" InsertCommandType="Text">
        <SelectParameters>
            <asp:SessionParameter SessionField="CallCenterID" Name="CallCenterID" Type="String" DefaultValue="" />
        </SelectParameters>
        <insertparameters>
            <asp:ControlParameter ControlID="cmbCallCenter" PropertyName="SelectedValue" Name="CallCenterID" Type="String" DefaultValue="" />
            <asp:ControlParameter ControlID="cmbPeriodoRif" PropertyName="SelectedValue" Name="PeriodoRif" Type="String" DefaultValue="" />
            <asp:ControlParameter ControlID="txtMailTo" Name="MailTo" Type="String" DefaultValue="" />
        </insertparameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsCallCenter" runat="server" ProviderName="System.Data.SqlClient" SelectCommandType="StoredProcedure" SelectCommand="sdsCallCenter" ConnectionString="<%$ ConnectionStrings:dbConn%>" />
    
    <asp:SqlDataSource ID="sdsPeriodoRif" runat="server" ProviderName="System.Data.SqlClient" SelectCommand="sdsPeriodoRif" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:dbConn%>" />

</asp:Content>