<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="corrispettivi.web.agenti._default" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <style type="text/css">
        .imButton
        {
            padding-left: 6px;
            vertical-align: bottom;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <div style="background-color: #999999; padding: 10px; width: 550px">
        <div style="padding: 10px; background-color: White;">
            <telerik:RadComboBox ID="RadComboBox1" runat="server" Skin="Vista" AutoPostBack="false"
                BorderStyle="None">
                <Items>
                    <telerik:RadComboBoxItem Text="RadGrid1" />
                    <telerik:RadComboBoxItem Text="RadGrid2" />
                    <telerik:RadComboBoxItem Text="RadGrid3" />
                    <telerik:RadComboBoxItem Text="All RadGrids" />
                </Items>
            </telerik:RadComboBox>
            <asp:ImageButton ID="ImageButton1" runat="server" AlternateText="Export to Excel"
                CssClass="imButton" ImageUrl="~/Images/Pdf.jpg" OnClick="ImageButton1_Click" />
        </div>
        <telerik:RadGrid ID="RadGridWrapper" runat="server" ShowHeader="false" Width="550px"
            BorderStyle="None" OnItemCreated="RadGridWrapper_ItemCreated">
            <ExportSettings OpenInNewWindow="true" />
            <MasterTableView AutoGenerateColumns="true" BorderStyle="None">
                <ItemTemplate>
                    <telerik:RadGrid ID="RadGrid1" runat="server" OnNeedDataSource="RadGrid_NeedDataSource"
                        BorderStyle="None" Skin="Office2007">
                        <ExportSettings ExportOnlyData="true" OpenInNewWindow="true" />
                        <MasterTableView AutoGenerateColumns="false">
                            <Columns>
                                <telerik:GridBoundColumn DataField="ID" HeaderText="ID" UniqueName="ID" />
                                <telerik:GridBoundColumn DataField="Number" HeaderText="Number" UniqueName="Number" />
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <br />
                    <telerik:RadGrid ID="RadGrid2" runat="server" OnNeedDataSource="RadGrid_NeedDataSource"
                        BorderStyle="None" Skin="Office2007">
                        <ExportSettings ExportOnlyData="true" OpenInNewWindow="true" />
                        <MasterTableView AutoGenerateColumns="false">
                            <Columns>
                                <telerik:GridBoundColumn DataField="ID" HeaderText="ID" UniqueName="ID" />
                                <telerik:GridBoundColumn DataField="Number" HeaderText="Number" UniqueName="Number" />
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <br />
                    <telerik:RadGrid ID="RadGrid3" runat="server" OnNeedDataSource="RadGrid_NeedDataSource"
                        BorderStyle="None" Skin="Office2007">
                        <ExportSettings ExportOnlyData="true" OpenInNewWindow="true" />
                        <MasterTableView AutoGenerateColumns="false">
                            <Columns>
                                <telerik:GridBoundColumn DataField="ID" HeaderText="ID" UniqueName="ID" />
                                <telerik:GridBoundColumn DataField="Number" HeaderText="Number" UniqueName="Number" />
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </ItemTemplate>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    </form>
</body>
</html>
