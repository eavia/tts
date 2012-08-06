<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ChangedList.aspx.cs" Inherits="TaobaoTesting.GoodsManager.ChangedList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="clearbar" style="display: none;">
        <asp:HiddenField ID="hfdSeletedIndex" runat="server" />
    </div>
    <asp:DataList Width="99%" ID="dlGoods" runat="server" ExtractTemplateRows="true"
        CellPadding="2" DataKeyField="ID" GridLines="Both" OnItemCommand="dlGoods_ItemCommand">
        <ItemStyle ForeColor="Black" Height="30px" />
        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
        <HeaderStyle BackColor="#A6CBEF" Font-Bold="True" ForeColor="#404040" BorderColor="#A6CBEF"
            Height="25px" />
        <HeaderTemplate>
            <asp:Table ID="tabHeader" runat="server">
                <asp:TableRow>
                    <asp:TableHeaderCell Width="30px">序号</asp:TableHeaderCell>
                    <asp:TableHeaderCell Width="60px">商品编号</asp:TableHeaderCell>
                    <asp:TableHeaderCell>商品名称</asp:TableHeaderCell>
                    <asp:TableHeaderCell>余额</asp:TableHeaderCell>
                    <asp:TableHeaderCell>操作</asp:TableHeaderCell>
                </asp:TableRow>
            </asp:Table>
        </HeaderTemplate>
        <ItemTemplate>
            <asp:Table ID="tabItem" runat="server">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:LinkButton ID="lnkSelect" runat="server" CommandArgument='<%#Eval("ID")%>' CommandName="Select"><%#Container.ItemIndex+1%></asp:LinkButton></asp:TableCell>
                    <asp:TableCell>
                        <asp:Literal ID="lbId" runat="server" Text='<%#Eval("ID")%>'></asp:Literal></asp:TableCell>
                    <asp:TableCell><%#Eval("GoodsName")%></asp:TableCell>
                    <asp:TableCell><%#Eval("Quantity")%></asp:TableCell>
                    <asp:TableCell>
                        <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%#Eval("ID")%>' CommandName="Change">变动</asp:LinkButton>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow ID="internal" Visible="false">
                    <asp:TableCell ColumnSpan="5" Style="margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px;
                        width: 700px">
                        <asp:DataList Width="100%" ID="internalChangedList" runat="server" ExtractTemplateRows="true"
                            CellPadding="2" DataKeyField="ChangedId" GridLines="Both" OnItemCommand="InternalChangedList_ItemCommand"
                            CssClass="margin:0px 0px 0px 0px; padding:0px 0px 0px 0px;">
                            <ItemStyle ForeColor="Black" />
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
                            <HeaderStyle Height="25px" />
                            <ItemStyle Height="30px" />
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
                                            <asp:Literal ID="ltaQuantity" runat="server" Text='<%#Eval("Quantity")%>' ></asp:Literal></asp:TableCell>
                                        <asp:TableCell>
                                            <asp:TextBox ID="txtValue" runat="server" Text='<%#Eval("Value")%>' CssClass="textBoxLine" onchange='IsVaild(this)' Width="60px"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell>
                                            <asp:TextBox ID="txtPieceCost" runat="server" CssClass="textBoxLine" Text='<%#Eval("PieceCost")%>' Width="60px"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell>
                                            <asp:TextBox ID="txtSumCost" runat="server" CssClass="textBoxLine" Text='<%#Eval("SumCost")%>' Width="60px"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell>
                                            <asp:TextBox ID="txtSource" runat="server" CssClass="textBoxLine" Text='<%#Eval("Source")%>'  Width="60px"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell>
                                            <asp:TextBox ID="txtDate" runat="server" CssClass="textBoxLine" Text='<%#Eval("Date")%>' Width="60px"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell Width="80px">
                                            <asp:LinkButton ID="lnkSave" runat="server" CommandName="Save" CommandArgument='<%#Eval("GoodsId")%>'>保存</asp:LinkButton>
                                            <asp:LinkButton ID="lnkHidden" runat="server" CommandName="Hide" CommandArgument='<%#Container.ItemIndex%>'>隐藏</asp:LinkButton>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </EditItemTemplate>
                        </asp:DataList>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ItemTemplate>
    </asp:DataList>
</asp:Content>
