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

        public int ContextGoodsID
        {
            get { return int.Parse(hfdGoodsID.Value); }
            set { hfdGoodsID.Value = value.ToString(); }
        }

        public int ContextChangedID
        {
            get { return int.Parse(hfdChangedID.Value); }
            set { hfdChangedID.Value = value.ToString(); }
        }

        public Goods ContextGoods
        {
            get
            {
                return (Goods)ViewState["ContextGoods"];
            }
            set
            {
                if (value != null)
                {
                    ViewState["ContextGoods"] = value;
                }
            }
        }

        public Changed ContextChanged
        {
            get
            {
                return (Changed)ViewState["ContextChanged"];
            }
            set
            {
                if (value != null)
                {
                    ViewState["ContextGoods"] = value;
                }
            }
        }

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

        public ChangedList()
        {
            GetSource();
            glogic = new GoodsLogic(dbContext, this.ContextUserKey);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.AttacthConfirmForControl(this.btnChangedNew, "创建变更单将导致现有操作结果丢失,确定?");

                string goodsid = (this.Request.QueryString["gid"] ?? "NaN").ToString();

                this.ContextGoodsID = int.Parse(goodsid);

                this.ContextGoods = glogic.GetGoodsByID(this.ContextGoodsID);

                BindInternalChangedList(this.ContextGoods);

            }
        }

        private void BindInternalChangedList(Goods god)
        {
            this.ChangedPager.RecordCount = god.ChangedSet.Count();
            var ds = god.ChangedSet.OrderByDescending(x => x.Date)
                .Skip((this.ChangedPager.StartRecordIndex > 0 ? this.ChangedPager.StartRecordIndex - 1 : 0)).Take(ChangedPager.PageSize);
            this.ChangedPager.CustomInfoHTML = string.Format("当前第{0}/{1}页 共{2}条记录 每页{3}条", new object[] { this.ChangedPager.CurrentPageIndex, this.ChangedPager.PageCount, this.ChangedPager.RecordCount, this.ChangedPager.PageSize });
            internalChangedList.DataSource = ds;
            internalChangedList.DataBind();
        }

        protected void BindItemsWithCID(Changed c)
        {
            if (!c.GoodsItemSet.IsLoaded)
            {
                c.GoodsItemSet.Load();
            }
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

        protected void InternalChangedList_ItemCommand(object source, DataListCommandEventArgs e)
        {
            string itemId = e.CommandArgument.ToString();
            if (e.CommandName == "Save")
            {
                if (glogic.UpdateGoods(GetPageGoods()))
                {
                    SetPageGoods(glogic.GetGoodsByID(this.ContextGoodsID));
                    this.internalChangedList.EditItemIndex = -1;
                    BindInternalChangedList();
                }
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

        protected void ChangedPager_PageChanged(object sender, EventArgs e)
        {
            BindInternalChangedList();
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
            BindInternalChangedList();
            BindItemsWithCID(c);
        }

        protected void btnSaveAll_Click(object sender, EventArgs e)
        {
            Goods g = glogic.GetGoodsByID(this.ContextGoodsID);
            Changed c = (Changed)ViewState["PageSeletedChanged"]; //获取页面上的进货单
            if (!glogic.UpdateingGoodsWithChanged(g, c))
            {
                throw new Exception("保存失败!");
            }
            else
            {
                this.ClientScript.RegisterClientScriptBlock(Page.GetType(), "Close", "CloseWin()", true);
            }
        }

        protected void dlChangedItems_CancelCommand(object source, DataListCommandEventArgs e)
        {
            Changed c = (Changed)ViewState["PageSeletedChanged"];
            BindItemsWithCID(c);
        }

        protected void btnChangedNew_Click(object sender, EventArgs e)
        {
            Goods God = GetPageGoods();
            Changed newChanged = new Changed();

            newChanged.Date = DateTime.Now;
            if (!God.ChangedSet.IsLoaded)
            {
                God.ChangedSet.Load();
            }
            God.ChangedSet.Attach(newChanged);
            SetPageGoods(God);
            this.internalChangedList.EditItemIndex = 0;
            BindInternalChangedList();

        }

    }
}