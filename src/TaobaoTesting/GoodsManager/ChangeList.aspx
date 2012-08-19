<%@ Page Title="商品库存信息" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ChangeList.aspx.cs" Inherits="TaobaoTesting.GoodsManager.ChangeList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">

        function CloseWin() {
            window.close();
            window.returnValue = true;
        }

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

        /*
        * 创建人：牛腩

        * 说明：只能向文本框里输入数字，缺点是可以输入中文，所以还要在焦点失去的时候做个判断

        */

        $(function () {

            // 给文本框加个keypress，即键盘按下的时候判断

            $("#internalChangedList_txtPieceCost_5").keypress(function (event) {

                if (!$.browser.mozilla) {

                    if (event.keyCode && (event.keyCode < 48 || event.keyCode > 57) && event.keyCode != 46) {

                        // ie6,7,8,opera,chrome管用

                        event.preventDefault();

                    }

                } else {

                    if (event.charCode && (event.charCode < 48 || event.charCode > 57) && event.keyCode != 46) {

                        // firefox管用

                        event.preventDefault();

                    }

                }

            });



            // 当文本框失去焦点的时候，检测输入的是否是数字

            $("#internalChangedList_txtPieceCost_5").blur(function () {

                var input = $(this);

                var v = $.trim(input.val());

                //alert("输入值：" + v);

                var reg = new RegExp("^[0-9]+(.[0-9]{2})?$", "g");

                if (!reg.test(v)) {

                    alert("请输入一个数字，最多只能有两位小数！");

                    input.val("0");

                }
            });
        });
    </script>
    <script src="../Datepicker/WdatePicker.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="clearbar" style="display: none;">
        <asp:HiddenField ID="hfdGoodsID" runat="server" Value="-1" />
        <asp:HiddenField ID="hfdChangedID" runat="server" Value="-1" />
    </div>
    <asp:Panel ID="GoodsChanged" runat="server">
        <table style="width: 100%">
            <tr style="height: 32px">
                <td style="width: 100%; background-color: #609870; padding: 2px 5px 2px 5px; vertical-align: top;">
                    <span>商品库存变更单</span>
                    <div style="float: right; vertical-align: top;">
                        <asp:Button ID="btnChangedNew" runat="server" Text="创建变更单" OnClick="btnChangedNew_Click" /></div>
                </td>
            </tr>
        </table>
        <asp:DataList Width="99%" ID="dlChangedList" runat="server" ExtractTemplateRows="true"
            CellPadding="2" DataKeyField="ID" GridLines="Both" CssClass="margin:0px 0px 0px 0px; padding:0px 0px 0px 0px;">
            <HeaderTemplate>
                <asp:Table ID="tabHeader" runat="server">
                    <asp:TableRow>
                        <asp:TableHeaderCell Width="40px">序号</asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="80px">编号</asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="60px">初始值</asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="60px">变动值</asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="60px">单件成本</asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="60px">总计成本</asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="80px">来源</asp:TableHeaderCell>
                        <asp:TableHeaderCell Width="70px">日期</asp:TableHeaderCell>
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
                            <asp:LinkButton ID="lnkSelect" runat="Server" Text='<%#Container.ItemIndex+1%>' GroupName="SelectGroup"
                                Width="98%" AutoPostBack="True" CommandName="Select" CommandArgument='<%#Eval("ID")%>' />
                        </asp:TableCell><asp:TableCell>
                            <asp:Literal ID="ltaId" runat="server" Text='<%#Eval("ID")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                <asp:Literal ID="ltaQuantity" runat="server" Text='<%#Eval("Quantity")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                    <asp:Literal ID="ltaValue" runat="server" Text='<%#Eval("Value")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                        <asp:Literal ID="ltaPieceCost" runat="server" Text='<%#Eval("PieceCost")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                            <asp:Literal ID="ltaSumCost" runat="server" Text='<%#Eval("SumCost")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                                <asp:Literal ID="ltaSource" runat="server" Text='<%#Eval("Source")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                                    <asp:Literal ID="ltaDate" runat="server" Text='<%#Convert.ToDateTime(Eval("Date")).ToShortDateString()%>'></asp:Literal></asp:TableCell><asp:TableCell></asp:TableCell></asp:TableRow></asp:Table></ItemTemplate><EditItemTemplate>
                <asp:Table ID="tabEditItem" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                                
                        </asp:TableCell><asp:TableCell>
                            <asp:Literal ID="txtChangeID" runat="server" Text='<%#Eval("ID")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                <asp:Literal ID="ltaQuantity" runat="server" Text='<%#Eval("Quantity")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                    <asp:Literal ID="txtValue" runat="server" Text='<%#Eval("Value")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                        <asp:HiddenField ID="hfPieceCost" runat="server" Value='<%#Eval("PieceCost")%>' />
                                        <asp:TextBox ID="txtPieceCost" runat="server" CssClass="textBoxLine" Text='<%#Eval("PieceCost")%>'
                                            Width="98%"></asp:TextBox></asp:TableCell><asp:TableCell>
                                                <asp:Literal ID="txtSumCost" runat="server" Text='<%#Eval("SumCost")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                                    <asp:HiddenField ID="hfSource" runat="server" Value='<%#Eval("Source")%>' />
                                                    <asp:TextBox ID="txtSource" runat="server" CssClass="textBoxLine" Text='<%#Eval("Source")%>'
                                                        Width="98%"></asp:TextBox></asp:TableCell><asp:TableCell>
                                                            <asp:HiddenField ID="hfDate" runat="server" Value='<%#Eval("Date")%>' />
                                                            <asp:TextBox ID="txtDate" runat="server" CssClass="textBoxLine" Text='<%#Convert.ToDateTime(Eval("Date")).ToShortDateString()%>'
                                                                onclick="WdatePicker();" Width="98%"></asp:TextBox></asp:TableCell><asp:TableCell>
                                                                    <asp:LinkButton ID="lnkSave" runat="server" CommandName="Save">保存</asp:LinkButton>
                                                                </asp:TableCell></asp:TableRow></asp:Table></EditItemTemplate></asp:DataList><webdiyer:AspNetPager 
            ID="ChangedPager" CssClass="paginator" CurrentPageButtonClass="cpb"
            runat="server" AlwaysShow="True" FirstPageText="首页" LastPageText="尾页" NextPageText="下一页"
            PrevPageText="上一页" ShowCustomInfoSection="Left" showinputbox="Never" CustomInfoTextAlign="Left"
            LayoutType="Table" PageSize="5" onpagechanged="ChangedPager_PageChanged"></webdiyer:AspNetPager>
    </asp:Panel>
    <hr />
    <asp:DataList Width="100%" ID="dlChangedItems" runat="server" ExtractTemplateRows="true"
        CellPadding="2" DataKeyField="ID" GridLines="Both" CssClass="margin:0px 0px 0px 0px; padding:0px 0px 0px 0px;">
        <HeaderTemplate>
            <asp:Table ID="tabHeader" runat="server">
                <asp:TableRow>
                    <asp:TableHeaderCell Width="45px">序号</asp:TableHeaderCell><asp:TableHeaderCell Width="60px">编号</asp:TableHeaderCell><asp:TableHeaderCell
                        Width="120px">标识</asp:TableHeaderCell><asp:TableHeaderCell Width="70px">出厂日期</asp:TableHeaderCell><asp:TableHeaderCell
                            Width="70px">有效期限</asp:TableHeaderCell><asp:TableHeaderCell Width="60px">数量</asp:TableHeaderCell><asp:TableHeaderCell
                                Width="70px">操作</asp:TableHeaderCell></asp:TableRow></asp:Table></HeaderTemplate><ItemStyle ForeColor="Black" Height="30px" />
        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
        <HeaderStyle BackColor="#A6CBEF" Font-Bold="True" ForeColor="#404040" BorderColor="#A6CBEF"
            Height="25px" />
        <ItemTemplate>
            <asp:Table ID="tabItem" runat="server">
                <asp:TableRow onmouseover="c=this.style.backgroundColor;this.style.backgroundColor='#6699ff'"
                    onmouseout="this.style.backgroundColor=c" Style="background-color: Silver">
                    <asp:TableCell>
                        <asp:Literal ID="ltaIndex" runat="server" Text='<%#Container.ItemIndex+1%>' />
                    </asp:TableCell><asp:TableCell>
                        <asp:Literal ID="ltaId" runat="server" Text='<%#Eval("ID")%>'></asp:Literal>
                    </asp:TableCell><asp:TableCell>
                        <asp:Literal ID="ltaQuantity" runat="server" Text='<%#Eval("ItemIdenifity")%>' />
                    </asp:TableCell><asp:TableCell>
                        <asp:Literal ID="ltaValue" runat="server" Text='<%#Convert.ToDateTime(Eval("ProductionDate")).ToShortDateString()%>' />
                    </asp:TableCell><asp:TableCell>
                        <asp:Literal ID="ltaPieceCost" runat="server" Text='<%#Convert.ToDateTime(Eval("ExpiryDate")).ToShortDateString()%>' />
                    </asp:TableCell><asp:TableCell>
                        <asp:Literal ID="ltaSumCost" runat="server" Text='<%#Eval("Quantity")%>' />
                    </asp:TableCell><asp:TableCell>
                        <asp:Literal ID="Literal1" runat="server" Text='<%#Eval("Quantity")%>' />
                    </asp:TableCell></asp:TableRow></asp:Table></ItemTemplate><EditItemTemplate>
            <asp:Table ID="tabEditItem" runat="server">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Literal ID="ltaIndex" runat="server" Text='<%#Container.ItemIndex+1%>'></asp:Literal>
                    </asp:TableCell><asp:TableCell>
                        <asp:TextBox ID="txtID" runat="server" Text='<%#Eval("ID")%>' Width="98%" CssClass="textBoxLine"></asp:TextBox>
                    </asp:TableCell><asp:TableCell>
                        <asp:TextBox ID="txtIdenifity" runat="server" Text='<%#Eval("ItemIdenifity")%>' Width="98%"
                            CssClass="textBoxLine"></asp:TextBox>
                    </asp:TableCell><asp:TableCell>
                        <asp:TextBox ID="txtProductionDate" runat="server" Text='<%#Convert.ToDateTime(Eval("ProductionDate")).ToShortDateString()%>'
                            Width="98%" CssClass="textBoxLine" onclick="WdatePicker();"></asp:TextBox>
                    </asp:TableCell><asp:TableCell>
                        <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="textBoxLine" Width="98%"
                            Text='<%#Convert.ToDateTime(Eval("ExpiryDate")).ToShortDateString()%>' onclick="WdatePicker();"></asp:TextBox>
                    </asp:TableCell><asp:TableCell>
                        <asp:TextBox ID="txtQuantity" runat="server" CssClass="textBoxLine" Text='<%#Eval("Quantity")%>'
                            Width="98%"></asp:TextBox>
                    </asp:TableCell><asp:TableCell>
                        <asp:LinkButton ID="ItemSave" runat="Server" Text="确定" CommandName="Update" />
                        <asp:LinkButton ID="ItemCancel" runat="Server" Text="取消" CommandName="Cancel" />
                    </asp:TableCell></asp:TableRow></asp:Table></EditItemTemplate></asp:DataList><asp:Panel ID="ToolBar" runat="Server" BorderWidth="1px" BorderStyle="Solid" ScrollBars="None"
        Width="99%" Style="vertical-align: middle;" Height="32px" HorizontalAlign="Center"
        CssClass="menu">
        <asp:Button ID="btnSaveAll" runat="server" Text="保存" Style="margin: 5px 2px 2px 2px;" />
        <asp:LinkButton ID="lnkCancel" runat="server" Style="margin: 5px 2px 2px 2px;">返回</asp:LinkButton></asp:Panel></asp:Content>