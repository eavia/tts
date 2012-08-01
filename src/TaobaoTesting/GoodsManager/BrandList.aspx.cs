using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using LogicLibary;
using LogicLibary.GoodsManager;

namespace TaobaoTesting.GoodsManager
{
    public partial class BrandList : BasePage
    {

        BrandLogic logic;
        GoodsLogic glogic;

        StoreEntities dbContext = new StoreEntities();

        public BrandList()
        {
            logic = new BrandLogic(dbContext,this.ContextUserKey);
            glogic = new GoodsLogic(dbContext,this.ContextUserKey);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            BrandListItems = BuildDropListItem();
            if (!IsPostBack)
            {
                BuildRootNode(this.trvBrand);
            }
        }

        #region 下拉菜单准备
        char nbsp = (char)0xA0;
        string perfix = "└";
        private void InsertDropListItem(Brand bc, ref int l, List<ListItem> lst)
        {
            foreach (Brand bd in bc.ChildBrandSet)
            {
                ListItem lt = new ListItem();
                string tmpStr = perfix.PadLeft(perfix.Length + l, nbsp);
                lt.Text = tmpStr + bd.BrandName;
                lt.Value = bd.ID.ToString();
                lst.Add(lt);
                if (bd.ChildBrandSet.Count != 0)
                {
                    l += 1;
                    InsertDropListItem(bd, ref l, lst);
                    l -= 1;
                }
            }
        }
        private List<ListItem> BrandListItems;
        private List<ListItem> BuildDropListItem()
        {
            List<ListItem> lst = new List<ListItem>();

            int l = 0;
            foreach (Brand br in logic.GetRootBrand())
            {
                ListItem lt = new ListItem();
                lt.Text = br.BrandName;
                lt.Value = br.ID.ToString();
                lst.Add(lt);
                if (br.ChildBrandSet.Count != 0)
                {
                    l += 1;
                    InsertDropListItem(br, ref l, lst);
                    l -= 1;
                }
            }
            return lst;
        }
        static string template = "<asp:ListItem Text=\"#text#\" Value=\"#value#\"></asp:ListItem>";
        public string GetItemString()
        {
            StringBuilder stb = new StringBuilder();
            foreach (ListItem li in BrandListItems)
            {
                stb.Append(template).Replace("#text#", li.Text)
                    .Replace("#value#", li.Value);
            }
            return stb.ToString();
        }
        #endregion

        private void BuildRootNode(TreeView tr)
        {
            tr.Nodes.Clear();
            TreeNode node = new TreeNode();
            node.Text = "根目录";
            node.Value = "0";
            tr.Nodes.Add(node);
            tr.DataBind();
        }

        private void ExplandTreeNode(TreeView tr)
        {
            TreeNode root = tr.SelectedNode;
            if (root != null)
            {
                int rid = int.Parse(root.Value);
                var cs = logic.GetChildren(rid);
                if (cs.Count() != 0)
                {
                    root.ChildNodes.Clear();
                    foreach (Brand b in cs.First().ChildBrandSet)
                    {
                        TreeNode node = new TreeNode();
                        node.Text = b.BrandName;
                        node.Value = b.ID.ToString();
                        root.ChildNodes.Add(node);
                    }
                }
                else
                {
                    root.ChildNodes.Clear();
                    cs = logic.GetRootBrand();
                    foreach (Brand b in cs)
                    {
                        TreeNode node = new TreeNode();
                        node.Text = b.BrandName;
                        node.Value = b.ID.ToString();
                        root.ChildNodes.Add(node);
                    }
                }
                tr.DataBind();
            }
        }

        protected void btnAddNode_Click(object sender, EventArgs e)
        {
            TreeView tr = this.trvBrand;
            if (!string.IsNullOrEmpty(txtName.Text.Trim()) && !string.IsNullOrEmpty(tr.SelectedValue))
            {
                int rid = int.Parse(tr.SelectedValue);
                var cs = logic.GetChildren(rid);
                if (cs.Count() != 0)
                {
                    Brand br = new Brand();
                    br.BrandName = txtName.Text.Trim();
                    br.UserKey = this.ContextUserKey;
                    cs.First().ChildBrandSet.Add(br);
                    logic.AddBrand(br);

                }
                else
                {
                    Brand br = new Brand();
                    br.BrandName = txtName.Text.Trim();
                    br.UserKey = this.ContextUserKey;
                    logic.AddBrand(br);
                }
                ExplandTreeNode(tr);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            TreeNode root = trvBrand.SelectedNode;
            if (root != null)
            {
                if (root.Text != "根目录" && root.ChildNodes.Count == 0)
                {
                    int rid = int.Parse(root.Value);
                    logic.DeleteBrand(logic.Where(x => x.ID.Equals(rid)).First()); //有问题
                    string r = root.Parent.Value;
                    (root.Parent).ChildNodes.Remove(root);
                    ExplandTreeNode(this.trvBrand);
                }
            }
        }

        protected void ddlBrand_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList d = (DropDownList)sender;
            int brandid = int.Parse(d.SelectedValue);
            Control parent = d.Parent.Parent;
            Literal lta = (Literal)parent.FindControl("lbId");
            int goodsid = int.Parse(lta.Text);
            Goods g = glogic.GetGoodsByID(goodsid);
            Brand b = logic.GetBrandByID(brandid);
            if (g != null && b != null)
            {
                g.Brand = b;
                if (dbContext.SaveChanges()>0)
                {
                    string id = this.trvBrand.SelectedValue;
                    int rid = int.Parse(id);
                    BindGoodsListWithBrandID(rid);
                }
            }
        }

        protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
        {
            TreeView tr = (TreeView)sender;
            string id = tr.SelectedValue;
            int rid = int.Parse(id);
            ExplandTreeNode(tr);
            BindGoodsListWithBrandID(rid);
        }

        public void BindGoodsListWithBrandID(int id)
        {
            var gs = glogic.GetGoodsWithBrandID(id);
            this.pgrBrandList.RecordCount = gs.Count();
            var gps = gs.OrderByDescending(x => x.ID).Skip((this.pgrBrandList.StartRecordIndex > 0 ? this.pgrBrandList.StartRecordIndex - 1 : 0)).Take(pgrBrandList.PageSize);
            this.dlGoods.DataSource = gps;
            this.dlGoods.DataBind();
        }

        protected void dlGoods_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DropDownList dl = (DropDownList)e.Item.FindControl("dlpBrandList");
                dl.ClearSelection();
                dl.Items.Clear();
                dl.DataSource = BuildDropListItem();
                dl.DataBind();
                if (e.Item.DataItem != null)
                {
                    Goods gs = (Goods)e.Item.DataItem;
                    dl.Items.FindByValue(gs.Brand.ID.ToString()).Selected = true;
                }
            }
        }

        protected void pgrBrandList_PageChanged(object sender, EventArgs e)
        {
            string id = this.trvBrand.SelectedValue;
            int rid = int.Parse(id);
            BindGoodsListWithBrandID(rid);
        }

    }
}