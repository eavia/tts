using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects;

namespace LogicLibary.GoodsManager
{
    public class GoodsLogic : BaseLogic
    {
        StoreEntities db = new StoreEntities();

        private GoodsLogic() { }

        public GoodsLogic(string userkey) : base(userkey) { }

        public bool AddGoods(Goods g)
        {
            try
            {
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
                                       where g.Brand.ID.Equals(id)
                                       select g;
        }
    }
}
