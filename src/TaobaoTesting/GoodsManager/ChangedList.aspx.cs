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
    public partial class ChangedList : BasePage
    {
        private ChangedLogic logic;
        private GoodsLogic glogic;
        private BrandLogic blogic;
        private UnitLogic ulogic;

        private StoreEntities dbContext = new StoreEntities();

        internal class PageChange
        {
            int goodsId;

            public int GoodsId
            {
                get { return goodsId; }
                set { goodsId = value; }
            }
            int changedId;

            public int ChangedId
            {
                get { return changedId; }
                set { changedId = value; }
            }

            decimal quantity;

            public decimal Quantity
            {
                get { return this.quantity; }
                set { this.quantity = value; }
            }

            decimal value;

            public decimal Value
            {
                get { return this.value; }
                set { this.value = value; }
            }

            decimal pieceCost;

            public decimal PieceCost
            {
                get { return pieceCost; }
                set { pieceCost = value; }
            }

            decimal sumCost;

            public decimal SumCost
            {
                get { return sumCost; }
                set { sumCost = value; }
            }

            string source;

            public string Source
            {
                get { return source; }
                set { source = value; }
            }

            DateTime date;

            public DateTime Date
            {
                get { return date; }
                set { date = value; }
            }
        }

        public ChangedList()
        {
            logic = new ChangedLogic(dbContext, this.ContextUserKey);
            glogic = new GoodsLogic(dbContext, this.ContextUserKey);
            blogic = new BrandLogic(dbContext, this.ContextUserKey);
            ulogic = new UnitLogic(dbContext, this.ContextUserKey);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string goodsid = (this.Request.QueryString["gid"] ?? "NaN").ToString();
                hfdGoodsID.Value = goodsid;
                BindInternalChangedList(goodsid);
            }
        }

        protected void dlGoods_ItemCommand(object source, DataListCommandEventArgs e)
        {
            string itemId = e.CommandArgument.ToString();
            if (e.CommandName == "Change")
            {
                DataList dl = (DataList)source;
                dl.SelectedIndex = e.Item.ItemIndex;
                hfdSeletedIndex.Value = e.Item.ItemIndex.ToString();
                DataListItem item = dl.Items[e.Item.ItemIndex];
            }
        }
        private void BindInternalChangedList(string itemId)
        {
            DataList cdl = this.internalChangedList;

            List<PageChange> lst = new List<PageChange>();

            int gid = int.Parse(itemId);
            Goods goods = glogic.GetGoodsByID(gid);
            foreach (Changed cd in goods.ChangedSet)
            {
                PageChange pc = new PageChange();
                pc.ChangedId = cd.ID;
                pc.GoodsId = gid;
                pc.Value = cd.Value;
                pc.Quantity = cd.Quantity;
                pc.Date = cd.Date;
                pc.PieceCost = cd.PieceCost;
                pc.SumCost = cd.SumCost;
                pc.Source = cd.Source;
                lst.Add(pc);
            }

            PageChange empty = new PageChange();
            empty.ChangedId = -1;
            empty.GoodsId = gid;
            empty.Quantity = goods.Quantity;
            empty.Value = 0;
            empty.PieceCost = 0;
            empty.SumCost = 0;
            empty.Source = "";
            empty.Date = DateTime.Now;
            lst.Add(empty);
            cdl.DataSource = lst;
            cdl.EditItemIndex = lst.Count - 1;
            cdl.DataBind();
        }

        protected void InternalChangedList_ItemCommand(object source, DataListCommandEventArgs e)
        {
            string itemId = e.CommandArgument.ToString();
            if (e.CommandName == "Save")
            {
                DataList dl = (DataList)source;
                DataListItem dli = e.Item;
                dl.SelectedIndex = dli.ItemIndex;
                TextBox lt = (TextBox)dli.FindControl("txtChangeID");
                if (lt.Text == "0")
                {
                    int goodsid = int.Parse(((HiddenField)dli.FindControl("hfEditGoodsID")).Value);
                    Goods goods = glogic.GetGoodsList().Single(x => x.ID.Equals(goodsid));
                    Changed chg = new Changed();
                    chg.Quantity = decimal.Parse(((Literal)dli.FindControl("ltaQuantity")).Text);
                    chg.Value = decimal.Parse(((TextBox)dli.FindControl("txtValue")).Text);
                    string datestring = ((TextBox)dli.FindControl("txtDate")).Text;
                    chg.Date = DateTime.Parse(datestring);
                    chg.UserKey = this.ContextUserKey;
                    if (logic.AddChangedToGoods(goods, chg))
                    {
                        BindInternalChangedList(goodsid.ToString());
                    }
                }
            }
            else if (e.CommandName == "Hide")
            {
                DataListItem dli = e.Item;
                Control tr = dli.Parent.Parent.Parent;
                this.hfdSeletedIndex.Value = "-1";
                tr.Visible = false;
            }
        }
    }
}