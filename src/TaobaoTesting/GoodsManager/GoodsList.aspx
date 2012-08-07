<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GoodsList.aspx.cs"
    Inherits="TaobaoTesting.GoodsManager.GoodsList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        function ShowBox(obj) {
            var features =
		        'dialogWidth:' + 1200 + 'px;' +
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
        <div id="goodstool" style="white-space: nowrap; width: 99%; height: 22px; margin: 0px 10px 0px 0px;
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
                CellPadding="2" DataKeyField="ID" GridLines="Both" OnSelectedIndexChanged="dlGoods_SelectedIndexChanged"
                OnItemCommand="dlGoods_ItemCommand">
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
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:LinkButton ID="lbnIndex" runat="Server" src='<%#"ChangedList.aspx?gid="+Eval("ID")%>'
                                    OnClientClick="return ShowBox(this);" Text='<%#Container.ItemIndex+1%>'></asp:LinkButton>
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
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%#Eval("ID")%>' CommandName="Delete">删除</asp:LinkButton>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </ItemTemplate>
            </asp:DataList>
        </div>
    </div>
</asp:Content>
