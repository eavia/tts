using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.simba.keywords.get
    /// </summary>
    public class SimbaKeywordsGetRequest : ITopRequest<SimbaKeywordsGetResponse>
    {
        /// <summary>
        /// 推广组Id
        /// </summary>
        public Nullable<long> AdgroupId { get; set; }

        /// <summary>
        /// 关键词Id数组，最多200个；
        /// </summary>
        public string KeywordIds { get; set; }

        /// <summary>
        /// 主人昵称
        /// </summary>
        public string Nick { get; set; }

        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.simba.keywords.get";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            parameters.Add("adgroup_id", this.AdgroupId);
            parameters.Add("keyword_ids", this.KeywordIds);
            parameters.Add("nick", this.Nick);
            return parameters;
        }

        public void Validate()
        {
            RequestValidator.ValidateMaxListSize("keyword_ids", this.KeywordIds, 200);
        }

        #endregion
    }
}
