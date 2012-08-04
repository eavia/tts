﻿using System;
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

            double quantity;

            public double Quantity
            {
                get { return this.quantity; }
                set { this.quantity = value; }
            }

            double value;

            public double Value
            {
                get { return this.value; }
                set { this.value = value; }
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
                BindGoodsList();
            }
        }

        private void BindGoodsList(string afterIndex)
        {
            BindGoodsList();
            int id = -1;
            if (!string.IsNullOrEmpty(afterIndex) && int.TryParse(afterIndex, out id))
            {
                this.dlGoods.SelectedIndex = id;
                DataListItem dlt = this.dlGoods.Items[id];
                Literal lta = (Literal)dlt.FindControl("lbId");
                ShowChangedList(this.dlGoods.Items[id], lta.Text);
            }
        }

        private void BindGoodsList()
        {
            this.dlGoods.DataSource = glogic.GetGoodsList();
            this.dlGoods.DataBind();
        }

        private void ShowChangedList(DataListItem item, string goodsid)
        {

            Control tr = item.FindControl("internal");
            tr.Visible = true;
            BindInternalChangedList(item, goodsid);
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
                ShowChangedList(item, itemId);
                //BindChangeListByGID(itemId);
            }
        }
        private void BindInternalChangedList(DataListItem it, string itemId)
        {
            DataList cdl = (DataList)it.FindControl("internalChangedList");

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
                lst.Add(pc);
            }
            PageChange empty = new PageChange();
            empty.ChangedId = -1;
            empty.GoodsId = gid;
            empty.Quantity = goods.Quantity;
            empty.Value = 0;
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
                    chg.Quantity = double.Parse(((Literal)dli.FindControl("ltaQuantity")).Text);
                    chg.Value = double.Parse(((TextBox)dli.FindControl("ltaValue")).Text);
                    string datestring = ((TextBox)dli.FindControl("ltaDate")).Text;
                    chg.Date = DateTime.Parse(datestring);
                    chg.UserKey = this.ContextUserKey;
                    if (logic.AddChangedToGoods(goods, chg))
                    {
                        BindGoodsList(this.hfdSeletedIndex.Value);
                        BindInternalChangedList((DataListItem)dl.Parent.Parent.Parent.Parent, goodsid.ToString());
                    }
                }
            }
        }

        private void BindChangeListByGID(string goodsid)
        {
            List<PageChange> lst = new List<PageChange>();
            int gid = int.Parse(goodsid);
            Goods goods = glogic.GetGoodsByID(gid);
            foreach (Changed cd in goods.ChangedSet)
            {
                PageChange pc = new PageChange();
                pc.ChangedId = cd.ID;
                pc.GoodsId = gid;
                pc.Value = cd.Value;
                pc.Quantity = cd.Quantity;
                pc.Date = cd.Date;
                lst.Add(pc);
            }
            PageChange empty = new PageChange();
            empty.ChangedId = -1;
            empty.GoodsId = gid;
            empty.Quantity = goods.Quantity;
            empty.Value = 0;
            empty.Date = DateTime.Now;
            lst.Add(empty);
            //this.dlChanged.DataSource = lst;
            //this.dlChanged.EditItemIndex = lst.Count - 1;
            //this.dlChanged.DataBind();
        }

        protected void dlChanged_ItemCommand(object source, DataListCommandEventArgs e)
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
                    chg.Quantity = double.Parse(((Literal)dli.FindControl("ltaQuantity")).Text);
                    chg.Value = double.Parse(((TextBox)dli.FindControl("ltaValue")).Text);
                    string datestring = ((TextBox)dli.FindControl("ltaDate")).Text;
                    chg.Date = DateTime.Parse(datestring);
                    chg.UserKey = this.ContextUserKey;
                    if (logic.AddChangedToGoods(goods, chg))
                    {
                        BindGoodsList();
                        BindChangeListByGID(goodsid.ToString());
                    }
                }
            }
        }
    }
}