using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.simba.campaign.area.get
    /// </summary>
    public class SimbaCampaignAreaGetRequest : ITopRequest<SimbaCampaignAreaGetResponse>
    {
        /// <summary>
        /// 推广计划Id
        /// </summary>
        public Nullable<long> CampaignId { get; set; }

        /// <summary>
        /// 主人昵称
        /// </summary>
        public string Nick { get; set; }

        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.simba.campaign.area.get";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            parameters.Add("campaign_id", this.CampaignId);
            parameters.Add("nick", this.Nick);
            return parameters;
        }

        public void Validate()
        {
            RequestValidator.ValidateRequired("campaign_id", this.CampaignId);
        }

        #endregion
    }
}
