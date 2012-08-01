using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.simba.campaign.channeloptions.get
    /// </summary>
    public class SimbaCampaignChanneloptionsGetRequest : ITopRequest<SimbaCampaignChanneloptionsGetResponse>
    {
        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.simba.campaign.channeloptions.get";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            return parameters;
        }

        public void Validate()
        {
        }

        #endregion
    }
}
