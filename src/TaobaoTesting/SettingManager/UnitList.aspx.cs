using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using LogicLibary.SettingManager;

namespace TaobaoTesting.SettingManager
{
    public partial class UnitList : BasePage
    {
        UnitLogic logic;
        public UnitList()
        {
            logic = new UnitLogic(this.ContextUserKey);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUnits();
            }
        }

        private void BindUnits()
        {
            this.dlUnits.DataSource = logic.GetList();
            this.dlUnits.DataBind();
        }

        protected void btnAddUnit_Click(object sender, EventArgs e)
        {
            string name=txtUnitName.Text.Trim();
            if (!string.IsNullOrEmpty(name))
            {
                if (logic.CreateUnit(name))
                {
                    txtUnitName.Text = "";
                    BindUnits();
                }
            }
        }

        protected void dlUnits_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            logic.DeleteUnit(id);
            BindUnits();
        }
    }
}