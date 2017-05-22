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
var ControllerSearchProfileID = angular.module('MugurthamApp').controller('ControllerSearchProfileID',
        ['$http', '$scope', '$filter', function ($http, $scope, $filter) {

            $scope.ControllerName = 'ControllerSearchProfileID';
            //===================================================
            //AJAX GET REQUEST - GET PROFILE BY PROFILEID
            //===================================================
            $scope.getByProfileID = function () {
                $scope.initData();
            };
            $scope.initData = function () {
                $http({
                    method: "GET", url: '/SearchAPI/AllProfilesAPI/getByProfileID/' + $scope.frmData[0].ProfileID.toLowerCase(),
                    params: { "MugurthamUserToken": getLoggedInUserID() },
                    headers: {
                        'content-Type': 'application/x-www-form-urlencoded',
                        "MugurthamUserToken": getLoggedInUserID(),
                        "CommunityID": getLoggedInUserCommunityID()
                    }
                }).
success(function (data, status, headers, config) {

    $scope.AllProfiles = data;
    if (data.PhotoCoreEntityList.length == 0)
        $('img').hide();
    else
        $('img').show();
    setTimeout(displayThumbnailSlider, 1);
}).
   error(function (data, status, headers, config) {
       NotifyStatus('2');
   });
                setTimeout(displayThumbnailSlider, 1);
            };
            $scope.hideDiv = function () {
                $('#divProfileBasicView').hide();
            }

        }]) 