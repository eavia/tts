using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.simba.adgroupids.changed.get
    /// </summary>
    public class SimbaAdgroupidsChangedGetRequest : ITopRequest<SimbaAdgroupidsChangedGetResponse>
    {
        /// <summary>
        /// 主人昵称
        /// </summary>
        public string Nick { get; set; }

        /// <summary>
        /// 返回的第几页数据，默认为1
        /// </summary>
        public Nullable<long> PageNo { get; set; }

        /// <summary>
        /// 返回的每页数据量大小,默认200最大1000
        /// </summary>
        public Nullable<long> PageSize { get; set; }

        /// <summary>
        /// 得到此时间点之后的数据，不能大于一个月
        /// </summary>
        public Nullable<DateTime> StartTime { get; set; }

        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.simba.adgroupids.changed.get";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            parameters.Add("nick", this.Nick);
            parameters.Add("page_no", this.PageNo);
            parameters.Add("page_size", this.PageSize);
            parameters.Add("start_time", this.StartTime);
            return parameters;
        }

        public void Validate()
        {
            RequestValidator.ValidateMinValue("page_no", this.PageNo, 1);
            RequestValidator.ValidateMaxValue("page_size", this.PageSize, 1000);
            RequestValidator.ValidateMinValue("page_size", this.PageSize, 1);
            RequestValidator.ValidateRequired("start_time", this.StartTime);
        }

        #endregion
    }
}
