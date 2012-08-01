using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: tmall.temai.subcats.search
    /// </summary>
    public class TmallTemaiSubcatsSearchRequest : ITopRequest<TmallTemaiSubcatsSearchResponse>
    {
        /// <summary>
        /// 父类目ID，固定是特卖前台一级类目id：50100982
        /// </summary>
        public Nullable<long> Cat { get; set; }

        #region ITopRequest Members

        public string GetApiName()
        {
            return "tmall.temai.subcats.search";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            parameters.Add("cat", this.Cat);
            return parameters;
        }

        public void Validate()
        {
            RequestValidator.ValidateRequired("cat", this.Cat);
        }

        #endregion
    }
}
