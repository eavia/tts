﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="BrandList.aspx.cs" Inherits="TaobaoTesting.GoodsManager.BrandList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="treediv" style="width: 20%; height: 450px; display: block; float: left;
        margin: 0px 0px 0px 0px;">
        <asp:TreeView ID="trvBrand" runat="server" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged"
            Height="90%" ShowLines="True" Width="185px" BorderStyle="Inset" CollapseImageUrl="~/Images/folderClosed.gif"
            ExpandImageUrl="~/Images/folderOpen.gif" ImageSet="News">
            <SelectedNodeStyle BorderColor="#FF3300" BorderWidth="1px" />
        </asp:TreeView>
    </div>
    <div id="listdiv" style="width: 700px; display: inline; float: right; margin-left: 5px;
        margin-right: 0px">
        <asp:Panel ID="pelEditor" runat="server" BorderColor="#CCFFCC" Height="25px" HorizontalAlign="Center">
            <asp:TextBox ID="txtName" runat="server" CssClass="textBoxLine"></asp:TextBox>
            <asp:Button ID="btnAddNode" runat="server" Text="添加" OnClick="btnAddNode_Click" /><asp:Button
                ID="btnDelete" runat="server" Text="删除" OnClick="btnDelete_Click" />
        </asp:Panel>
        <asp:Panel ID="pelList" runat="server">
            <asp:DataList Width="99%" ID="dlGoods" runat="server" ExtractTemplateRows="true"
                CellPadding="2" DataKeyField="ID" GridLines="Both" OnItemDataBound="dlGoods_ItemDataBound">
                <ItemStyle ForeColor="Black" />
                <HeaderTemplate>
                    <asp:Table ID="tabHeader" runat="server">
                        <asp:TableRow>
                            <asp:TableHeaderCell Width="35px" HorizontalAlign="Center" VerticalAlign="Middle">序号</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="100px" HorizontalAlign="Center" VerticalAlign="Middle">商品编号</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="270px" HorizontalAlign="Center" VerticalAlign="Middle">商品名称</asp:TableHeaderCell>
                            <asp:TableHeaderCell Width="120px" HorizontalAlign="Center" VerticalAlign="Middle">操作</asp:TableHeaderCell>
                        </asp:TableRow>
                    </asp:Table>
                </HeaderTemplate>
                <HeaderStyle Height="25px" />
                <ItemStyle Height="30px" />
                <ItemTemplate>
                    <asp:Table ID="tabItem" runat="server">
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="Center" VerticalAlign="Middle">
                                <asp:LinkButton ID="lnkSelect" runat="server" CommandArgument='<%#Eval("ID")%>' CommandName="Select"><%#Container.ItemIndex+1%></asp:LinkButton></asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center" VerticalAlign="Middle">
                                <asp:Literal ID="lbId" runat="server" Text='<%#Eval("ID")%>'></asp:Literal></asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center" VerticalAlign="Middle"><%#Eval("GoodsName")%></asp:TableCell>
                            <asp:TableCell HorizontalAlign="Center" VerticalAlign="Middle">
                                <asp:DropDownList ID="dlpBrandList" runat="server" DataTextField="Text" DataValueField="Value"
                                    Width="110px">
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </ItemTemplate>
            </asp:DataList>
        </asp:Panel>
    </div>
</asp:Content>
