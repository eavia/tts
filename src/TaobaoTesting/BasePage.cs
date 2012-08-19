using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Text;
using System.Web.UI.WebControls;
using LogicLibary;
using System.Collections;

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

        Hashtable valueOfPage;

        public Hashtable ValueOfPage
        {
            get
            {
                return valueOfPage;
            }
        }

        protected override void OnUnload(EventArgs e)
        {
            base.OnUnload(e);
            ViewState.Remove("Page_" + this.Page.ClientID + "_Value");
            if (valueOfPage != null && valueOfPage.Count != 0)
            {
                ViewState.Add("Page_" + this.Page.ClientID + "_Value", valueOfPage);
            }
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInitComplete(e);
            if (ViewState["Page_" + this.Page.ClientID + "_Value"] != null)
            {
                valueOfPage = (Hashtable)ViewState["Page_" + this.Page.ClientID + "_Value"];
            }
            else
            {
                valueOfPage = new Hashtable();
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