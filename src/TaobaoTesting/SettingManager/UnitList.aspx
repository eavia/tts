<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="UnitList.aspx.cs" Inherits="TaobaoTesting.SettingManager.UnitList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="pelGoods" style="width: 99%; height: 300px;">
        <div id="goodstool" style="white-space: nowrap; width: 99%; height: 32px; vertical-align: middle; text-align: center;">
        <asp:Label ID="title" runat="Server" Text="商品单位名称:"></asp:Label>
            <asp:TextBox ID="txtUnitName" runat="server" ValidationGroup="Unit"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtUnitName"
                ErrorMessage="*" ValidationGroup="Unit"></asp:RequiredFieldValidator>
            <asp:CheckBox ID="IsEnabled" runat="Server" Checked="false" Text="启用" />
            <asp:Button ID="btnAddUnit" runat="server" OnClick="btnAddUnit_Click" Text="添加单位"
                ValidationGroup="Unit" />
        </div>
        <div id="goodslst" style="padding: 0px 2px 2px 2px; width: 99%;">
            <asp:DataList Width="99%" ID="dlUnits" runat="server" ExtractTemplateRows="true"
                CellPadding="2" DataKeyField="ID" GridLines="Both" OnItemCommand="dlUnits_ItemCommand">
                <ItemStyle ForeColor="Black" />
                <HeaderTemplate>
                    <asp:Table ID="tabHeader" runat="server">
                        <asp:TableHeaderRow>
                            <asp:TableHeaderCell Width="40px">序号</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="100px">单位编号</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="30px">启用</asp:TableHeaderCell>
                            <asp:TableHeaderCell>商品单位名称</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="100px">操作</asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                    </asp:Table>
                </HeaderTemplate>
                <HeaderStyle Height="25px" />
                <ItemStyle Height="30px" />
                <ItemTemplate>
                    <asp:Table ID="tabItem" runat="server">
                        <asp:TableRow>
                            <asp:TableCell><%#Container.ItemIndex+1%></asp:TableCell>
                            <asp:TableCell><asp:Literal ID="lbId" runat="server" Text='<%#Eval("ID")%>'></asp:Literal></asp:TableCell>
                            <asp:TableCell><asp:CheckBox ID="UnitEnabled" runat="Server" Checked='<%#Eval("Enable")%>' AutoPostBack="true" OnCheckedChanged="CheckBox_CheckedChanged" /></asp:TableCell>
                            <asp:TableCell><%#Eval("UnitName")%></asp:TableCell>
                            <asp:TableCell>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%#Eval("ID")%>' CommandName="Delete">删除</asp:LinkButton>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </ItemTemplate>
            </asp:DataList>
        </div>
    </div>
</asp:Content>
