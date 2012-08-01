using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using LogicLibary.SettingManager;
using LogicLibary;

namespace TaobaoTesting.SettingManager
{
    public partial class UnitList : BasePage
    {
        UnitLogic logic;
        private StoreEntities dbContext = new StoreEntities();
        public UnitList()
        {
            logic = new UnitLogic(dbContext,this.ContextUserKey);
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
            this.dlUnits.DataSource = logic.GetUnitList();
            this.dlUnits.DataBind();
        }

        protected void btnAddUnit_Click(object sender, EventArgs e)
        {
            string name=txtUnitName.Text.Trim();
            if (!string.IsNullOrEmpty(name))
            {
                if (logic.CreateUnit(name,this.IsEnabled.Checked))
                {
                    txtUnitName.Text = "";
                    this.IsEnabled.Checked = false;
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

        protected void CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chk = (CheckBox)sender;
            Control p = chk.Parent.Parent;
            Literal idText = (Literal)p.FindControl("lbId");
            int bid = int.Parse(idText.Text);
            if (logic.TiggerUnitState(bid, chk.Checked))
            {
                BindUnits();
            }
        }
    }
}