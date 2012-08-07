﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangedList.aspx.cs" Inherits="TaobaoTesting.GoodsManager.ChangedList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>商品库存信息</title>
    <script type="text/javascript" language="javascript">
        function IsVaild(t) { //商品可用额度检测
            var source = t;
            var value = t.value;
            var leftTd = source.parentNode.previousSibling;
            var leftValue = leftTd.innerHTML;
            var changeid = leftTd.previousSibling.children[1];
            var offset = new Number(leftValue) + new Number(value)
            if (offset < 0) {
                t.value = "0";
                changeid.value = "-1";
                return false;
            }
            changeid.value = "0";
            return true;
        }
    </script>
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style=" padding: 2px 2px 2px 2px; margin: 2px 2px 2px 2px;">
        <div id="clearbar" style="display: none;">
            <asp:HiddenField ID="hfdGoodsID" runat="server" />
            <asp:HiddenField ID="hfdSeletedIndex" runat="server" />
        </div>
        <asp:DataList Width="100%" ID="internalChangedList" runat="server" ExtractTemplateRows="true"
            CellPadding="2" DataKeyField="ChangedId" GridLines="Both" OnItemCommand="InternalChangedList_ItemCommand"
            CssClass="margin:0px 0px 0px 0px; padding:0px 0px 0px 0px;">
            <HeaderTemplate>
                <asp:Table ID="tabHeader" runat="server">
                    <asp:TableRow>
                        <asp:TableHeaderCell Width="43px">序号</asp:TableHeaderCell>
                        <asp:TableHeaderCell>操作编号</asp:TableHeaderCell>
                        <asp:TableHeaderCell>初始值</asp:TableHeaderCell>
                        <asp:TableHeaderCell>变动值</asp:TableHeaderCell>
                        <asp:TableHeaderCell>单件成本</asp:TableHeaderCell>
                        <asp:TableHeaderCell>总计成本</asp:TableHeaderCell>
                        <asp:TableHeaderCell>来源</asp:TableHeaderCell>
                        <asp:TableHeaderCell>操作日期</asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="80px">操作</asp:TableHeaderCell>
                    </asp:TableRow>
                </asp:Table>
            </HeaderTemplate>
            <ItemStyle ForeColor="Black" Height="30px" />
                <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                <HeaderStyle BackColor="#A6CBEF" Font-Bold="True" ForeColor="#404040" BorderColor="#A6CBEF"
                    Height="25px" />
            <ItemTemplate>
                <asp:Table ID="tabItem" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Literal ID="ltaIndex" runat="server" Text='<%#Container.ItemIndex+1%>'></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:HiddenField ID="hfGoodsID" runat="server" Value='<%#Eval("GoodsId")%>' />
                            <asp:Literal ID="ltaId" runat="server" Text='<%#Eval("ChangedId")%>'></asp:Literal></asp:TableCell>
                        <asp:TableCell>
                            <asp:Literal ID="ltaQuantity" runat="server" Text='<%#Eval("Quantity")%>'></asp:Literal></asp:TableCell>
                        <asp:TableCell>
                            <asp:Literal ID="ltaValue" runat="server" Text='<%#Eval("Value")%>'></asp:Literal></asp:TableCell>
                        <asp:TableCell>
                            <asp:Literal ID="ltaPieceCost" runat="server" Text='<%#Eval("PieceCost")%>'></asp:Literal></asp:TableCell>
                        <asp:TableCell>
                            <asp:Literal ID="ltaSumCost" runat="server" Text='<%#Eval("SumCost")%>'></asp:Literal></asp:TableCell>
                        <asp:TableCell>
                            <asp:Literal ID="ltaSource" runat="server" Text='<%#Eval("Source")%>'></asp:Literal></asp:TableCell>
                        <asp:TableCell>
                            <asp:Literal ID="ltaDate" runat="server" Text='<%#Eval("Date")%>'></asp:Literal></asp:TableCell>
                        <asp:TableCell Width="80px"></asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:Table ID="tabEditItem" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Literal ID="ltaIndex" runat="server" Text='<%#Container.ItemIndex+1%>'></asp:Literal>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:HiddenField ID="hfEditGoodsID" runat="server" Value='<%#Eval("GoodsId")%>' />
                            <asp:TextBox ID="txtChangeID" runat="server" Text='<%#Eval("ChangedId")%>' Width="60px"></asp:TextBox></asp:TableCell>
                        <asp:TableCell>
                            <asp:Literal ID="ltaQuantity" runat="server" Text='<%#Eval("Quantity")%>'></asp:Literal></asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtValue" runat="server" Text='<%#Eval("Value")%>' CssClass="textBoxLine"
                                onchange='IsVaild(this)' Width="60px"></asp:TextBox></asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtPieceCost" runat="server" CssClass="textBoxLine" Text='<%#Eval("PieceCost")%>'
                                Width="60px"></asp:TextBox></asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtSumCost" runat="server" CssClass="textBoxLine" Text='<%#Eval("SumCost")%>'
                                Width="60px"></asp:TextBox></asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtSource" runat="server" CssClass="textBoxLine" Text='<%#Eval("Source")%>'
                                Width="60px"></asp:TextBox></asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtDate" runat="server" CssClass="textBoxLine" Text='<%#Eval("Date")%>'
                                Width="60px"></asp:TextBox></asp:TableCell>
                        <asp:TableCell Width="80px">
                            <asp:LinkButton ID="lnkSave" runat="server" CommandName="Save" CommandArgument='<%#Eval("GoodsId")%>'>保存</asp:LinkButton>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </EditItemTemplate>
        </asp:DataList>
    </div>
    </form>
</body>
</html>
