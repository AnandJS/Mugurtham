using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Mugurtham.Common.Utilities
{
    public static class Helpers
    {
        public static string primaryKey()
        {
            return Guid.NewGuid().ToString().Substring(1, 20).Replace("-", "").ToUpper();
        }
        public static string passwordGenerator()
        {
            return Guid.NewGuid().ToString().Substring(1, 5).Replace("-", "").ToUpper();
        }
    }
}
