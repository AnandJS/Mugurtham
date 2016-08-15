using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mugurtham.Common.Utilities
{
    public static class AsyncLogger
    {
        private static readonly log4net.ILog objLog =
        log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public static int Debug(string strDebug)
        {
            objLog.Info("===============================================================================" + "\r\n");
            Task.Run(() => objLog.Debug(strDebug));
            objLog.Info("*********************************************************************************" + "\r\n");
            return 0;
        }

        public static int Info(string strInformation)
        {
            objLog.Info("===============================================================================" + "\r\n");
            Task.Run(() => objLog.Debug(strInformation));
            objLog.Info("*********************************************************************************" + "\r\n");
            return 0;
        }

        public static int Error(string strError)
        {
            objLog.Info("===============================================================================" + "\r\n");
            Task.Run(() => objLog.Debug(strError));
            objLog.Info("*********************************************************************************" + "\r\n");
            return 0;
        }

        public static int Fatal(string strFatal)
        {
            objLog.Info("===============================================================================" + "\r\n");
            Task.Run(() => objLog.Debug(strFatal));
            objLog.Info("*********************************************************************************" + "\r\n");
            return 0;
        }
    }
}
