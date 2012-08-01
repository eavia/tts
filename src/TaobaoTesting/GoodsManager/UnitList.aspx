<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="UnitList.aspx.cs" Inherits="TaobaoTesting.GoodsManager.UnitList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="pelGoods" style="width: 99%; height: 300px;">
        <div id="goodstool" style="white-space: nowrap; width: 99%; height: 22px; margin: 0px 10px 0px 0px;
            vertical-align: middle; text-align: center">
            <asp:TextBox ID="txtUnitName" runat="server" ValidationGroup="Unit"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtUnitName"
                ErrorMessage="*" ValidationGroup="Unit"></asp:RequiredFieldValidator>
            <asp:Button ID="btnAddUnit" runat="server" OnClick="btnAddUnit_Click" Text="添加单位"
                ValidationGroup="Unit" />
        </div>
        <div id="goodslst" style="padding: 0px 2px 2px 2px; width: 99%;">
            <asp:DataList Width="99%" ID="dlUnits" runat="server" ExtractTemplateRows="true"
                CellPadding="2" DataKeyField="ID" GridLines="Both" OnItemCommand="dlUnits_ItemCommand">
                <ItemStyle ForeColor="Black" />
                <HeaderTemplate>
                    <asp:Table ID="tabHeader" runat="server">
                        <asp:TableRow>
                            <asp:TableHeaderCell>序号</asp:TableHeaderCell>
                            <asp:TableHeaderCell>单位编号</asp:TableHeaderCell>
                            <asp:TableHeaderCell>单位名称</asp:TableHeaderCell>
                            <asp:TableHeaderCell>操作</asp:TableHeaderCell>
                        </asp:TableRow>
                    </asp:Table>
                </HeaderTemplate>
                <HeaderStyle Height="25px" />
                <ItemStyle Height="30px" />
                <ItemTemplate>
                    <asp:Table ID="tabItem" runat="server">
                        <asp:TableRow>
                            <asp:TableCell><%#Container.ItemIndex+1%></asp:TableCell>
                            <asp:TableCell><%#Eval("ID")%></asp:TableCell>
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
