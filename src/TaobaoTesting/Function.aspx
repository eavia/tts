<%@ Page Title="功能" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Function.aspx.cs" Inherits="TaobaoTesting.Function" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <asp:Panel ID="Panel4" runat="server">
        <asp:Label ID="Label1" runat="server" Text="订单编号:"></asp:Label>
        <asp:Label ID="lblOrderId" runat="server" Text="______________"></asp:Label>
        <asp:TextBox ID="txtBuyer" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtBuyer"
            ErrorMessage="*" ValidationGroup="Order"></asp:RequiredFieldValidator>
        <asp:Button ID="btnCrateOrder" runat="server" OnClick="btnCrateOrder_Click" Text="创建订单"
            ValidationGroup="Order" />
    </asp:Panel>
    <asp:Panel ID="Panel6" runat="server">
        <asp:GridView ID="gdvOrderItem" runat="server">
            <Columns>
                <asp:CommandField HeaderText="操作" ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
        <asp:Button ID="btnSaveOrder" runat="server" Text="保存订单" />
    </asp:Panel>
    <asp:Panel ID="Panel5" runat="server">
        <div id="MainTool" style="white-space: nowrap; width: 99%; height: 30px; margin: 5px 10px 5px 10px;
            vertical-align: bottom; text-align: center;">
            <asp:Button ID="btnGoods" runat="server" onclick="btnGoods_Click" 
                Text="商品列表" /> <asp:Button ID="btnUnit" runat="server" onclick="btnUnit_Click" 
                Text="单位列表" />
        </div>
        <asp:DataList Width="100%" ID="dlOrders" runat="server" ExtractTemplateRows="true"
            CellPadding="2" DataKeyField="ID" GridLines="Both" OnItemCommand="dlOrders_ItemCommand">
            <ItemStyle ForeColor="Black" />
            <HeaderTemplate>
                <asp:Table ID="tabHeader" runat="server">
                    <asp:TableRow>
                        <asp:TableHeaderCell>序号</asp:TableHeaderCell>
                        <asp:TableHeaderCell>订单编号</asp:TableHeaderCell>
                        <asp:TableHeaderCell>购买者</asp:TableHeaderCell>
                        <asp:TableHeaderCell>商品数目</asp:TableHeaderCell>
                        <asp:TableHeaderCell>订单状态</asp:TableHeaderCell>
                        <asp:TableHeaderCell>订单操作</asp:TableHeaderCell>
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
                        <asp:TableCell><%#Eval("Buyer")%></asp:TableCell>
                        <asp:TableCell><%#Eval("Sum")%></asp:TableCell>
                        <asp:TableCell><%#Eval("STATUS")%></asp:TableCell>
                        <asp:TableCell>
                            <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%#Eval("ID")%>' CommandName="Delete">删除</asp:LinkButton>
                            <asp:LinkButton ID="lnkPay" runat="server" CommandArgument='<%#Eval("ID")%>' CommandName="Pay"
                                Style="padding-left: 3px">支付</asp:LinkButton>
                            <asp:LinkButton ID="lnkSend" runat="server" CommandArgument='<%#Eval("ID")%>' CommandName="Pay"
                                Style="padding-left: 3px">发货</asp:LinkButton>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ItemTemplate>
        </asp:DataList>
    </asp:Panel>
</asp:Content>
