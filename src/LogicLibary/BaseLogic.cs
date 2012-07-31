using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LogicLibary
{
    public class BaseLogic
    {
        internal BaseLogic() { }

        static StoreEntities dbContext;
        static object lockobj = new object();

        public StoreEntities db
        {
            private set { }
            get
            {
                if (dbContext == null)
                {
                    lock (lockobj)
                    {
                        if (dbContext == null)
                        {
                            dbContext = new StoreEntities();
                        }
                    }
                }
                return dbContext;
            }
        }


        public String ContextUserKey {
            private set;
            get;
        }

        public BaseLogic(string userkey)
        {
            this.ContextUserKey = userkey;
        }

    }
}
