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

        public UnitLogic(string userkey):base(userkey)
        {
           
        }

        public ObjectSet<GoodsUnit> GetUnitList()
        {
            return db.GoodsUnitSet;
        }

        public GoodsUnit GetUnitByID(int id)
        {
            GoodsUnit gu = null;
            try
            {
                gu = db.GoodsUnitSet.Single(u => u.ID.Equals(id));
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
