/*************************************************************************
 * Copyright (C) 2015 Mugurtham Technology, Incorporated 
 * All Rights Reserved.
 * 
 * NOTICE:  All the intellectual and technical concepts contained
 * herein are proprietary to Mugurtham Technology, Incorporated
 * and may be covered by Indian and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Mugurtham Technology, Incorporated.
/*************************************************************************
/*
This Learning controller is the global Mugurtham controller for global operations
*/


/*app.controller('Ctrl', function ($scope, $translate) {
  $scope.changeLanguage = function (key) {
    $translate.use(key);
  };*/
function displayThumbnailSlider() {
    if ($(".flexslider")[0]) {
        $('.flexslider').flexslider({
            animation: "slide",
            controlsContainer: $(".custom-controls-container"),
            customDirectionNav: $(".custom-navigation a"),
            start: function (slider) {
            }
        })
    }
}
function displaySimilarPofilesSlider() {
    if ($(".flexslider")[0]) {
        $('.flexslider').flexslider({
            animation: "slide",
            pauseOnHover: true,
            minItems: 2,
            maxItems: 5,
            itemWidth: 150,
            itemMargin: 0,
            controlsContainer: $(".custom-controls-container"),
            customDirectionNav: $(".custom-navigation a"),
            start: function (slider) {
            }
        })
    }
}
var MugurthamController = angular.module('MugurthamApp').
    run(function ($rootScope) {
        $rootScope.globalProfileID = '';
        $rootScope.HomePageLink = 'ProfileID';
    }).
    controller('MugurthamController', ['$http', '$scope', '$location', '$translate',
         function ($http, $scope, $location, $translate) {
             // Global loggedIn User object with full details called only once at login
             // and during page refreshes, which should not supposed to happen
             getLoggedInUserInfo($http);
             //Global Call once to set the session
             setSessionData();
             //==================
             //HIGHLIGHT CLICKED TAB
             //==================
             $scope.setActiveTab = function (tabID) {
                 $('#navBarProfile li').removeClass('active');
                 $('#' + tabID).parent().addClass('active');
             }

             $scope.sangamName = 'Viswakarma Sangam';
             $scope.globalProfileID = '';
             // Switching Theme
             $('#ddlThemes > li').on("click", function (event) {
                 $("#stylesheet").attr({ href: $('#' + event.target.id).attr('cssurl') });
                 $("#ddlThemes > li").removeClass("active");
                 $('#' + event.target.id).parent().addClass("active");
                 //$('#aSelectStyle').html(event.target.id);
             });
             // Switching Locale
             $('#ddlLocale > li').on("click", function (event) {
                 $translate.use($('#' + event.target.id).attr('localeid'));
                 $("#ddlLocale > li").removeClass("active");
                 $('#' + event.target.id).parent().addClass("active");
             });


             /************TRANSALATE SETS ON PAGE LOAD ************************/
             $scope.changeLanguage = function (key) {
                 // Set loggedin user locale
                 $translate.use(key);
                 $("#ddlLocale > li").removeClass("active");
                 $('#' + key).parent().addClass("active");
             };





             /*============================================SEARCH GLOBAL FILTER PANEL=================================*/
             //http://stackoverflow.com/questions/14514461/how-to-bind-to-list-of-checkbox-values-with-angularjs
             $scope.arrFilterSubCaste = ['Avusula', 'Kai Kolar', 'Kammari', 'Kanchari', 'Shipi', 'Vadrangi', 'Kamalar', 'Achari'];
             $scope.arrFilterStar = ['Anusham', 'Aswini', 'Avittam', 'Aayilyam', 'Bharani', 'Chithirai', 'Hastham', 'Karthigai', 'Kettai', 'Makam', 'Moolam', 'Mrigasheersham', 'Pooraadam', 'Pooram', 'Poorattathi', 'Poosam', 'Punarpoosam', 'Revathi', 'Rohini', 'Sadayam', 'Swaathi', 'Thiruvaathirai', 'Thiruvonam', 'Uthiraadam', 'Uthiram', 'Uthirattathi', 'Visaakam'];

             /*============================================SEARCH GLOBAL FILTER PANEL ENDS=================================*/


         }])


function setUserStyleLocale(themeID) {
    // Set loggedin user style
    $("#stylesheet").attr({ href: $('#' + themeID).attr('cssurl') });
    $("#ddlThemes > li").removeClass("active");
    $('#' + themeID).parent().addClass("active");
}

function NotifySuccessStatus(intStatus) {
    if (intStatus == '1') {
        toastr.success('BasicInfo created successfully');
    }
    else if (intStatus == '2') {
        toastr.success('BasicInfo updated successfully');
    }
    else if (intStatus == '3') {
        toastr.success('Career updated successfully');
    }
    else if (intStatus == '4') {
        toastr.success('Contact updated successfully');
    }
    else if (intStatus == '5') {
        toastr.success('Family updated successfully');
    }
    else if (intStatus == '6') {
        toastr.success('Horoscope updated successfully');
    }
    else if (intStatus == '7') {
        toastr.success('Location updated successfully');
    }
    else if (intStatus == '8') {
        toastr.success('Reference updated successfully');
    }
    else if (intStatus == '9') {
        toastr.success('User added successfully');
    }
    else if (intStatus == '10') {
        toastr.success('User updated successfully');
    }
    else if (intStatus == '11') {
        toastr.success('Role added successfully');
    }
    else if (intStatus == '12') {
        toastr.success('Role updated successfully');
    }
    else if (intStatus == '13') {
        toastr.success('Sangam added successfully');
    }
    else if (intStatus == '14') {
        toastr.success('Sangam updated successfully');
    }
    else if (intStatus == '15') {
        toastr.success('Interest shown on this profile successfully');
    }
    else if (intStatus == '16') {
        toastr.success('Interest removed on this profile successfully');
    }
    else if (intStatus == '17') {
        toastr.success('Profile picture updated successfully');
    }
    else if (intStatus == '18') {
        toastr.success('Profile picture deleted successfully');
    }

}
function NotifyErrorStatus(data, status) {
    toastr.error(status + ' : ' + data.Message);
}

//This method listens to open the Modal window only when loggedin first time
function landingPageCounter() {
    if (typeof (Storage) !== "undefined") {
        if (localStorage.getItem("landingFirstTimeCount")) {
            if (Number(localStorage.getItem("landingFirstTimeCount")) == 0) {
                $('#squarespaceModal').modal('show');
                $('#MugurthamModal').modal('show');
                localStorage.setItem("landingFirstTimeCount", "1");
            }
        }
    } else {
        toastr.error("Sorry, your browser does not support web storage...");
    }
}

// Global Function to retrieve the loggedIn user from the client side
function getLoggedInUserID() {
    var LoggedInUserID;
    if (typeof (Storage) !== "undefined") {
        if (localStorage.getItem("LoggedInUserID")) {
            LoggedInUserID = localStorage.getItem("LoggedInUserID");
        }
    }
    else {
        toastr.error("Sorry, your browser does not support web storage...");
    }
    return LoggedInUserID;
}


// Global Function to retrieve the loggedIn user information from the client side
function getLoggedInUserInfo($http) {
    LoggedInUserInfo = '';
    var strGetURL = "Search/Search/getByProfileID";
    $http({
        method: "GET", url: strGetURL, params: { ProfileID: getLoggedInUserID() }
    }).
success(function (data, status, headers, config) {
    //alert(data.BasicInfoCoreEntity.Star);
    if (typeof (Storage) !== "undefined") {
        localStorage.setItem("LoggedInUser", JSON.stringify(data));
    }
    else {
        toastr.error("Sorry, your browser does not support web storage...");
    }

}).
    error(function (data, status, headers, config) {
    });
    return LoggedInUserInfo;
}