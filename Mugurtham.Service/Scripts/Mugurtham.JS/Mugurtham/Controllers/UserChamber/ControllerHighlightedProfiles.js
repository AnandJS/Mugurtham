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
        ['$http', '$scope', 'ServiceUserChamber', function ($http, $scope, ServiceUserChamber) {
            $scope.ControllerName = 'ControllerHighlightedProfiles';


            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            $scope.getHighlightedProfiles = function () {
                if (sessionStorage.getItem('HiglightedProfiles')) {
                    $scope.initData(JSON.parse(sessionStorage.getItem('HiglightedProfiles')).data);
                }
                else {
                    ServiceUserChamber.getHighlightedProfilesJSON().then(function (response) {
                        sessionStorage.setItem('HiglightedProfiles', JSON.stringify(response));
                        $scope.initData(response.data)
                    });
                }
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