using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LogicLibary;
using LogicLibary.GoodsManager;

namespace TaobaoTesting.GoodsManager
{
    public partial class GoodsList : BasePage
    {
        private GoodsLogic logic;
        private BrandLogic blogic;

        public GoodsList()
        {
            logic = new GoodsLogic(this.ContextUserKey);
            blogic = new BrandLogic(this.ContextUserKey);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
                BindDdpUnits();
                this.DropDownList1.DataSource = BuildDropListItem();
                this.DropDownList1.DataBind();
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
                lt.Text = perfix.PadLeft(bd.BrandName.Length + l, nbsp) + bd.BrandName;
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

        private List<ListItem> BuildDropListItem()
        {
            StoreEntities db = new StoreEntities();
            List<ListItem> lst = new List<ListItem>();
            var bs = from b in db.BrandSet
                     where b.RootBrand == null
                     select b;
            int l = 0;
            foreach (Brand br in bs)
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
        #endregion

        protected void btnAddGoods_Click(object sender, EventArgs e)
        {
            int traget = int.Parse(ddpUnits.SelectedValue);
            GoodsUnit u = db.GoodsUnitSet.Single(x => x.ID.Equals(traget));
            Goods goods = new Goods();
            goods.Unit = u;
            goods.GoodsName = txtGoodsName.Text.Trim();
            goods.UserKey = this.ContextUserKey;

            int bid=int.Parse(this.ddpUnits.SelectedValue);
            goods.Brand=db.BrandSet.Single(x => x.ID == bid);
            db.GoodsSet.AddObject(goods);
            db.SaveChanges();
            ddpUnits.SelectedValue = "-1";
            txtGoodsName.Text = "";
            BindGridView();
        }

        private void BindGridView()
        {
            StoreEntities db = new StoreEntities();
            dlGoods.DataSource = db.GoodsSet;
            dlGoods.DataBind();
        }

        private void BindDdpUnits()
        {
            ddpUnits.Items.Clear();
            ddpUnits.Items.Add(new ListItem()
            {
                Text = "",
                Value = "-1"
            });
            StoreEntities db = new StoreEntities();
            foreach (GoodsUnit u in db.GoodsUnitSet)
            {
                ddpUnits.Items.Add(new ListItem()
                {
                    Text = u.UnitName,
                    Value = u.ID.ToString()
                });
            }
            ddpUnits.SelectedIndex = 0;
        }


        protected void dlGoods_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataList dl = (DataList)sender;
            string sid = ((Literal)dl.SelectedItem.FindControl("lbId")).Text;
            Response.Redirect("Function.aspx?sid=" + sid, true);
        }

        protected void dlGoods_ItemCommand(object source, DataListCommandEventArgs e)
        {
            string cmd = e.CommandName;
            if (cmd.Equals("Select"))
            {
                DataList dl = (DataList)source;
                dl.SelectedIndex = e.Item.ItemIndex;
            }
        }
    }
}