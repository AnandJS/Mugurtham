$(document).ready(function () {

    // Set a global level variable deciding weather to run all the below JSON get requests
    // If needed On Demand we may have some timer set to clear the session storage to have the APIs called 
    // in regular intervals for updated data from DB - Simply avoiding round trip to the server.
    //https://snippets.webaware.com.au/snippets/session-storage-with-expiry-time/

    /* Date.daysBetween = function (date1, date2) {
         //Get 1 day in milliseconds
         var one_day = 1000 * 60 * 60 * 24;
 
         // Convert both dates to milliseconds
         var date1_ms = date1.getTime();
         var date2_ms = date2.getTime();
 
         // Calculate the difference in milliseconds
         var difference_ms = date2_ms - date1_ms;
 
         // Convert back to days and return
         return Math.round(difference_ms / one_day);
     }*/
    if (typeof (Storage) !== "undefined") {
        /*// Save data to sessionStorage
sessionStorage.setItem('key', 'value');
// Get saved data from sessionStorage
var data = sessionStorage.getItem('key');
// Remove saved data from sessionStorage
sessionStorage.removeItem('key')*/
        /* var hasStorage = ("sessionStorage" in window && window.sessionStorage),
         storageKey = "storageKey",
         now, expiration, data = false;*/
        //Set the Initial Timer
        //alert((Date.parse('January 1, 1971 16:46') - Date.parse('January 1, 1971 15:46')) / 60000);
        //sessionStorage.SessionStartedTime.setMinutes(10);

        // Global check to avoid API service roundtrip call each time during page load
        var boolIsSessionStorageSet = sessionStorage.IsSessionStorageSet;
        if (!boolIsSessionStorageSet) {
            // Intentionally the GetAllProfiles API is kept first
            // becuase this may take some times during heavy data load
            // so the following APIs will get called Asynchroubnously

            // API Call for AllProfiles JSON
            $.getJSON("Search/Search/getAllProfiles")
        .done(function (json) {
            setSessionStorageForAllProfiles(JSON.stringify(json));
        })
        .fail(function (jqxhr, textStatus, error) {
            var err = textStatus + ", " + error;
            console.log("Request Failed: " + err);
        });

            // API Call for HighlightedProfiles JSON
            $.getJSON("Search/Search/getHighlightedProfiles")
        .done(function (json) {
            setSessionStorageForHiglightedProfiles(JSON.stringify(json));
        })
        .fail(function (jqxhr, textStatus, error) {
            var err = textStatus + ", " + error;
            console.log("Request Failed: " + err);
        });

            // API Call for InterestedInMeProfiles JSON
            $.getJSON("User/User/getInterestedInMeProfiles")
        .done(function (json) {
            setSessionStorageForInterestedInMeProfiles(JSON.stringify(json));
        })
        .fail(function (jqxhr, textStatus, error) {
            var err = textStatus + ", " + error;
            console.log("Request Failed: " + err);
        });

            // API Call for InterestedProfiles JSON
            $.getJSON("User/User/getInterestedProfiles")
        .done(function (json) {
            setSessionStorageForInterestedProfiles(JSON.stringify(json));
        })
        .fail(function (jqxhr, textStatus, error) {
            var err = textStatus + ", " + error;
            console.log("Request Failed: " + err);
        });

            // API Call for RecentlyJoinedProfiles JSON
            $.getJSON("Search/Search/GetRecentlyJoinedProfiles")
        .done(function (json) {
            setSessionStorageForRecentlyJoinedProfiles(JSON.stringify(json));
        })
        .fail(function (jqxhr, textStatus, error) {
            var err = textStatus + ", " + error;
            console.log("Request Failed: " + err);
        });
            // API Call for UserBadgeCount JSON
            $.getJSON("User/User/getUserBadgeCount")
        .done(function (json) {
            setSessionStorageForUserBadgeCount(JSON.stringify(json));
        })
        .fail(function (jqxhr, textStatus, error) {
            var err = textStatus + ", " + error;
            console.log("Request Failed: " + err);
        });
            // API Call for ViewedProfiles JSON
            $.getJSON("Search/Search/getViewedProfiles")
        .done(function (json) {
            setSessionStorageForViewedProfiles(JSON.stringify(json));
        })
        .fail(function (jqxhr, textStatus, error) {
            var err = textStatus + ", " + error;
            console.log("Request Failed: " + err);
        });

            //End of Calling API Services
            // Global variable check is set to avoid roundtrip API service calls at each page load
            sessionStorage.IsSessionStorageSet = true;
        }
        else {
            /*alert((sessionStorage.HiglightedProfiles) + 'From Session Storage');
            alert((sessionStorage.InterestedInMeProfiles) + 'From Session Storage');
            alert((sessionStorage.AllProfiles) + 'From Session Storage');
            alert((sessionStorage.HiglightedProfiles) + 'From Session Storage');
            alert((sessionStorage.InterestedInMeProfiles) + 'From Session Storage');
            alert((sessionStorage.InterestedProfiles) + 'From Session Storage');
            alert((sessionStorage.RecentlyJoinedProfiles) + 'From Session Storage');
            alert((sessionStorage.UserBadgeCount) + 'From Session Storage');
            alert((sessionStorage.ViewedProfiles) + 'From Session Storage');*/
        }
    }// Check for session storage support in browser
    else{
    }
});

function setSessionStorageForAllProfiles(jsonData) {
    if (typeof (Storage) !== "undefined") {
        if (sessionStorage.AllProfiles) {
            sessionStorage.AllProfiles = jsonData;
        } else {
            sessionStorage.AllProfiles = jsonData;
        }
    } else {
        toastr.error("Sorry, your browser does not support web storage...");
    }
}

function setSessionStorageForHiglightedProfiles(jsonData) {
    if (typeof (Storage) !== "undefined") {
        if (sessionStorage.HiglightedProfiles) {
            sessionStorage.HiglightedProfiles = jsonData;
        } else {
            sessionStorage.HiglightedProfiles = jsonData;
        }
    } else {
        toastr.error("Sorry, your browser does not support web storage...");
    }
}
function setSessionStorageForInterestedInMeProfiles(jsonData) {
    if (typeof (Storage) !== "undefined") {
        if (sessionStorage.InterestedInMeProfiles) {
            sessionStorage.InterestedInMeProfiles = jsonData;
        } else {
            sessionStorage.InterestedInMeProfiles = jsonData;
        }
    } else {
        toastr.error("Sorry, your browser does not support web storage...");
    }
}

function setSessionStorageForInterestedProfiles(jsonData) {
    if (typeof (Storage) !== "undefined") {
        if (sessionStorage.InterestedProfiles) {
            sessionStorage.InterestedProfiles = jsonData;
        } else {
            sessionStorage.InterestedProfiles = jsonData;
        }
    } else {
        toastr.error("Sorry, your browser does not support web storage...");
    }
}

function setSessionStorageForRecentlyJoinedProfiles(jsonData) {
    if (typeof (Storage) !== "undefined") {
        if (sessionStorage.RecentlyJoinedProfiles) {
            sessionStorage.RecentlyJoinedProfiles = jsonData;
        } else {
            sessionStorage.RecentlyJoinedProfiles = jsonData;
        }
    } else {
        toastr.error("Sorry, your browser does not support web storage...");
    }
}

function setSessionStorageForUserBadgeCount(jsonData) {
    if (typeof (Storage) !== "undefined") {
        if (sessionStorage.UserBadgeCount) {
            sessionStorage.UserBadgeCount = jsonData;
        } else {
            sessionStorage.UserBadgeCount = jsonData;
        }
    } else {
        toastr.error("Sorry, your browser does not support web storage...");
    }
}

function setSessionStorageForViewedProfiles(jsonData) {
    if (typeof (Storage) !== "undefined") {
        if (sessionStorage.ViewedProfiles) {
            sessionStorage.ViewedProfiles = jsonData;
        } else {
            sessionStorage.ViewedProfiles = jsonData;
        }
    } else {
        toastr.error("Sorry, your browser does not support web storage...");
    }
}




function sampleCode() {
    // Assign handlers immediately after making the request,
    // and remember the jqxhr object for this request
    var jqxhr = $.get("example.php", function (data, status) {
        setSessionStorageForHiglightedProfiles(data);
    })
      .done(function () {
      })
      .fail(function () {
      })
      .always(function () {
      });

    // Perform other work here ...

    // Set another completion function for the request above
    jqxhr.always(function () {
    });

}