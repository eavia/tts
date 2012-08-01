using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.simba.adgroups.item.exist
    /// </summary>
    public class SimbaAdgroupsItemExistRequest : ITopRequest<SimbaAdgroupsItemExistResponse>
    {
        /// <summary>
        /// 推广计划Id
        /// </summary>
        public Nullable<long> CampaignId { get; set; }

        /// <summary>
        /// 商品Id
        /// </summary>
        public Nullable<long> ItemId { get; set; }

        /// <summary>
        /// 主人昵称
        /// </summary>
        public string Nick { get; set; }

        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.simba.adgroups.item.exist";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            parameters.Add("campaign_id", this.CampaignId);
            parameters.Add("item_id", this.ItemId);
            parameters.Add("nick", this.Nick);
            return parameters;
        }

        public void Validate()
        {
            RequestValidator.ValidateRequired("campaign_id", this.CampaignId);
            RequestValidator.ValidateRequired("item_id", this.ItemId);
        }

        #endregion
    }
}
