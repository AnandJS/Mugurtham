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
THIS CONTROLLER IS SPECIFICALLY FOR DISPLAYING Location SEARCH ON SEARCH MODULE
==========================================================================================
*/
var ControllerSearchLocation = angular.module('MugurthamApp').controller('ControllerSearchLocation',
        ['$http', '$scope', function ($http, $scope) {

            $scope.ControllerName = 'ControllerSearchLocation';
            //===============================================================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES AND THEN FILTER ON Location THROUGH VIEW SMART SEARCH
            //===============================================================================================
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
                    $scope.initData(JSON.parse(sessionStorage.getItem('AllProfiles')));
            }
            $scope.getAllProfilesfromAPI = function () {
                var strGetURL = "Search/Search/getAllProfiles";
                $("#divContainer").mask("Searching profiles please wait...");
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $("#divContainer").unmask();
                initData(data);
            }).
                error(function (data, status, headers, config) {
                    $("#divContainer").unmask();
                    NotifyStatus('2');
                });
            }

            $scope.initData = function (data) {
                $scope.AllProfiles = $.parseJSON(sessionStorage.getItem('AllProfiles'));
                $scope.currentPage = 1;
                $scope.pageSize = 15;
                $scope.SearchedProfiles = ($.parseJSON(sessionStorage.getItem('AllProfiles')).ProfileBasicInfoViewCoreEntityList);
                $scope.profilePhotos = ($.parseJSON(sessionStorage.getItem('AllProfiles')).PhotoCoreEntityList);
                $scope.pageChangeHandler = function (num) {
                    $("html, body").animate({ scrollTop: 220 }, "slow");
                    setTimeout(displayThumbnailSlider, 10);
                    console.log('Profiles page changed to ' + num);
                };
                setTimeout(displayThumbnailSlider, 10);
            }

        }])

