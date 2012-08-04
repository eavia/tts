using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects;

namespace LogicLibary.SettingManager
{
    public class UnitLogic : BaseLogic
    {

        private UnitLogic() { }

        public UnitLogic(ObjectContext context, string userkey)
            : base(context, userkey)
        {

        }

        public IQueryable<GoodsUnit> GetUnitList()
        {
            return this.ObjectContext.EntitySet.OfType<GoodsUnit>();
        }

        public IQueryable<GoodsUnit> GetUnitList(bool e)
        {
            return this.ObjectContext.EntitySet.OfType<GoodsUnit>().Where(u => u.Enable.Equals(e));
        }

        public GoodsUnit GetUnitByID(int id)
        {
            GoodsUnit gu = null;
            try
            {
                gu = this.ObjectContext.EntitySet.OfType<GoodsUnit>().Single(u => u.ID.Equals(id));
            }
            catch (System.Exception ex)
            {

            }
            return gu;
        }

        public bool DeleteUnit(int ID)
        {
            try
            {
                GoodsUnit gu = this.ObjectContext.EntitySet.OfType<GoodsUnit>().Single(x => x.ID.Equals(ID));
                this.ObjectContext.EntitySet.DeleteObject(gu);
                this.ObjectContext.SaveChanges();
                return true;
            }
            catch
            {

            }
            return false;
        }

        public bool TiggerUnitState(int uid, bool isenabled)
        {
            try
            {
                GoodsUnit gu = this.ObjectContext.EntitySet.OfType<GoodsUnit>().Single(x => x.ID.Equals(uid));
                gu.Enable = isenabled;
                this.ObjectContext.SaveChanges();
                return true;
            }
            catch
            {

            }
            return false;
        }

        public bool CreateUnit(string name)
        {
            return CreateUnit(name, false);
        }

        public bool CreateUnit(string name, bool e)
        {
            if (this.ObjectContext.EntitySet.OfType<GoodsUnit>().Where(X => X.UnitName.Equals(name)).Count() == 0)
            {
                try
                {
                    this.ObjectContext.EntitySet.AddObject(new GoodsUnit()
                    {
                        UnitName = name,
                        Enable = e
                    });
                    this.ObjectContext.SaveChanges();
                    return true;
                }
                catch
                {

                }
            }
            return false;
        }

    }
}
