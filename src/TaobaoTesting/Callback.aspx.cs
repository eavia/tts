using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TaobaoTesting
{
    public partial class Callback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string sessionkey = (this.Request.Params["top_session"] ?? "NaN").ToString();
                if (!sessionkey.Equals("NaN"))
                {
                    Session.Add("SessionKey", sessionkey);
                    Response.Redirect("Default.aspx");
                }
            }
        }
    }
}