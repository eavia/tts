using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace TaobaoTesting
{
    public class BasePage : System.Web.UI.Page
    {
        public String ContextUserKey
        {
            private set;
            get;
        }
        public BasePage()
        {
            MembershipUser u = Membership.GetUser(User.Identity.Name);
            ContextUserKey = u.ProviderUserKey.ToString();
        }

    }
}