﻿/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR DISPLAYING VIEWED PROFILES IN USER HOME PAGE
==========================================================================================
*/
var ControllerRecentlyViewedProfiles = angular.module('MugurthamApp').controller('ControllerRecentlyViewedProfiles',
        ['$http', '$scope', function ($http, $scope) {

            $scope.ControllerName = 'ControllerRecentlyViewedProfiles';
            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            $scope.getRecentlyViewedProfiles = function () {
                if (typeof (Storage) !== "undefined") {
                    if ((!sessionStorage.getItem('RecentlyViewedProfiles')))
                        $scope.getRecentlyViewedProfilesfromAPI();
                    else
                        $scope.getRecentlyViewedProfilesfromSession();
                }
                else
                    $scope.getRecentlyViewedProfilesfromAPI();
            }

            $scope.getRecentlyViewedProfilesfromSession = function () {
                if ((sessionStorage.getItem('RecentlyViewedProfiles')))
                    $scope.initData(JSON.parse(sessionStorage.getItem('RecentlyViewedProfiles')));
            }
            $scope.getRecentlyViewedProfilesfromAPI = function () {
                var strGetURL = "Search/Search/getRecentlyViewedProfiles";
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
                $scope.AllProfiles = data;
                $scope.currentPage = 1;
                $scope.pageSize = 15;
                $scope.SearchedProfiles = data.ProfileBasicInfoViewCoreEntityList;
                $scope.pageChangeHandler = function (num) {
                    $("html, body").animate({ scrollTop: 220 }, "slow");
                    setTimeout(displayThumbnailSlider, 1000);
                    console.log('Profiles page changed to ' + num);
                };
                setTimeout(displayThumbnailSlider, 1000);
                toastr.success('Recently Viewed Profiles loaded Successfully');
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
        toastr.Error('Error occured in ControllerRecentlyViewedProfiles - getData');
    }
}