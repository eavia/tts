using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.simba.campaigns.get
    /// </summary>
    public class SimbaCampaignsGetRequest : ITopRequest<SimbaCampaignsGetResponse>
    {
        /// <summary>
        /// 主人昵称
        /// </summary>
        public string Nick { get; set; }

        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.simba.campaigns.get";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            parameters.Add("nick", this.Nick);
            return parameters;
        }

        public void Validate()
        {
        }

        #endregion
    }
}
