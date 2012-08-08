<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GoodsList.aspx.cs"
    Inherits="TaobaoTesting.GoodsManager.GoodsList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        function ShowBox(obj) {
            var features =
		        'dialogWidth:' + 1000 + 'px;' +
		        'dialogHeight:' + 560 + 'px;' +
		        'dialogLeft:' + 80 + 'px;' +
		        'dialogTop:' + 120 + 'px;' +
		        'directories:no; localtion:no; menubar:no; status=no; toolbar=no;scrollbars:yes;Resizeable=no';
            var retval = window.showModalDialog(obj.src, "getReturn", features);
            return retval;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="pelGoods">
        <div id="goodstool" style="white-space: nowrap; width: 99%; height: 32px; margin: 0px 10px 0px 0px;
            vertical-align: middle; text-align: center">
            <asp:TextBox ID="txtGoodsName" runat="server" ValidationGroup="Goods"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtGoodsName"
                ErrorMessage="*" ValidationGroup="Goods"></asp:RequiredFieldValidator>
            <asp:DropDownList ID="ddlUnits" runat="server" ValidationGroup="Goods">
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlUnits"
                ErrorMessage="*" ValidationGroup="Goods"></asp:RequiredFieldValidator>
            <asp:DropDownList ID="ddlBrand" runat="server" DataValueField="Value" DataTextField="Text">
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlBrand"
                ErrorMessage="*" ValidationGroup="Goods"></asp:RequiredFieldValidator>
            <asp:Button ID="btnAddGoods" runat="server" OnClick="btnAddGoods_Click" ValidationGroup="Goods"
                Text="添加商品" />
        </div>
        <div id="goodslst" style="padding: 0px 2px 2px 2px; width: 99%;">
            <asp:DataList Width="99%" ID="dlGoods" runat="server" ExtractTemplateRows="true"
                CellPadding="2" DataKeyField="ID" GridLines="Both" OnItemCommand="dlGoods_ItemCommand">
                <ItemStyle ForeColor="Black" Height="30px" />
                <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                <HeaderStyle BackColor="#A6CBEF" Font-Bold="True" ForeColor="#404040" BorderColor="#A6CBEF"
                    Height="25px" />
                <HeaderTemplate>
                    <asp:Table ID="tabHeader" runat="server">
                        <asp:TableRow>
                            <asp:TableHeaderCell Width="40px">序号</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="80px">编号</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="240px">名称</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="80px">品牌</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="90px">余额</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="40px">单位</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="80px">操作</asp:TableHeaderCell>
                        </asp:TableRow>
                    </asp:Table>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Table ID="tabItem" runat="server">
                        <asp:TableRow onmouseover="c=this.style.backgroundColor;this.style.backgroundColor='#6699ff'"
                            onmouseout="this.style.backgroundColor=c" Style="background-color: Silver">
                            <asp:TableCell>
                                <asp:Literal ID="lbnIndex" runat="Server" Text='<%#Container.ItemIndex+1%>'></asp:Literal>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:Literal ID="ltaID" runat="server" Text='<%#Eval("ID")%>'></asp:Literal></asp:TableCell>
                            <asp:TableCell>
                                <asp:Literal ID="ltaName" runat="server" Text='<%#Eval("GoodsName")%>'></asp:Literal></asp:TableCell>
                            <asp:TableCell>
                                <asp:Literal ID="ltaBrand" runat="server" Text='<%#Eval("Brand.BrandName")%>'></asp:Literal></asp:TableCell>
                            <asp:TableCell>
                                <asp:Literal ID="ltaQuantity" runat="server" Text='<%#Eval("Quantity")%>'></asp:Literal></asp:TableCell>
                            <asp:TableCell>
                                <asp:Literal ID="ltaUnit" runat="server" Text='<%#Eval("Unit.UnitName")%>'></asp:Literal></asp:TableCell>
                            <asp:TableCell>
                                <asp:LinkButton ID="LinkButton1" runat="Server" OnClientClick="return ShowBox(this);"
                                    src='<%#"ChangedList.aspx?gid="+Eval("ID") %>' Text='变动<%#Container.ItemIndex+1%>'></asp:LinkButton>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%#Eval("ID")%>' CommandName="Delete">删除</asp:LinkButton>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </ItemTemplate>
            </asp:DataList>
            <webdiyer:AspNetPager ID="GoodsPager" CssClass="paginator" CurrentPageButtonClass="cpb"
                runat="server" AlwaysShow="True" FirstPageText="首页" LastPageText="尾页" NextPageText="下一页"
                PrevPageText="上一页" ShowCustomInfoSection="Left" ShowInputBox="Never" CustomInfoTextAlign="Left"
                LayoutType="Table" OnPageChanged="GoodsPager_PageChanged">
            </webdiyer:AspNetPager>
        </div>
    </div>
</asp:Content>
