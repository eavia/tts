using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Top.Api;
using Top.Api.Request;
using Top.Api.Response;
using System.Text;
namespace TaobaoTesting
{
    public partial class _Default : System.Web.UI.Page
    {
        DefaultTopClient client = new DefaultTopClient(TaobaoTesting.Global.ApiAddress, TaobaoTesting.Global.AppKey
, TaobaoTesting.Global.AppSecret);
        string SessionKey;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //SessionKey = (Session["SessionKey"] ?? "NaN").ToString();
                //if (SessionKey.Equals("NaN"))
                //{
                //    HttpCookie coo = Request.Cookies["SessionKeyCoo"];
                //    if (coo != null)
                //    {
                //        Session.Add("SessionKey", coo.Value);
                //        SessionKey = coo.Value;
                //    }
                //    if (string.IsNullOrEmpty(SessionKey) || SessionKey == "NaN")
                //    {
                //        StringBuilder path = new StringBuilder(@"http://container.api.tbsandbox.com/container?appkey={appkey}&encode=utf-8 ");
                //        path.Replace("{appkey}", TaobaoTesting.Global.AppKey);
                //        Response.Redirect(path.ToString());
                //    }
                //}
                //else
                //{
                //    HttpCookie coo = new HttpCookie("SessionKeyCoo");
                //    coo.Value = SessionKey;
                //    coo.Expires = DateTime.Now.AddMinutes(5);
                //    Response.Cookies.Add(coo);
                //}
            }
        }

        private void GetGoods()
        {
            ITopClient client = new DefaultTopClient(TaobaoTesting.Global.ApiAddress, TaobaoTesting.Global.AppKey
, TaobaoTesting.Global.AppSecret);
            TradesSoldGetRequest req = new TradesSoldGetRequest();
            req.Fields = "seller_nick,buyer_nick,title,type,created,sid,tid,seller_rate,buyer_rate,status,payment,discount_fee,adjust_fee,post_fee,total_fee,pay_time,end_time,modified,consign_time,buyer_obtain_point_fee,point_fee,real_point_fee,received_payment,commission_fee,pic_path,num_iid,num_iid,num,price,cod_fee,cod_status,shipping_type,receiver_name,receiver_state,receiver_city,receiver_district,receiver_address,receiver_zip,receiver_mobile,receiver_phone,orders.title,orders.pic_path,orders.price,orders.num,orders.iid,orders.num_iid,orders.sku_id,orders.refund_status,orders.status,orders.oid,orders.total_fee,orders.payment,orders.discount_fee,orders.adjust_fee,orders.sku_properties_name,orders.item_meal_name,orders.buyer_rate,orders.seller_rate,orders.outer_iid,orders.outer_sku_id,orders.refund_id,orders.seller_type";
            TradesSoldGetResponse response = client.Execute(req, SessionKey);
        }

        private void TestShipping()
        {
            ITopClient client = new DefaultTopClient(TaobaoTesting.Global.ApiAddress, TaobaoTesting.Global.AppKey
, TaobaoTesting.Global.AppSecret);
            LogisticsTraceSearchRequest req = new LogisticsTraceSearchRequest();
            req.Tid = 92062670026941L;
            req.SellerNick = "sandbox_c_20";
            LogisticsTraceSearchResponse response = client.Execute(req);
        }

        private string GetUserInfo(string nickname)
        {
            UserGetRequest req = new UserGetRequest();
            req.Fields = ("user_id,uid,nick,sex,buyer_credit,seller_credit,location,created,last_visit,birthday,type,status,alipay_no,alipay_account,alipay_account,email,consumer_protection,alipay_bind");
            //req.Nick = "sandbox_c_20";
            req.Nick = nickname;
            UserGetResponse response = client.Execute(req, SessionKey);
            return response.Body;
        }
    }
}
