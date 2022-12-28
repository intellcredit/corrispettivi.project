<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="corrispettivi.web.home" %>
<%@ Register src="anomalie/alertCounter.ascx" tagname="alertCounter" tagprefix="UC" %>
<%@ Register src="anomalie/alertContratti.ascx" tagname="alertContratti" tagprefix="UC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="masterHead" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="masterMain" Runat="Server">

    <br />
    <table border="0" cellpadding="2" cellspacing="2" width="100%">
        <tr><td><UC:alertcontratti ID="alertContratti" runat="server" /></td></tr>
        <tr><td><br /><br /></td></tr>
        <tr><td><UC:alertCounter ID="alertCounter" runat="server" /></td></tr>
    </table>    
    
</asp:Content>