using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.rds.db.create
    /// </summary>
    public class RdsDbCreateRequest : ITopRequest<RdsDbCreateResponse>
    {
        /// <summary>
        /// 数据库名
        /// </summary>
        public string DbName { get; set; }

        /// <summary>
        /// rds的实例名
        /// </summary>
        public string InstanceName { get; set; }

        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.rds.db.create";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            parameters.Add("db_name", this.DbName);
            parameters.Add("instance_name", this.InstanceName);
            return parameters;
        }

        public void Validate()
        {
            RequestValidator.ValidateRequired("db_name", this.DbName);
            RequestValidator.ValidateMaxLength("db_name", this.DbName, 64);
            RequestValidator.ValidateRequired("instance_name", this.InstanceName);
            RequestValidator.ValidateMaxLength("instance_name", this.InstanceName, 30);
        }

        #endregion
    }
}
