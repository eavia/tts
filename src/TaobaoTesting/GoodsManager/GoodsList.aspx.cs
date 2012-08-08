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

        private StoreEntities dbContext = new StoreEntities();

        public GoodsList()
        {
            logic = new GoodsLogic(dbContext, this.ContextUserKey);
            blogic = new BrandLogic(dbContext, this.ContextUserKey);
            ulogic = new UnitLogic(dbContext, this.ContextUserKey);
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
            var bs = blogic.GetRootBrand();
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
            IQueryable<Goods> glst = logic.GetGoodsList();
            this.GoodsPager.RecordCount = glst.Count();
            dlGoods.DataSource = glst.OrderByDescending(x => x.ID).Skip((GoodsPager.StartRecordIndex > 0 ? GoodsPager.StartRecordIndex - 1 : 0)).Take(GoodsPager.PageSize);
            dlGoods.DataBind();
            this.GoodsPager.CustomInfoHTML = string.Format("当前第{0}/{1}页 共{2}条记录 每页{3}条", new object[] { this.GoodsPager.CurrentPageIndex, this.GoodsPager.PageCount, this.GoodsPager.RecordCount, this.GoodsPager.PageSize });
        }

        private void BindDdpUnits()
        {
            ddlUnits.Items.Clear();
            ddlUnits.Items.Add(new ListItem()
            {
                Text = "",
                Value = "-1"
            });
            foreach (GoodsUnit u in ulogic.GetUnitList(true))
            {
                ddlUnits.Items.Add(new ListItem()
                {
                    Text = u.UnitName,
                    Value = u.ID.ToString()
                });
            }
            ddlUnits.SelectedIndex = 0;
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

        protected void GoodsPager_PageChanged(object sender, EventArgs e)
        {
            BindGridView();
        }
    }
}