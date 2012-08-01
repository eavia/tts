using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LogicLibary;

namespace TaobaoTesting.GoodsManager
{
    public partial class ChangedList : System.Web.UI.Page
    {

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
        StoreEntities db = new StoreEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGoodsList();
            }
        }

        private void BindGoodsList()
        {
            this.dlGoods.DataSource = db.GoodsSet;
            this.dlGoods.DataBind();
        }

        protected void dlGoods_ItemCommand(object source, DataListCommandEventArgs e)
        {
            string itemId = e.CommandArgument.ToString();
            if (e.CommandName == "Change")
            {
                DataList dl = (DataList)source;
                dl.SelectedIndex = e.Item.ItemIndex;
                BindChangeListByGID(itemId);
            }
        }

        private void BindChangeListByGID(string goodsid)
        {
            List<PageChange> lst = new List<PageChange>();
            int gid = int.Parse(goodsid);
            Goods goods = db.GoodsSet.Single(x => x.ID.Equals(gid));
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
            this.dlChanged.DataSource = lst;
            this.dlChanged.EditItemIndex = lst.Count - 1;
            this.dlChanged.DataBind();
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
                    Goods goods = db.GoodsSet.Single(x => x.ID.Equals(goodsid));
                    Changed chg = new Changed();
                    chg.Quantity = double.Parse(((Literal)dli.FindControl("ltaQuantity")).Text);
                    chg.Value = double.Parse(((TextBox)dli.FindControl("ltaValue")).Text);
                    string datestring = ((TextBox)dli.FindControl("ltaDate")).Text;
                    chg.Date = DateTime.Parse(datestring);
                    goods.ChangedSet.Add(chg);
                    goods.Quantity =goods.Quantity + chg.Value;
                    db.SaveChanges();
                    BindGoodsList();
                    BindChangeListByGID(goodsid.ToString());
                }
            }
        }
    }
}