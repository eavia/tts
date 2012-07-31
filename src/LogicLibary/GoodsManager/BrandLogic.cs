using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects;

namespace LogicLibary.GoodsManager
{
    public class BrandLogic:BaseLogic
    {
        StoreEntities db = new StoreEntities();
        
        private BrandLogic() { }

        public BrandLogic(string userkey) : base(userkey) { }

        public bool AddBrand(Brand b)
        {
            try
            {
                b.Modified = DateTime.Now;
                db.BrandSet.AddObject(b);
                db.SaveChanges();
                return true;
            }
            catch
            {

            }
            return false;
        }

        public bool DeleteBrand(Brand b)
        {
            try
            {
                db.BrandSet.DeleteObject(b);
                db.SaveChanges();
                return true;
            }
            catch
            {

            }
            return false;
        }

        public IEnumerable<Brand> Where(Func<Brand,bool> p)
        {
            // 不加权限控制
            return db.BrandSet.Where(p);
        }

        public ObjectQuery<Brand> GetRootBrand()
        {

            return (ObjectQuery<Brand>)(from b in db.BrandSet
                                                     where b.RootBrand == null && b.UserKey.Equals(this.ContextUserKey)
                                                     select b);
        }

        public ObjectQuery<Brand> GetChildren(int id)
        {
            return (ObjectQuery<Brand>)from x in db.BrandSet
                                       where x.ID.Equals(id) && x.UserKey.Equals(this.ContextUserKey)
                                       select x;
        }
    }
}
