using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects;
using System.Transactions;

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
                this.ObjectContext.EntitySet.AddObject(g);
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
            return from g in this.ObjectContext.EntitySet.OfType<Goods>()
                   where g.Brand.ID.Equals(id) && g.UserKey.Equals(this.ContextUserKey)
                   select g;
        }

        public IQueryable<Goods> GetGoodsList()
        {
            return from g in this.ObjectContext.EntitySet.OfType<Goods>()
                   where g.UserKey.Equals(this.ContextUserKey)
                   select g;
        }

        public Goods GetGoodsByID(int goodsid)
        {
            Goods g = null;

            ObjectParameter p = new ObjectParameter("p", goodsid);
            ObjectQuery<Goods> set = this.ObjectContext.EntitySet.OfType<Goods>().Where("it.ID=@p", p);

            if (set.Count() == 1)
            {
                g = set.First();
            }


            return g;
        }

        public Changed GetChangedByID(int id)
        {
            Changed c = null;
            try
            {
                c = this.ObjectContext.EntitySet.OfType<Changed>().Single(cc => cc.ID.Equals(id) && cc.UserKey.Equals(this.ContextUserKey));
            }
            catch
            {

            }
            return c;
        }

        public bool UpdateingGoodsWithChanged(Goods g, Changed c)
        {
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {

                    c.Value = c.GoodsItemSet.Sum(x => x.Quantity);
                    c.SumCost = c.GoodsItemSet.Sum(p => (decimal)p.Quantity * c.PieceCost);
                    this.ObjectContext.SaveChanges();

                    g.Quantity = g.Quantity + c.Value;
                    this.ObjectContext.SaveChanges();


                    scope.Complete();
                    this.ObjectContext.AcceptAllChanges();
                    return true;
                }
            }
            catch
            {

            }
            return false;
        }

        public bool UpdateGoods(Goods g)
        {
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    this.ObjectContext.SaveChanges();
                    decimal sum = g.ChangedSet.Sum(x => x.Value);
                    g.Quantity = sum;
                    this.ObjectContext.SaveChanges();
                    scope.Complete();
                    this.ObjectContext.AcceptAllChanges();
                    return true;
                }
            }
            catch
            {

            }
            return false;
        }


        public bool AddChangedToGoods(Goods g, Changed c)
        {
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    g.ChangedSet.Add(c);
                    g.Quantity = g.Quantity + c.Value;
                    this.ObjectContext.SaveChanges(SaveOptions.None);

                    scope.Complete();
                    this.ObjectContext.AcceptAllChanges();
                    return true;
                }
            }
            catch
            {

            }
            return false;
        }
    }
}
