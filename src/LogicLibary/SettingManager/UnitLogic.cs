using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects;

namespace LogicLibary.SettingManager
{
    public class UnitLogic : BaseLogic
    {
        StoreEntities db = new StoreEntities();
        
        private UnitLogic() { }

        public UnitLogic(string userkey):base(userkey)
        {
            
        }

        public ObjectSet<GoodsUnit> GetList()
        {
            return db.GoodsUnitSet;
        }

        public bool DeleteUnit(int ID)
        {
            try
            {
                GoodsUnit gu = db.GoodsUnitSet.Single(x => x.ID.Equals(ID));
                db.GoodsUnitSet.DeleteObject(gu);
                db.SaveChanges();
                return true;
            }
            catch
            {

            }
            return false;
        }

        public bool CreateUnit(string name)
        {
            try
            {
                db.GoodsUnitSet.AddObject(new GoodsUnit()
                {
                    UnitName = name,
                    UserKey=this.ContextUserKey,
                    Modified=DateTime.Now
                });
                db.SaveChanges();
                return true;
            }
            catch
            {

            }
            return false;
        }
    }
}
