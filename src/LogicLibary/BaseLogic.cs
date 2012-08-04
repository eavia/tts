using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects;

namespace LogicLibary
{
    public class BaseLogic
    {
        internal BaseLogic() { }

        StoreEntities _objectContext;
        public StoreEntities ObjectContext
        {
            get { return _objectContext; }
            private set { _objectContext = value; }
        }

        public String ContextUserKey
        {
            private set;
            get;
        }

        public BaseLogic(ObjectContext context, string userkey)
        {
            this.ObjectContext = (StoreEntities)context;
            this.ContextUserKey = userkey;
            this.ObjectContext.SavingChanges += new EventHandler(ObjectContext_SavingChanges);
        }

        void ObjectContext_SavingChanges(object sender, EventArgs e)
        {
            foreach (var c in this.ObjectContext.ObjectStateManager.GetObjectStateEntries(System.Data.EntityState.Modified | System.Data.EntityState.Added))
            {
                Entity en = (Entity)c.Entity;
                if (en != null)
                {
                    en.Modified = DateTime.Now;
                    if (c.State == System.Data.EntityState.Added)
                    {
                        en.UserKey = this.ContextUserKey;
                    }
                }
            }
        }

    }
}
