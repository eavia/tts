using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects;

namespace LogicLibary.GoodsManager
{
    public class GoodsLogic : BaseLogic
    {

        private GoodsLogic() { }

        public GoodsLogic(ObjectContext context, string userkey)
            : base(context, userkey)
        {

        }

        public bool AddGoods(Goods g)
        {
            try
            {
                g.Modified = DateTime.Now;
                this.ObjectContext.GoodsSet.AddObject(g);
                ObjectContext.SaveChanges();
                return true;
            }
            catch (System.Exception ex)
            {

            }
            return false;
        }

        public IQueryable<Goods> GetGoodsWithBrandID(int id)
        {
            return from g in this.ObjectContext.GoodsSet
                   where g.Brand.ID.Equals(id) && g.UserKey.Equals(this.ContextUserKey)
                   select g;
        }

        public IQueryable<Goods> GetGoodsList()
        {
            return from g in this.ObjectContext.GoodsSet
                   where g.UserKey.Equals(this.ContextUserKey)
                   select g;
        }

        public Goods GetGoodsByID(int goodsid)
        {
            Goods g = null;
            try
            {
                g = this.ObjectContext.GoodsSet.Single(gg => gg.ID.Equals(goodsid) && gg.UserKey.Equals(this.ContextUserKey));
            }
            catch
            {

            }
            return g;
        }
    }
}
