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
THIS CONTROLLER IS SPECIFICALLY FOR DISPLAYING Education SEARCH ON SEARCH MODULE
==========================================================================================
*/
var ControllerSearchEducation = angular.module('MugurthamApp').controller('ControllerSearchEducation',
        ['$http', '$scope', function ($http, $scope) {

            $scope.ControllerName = 'ControllerSearchEducation';
            //===============================================================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES AND THEN FILTER ON Education THROUGH VIEW SMART SEARCH
            //===============================================================================================
            $scope.getAllProfiles = function () {
                $scope.initData();
            };

            $scope.initData = function () {
                $scope.currentPage = 1;
                $scope.pageSize = 15;
                $scope.SearchedProfiles = JSON.parse(sessionStorage.getItem('AllProfiles')).data;
                $scope.profilePhotos = JSON.parse(sessionStorage.getItem('AllProfilesPhotosSearch')).data;
                $scope.pageChangeHandler = function (num) {
                    $("html, body").animate({ scrollTop: 220 }, "slow");
                    setTimeout(displayThumbnailSlider, 10);
                    console.log('Profiles page changed to ' + num);
                };
                setTimeout(displayThumbnailSlider, 10);
            };

        }])

