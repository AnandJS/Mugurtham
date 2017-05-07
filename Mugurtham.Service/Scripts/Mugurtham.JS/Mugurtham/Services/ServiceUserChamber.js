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
THIS SERVICE DEFINES ALL THE REST API CALLS FOR USER CHAMBER FUNCTIONALITY
==========================================================================================
*/

var app = angular.module('MugurthamApp');


app.service('ServiceUserChamber', ['$http', function ($http) {


    this.getHighlightedProfilesJSON = function () {
        var endPoint = 'Search/Search/getHighlightedProfiles';
        var promise = this.getJSONObject(endPoint);
        return promise;
    };

    this.getRecentlyJoinedProfilesJSON = function () {
        var endPoint = 'Search/Search/GetRecentlyJoinedProfiles';
        var promise = this.getJSONObject(endPoint);
        return promise;
    };

    this.getInterestedInMeProfilesJSON = function () {
        var endPoint = 'User/User/getInterestedInMeProfiles';
        var promise = this.getJSONObject(endPoint);
        return promise;
    };

    this.getUserBadgeCountJSON = function () {
        var endPoint = 'User/User/getUserBadgeCount';
        var promise = this.getJSONObject(endPoint);
        return promise;
    };

    this.getRecentlyViewedProfilesJSON = function () {
        var endPoint = 'Search/Search/getRecentlyViewedProfiles';
        var promise = this.getJSONObject(endPoint);
        return promise;
    };

    this.getAstrologicalMatchersJSON = function () {
        var endPoint = 'Search/Search/getAllProfiles';
        var promise = this.getJSONObject(endPoint);
        return promise;
    };

    this.geAllProfilesJSON = function () {
        var endPoint = 'Search/Search/getAllProfiles';
        var promise = this.getJSONObject(endPoint);
        $("#divContainer").unmask();
        return promise;
    };

    this.geAllProfilesPhotosJSON = function () {
        var endPoint = 'Search/Search/getAllProfilesPhoto';
        var promise = this.getJSONObject(endPoint);
        $("#divContainer").unmask();
        return promise;
    };

    this.geAllProfilesSlicedJSON = function () {
        try {
            var endPoint = 'Search/Search/getAllProfiles';
            $("#divContainer").mask();
            var jsonObject;
            var promise = $http({
                method: "GET", url: endPoint, params: { lazyLoad: 'true' }
            }).
           success(function (data, status, headers, config) {
               $("#divContainer").unmask();
               return data;
           }).
            error(function (data, status, headers, config) {
                $("#divContainer").unmask();
                toastr.error('Error Occured :' + status);
            });
        }
        catch (err)
        { toastr.error(err.message); }
        return promise;
    };

    this.geAllProfilesPhotosSlicedJSON = function () {
        try {
            var endPoint = 'Search/Search/getAllProfilesPhoto';
            $("#divContainer").mask();
            var jsonObject;
            var promise = $http({
                method: "GET", url: endPoint, params: { lazyLoad: 'true' }
            }).
           success(function (data, status, headers, config) {
               $("#divContainer").unmask();
               return data;
           }).
            error(function (data, status, headers, config) {
                $("#divContainer").unmask();
                toastr.error('Error Occured :' + status);
            });
        }
        catch (err)
        { toastr.error(err.message); }
        return promise;
    };

    this.getInterestedProfilesJSON = function () {
        var endPoint = 'User/User/getInterestedProfiles';
        var promise = this.getJSONObject(endPoint);
        return promise;
    };

    this.getViewedMeProfilesJSON = function () {
        var endPoint = 'Search/Search/getViewedProfiles';
        var promise = this.getJSONObject(endPoint);
        return promise;
    };

    // Can make this function private
    this.getJSONObject = function (endPoint) {
        $("#divContainer").mask();
        var jsonObject;
        var promise = $http({
            method: "GET", url: endPoint
        }).
       success(function (data, status, headers, config) {
           $("#divContainer").unmask();
           return data;
       }).
        error(function (data, status, headers, config) {
            $("#divContainer").unmask();
            toastr.error('Error Occured :' + status);
        });
        return promise;
    }


}]);



