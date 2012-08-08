<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangedList.aspx.cs" Inherits="TaobaoTesting.GoodsManager.ChangedList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
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
    <script src="../Datepicker/WdatePicker.js" type="text/javascript"></script>
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        
    </style>
</head>
<base target="_self" />
<body style="width: 980px">
    <form id="form1" runat="server">
    <div style="padding: 2px 2px 2px 2px; margin: 2px 2px 2px 2px;">
        <div id="clearbar" style="display: none;">
            <asp:HiddenField ID="hfdGoodsID" runat="server" Value="3" />
        </div>
        <div>
            <asp:DataList Width="980px" ID="internalChangedList" runat="server" ExtractTemplateRows="true"
                CellPadding="2" DataKeyField="ChangedId" GridLines="Both" OnItemCommand="InternalChangedList_ItemCommand"
                CssClass="margin:0px 0px 0px 0px; padding:0px 0px 0px 0px;">
                <HeaderTemplate>
                    <asp:Table ID="tabHeader" runat="server">
                        <asp:TableRow>
                            <asp:TableHeaderCell Width="40px">序号</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="80px">操作编号</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="60px">初始值</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="60px">变动值</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="60px">单件成本</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="60px">总计成本</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="80px">来源</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="70px">操作日期</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="70px">操作</asp:TableHeaderCell>
                        </asp:TableRow>
                    </asp:Table>
                </HeaderTemplate>
                <ItemStyle ForeColor="Black" Height="30px" />
                <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                <HeaderStyle BackColor="#A6CBEF" Font-Bold="True" ForeColor="#404040" BorderColor="#A6CBEF"
                    Height="25px" />
                <ItemTemplate>
                    <asp:Table ID="tabItem" runat="server" Width="99%">
                        <asp:TableRow onmouseover="c=this.style.backgroundColor;this.style.backgroundColor='#6699ff'"
                            onmouseout="this.style.backgroundColor=c" Style="background-color: Silver">
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
                                <asp:Literal ID="ltaDate" runat="server" Text='<%#Convert.ToDateTime(Eval("Date")).ToShortDateString()%>'></asp:Literal></asp:TableCell>
                            <asp:TableCell></asp:TableCell>
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
                                <asp:TextBox ID="txtChangeID" runat="server" Text='<%#Eval("ChangedId")%>' CssClass="textBoxLine"
                                    Width="98%"></asp:TextBox></asp:TableCell>
                            <asp:TableCell>
                                <asp:Literal ID="ltaQuantity" runat="server" Text='<%#Eval("Quantity")%>'></asp:Literal></asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtValue" runat="server" Text='<%#Eval("Value")%>' CssClass="textBoxLine"
                                    onchange='IsVaild(this)' Width="98%"></asp:TextBox></asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtPieceCost" runat="server" CssClass="textBoxLine" Text='<%#Eval("PieceCost")%>'
                                    Width="98%"></asp:TextBox></asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtSumCost" runat="server" CssClass="textBoxLine" Text='<%#Eval("SumCost")%>'
                                    Width="98%"></asp:TextBox></asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtSource" runat="server" CssClass="textBoxLine" Text='<%#Eval("Source")%>'
                                    Width="98%"></asp:TextBox></asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtDate" runat="server" CssClass="textBoxLine" Text='<%#Convert.ToDateTime(Eval("Date")).ToShortDateString()%>'
                                    onclick="WdatePicker();" Width="98%"></asp:TextBox></asp:TableCell>
                            <asp:TableCell>
                                <asp:LinkButton ID="lnkSave" runat="server" CommandName="Save" CommandArgument='<%#Eval("GoodsId")%>'>保存</asp:LinkButton>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </EditItemTemplate>
            </asp:DataList>
            <webdiyer:AspNetPager ID="ChangedPager" CssClass="paginator" CurrentPageButtonClass="cpb"
                runat="server" AlwaysShow="True" FirstPageText="首页" LastPageText="尾页" NextPageText="下一页"
                PrevPageText="上一页" ShowCustomInfoSection="Left" ShowInputBox="Never" CustomInfoTextAlign="Left"
                LayoutType="Table">
            </webdiyer:AspNetPager>
        </div>
        <hr />
        <asp:DataList Width="100%" ID="DataList1" runat="server" ExtractTemplateRows="true"
            CellPadding="2" DataKeyField="ChangedId" GridLines="Both" OnItemCommand="InternalChangedList_ItemCommand"
            CssClass="margin:0px 0px 0px 0px; padding:0px 0px 0px 0px;">
            <HeaderTemplate>
                <asp:Table ID="tabHeader" runat="server">
                    <asp:TableRow>
                        <asp:TableHeaderCell Width="45px">序号</asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="60px">编号</asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="90px">标识</asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="70px">出厂日期</asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="70px">有效期限</asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="60px">数量</asp:TableHeaderCell>
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
                            <asp:Literal ID="ltaId" runat="server" Text='<%#Eval("ID")%>'></asp:Literal></asp:TableCell>
                        <asp:TableCell>
                            <asp:Literal ID="ltaQuantity" runat="server" Text='<%#Eval("ItemIdenifity")%>'></asp:Literal></asp:TableCell>
                        <asp:TableCell>
                            <asp:Literal ID="ltaValue" runat="server" Text='<%#Eval("ProductionDate")%>'></asp:Literal></asp:TableCell>
                        <asp:TableCell>
                            <asp:Literal ID="ltaPieceCost" runat="server" Text='<%#Eval("ExpiryDate")%>'></asp:Literal></asp:TableCell>
                        <asp:TableCell>
                            <asp:Literal ID="ltaSumCost" runat="server" Text='<%#Eval("Quantity")%>'></asp:Literal></asp:TableCell>
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
                            <asp:TextBox ID="txtChangeID" runat="server" Text='<%#Eval("ID")%>' Width="60px"></asp:TextBox></asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtIdenifity" runat="server" Text='<%#Eval("ItemIdenifity")%>'></asp:TextBox></asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtValue" runat="server" Text='<%#Eval("ProductionDate")%>' CssClass="textBoxLine"
                                onclick="WdatePicker();"></asp:TextBox></asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtPieceCost" runat="server" CssClass="textBoxLine" Text='<%#Eval("ExpiryDate")%>'
                                onclick="WdatePicker();"></asp:TextBox></asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtSumCost" runat="server" CssClass="textBoxLine" Text='<%#Eval("Quantity")%>'></asp:TextBox></asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </EditItemTemplate>
        </asp:DataList>
    </div>
    </form>
</body>
</html>
