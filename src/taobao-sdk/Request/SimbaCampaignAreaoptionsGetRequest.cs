using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.simba.campaign.areaoptions.get
    /// </summary>
    public class SimbaCampaignAreaoptionsGetRequest : ITopRequest<SimbaCampaignAreaoptionsGetResponse>
    {
        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.simba.campaign.areaoptions.get";
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
