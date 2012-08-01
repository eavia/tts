using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LogicLibary;

namespace TaobaoTesting
{
    public partial class Function : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindOrder();
            }
            if (!string.IsNullOrEmpty(this.Request.QueryString["sid"] ?? ""))
            {
                SelectedGoods(this.Request.QueryString["sid"]);
            }
        }

        private void SelectedGoods(string sid)
        {
            int goods = -1;
            if (int.TryParse(sid, out goods))
            {
                
            }
        }

        protected void btnCrateOrder_Click(object sender, EventArgs e)
        {
            StoreEntities db = new StoreEntities();
            OrderHead head = db.OrderHeadSet.CreateObject();
            head.Buyer = txtBuyer.Text.Trim();
            db.AddToOrderHeadSet(head);
            db.SaveChanges();
            lblOrderId.Text = head.ID.ToString();
            BindOrder();
        }

        private void BindOrder()
        {
            StoreEntities db = new StoreEntities();
            this.dlOrders.DataSource = db.OrderHeadSet;
            this.dlOrders.DataBind();
        }

        protected void dlOrders_ItemCommand(object source, DataListCommandEventArgs e)
        {
            LinkButton arg = (LinkButton)e.CommandSource;
            if (arg.CommandName.Equals("Pay"))
            {
                int orderid = int.Parse(arg.CommandArgument.ToString());
                StoreEntities db = new StoreEntities();
                OrderHead order = db.OrderHeadSet.Single(x => x.ID.Equals(orderid));
                if (order.Status == "SUCCESS")
                {
                    return;
                }
                SortedDictionary<string, string> Paramers = new SortedDictionary<string, string>();
                Paramers.Add("out_trade_no", orderid.ToString());
                Paramers.Add("subject", "订单ID:"+ order.ID.ToString());
                Paramers.Add("payment_type", "1");
                Paramers.Add("logistics_type", "EXPRESS");
                Paramers.Add("logistics_fee","0");
                Paramers.Add("logistics_payment", "SELLER_PAY");
                Paramers.Add("price", "0.01");
                Paramers.Add("quantity", "1");
                Service ali = new Service();
                string sHtmlText = ali.Create_partner_trade_by_buyer(Paramers);
                Response.Write(sHtmlText);
            }
        }

        protected void btnGoods_Click(object sender, EventArgs e)
        {
            this.Response.Redirect("GoodsList.aspx", true);
        }
        protected void btnUnit_Click(object sender, EventArgs e)
        {
            this.Response.Redirect("UnitList.aspx", true);
        }
    }
}