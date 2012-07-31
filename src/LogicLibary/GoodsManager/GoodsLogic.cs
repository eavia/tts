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

        public GoodsLogic(string userkey) : base(userkey) { }

        public bool AddGoods(Goods g)
        {
            try
            {
                g.Modified = DateTime.Now;
                db.GoodsSet.AddObject(g);
                db.SaveChanges();
                return true;
            }
            catch (System.Exception ex)
            {

            }
            return false;
        }

        public ObjectQuery<Goods> GetGoodsWithBrandID(int id)
        {
            return (ObjectQuery<Goods>)from g in db.GoodsSet
                                       where g.Brand.ID.Equals(id) && g.UserKey.Equals(this.ContextUserKey)
                                       select g;
        }

        public ObjectQuery<Goods> GetGoodsList()
        {
            return (ObjectQuery<Goods>)from g in db.GoodsSet
                                       where g.UserKey.Equals(this.ContextUserKey)
                                       select g;
        }

        public bool SaveChanges()
        {
            try
            {
                db.SaveChanges();
                return true;
            }
            catch
            {

            }
            return false;
        }

        public Goods GetGoodsByID(int goodsid)
        {
            Goods g = null;
            try
            {
                g = db.GoodsSet.Single(gg => gg.ID.Equals(goodsid) && gg.UserKey.Equals(this.ContextUserKey));
            }
            catch
            {

            }
            return g;
        }
    }
}
