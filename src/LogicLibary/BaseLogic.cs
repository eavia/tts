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
        }
    }
}
