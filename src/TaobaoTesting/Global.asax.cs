using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace TaobaoTesting
{
    public class Global : System.Web.HttpApplication
    {
        static string _appKey;

        public static string AppKey
        {
            get { return Global._appKey; }
        }
        static string _appSecret;

        public static string AppSecret
        {
            get { return Global._appSecret; }
        }
        static string _apiAddress;

        public static string ApiAddress
        {
            get { return Global._apiAddress; }
        }

        void Application_Start(object sender, EventArgs e)
        {
            // 在应用程序启动时运行的代码
            _appKey=System.Configuration.ConfigurationManager.AppSettings["appKey"];
            _appSecret = System.Configuration.ConfigurationManager.AppSettings["appSecret"];
            _apiAddress = System.Configuration.ConfigurationManager.AppSettings["apiAddress"]; 
        }

        void Application_End(object sender, EventArgs e)
        {
            //  在应用程序关闭时运行的代码

        }

        void Application_Error(object sender, EventArgs e)
        {
            // 在出现未处理的错误时运行的代码

        }

        void Session_Start(object sender, EventArgs e)
        {
            // 在新会话启动时运行的代码
        }

        void Session_End(object sender, EventArgs e)
        {
            // 在会话结束时运行的代码。 
            // 注意: 只有在 Web.config 文件中的 sessionstate 模式设置为
            // InProc 时，才会引发 Session_End 事件。如果会话模式设置为 StateServer 
            // 或 SQLServer，则不会引发该事件。

        }

    }
}
