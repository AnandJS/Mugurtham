﻿






function setSessionData() {
   
    if (typeof (Storage) !== "undefined") {

        // Global check to avoid API service roundtrip call each time during page load
        var boolIsSessionStorageSet = sessionStorage.getItem('IsSessionStorageSet');

        if (!boolIsSessionStorageSet) {


            // API Call for HighlightedProfiles JSON
            $.getJSON("Search/Search/getHighlightedProfiles")
        .done(function (jsonObject) {
            sessionStorage.setItem('HiglightedProfiles', JSON.stringify(jsonObject));
        })
        .fail(function (jqxhr, textStatus, error) {
        });

            // API Call for InterestedInMeProfiles JSON
            $.getJSON("User/User/getInterestedInMeProfiles")
        .done(function (jsonObject) {
            sessionStorage.setItem('InterestedInMeProfiles', JSON.stringify(jsonObject));
        })
        .fail(function (jqxhr, textStatus, error) {
        });

            // API Call for InterestedProfiles JSON
            $.getJSON("User/User/getInterestedProfiles")
        .done(function (jsonObject) {
            sessionStorage.setItem('InterestedProfiles', JSON.stringify(jsonObject));
        })
        .fail(function (jqxhr, textStatus, error) {
        });

            // API Call for RecentlyJoinedProfiles JSON
            $.getJSON("Search/Search/GetRecentlyJoinedProfiles")
        .done(function (jsonObject) {
            sessionStorage.setItem('RecentlyJoinedProfiles', JSON.stringify(jsonObject));
        })
        .fail(function (jqxhr, textStatus, error) {
        });
            // API Call for UserBadgeCount JSON
            $.getJSON("User/User/getUserBadgeCount")
        .done(function (jsonObject) {
            sessionStorage.setItem('UserBadgeCount', JSON.stringify(jsonObject));
        })
        .fail(function (jqxhr, textStatus, error) {
        });
            // API Call for ViewedProfiles JSON
            $.getJSON("Search/Search/getViewedProfiles")
        .done(function (jsonObject) {
            sessionStorage.setItem('ViewedProfiles', JSON.stringify(jsonObject));
        })
        .fail(function (jqxhr, textStatus, error) {
        });
            // API Call for Recently Viewed Profiles JSON
            $.getJSON("Search/Search/getRecentlyViewedProfiles")
        .done(function (jsonObject) {
            sessionStorage.setItem('RecentlyViewedProfiles', JSON.stringify(jsonObject));
        })
        .fail(function (jqxhr, textStatus, error) {
        });
            //End of Calling API Services
            // Global variable check is set to avoid roundtrip API service calls at each page load
            sessionStorage.setItem('IsSessionStorageSet', true);
        }
        else {
            /*alert((sessionStorage.getItem('AllProfiles')) + 'From Session Storage1');
            alert((sessionStorage.getItem('HiglightedProfiles')) + 'From Session Storage2');
            alert((sessionStorage.getItem('InterestedInMeProfiles')) + 'From Session Storage3');*/
        }

        // Intentionally the GetAllProfiles API is kept first
        // becuase this may take some times during heavy data load
        // so the following APIs will get called Asynchroubnously

        // API Call for AllProfiles BasicInfo JSON
        $.getJSON("Search/Search/getAllProfiles")
    .done(function (jsonObject) {
        sessionStorage.setItem('AllProfiles', JSON.stringify(jsonObject));
    })
    .fail(function (jqxhr, textStatus, error) {
    });
        // API Call for AllProfiles BasicInfo Photo JSON
        $.getJSON("Search/Search/getAllProfilesPhoto")
    .done(function (jsonObject) {
        sessionStorage.setItem('AllProfilesPhoto', JSON.stringify(jsonObject));
    })
    .fail(function (jqxhr, textStatus, error) {
    });
    }// Check for session storage support in browser
};


function removeSessionData() {
    sessionStorage.removeItem('IsSessionStorageSet');
    sessionStorage.removeItem('AllProfiles');
    sessionStorage.removeItem('AllProfilesPhotos');
    sessionStorage.removeItem('HiglightedProfiles');
    sessionStorage.removeItem('InterestedProfiles');
    sessionStorage.removeItem('InterestedInMeProfiles');
    sessionStorage.removeItem('RecentlyJoinedProfiles');
    sessionStorage.removeItem('UserBadgeCount');
    sessionStorage.removeItem('ViewedMeProfiles');
    sessionStorage.removeItem('RecentlyViewedProfiles');
    sessionStorage.removeItem('LoggedInUserID');
    sessionStorage.removeItem('AstrologicalMatchers');
    sessionStorage.removeItem('MyMatchingProfilesBadgeCount');
    sessionStorage.removeItem('AllProfilesPhotosSearch');

    //AllProfilesPhotosSearch
};