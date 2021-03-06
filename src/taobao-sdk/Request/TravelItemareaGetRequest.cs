using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.travel.itemarea.get
    /// </summary>
    public class TravelItemareaGetRequest : ITopRequest<TravelItemareaGetResponse>
    {
        /// <summary>
        /// 商品所属类目ID。旅游线路商品有两个值：1(国内线路类目ID)，2(国际线路类目ID)。
        /// </summary>
        public Nullable<long> Cid { get; set; }

        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.travel.itemarea.get";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            parameters.Add("cid", this.Cid);
            return parameters;
        }

        public void Validate()
        {
            RequestValidator.ValidateRequired("cid", this.Cid);
        }

        #endregion
    }
}
