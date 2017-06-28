using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Twilio;
using Twilio.Rest.Api.V2010.Account;
using Twilio.Types;



namespace Mugurtham.Common.Utilities
{
    public class Notifications
    {
        public int sendSMS()
        {
            try
            {
                var accountSid = "AC194a875ea62f4ccaba8400b3df223acd";
                // Your Auth Token from twilio.com/console
                var authToken = "4234556c7698862e49c7ac8867c3443f";

                TwilioClient.Init(accountSid, authToken);

                var message = MessageResource.Create(
                    to: new PhoneNumber("+19522974157"),
                    from: new PhoneNumber("+19522220256"),
                    body: "Hello from Common DLL");

                Console.WriteLine(message.Sid);
                Console.Write("Press any key to continue.");
                Console.ReadKey();
            }
            catch (Exception objEx)
            {
                Helpers.LogExceptionInFlatFile(objEx);
            }
            return 0;
        }
    }
}
