using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LogicLibary;
using LogicLibary.GoodsManager;
using LogicLibary.SettingManager;

namespace TaobaoTesting.GoodsManager
{
    public partial class GoodsList : BasePage
    {
        private GoodsLogic logic;
        private BrandLogic blogic;
        private UnitLogic ulogic;
        public GoodsList()
        {
            logic = new GoodsLogic(this.ContextUserKey);
            blogic = new BrandLogic(this.ContextUserKey);
            ulogic = new UnitLogic(this.ContextUserKey);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
                BindDdpUnits();
                this.ddlBrand.DataSource = BuildDropListItem();
                this.ddlBrand.DataBind();
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
            GoodsUnit u = ulogic.GetUnitByID(int.Parse(ddlUnits.SelectedValue));
            Brand b = blogic.GetBrandByID(int.Parse(this.ddlBrand.SelectedValue));
            if (u != null && b != null)
            {
                Goods goods = new Goods();
                goods.Unit = u;
                goods.Brand = b;
                goods.GoodsName = txtGoodsName.Text.Trim();
                goods.UserKey = this.ContextUserKey;
                if (logic.AddGoods(goods))
                {
                    ddlUnits.SelectedValue = "-1";
                    txtGoodsName.Text = "";
                    BindGridView();
                }
            }
        }

        private void BindGridView()
        {
            dlGoods.DataSource = logic.GetGoodsList();
            dlGoods.DataBind();
        }

        private void BindDdpUnits()
        {
            ddlUnits.Items.Clear();
            ddlUnits.Items.Add(new ListItem()
            {
                Text = "",
                Value = "-1"
            });
            foreach (GoodsUnit u in ulogic.GetUnitList())
            {
                ddlUnits.Items.Add(new ListItem()
                {
                    Text = u.UnitName,
                    Value = u.ID.ToString()
                });
            }
            ddlUnits.SelectedIndex = 0;
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