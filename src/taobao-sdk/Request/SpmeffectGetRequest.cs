using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.spmeffect.get
    /// </summary>
    public class SpmeffectGetRequest : ITopRequest<SpmeffectGetResponse>
    {
        /// <summary>
        /// 日期
        /// </summary>
        public string Date { get; set; }

        /// <summary>
        /// 查询指定的SPM第四位的效果报表。默认值为false，不传视为不需要
        /// </summary>
        public Nullable<bool> ModuleDetail { get; set; }

        /// <summary>
        /// 查询指定的SPM第三位的效果报表。默认值为false，不传视为不需要
        /// </summary>
        public Nullable<bool> PageDetail { get; set; }

        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.spmeffect.get";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            parameters.Add("date", this.Date);
            parameters.Add("module_detail", this.ModuleDetail);
            parameters.Add("page_detail", this.PageDetail);
            return parameters;
        }

        public void Validate()
        {
            RequestValidator.ValidateRequired("date", this.Date);
        }

        #endregion
    }
}
