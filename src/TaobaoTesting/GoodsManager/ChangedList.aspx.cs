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
    public partial class ChangedList : BasePage
    {

        private GoodsLogic Logic;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string ParaGID = (Request.QueryString["gid"] ?? "NaN").ToString();
                if (ParaGID != "NaN")
                {
                    hfdGoodsID.Value = ParaGID;
                    StoreEntities db = new StoreEntities();
                    ValueOfPage.Add("DataSource", db);
                    int Id = int.Parse(ParaGID);
                    BindChangedList(Id);
                }
            }
        }

        private void BindChangedList(int GoodsId)
        {
            StoreEntities db =(StoreEntities)ValueOfPage["DataSource"];
            Logic = new GoodsLogic(db, this.ContextUserKey);
            Goods goods = Logic.GetGoodsByID(GoodsId);
            if (!goods.ChangedSet.IsLoaded)
            {
                goods.ChangedSet.Load();
            }

            this.ChangedPager.RecordCount = goods.ChangedSet.Count;
            var rs = goods.ChangedSet.OrderByDescending(x => x.ID).Skip((this.ChangedPager.StartRecordIndex > 0 ? this.ChangedPager.StartRecordIndex - 1 : 0)).Take(ChangedPager.PageSize);
            this.dlChangedList.DataSource = rs;
            this.dlChangedList.DataBind();
            this.ChangedPager.CustomInfoHTML = string.Format("当前第{0}/{1}页 共{2}条记录 每页{3}条", new object[] { this.ChangedPager.CurrentPageIndex, this.ChangedPager.PageCount, this.ChangedPager.RecordCount, this.ChangedPager.PageSize });
        }

        protected void btnChangedNew_Click(object sender, EventArgs e)
        {

        }

        protected void ChangedPager_PageChanged(object sender, EventArgs e)
        {
            int Id = int.Parse(this.hfdGoodsID.Value);
            BindChangedList(Id);
        }
    }
}