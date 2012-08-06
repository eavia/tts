using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects;

namespace LogicLibary.GoodsManager
{
    public class BrandLogic : BaseLogic
    {

        private BrandLogic() { }

        public BrandLogic(ObjectContext context, string userkey) : base(context,userkey) { }

        public bool AddBrand(Brand b)
        {
            try
            {
                this.ObjectContext.EntitySet.AddObject(b);
                this.ObjectContext.SaveChanges();
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
                this.ObjectContext.DeleteObject(b);
                this.ObjectContext.SaveChanges();
                return true;
            }
            catch
            {

            }
            return false;
        }

        public Brand GetBrandByID(int id)
        {
            Brand br = null;
            try
            {
                br = this.ObjectContext.EntitySet.OfType<Brand>().Single(b => b.ID.Equals(id));
            }
            catch (System.Exception ex)
            {

            }
            return br;
        }

        public IEnumerable<Brand> Where(Func<Brand, bool> p)
        {
            // 不加权限控制
            return this.ObjectContext.EntitySet.OfType<Brand>().Where(p);
        }

        public IQueryable<Brand> GetRootBrand()
        {

            return (from b in this.ObjectContext.EntitySet.OfType<Brand>()
                    where b.RootBrand == null && b.UserKey.Equals(this.ContextUserKey)
                    select b);
        }

        public IQueryable<Brand> GetChildren(int id)
        {
            return from x in this.ObjectContext.EntitySet.OfType<Brand>()
                   where x.ID.Equals(id) && x.UserKey.Equals(this.ContextUserKey)
                   select x;
        }
    }
}
