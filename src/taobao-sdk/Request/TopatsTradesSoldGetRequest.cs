using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.topats.trades.sold.get
    /// </summary>
    public class TopatsTradesSoldGetRequest : ITopRequest<TopatsTradesSoldGetResponse>
    {
        /// <summary>
        /// 订单创建结束时间，格式yyyyMMdd，距现在最长间隔是3个月，最近只能取昨天的时间，其中end_time - start_time <= 1个月。如20120531相当于取订单创建时间到2012-05-31 23:59:59为止的订单。注意：如果start_time和end_time相同，表示取一天的订单数据。
        /// </summary>
        public string EndTime { get; set; }

        /// <summary>
        /// Trade和Order结构体中的所有字段。<span style="color:red">如果只取tid字段，获取订单数据速度会超快。</span>
        /// </summary>
        public string Fields { get; set; }

        /// <summary>
        /// 订单创建开始时间，格式yyyyMMdd，距现在最长间隔是3个月。如：20120501相当于取订单创建时间从2012-05-01 00:00:00开始的订单。
        /// </summary>
        public string StartTime { get; set; }

        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.topats.trades.sold.get";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            parameters.Add("end_time", this.EndTime);
            parameters.Add("fields", this.Fields);
            parameters.Add("start_time", this.StartTime);
            return parameters;
        }

        public void Validate()
        {
            RequestValidator.ValidateRequired("end_time", this.EndTime);
            RequestValidator.ValidateRequired("fields", this.Fields);
            RequestValidator.ValidateRequired("start_time", this.StartTime);
        }

        #endregion
    }
}
