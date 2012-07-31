using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.fenxiao.order.price.update
    /// </summary>
    public class FenxiaoOrderPriceUpdateRequest : ITopRequest<FenxiaoOrderPriceUpdateResponse>
    {
        /// <summary>
        /// 单位是分，多个值用","分隔。负数表示减价，正数表示加价。  adjust_fee值的个数必须和sub_order_ids个数一样
        /// </summary>
        public string AdjustFee { get; set; }

        /// <summary>
        /// 单位是分,值不能小于0,值必须在采购单可改的范围内。  post_fee和sub_order_ids  至少有一组不能为空
        /// </summary>
        public Nullable<long> PostFee { get; set; }

        /// <summary>
        /// 采购单id
        /// </summary>
        public Nullable<long> PurchaseOrderId { get; set; }

        /// <summary>
        /// 采购子单id
        /// </summary>
        public string SubOrderIds { get; set; }

        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.fenxiao.order.price.update";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            parameters.Add("adjust_fee", this.AdjustFee);
            parameters.Add("post_fee", this.PostFee);
            parameters.Add("purchase_order_id", this.PurchaseOrderId);
            parameters.Add("sub_order_ids", this.SubOrderIds);
            return parameters;
        }

        public void Validate()
        {
            RequestValidator.ValidateMinValue("post_fee", this.PostFee, 0);
            RequestValidator.ValidateRequired("purchase_order_id", this.PurchaseOrderId);
        }

        #endregion
    }
}
