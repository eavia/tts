using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.simba.keywords.price.set
    /// </summary>
    public class SimbaKeywordsPriceSetRequest : ITopRequest<SimbaKeywordsPriceSetResponse>
    {
        /// <summary>
        /// 推广组Id（暂时无用，为了兼容新老接口暂时保留）
        /// </summary>
        public Nullable<long> AdgroupId { get; set; }

        /// <summary>
        /// 关键词Id出价字符串和匹配方式字符串数组，最多200个;  每个字符串：keywordId+  ”^^”+price+”^^”+matchscope；  Price是整数，以“分”为单位，不能小于5，不能大于日限额; 如果该词为无展现词，出价需要大于原来出价，才会生效。  price为0则设置为使用默认出价；  matchscope只能是1,2,4 (1代表精确匹配，2代表子串匹配，4代表广泛匹配) 可不传  例如102232^^85，102231^^82^^4
        /// </summary>
        public string KeywordidPrices { get; set; }

        /// <summary>
        /// 主人昵称
        /// </summary>
        public string Nick { get; set; }

        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.simba.keywords.price.set";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            parameters.Add("adgroup_id", this.AdgroupId);
            parameters.Add("keywordid_prices", this.KeywordidPrices);
            parameters.Add("nick", this.Nick);
            return parameters;
        }

        public void Validate()
        {
            RequestValidator.ValidateRequired("keywordid_prices", this.KeywordidPrices);
            RequestValidator.ValidateMaxListSize("keywordid_prices", this.KeywordidPrices, 200);
        }

        #endregion
    }
}
