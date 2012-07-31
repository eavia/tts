using System;
using System.Collections.Generic;
using Top.Api.Response;
using Top.Api.Util;

namespace Top.Api.Request
{
    /// <summary>
    /// TOP API: taobao.simba.customers.authorized.get
    /// </summary>
    public class SimbaCustomersAuthorizedGetRequest : ITopRequest<SimbaCustomersAuthorizedGetResponse>
    {
        #region ITopRequest Members

        public string GetApiName()
        {
            return "taobao.simba.customers.authorized.get";
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
