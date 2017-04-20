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
THIS CONTROLLER IS SPECIFICALLY FOR DISPLAYING Occupation SEARCH ON SEARCH MODULE
==========================================================================================
*/
var ControllerSearchOccupation = angular.module('MugurthamApp').controller('ControllerSearchOccupation',
        ['$http', '$scope', '$timeout', 'ServiceSearchAllProfiles', function ($http, $scope, $timeout, ServiceSearchAllProfiles) {

            $scope.ControllerName = 'ControllerSearchOccupation';
            //===============================================================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES AND THEN FILTER ON Occupation THROUGH VIEW SMART SEARCH
            //===============================================================================================
            $scope.getAllProfiles = function () {
                /*if (typeof (Storage) !== "undefined") {
                    if ((!sessionStorage.getItem('AllProfiles'))) 
                        $scope.getAllProfilesfromAPI();
                    else
                        $scope.getAllProfilesfromSession();
                }
                else
                    $scope.getAllProfilesfromAPI();*/


                /*Service Impementation*/
                /*ServiceSearchAllProfiles.getData().then(function (data) {                    
                    
                }).catch(function (error) {
                    alert(error);
                });*/

                $scope.initData();
            }
            /*
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
            */
            $scope.initData = function () {
                //$scope.AllProfiles = $.parseJSON(sessionStorage.getItem('AllProfiles'));
                $scope.currentPage = 1;
                $scope.pageSize = 15;
                $scope.SearchedProfiles = JSON.parse(sessionStorage.getItem('AllProfiles'));
                $scope.profilePhotos = JSON.parse(sessionStorage.getItem('AllProfilesPhoto'));
                //$scope.lazyLoadData($scope.AllProfiles);
            }

            /*==========================Lazy loading custom logic starts==============================*/
            /*
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
            */
            /*==========================Lazy loading custom logic ends==============================*/

            $scope.pageChangeHandler = function (num) {
                $("html, body").animate({ scrollTop: 220 }, "slow");
                setTimeout(displayThumbnailSlider, 10);
                console.log('Profiles page changed to ' + num);
            };
            setTimeout(displayThumbnailSlider, 10);

        }])

