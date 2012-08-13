using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LogicLibary;
using LogicLibary.GoodsManager;
using LogicLibary.SettingManager;
using System.Data.Objects;
using System.Data;

namespace TaobaoTesting.GoodsManager
{
    public partial class ChangedList : BasePage
    {
        private GoodsLogic glogic;

        private StoreEntities dbContext;

        private void GetSource()
        {
            StoreEntities tmp = null;
            if (ViewState["ChangedDataSource"] == null)
            {
                tmp = new StoreEntities();
                ViewState["ChangedDataSource"] = tmp;
            }
            else
            {
                tmp = (StoreEntities)ViewState["ChangedDataSource"];
            }
            dbContext = tmp;
        }

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
            GetSource();
            glogic = new GoodsLogic(dbContext, this.ContextUserKey);
        }

        private int _contextGoodsID = -1;

        private int _contextChangedID = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string goodsid = (this.Request.QueryString["gid"] ?? "NaN").ToString();
                hfdGoodsID.Value = goodsid;
                _contextGoodsID = int.Parse(hfdGoodsID.Value);
                BindInternalChangedList(_contextGoodsID);
                _contextChangedID = int.Parse(hfdChangedID.Value);
            }
            else
            {
                _contextGoodsID = int.Parse(hfdGoodsID.Value);
                _contextChangedID = int.Parse(hfdChangedID.Value);
            }

        }

        private void BindInternalChangedList(int id)
        {
            Goods g = glogic.GetGoodsByID(id);
            this.ChangedPager.RecordCount = g.ChangedSet.Count();
            var ds = g.ChangedSet.OrderByDescending(x => x.ID)
                .Skip((this.ChangedPager.StartRecordIndex > 0 ? this.ChangedPager.StartRecordIndex - 1 : 0)).Take(ChangedPager.PageSize);

            List<PageChange> lst = new List<PageChange>();
            foreach (Changed cd in ds)
            {
                PageChange pc = new PageChange();
                pc.ChangedId = cd.ID;
                pc.GoodsId = _contextGoodsID;
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
            empty.GoodsId = _contextGoodsID;
            empty.Quantity = g.Quantity;
            empty.Value = 0;
            empty.PieceCost = 0;
            empty.SumCost = 0;
            empty.Source = "";
            empty.Date = DateTime.Now;
            lst.Add(empty);

            internalChangedList.DataSource = lst;
            internalChangedList.EditItemIndex = lst.Count - 1;
            internalChangedList.DataBind();
            this.ChangedPager.CustomInfoHTML = string.Format("当前第{0}/{1}页 共{2}条记录 每页{3}条", new object[] { this.ChangedPager.CurrentPageIndex, this.ChangedPager.PageCount, this.ChangedPager.RecordCount, this.ChangedPager.PageSize });
        }

        protected void InternalChangedList_ItemCommand(object source, DataListCommandEventArgs e)
        {
            string itemId = e.CommandArgument.ToString();
            if (e.CommandName == "Save")
            {
                DataList dl = (DataList)source;
                Goods g = glogic.GetGoodsByID(_contextGoodsID);
                DataListItem dli = e.Item;
                HiddenField orgCost = (HiddenField)dli.FindControl("hfPieceCost");
                TextBox Cost = (TextBox)dli.FindControl("txtPieceCost");

                Changed chg = dbContext.CreateObject<Changed>();
                chg.Quantity = decimal.Parse(((Literal)dli.FindControl("ltaQuantity")).Text);
                chg.Value = decimal.Parse(((Literal)dli.FindControl("txtValue")).Text);

                chg.PieceCost = decimal.Parse(((TextBox)dli.FindControl("txtPieceCost")).Text);
                chg.Date = DateTime.Parse(((TextBox)dli.FindControl("txtDate")).Text);
                chg.Source = ((TextBox)dli.FindControl("txtSource")).Text.Trim();

                chg.Goods = g;
                glogic.AddChangedToGoods(g, chg);
                dbContext.SaveChanges();
                BindInternalChangedList(_contextGoodsID);

            }
            else if (e.CommandName == "Select")
            {
                DataList dl = (DataList)source;
                dl.SelectedIndex = e.Item.ItemIndex;
                Changed c = null;
                if (!hfdChangedID.Value.Equals(e.CommandArgument.ToString()))
                {
                    hfdChangedID.Value = e.CommandArgument.ToString();
                    int id = int.Parse(e.CommandArgument.ToString());
                    c = glogic.GetChangedByID(id);
                    ViewState.Add("PageSeletedChanged", c);
                }
                else
                {
                    c = (Changed)ViewState["PageSeletedChanged"];
                }
                BindItemsWithCID(c);
            }
        }

        protected void BindItemsWithCID(Changed c)
        {

            List<GoodsItem> lst = null;
            if (c.GoodsItemSet.Count == 0)
            {
                lst = new List<GoodsItem>();
            }
            else
            {
                lst = c.GoodsItemSet.ToList();
            }


            GoodsItem item = new GoodsItem();
            item.ProductionDate = DateTime.Now;
            item.ExpiryDate = item.ProductionDate.AddMonths(12);
            lst.Add(item);


            dlChangedItems.DataSource = lst;
            dlChangedItems.EditItemIndex = lst.Count() - 1;
            dlChangedItems.DataBind();
        }

        protected void ChangedPager_PageChanged(object sender, EventArgs e)
        {
            BindInternalChangedList(_contextGoodsID);
        }

        protected void dlChangedItems_UpdateCommand(object source, DataListCommandEventArgs e)
        {
            Changed c = (Changed)ViewState["PageSeletedChanged"];
            DataListItem dit = e.Item;
            GoodsItem item = new GoodsItem();
            item.Goods = c.Goods;
            item.ItemIdenifity = ((TextBox)dit.FindControl("txtIdenifity")).Text;
            item.ProductionDate = DateTime.Parse(((TextBox)dit.FindControl("txtProductionDate")).Text);
            item.ExpiryDate = DateTime.Parse(((TextBox)dit.FindControl("txtExpiryDate")).Text);
            item.Quantity = decimal.Parse(((TextBox)dit.FindControl("txtQuantity")).Text);
            c.GoodsItemSet.Add(item);
            c.Value = c.GoodsItemSet.Sum(x => x.Quantity);
            c.SumCost = c.GoodsItemSet.Sum(x => x.Quantity * c.PieceCost);
            ViewState["PageSeletedChanged"] = c;
            BindInternalChangedList(_contextGoodsID);
            BindItemsWithCID(c);
        }

        protected void btnSaveAll_Click(object sender, EventArgs e)
        {
            Goods g = glogic.GetGoodsByID(_contextGoodsID);
            Changed c = (Changed)ViewState["PageSeletedChanged"]; //获取页面上的进货单
            if (glogic.UpdateingGoodsWithChanged(g, c))
            {
                throw new Exception("保存失败!");
            }
        }

        protected void dlChangedItems_CancelCommand(object source, DataListCommandEventArgs e)
        {
            Changed c = (Changed)ViewState["PageSeletedChanged"];
            BindItemsWithCID(c);
        }
    }
}