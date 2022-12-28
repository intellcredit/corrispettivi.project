<%@ Page Title="" Language="C#" MasterPageFile="~/SiteUffPersonale.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="corrispettivi.web.uffpersonale.home" %>
<%@ Register src="../anomalie/alertCounter.ascx" tagname="alertCounter" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="masterHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="masterMain" Runat="Server">
    <uc1:alertCounter ID="alertCounter1" runat="server" />
</asp:Content>