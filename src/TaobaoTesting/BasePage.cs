using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Text;
using System.Web.UI.WebControls;

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
        protected override void OnPreLoad(EventArgs e)
        {
            base.OnPreLoad(e);
            if (IsPostBack)
            {
                string value = this.Request.Params["NextPostHandler"];
            }
        }

        protected void AttacthConfirmForControl(WebControl ctl, string messanage)
        {

            StringBuilder ScriptStr = new StringBuilder(script);

            ScriptStr.Replace("#MSG#", messanage.Trim());

            string orgstr = ctl.Attributes["onclick"] ?? "";

            ctl.Attributes["onclick"] = ScriptStr.ToString() + " " + orgstr;


        }

        static string script = "if(!confirm('#MSG#')) return false;";

        protected void ShowAlertBox(string messanges)
        {
            StringBuilder ScriptStr = new StringBuilder("alert('#MSG#');");
            ScriptStr.Replace("#MSG#", messanges);
            this.ClientScript.RegisterClientScriptBlock(this.GetType(), "Dialog", ScriptStr.ToString(), true);
        }

    }
}