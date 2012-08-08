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

namespace TaobaoTesting.GoodsManager
{
    public partial class ChangedList : BasePage
    {
        private GoodsLogic glogic;

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
            glogic = new GoodsLogic(dbContext, this.ContextUserKey);
        }

        private int _contextGoodsID = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string goodsid = (this.Request.QueryString["gid"] ?? "NaN").ToString();
                hfdGoodsID.Value = goodsid;
                _contextGoodsID = int.Parse(hfdGoodsID.Value);
                Goods g = glogic.GetGoodsByID(_contextGoodsID);
                BindInternalChangedList(BuildPageList(g));
            }
            else
            {
                _contextGoodsID = int.Parse(hfdGoodsID.Value);
            }

        }

        private List<PageChange> BuildPageList(Goods g)
        {

            g.ChangedSet.Load();
            List<PageChange> lst = new List<PageChange>();

            foreach (Changed cd in g.ChangedSet)
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


            return lst;
        }

        private void BindInternalChangedList(List<PageChange> lst)
        {

            
            List<PageChange> ds = (lst.OrderByDescending(x => x.Date).Skip((this.ChangedPager.StartRecordIndex > 0 ? this.ChangedPager.StartRecordIndex - 1 : 0)).Take(ChangedPager.PageSize)).ToList();

            Goods g = glogic.GetGoodsByID(_contextGoodsID);
            PageChange empty = new PageChange();
            empty.ChangedId = -1;
            empty.GoodsId = _contextGoodsID;
            empty.Quantity = g.Quantity;
            empty.Value = 0;
            empty.PieceCost = 0;
            empty.SumCost = 0;
            empty.Source = "";
            empty.Date = DateTime.Now;
            ds.Add(empty);
            this.ChangedPager.RecordCount = ds;
            internalChangedList.DataSource = ds;
            internalChangedList.EditItemIndex = ds.Count - 1;
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
                TextBox lt = (TextBox)dli.FindControl("txtChangeID");
                if (lt.Text == "0")
                {
                    Changed chg = dbContext.CreateObject<Changed>();
                    chg.Quantity = decimal.Parse(((Literal)dli.FindControl("ltaQuantity")).Text);
                    chg.Value = decimal.Parse(((TextBox)dli.FindControl("txtValue")).Text);
                    chg.Date = DateTime.Parse(((TextBox)dli.FindControl("txtDate")).Text);
                    chg.Source = ((TextBox)dli.FindControl("txtSource")).Text;
                    chg.Goods = g;
                    glogic.AddChangedToGoods(g, chg);
                    dbContext.SaveChanges();
                    BindInternalChangedList(BuildPageList(g));
                }
            }
        }
    }
}