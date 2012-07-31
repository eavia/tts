<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GoodsList.aspx.cs" Inherits="TaobaoTesting.GoodsManager.GoodsList" %>

<asp:content id="Content1" contentplaceholderid="HeadContent" runat="server">
</asp:content>
<asp:content id="Content2" contentplaceholderid="MainContent" runat="server">
    <div id="pelGoods">
        <div id="goodstool" style="white-space: nowrap; width: 99%; height: 22px; margin: 0px 10px 0px 0px;
            vertical-align: middle; text-align: center">
            <asp:TextBox ID="txtGoodsName" runat="server" ValidationGroup="Goods"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtGoodsName"
                ErrorMessage="*" ValidationGroup="Goods"></asp:RequiredFieldValidator>
            <asp:DropDownList ID="ddpUnits" runat="server" ValidationGroup="Goods">
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddpUnits"
                ErrorMessage="*" ValidationGroup="Goods"></asp:RequiredFieldValidator>
            <asp:DropDownList ID="DropDownList1" runat="server">
            </asp:DropDownList>
            <asp:Button ID="btnAddGoods" runat="server" OnClick="btnAddGoods_Click" ValidationGroup="Goods"
                Text="添加商品" />
        </div>
        <div id="goodslst" style="padding: 0px 2px 2px 2px; width: 99%;">
            <asp:DataList Width="99%" ID="dlGoods" runat="server" ExtractTemplateRows="true"
            CellPadding="2" DataKeyField="ID" GridLines="Both" 
                onselectedindexchanged="dlGoods_SelectedIndexChanged" 
                onitemcommand="dlGoods_ItemCommand">
            <ItemStyle ForeColor="Black" />
            <HeaderTemplate>
                <asp:Table ID="tabHeader" runat="server">
                    <asp:TableRow>
                        <asp:TableHeaderCell>序号</asp:TableHeaderCell>
                        <asp:TableHeaderCell>商品编号</asp:TableHeaderCell>
                        <asp:TableHeaderCell>商品名称</asp:TableHeaderCell>
                        <asp:TableHeaderCell>操作</asp:TableHeaderCell>
                    </asp:TableRow>
                </asp:Table>
            </HeaderTemplate>
            <HeaderStyle Height="25px" />
            <ItemStyle Height="30px" />
            <ItemTemplate>
                <asp:Table ID="tabItem" runat="server">
                    <asp:TableRow>
                        <asp:TableCell><asp:LinkButton ID="lnkSelect" runat="server" CommandArgument='<%#Eval("ID")%>' CommandName="Select"><%#Container.ItemIndex+1%></asp:LinkButton></asp:TableCell>
                        <asp:TableCell><asp:Literal ID="lbId" runat="server" Text='<%#Eval("ID")%>'></asp:Literal></asp:TableCell>
                        <asp:TableCell><%#Eval("GoodsName")%></asp:TableCell>
                        <asp:TableCell>
                            <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%#Eval("ID")%>' CommandName="Delete">删除</asp:LinkButton>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ItemTemplate>
        </asp:DataList>
        </div>
    </div>
</asp:content>
