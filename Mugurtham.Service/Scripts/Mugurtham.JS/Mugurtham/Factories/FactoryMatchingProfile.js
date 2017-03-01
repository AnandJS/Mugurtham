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
THIS FACTORY IS SPECIFICALLY FOR PROCESSING MY MATCHING PROFILES 
==========================================================================================
*/

var app = angular.module('MugurthamApp');


app.factory('FactoryMatchingProfiles', ['$http', function ($http) {
    var serviceFactoryMatchingStar = {}
    serviceFactoryMatchingStar.propFactoryName = 'FactoryMatchingProfiles'
    serviceFactoryMatchingStar.ConstantMatchingStarsForGroom = '';
    serviceFactoryMatchingStar.MyMatchingProfilesBadgeCount = 0;

    //alert(serviceFactoryMatchingStar.propFactoryName);
    //alert(ConstantMatchingStarsForGroom.Aswini[1].Category);

    serviceFactoryMatchingStar.getMatchingProfiles = function ($scope) {

        if (typeof (Storage) !== "undefined") {
            if ((!sessionStorage.getItem('HiglightedProfiles')))
                getMatchingProfilesfromAPI($scope);
            else
                getMatchingProfilesfromSession($scope);
        }
        else
            getMatchingProfilesfromAPI($scope);
    };

    function getMatchingProfilesfromSession($scope) {
        if ((sessionStorage.getItem('HiglightedProfiles')))
            initData($http, $scope, JSON.parse(sessionStorage.getItem('HiglightedProfiles')));
    }

    function getMatchingProfilesfromAPI($scope) {
        var strGetURL = "Search/Search/getHighlightedProfiles";
        $("#divContainer").mask("Searching profiles please wait...");
        $http({
            method: "GET", url: strGetURL
        }).
    success(function (data, status, headers, config) {
        $("#divContainer").unmask();
        initData($http, $scope, data);
    }).
        error(function (data, status, headers, config) {
            $("#divContainer").unmask();
            // NotifyStatus('2');
        });
    }

    function initData($http, $scope, data) {        
        var _star = '';
        if (typeof (Storage) !== "undefined") {
            _star = JSON.parse(localStorage.getItem("LoggedInUser")).BasicInfoCoreEntity.Star;
        }
        $("#divContainer").unmask();
        $scope.pageHeader = 'LYTPROFILESMYMATCHES';
        $scope.AllProfiles = data;
        $scope.currentPage = 1;
        $scope.pageSize = 15;
        $scope.SearchedProfiles = getMatchingProfiles($scope, data, _star);
        $scope.profilePhotos = data.PhotoCoreEntityList;
        serviceFactoryMatchingStar.MyMatchingProfilesBadgeCount = $scope.SearchedProfiles.length;
        $('#badgeMyMactchingProfiles').text($scope.SearchedProfiles.length);

        $scope.pageChangeHandler = function (num) {
            $("html, body").animate({ scrollTop: 220 }, "slow");
            setTimeout(displayThumbnailSlider, 10);
        };
        setTimeout(displayThumbnailSlider, 10);
        toastr.success('My Matching Profiles loaded Successfully');
    }

    function getMatchingProfiles($scope, data, _star) {
        var matchingProfiles = [];
        $.each($scope.ConstantMatchingStarsForGroom, function (key, value) {
            if (key === _star) {
                $.each(value, function (index, object) {
                    $.each(data.ProfileBasicInfoViewCoreEntityList, function (profilekey, profilevalue) {
                        if (object.Star === profilevalue.Star) {
                            matchingProfiles[profilekey] = data.ProfileBasicInfoViewCoreEntityList[profilekey];
                        }
                    });
                });
            }
        });
        return matchingProfiles;
    }

    return serviceFactoryMatchingStar;
}]);





