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
var ControllerSearchAllProfiles = angular.module('MugurthamApp').controller('ControllerSearchAllProfiles',
        ['$http', '$scope', '$filter', '$timeout', function ($http, $scope, $filter, $timeout) {

            $scope.ControllerName = 'ControllerSearchAllProfiles';
            $scope.filter = {};
            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            $scope.getAllProfiles = function () {
                if (typeof (Storage) !== "undefined") {
                    if ((!sessionStorage.getItem('AllProfiles')))
                        $scope.getAllProfilesfromAPI();
                    else
                        $scope.getAllProfilesfromSession();
                }
                else
                    $scope.getAllProfilesfromAPI();
            }

            $scope.getAllProfilesfromSession = function () {
                if ((sessionStorage.getItem('AllProfiles')))
                    $scope.initData();
            }
            $scope.getAllProfilesfromAPI = function () {
                var strGetURL = "Search/Search/getAllProfiles";
                $("#divContainer").mask("Searching profiles please wait...");
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $("#divContainer").unmask();
                initData();
            }).
                error(function (data, status, headers, config) {
                    $("#divContainer").unmask();
                    NotifyStatus('2');
                });
            }

            $scope.initData = function () {
                //$scope.AllProfiles = data;
                try
                {
                    $scope.currentPage = 1;
                    $scope.pageSize = 15;
                    $scope.SearchedProfiles = JSON.parse(sessionStorage.getItem('AllProfiles')).data;
                    $scope.profilePhotos = JSON.parse(sessionStorage.getItem('AllProfilesPhotosSearch')).data;
                }
                catch(err)
                {
                    toastr.error(err.message);
                }
               // $scope.lazyLoadData(data);
            }

            /*==========================Lazy loading custom logic starts==============================*/

            $scope.lazyLoadData = function (data) {
                var loadAll;
                //Give a max of 40 rows to the view
                if (data.ProfileBasicInfoViewCoreEntityList.length > 1000) {
                    $scope.dataView = data.ProfileBasicInfoViewCoreEntityList.slice(0, 1000);
                    $scope.photoView = data.PhotoCoreEntityList.slice(0, 1000);
                } else {
                    $scope.dataView = data.ProfileBasicInfoViewCoreEntityList;
                    $scope.photoView = data.PhotoCoreEntityList;
                }
                //Cancel previous deferred function
                if (loadAll !== undefined) {
                    $timeout.cancel(loadAll);
                }
                $scope.SearchedProfiles = $scope.dataView;
                $scope.profilePhotos = $scope.photoView;
                //Will load all the rest of data after 1.5s
                loadAll = $timeout(function () {
                    $scope.SearchedProfiles = data.ProfileBasicInfoViewCoreEntityList;
                    $scope.profilePhotos = data.PhotoCoreEntityList;
                }, 5000);
            };
            /*==========================Lazy loading custom logic ends==============================*/

            $scope.pageChangeHandler = function (num) {
                $("html, body").animate({ scrollTop: 220 }, "slow");
                setTimeout(displayThumbnailSlider, 10);
                console.log('Profiles page changed to ' + num);
            };
            setTimeout(displayThumbnailSlider, 10);


            $scope.setProfileIDBySangamAdminForProfilePic = function (ProfileID) {
                localStorage.setItem("ProfileIDBySangamAdminForProfilePic", ProfileID);
            }
            /*========================================= E-Commerce Filter Section ======================================================*/
            $scope.getFilterItemCount = function (data) {
                var counter = 0;
                angular.forEach($scope.SearchedProfiles, function (value, key) {
                    if (value.Star == data)
                        counter = parseInt(counter + 1);
                });
                return parseInt(counter);
            }

            $scope.filterItem = [];
            $scope.filterDataByThisItem = function (data) {
                var i = $.inArray(data, $scope.filterItem);
                if (i > -1) {
                    $scope.filterItem.splice(i, 1);
                } else {
                    $scope.filterItem.push(data);
                }
                setTimeout(displayThumbnailSlider, 10);
                $("html, body").animate({ scrollTop: 220 }, "slow");
            }
            $scope.colourFilter = function (item) {
                if ($scope.filterItem.length > 0) {
                    if ($.inArray(item.Star, $scope.filterItem) < 0)
                        return;
                }
                return item.Star;
            }
            /*========================================= E-Commerce Filter Section End======================================================*/


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
