using System;
using System.Xml.Serialization;

namespace Top.Api.Response
{
    /// <summary>
    /// FenxiaoOrderPriceUpdateResponse.
    /// </summary>
    public class FenxiaoOrderPriceUpdateResponse : TopResponse
    {
        /// <summary>
        /// 操作是否成功
        /// </summary>
        [XmlElement("is_success")]
        public bool IsSuccess { get; set; }
    }
}
