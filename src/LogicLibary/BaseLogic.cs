using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LogicLibary
{
    public class BaseLogic
    {
        internal BaseLogic() { }


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
