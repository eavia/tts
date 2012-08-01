using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.rds.db.delete
    /// </summary>
    public class RdsDbDeleteRequest : ITopRequest<RdsDbDeleteResponse>
    {
        /// <summary>
        /// 数据库的ID，可以通过 taobao.rds.db.get 获取
        /// </summary>
        public Nullable<long> DbId { get; set; }

        /// <summary>
        /// rds的实例名
        /// </summary>
        public string InstanceName { get; set; }

        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.rds.db.delete";
        }

        public IDictionary<string, string> GetParameters()
        {
            TopDictionary parameters = new TopDictionary();
            parameters.Add("db_id", this.DbId);
            parameters.Add("instance_name", this.InstanceName);
            return parameters;
        }

        public void Validate()
        {
            RequestValidator.ValidateRequired("db_id", this.DbId);
            RequestValidator.ValidateRequired("instance_name", this.InstanceName);
            RequestValidator.ValidateMaxLength("instance_name", this.InstanceName, 30);
        }

        #endregion
    }
}
