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
THIS CONTROLLER IS SPECIFICALLY FOR DISPLAYING HIGHLIGHTED PROFILES USER HOME PAGE
==========================================================================================
*/
var ControllerHighlightedProfiles = angular.module('MugurthamApp').controller('ControllerHighlightedProfiles',
        ['$http', '$scope', function ($http, $scope) {
            $scope.ControllerName = 'ControllerHighlightedProfiles';


            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            $scope.getHighlightedProfiles = function () {
                if (typeof (Storage) !== "undefined") {
                    if ((!sessionStorage.getItem('HiglightedProfiles')))
                        $scope.getHighlightedProfilesfromAPI();
                    else
                        $scope.getHighlightedProfilesfromSession();
                }
                else
                    $scope.getHighlightedProfilesfromAPI();
            }

            $scope.getHighlightedProfilesfromSession = function () {
                if ((sessionStorage.getItem('HiglightedProfiles')))
                    $scope.initData(JSON.parse(sessionStorage.getItem('HiglightedProfiles')));
            }
            $scope.getHighlightedProfilesfromAPI = function () {
                var strGetURL = "Search/Search/getHighlightedProfiles";
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
                $("#divContainer").unmask();
                $scope.AllProfiles = data;
                $scope.currentPage = 1;
                $scope.pageSize = 15;
                $scope.SearchedProfiles = data.ProfileBasicInfoViewCoreEntityList;
                $scope.profilePhotos = data.PhotoCoreEntityList;
                $scope.pageChangeHandler = function (num) {
                    $("html, body").animate({ scrollTop: 220 }, "slow");
                    setTimeout(displayThumbnailSlider, 10);
                    console.log('Profiles page changed to ' + num);
                };
                setTimeout(displayThumbnailSlider, 10);
                toastr.success('Highlighted Profiles loaded Successfully');
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
