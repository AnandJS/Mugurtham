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
THIS CONTROLLER IS SPECIFICALLY FOR RECENTLY JOINED PROFILES BY LASTWEEK IN USER HOME PAGE
==========================================================================================
*/
var ControllerRecentlyJoined = angular.module('MugurthamApp').controller('ControllerRecentlyJoined',
        ['$http', '$scope', function ($http, $scope) {


            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================

            $scope.getRecentlyJoinedProfiles = function () {
                if (typeof (Storage) !== "undefined") {
                    if ((!sessionStorage.getItem('RecentlyJoinedProfiles')))
                        $scope.getRecentlyJoinedProfilesfromAPI();
                    else
                        $scope.getRecentlyJoinedProfilesfromSession();
                }
                else
                    $scope.getRecentlyJoinedProfilesfromAPI();
            }

            $scope.getRecentlyJoinedProfilesfromSession = function () {                
                if ((sessionStorage.getItem('RecentlyJoinedProfiles')))
                    $scope.initData(JSON.parse(sessionStorage.getItem('RecentlyJoinedProfiles')));
            }
            $scope.getRecentlyJoinedProfilesfromAPI = function () {
                var strGetURL = "Search/Search/GetRecentlyJoinedProfiles";
                $("#divContainer").mask("Searching profiles please wait...");
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $("#divContainer").unmask();
                $scope.initData(data);
            }).
                error(function (data, status, headers, config) {
                    $("#divContainer").unmask();
                    NotifyStatus('2');
                });
            }

            $scope.initData = function (data) {
                $scope.AllProfiles = $.parseJSON(sessionStorage.RecentlyJoinedProfiles);
                $scope.currentPage = 1;
                $scope.pageSize = 15;
                $scope.SearchedProfiles = ($.parseJSON(sessionStorage.RecentlyJoinedProfiles).ProfileBasicInfoViewCoreEntityList);
                $scope.profilePhotos = ($.parseJSON(sessionStorage.RecentlyJoinedProfiles).PhotoCoreEntityList);
                $scope.pageChangeHandler = function (num) {
                    $("html, body").animate({ scrollTop: 220 }, "slow");                    
                    setTimeout(displayThumbnailSlider, 10);
                    console.log('Profiles page changed to ' + num);
                };
                setTimeout(displayThumbnailSlider, 10);
                toastr.success('Recently Profiles loaded Successfully');
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
        toastr.Error('Error occured in ControllerHighlightedProfiles - getData');
    }
}


