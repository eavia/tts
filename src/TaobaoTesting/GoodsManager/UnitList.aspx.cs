using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TaobaoTesting.GoodsManager
{
    public partial class UnitList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUnits();
            }
        }

        private void BindUnits()
        {
            TaobaoTesting.StoreEntities db = new StoreEntities();
            this.dlUnits.DataSource = db.Units;
            this.dlUnits.DataBind();
        }

        protected void btnAddUnit_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtUnitName.Text.Trim()))
            {
                TaobaoTesting.StoreEntities db = new StoreEntities();
                db.Units.AddObject(new Unit()
                {
                    UnitName = txtUnitName.Text.Trim()
                });
                txtUnitName.Text = "";
                db.SaveChanges();
                BindUnits();
            }
        }

        protected void dlUnits_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            TaobaoTesting.StoreEntities db = new StoreEntities();
            db.Units.DeleteObject(db.Units.Single(x => x.ID.Equals(id)));
            db.SaveChanges();
            BindUnits();
        }
    }
}