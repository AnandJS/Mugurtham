﻿/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR DISPLAYING VIEWED PROFILES IN USER HOME PAGE
==========================================================================================
*/
var ControllerInterestedInMeProfiles = angular.module('MugurthamApp').controller('ControllerInterestedInMeProfiles',
        ['$http', '$scope', function ($http, $scope) {

            $scope.ControllerName = 'ControllerInterestedInMeProfiles';
            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            $scope.getInterestedInMeProfiles = function () {
                var strGetURL = "User/User/getInterestedInMeProfiles";
                $("#divContainer").mask("Searching profiles please wait...");
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $("#divContainer").unmask();
                $scope.AllProfiles = data;
                $scope.currentPage = 1;
                $scope.pageSize = 5;
                $scope.SearchedProfiles = data.ProfileBasicInfoViewCoreEntityList;
                $scope.pageChangeHandler = function (num) {
                    setTimeout(displayThumbnailSlider, 1000);
                    console.log('Profiles page changed to ' + num);
                };
                setTimeout(displayThumbnailSlider, 1000);
            }).
                error(function (data, status, headers, config) {
                    $("#divContainer").unmask();
                    NotifyStatus('2');
                });
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
        toastr.Error('Error occured in ControllerInterestedInMeProfiles - getData');
    }
}