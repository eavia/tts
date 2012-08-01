using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.simba.adgroup.catmatch.get
    /// </summary>
    public class SimbaAdgroupCatmatchGetRequest : ITopRequest<SimbaAdgroupCatmatchGetResponse>
    {
        /// <summary>
        /// 推广组Id
        /// </summary>
        public Nullable<long> AdgroupId { get; set; }

        /// <summary>
        /// 主人昵称
        /// </summary>
        public string Nick { get; set; }

        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.simba.adgroup.catmatch.get";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            parameters.Add("adgroup_id", this.AdgroupId);
            parameters.Add("nick", this.Nick);
            return parameters;
        }

        public void Validate()
        {
            RequestValidator.ValidateRequired("adgroup_id", this.AdgroupId);
        }

        #endregion
    }
}
