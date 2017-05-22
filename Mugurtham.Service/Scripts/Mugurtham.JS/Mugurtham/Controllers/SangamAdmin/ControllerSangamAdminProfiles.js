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
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR ALL-PROFILES PAGE ON SEARCH MODULE
==========================================================================================
*/
var ControllerSearchAllProfiles = angular.module('MugurthamApp').controller('ControllerSangamAdminProfiles',
        ['$http', '$scope', '$filter', function ($http, $scope, $filter) {

            $scope.ControllerName = 'ControllerSangamAdminProfiles';
            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            $scope.getAllProfilesBySangam = function () {
                var strGetURL = "Search/Search/getAllProfilesBySangam";
                $("#divContainer").mask("Searching profiles please wait...");
                $http({
                    method: "GET", url: strGetURL,
                    headers: {
                        'content-Type': 'application/x-www-form-urlencoded',
                        "MugurthamUserToken": getLoggedInUserID(),
                        "CommunityID": getLoggedInUserCommunityID()
                    }
                }).
            success(function (data, status, headers, config) {
                $("#divContainer").unmask();
                $scope.AllProfiles = data;
                $scope.currentPage = 1;
                $scope.pageSize = 15;
                $scope.SearchedProfiles = data.ProfileBasicInfoViewCoreEntityList;
                $scope.pageChangeHandler = function (num) {
                    $("html, body").animate({ scrollTop: 220 }, "slow");
                    setTimeout(displayThumbnailSlider, 10);
                    console.log('Profiles page changed to ' + num);
                };
                setTimeout(displayThumbnailSlider, 10);
            }).
                error(function (data, status, headers, config) {
                    $("#divContainer").unmask();
                    NotifyStatus('2');
                });
            }

            $scope.setProfileIDBySangamAdminForProfilePic = function (ProfileID) {
                localStorage.setItem("ProfileIDBySangamAdminForProfilePic", ProfileID);
            }
        }])


function NotifyStatus(intStatus) {
    /*
         1-> Success
         2-> Error
    */
    if (intStatus == '1') {
        toastr.success('Profiles Received Successfully');
    }
    else if (intStatus == '2') {
        toastr.Error('Error occured in ControllerSearchAllProfiles - getData');
    }
}
