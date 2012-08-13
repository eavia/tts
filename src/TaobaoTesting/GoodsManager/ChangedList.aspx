<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangedList.aspx.cs" Inherits="TaobaoTesting.GoodsManager.ChangedList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>商品库存信息</title>
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
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
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        
    </style>
</head>
<base target="_self" />
<body style="width: 0px">
    <form id="form1" runat="server">
    <div style="padding: 4px 4px 4px 4px; margin: 4px 4px 4px 4px; width: 980px;">
        <div id="clearbar" style="display: none;">
            <asp:HiddenField ID="hfdGoodsID" runat="server" Value="-1" />
            <asp:HiddenField ID="hfdChangedID" runat="server" Value="-1" />
        </div>
        <div>
            <asp:DataList Width="980px" ID="internalChangedList" runat="server" ExtractTemplateRows="true"
                CellPadding="2" DataKeyField="ChangedId" GridLines="Both" OnItemCommand="InternalChangedList_ItemCommand"
                CssClass="margin:0px 0px 0px 0px; padding:0px 0px 0px 0px;">
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
                                    Width="98%" AutoPostBack="True" CommandName="Select" CommandArgument='<%#Eval("ChangedId")%>' />
                            </asp:TableCell><asp:TableCell>
                                <asp:HiddenField ID="hfGoodsID" runat="server" Value='<%#Eval("GoodsId")%>' />
                                <asp:Literal ID="ltaId" runat="server" Text='<%#Eval("ChangedId")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                    <asp:Literal ID="ltaQuantity" runat="server" Text='<%#Eval("Quantity")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                        <asp:Literal ID="ltaValue" runat="server" Text='<%#Eval("Value")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                            <asp:Literal ID="ltaPieceCost" runat="server" Text='<%#Eval("PieceCost")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                                <asp:Literal ID="ltaSumCost" runat="server" Text='<%#Eval("SumCost")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                                    <asp:Literal ID="ltaSource" runat="server" Text='<%#Eval("Source")%>'></asp:Literal></asp:TableCell><asp:TableCell>
                                                        <asp:Literal ID="ltaDate" runat="server" Text='<%#Convert.ToDateTime(Eval("Date")).ToShortDateString()%>'></asp:Literal></asp:TableCell><asp:TableCell></asp:TableCell></asp:TableRow>
                    </asp:Table>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Table ID="tabEditItem" runat="server">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Literal ID="ltaIndex" runat="server" Text='<%#Container.ItemIndex+1%>'></asp:Literal>
                            </asp:TableCell><asp:TableCell>
                                <asp:HiddenField ID="hfEditGoodsID" runat="server" Value='<%#Eval("GoodsId")%>' />
                                <asp:Literal ID="txtChangeID" runat="server" Text='<%#Eval("ChangedId")%>'></asp:Literal></asp:TableCell><asp:TableCell>
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
                                                                        <asp:LinkButton ID="lnkSave" runat="server" CommandName="Save" CommandArgument='<%#Eval("GoodsId")%>'>保存</asp:LinkButton>
                                                                    </asp:TableCell></asp:TableRow>
                    </asp:Table>
                </EditItemTemplate>
            </asp:DataList><webdiyer:AspNetPager ID="ChangedPager" CssClass="paginator" CurrentPageButtonClass="cpb"
                runat="server" AlwaysShow="True" FirstPageText="首页" LastPageText="尾页" NextPageText="下一页"
                PrevPageText="上一页" ShowCustomInfoSection="Left" ShowInputBox="Never" CustomInfoTextAlign="Left"
                LayoutType="Table" OnPageChanged="ChangedPager_PageChanged" PageSize="5">
            </webdiyer:AspNetPager>
        </div>
        <hr />
        <asp:DataList Width="100%" ID="dlChangedItems" runat="server" ExtractTemplateRows="true"
            CellPadding="2" DataKeyField="ID" GridLines="Both" CssClass="margin:0px 0px 0px 0px; padding:0px 0px 0px 0px;"
            OnUpdateCommand="dlChangedItems_UpdateCommand" OnCancelCommand="dlChangedItems_CancelCommand">
            <HeaderTemplate>
                <asp:Table ID="tabHeader" runat="server">
                    <asp:TableRow>
                        <asp:TableHeaderCell Width="45px">序号</asp:TableHeaderCell><asp:TableHeaderCell Width="60px">编号</asp:TableHeaderCell><asp:TableHeaderCell
                            Width="120px">标识</asp:TableHeaderCell><asp:TableHeaderCell Width="70px">出厂日期</asp:TableHeaderCell><asp:TableHeaderCell
                                Width="70px">有效期限</asp:TableHeaderCell><asp:TableHeaderCell Width="60px">数量</asp:TableHeaderCell><asp:TableHeaderCell
                                    Width="70px">操作</asp:TableHeaderCell></asp:TableRow>
                </asp:Table>
            </HeaderTemplate>
            <ItemStyle ForeColor="Black" Height="30px" />
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
                        </asp:TableCell></asp:TableRow>
                </asp:Table>
            </ItemTemplate>
            <EditItemTemplate>
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
                        </asp:TableCell></asp:TableRow>
                </asp:Table>
            </EditItemTemplate>
        </asp:DataList><asp:Panel ID="ToolBar" runat="Server" BorderWidth="1px" BorderStyle="Solid"
            ScrollBars="None" Width="99%" Style="vertical-align: middle;" Height="32px" HorizontalAlign="Center"
            CssClass="menu">
            <asp:Button ID="btnSaveAll" runat="server" Text="保存" Style="margin: 5px 2px 2px 2px;"
                OnClick="btnSaveAll_Click" /><asp:LinkButton ID="lnkCancel" runat="server" Style="margin: 5px 2px 2px 2px;">关闭</asp:LinkButton></asp:Panel>
    </div>
    </form>
</body>
</html>
