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


app.factory('FactoryMatchingProfiles', ['$http', 'ConstantMatchingStarsForGroom', function ($http, ConstantMatchingStarsForGroom) {
    var serviceFactoryMatchingStar = {}
    serviceFactoryMatchingStar.propFactoryName = 'FactoryMatchingProfiles'

    serviceFactoryMatchingStar.MyMatchingProfilesBadgeCount = 0;
    serviceFactoryMatchingStar.AllProfiles;
    serviceFactoryMatchingStar.SearchedProfiles;
    serviceFactoryMatchingStar.profilePhotos;

    //alert(serviceFactoryMatchingStar.propFactoryName);
    //alert(ConstantMatchingStarsForGroom.Aswini[1].Category);

    serviceFactoryMatchingStar.getMatchingProfiles = function () {
        if (typeof (Storage) !== "undefined") {
            if ((!sessionStorage.getItem('HiglightedProfiles')))
                getMatchingProfilesfromAPI();
            else
                getMatchingProfilesfromSession();
        }
        else
            getMatchingProfilesfromAPI();
    };

    function getMatchingProfilesfromSession() {
        if ((sessionStorage.getItem('AllProfiles')))
            initData($http, JSON.parse(sessionStorage.getItem('AllProfiles')));
    }

    function getMatchingProfilesfromAPI() {
        var strGetURL = "Search/Search/getAllProfiles";
        $("#divContainer").mask("Searching profiles please wait...");
        $http({
            method: "GET", url: strGetURL
        }).
    success(function (data, status, headers, config) {
        $("#divContainer").unmask();
        initData($http, data);
    }).
        error(function (data, status, headers, config) {
            $("#divContainer").unmask();
            // NotifyStatus('2');
        });
    }

    function initData($http, data) {
        var _star = '';
        if (typeof (Storage) !== "undefined") {
            _star = JSON.parse(localStorage.getItem("LoggedInUser")).BasicInfoCoreEntity.Star;
        }
        serviceFactoryMatchingStar.AllProfiles = data;
        serviceFactoryMatchingStar.SearchedProfiles = getMatchingProfiles(data, _star);
        serviceFactoryMatchingStar.profilePhotos = data.PhotoCoreEntityList;
        serviceFactoryMatchingStar.MyMatchingProfilesBadgeCount = serviceFactoryMatchingStar.SearchedProfiles.length;
        sessionStorage.setItem("MyMatchingProfilesBadgeCount", (serviceFactoryMatchingStar.SearchedProfiles.length));
        $('#badgeMyMactchingProfiles').text(serviceFactoryMatchingStar.SearchedProfiles.length);
    }

    function getMatchingProfiles(data, _star) {
        var matchingProfiles = [];
        var itrIndex = 0;
        $.each(ConstantMatchingStarsForGroom, function (key, value) {
            if (key === _star) {
                $.each(value, function (index, object) {
                    $.each(data.ProfileBasicInfoViewCoreEntityList, function (profilekey, profilevalue) {
                        if (object.Star === profilevalue.Star) {
                            matchingProfiles[itrIndex] = data.ProfileBasicInfoViewCoreEntityList[profilekey];
                            itrIndex += 1;
                        }
                    });
                });
            }
        });
        return matchingProfiles;
    }


    /*========================================= E-Commerce Filter Section ======================================================*/
    serviceFactoryMatchingStar.getStarFilterItemCount = function (_star, SearchedProfiles) {
        var counter = 0;
        angular.forEach(SearchedProfiles, function (value, key) {
            if (value.Star == _star)
                counter = parseInt(counter + 1);
        });
        return parseInt(counter);
    };

    serviceFactoryMatchingStar.getSubCasteFilterItemCount = function (subCaste, SearchedProfiles) {
        var counter = 0;
        angular.forEach(SearchedProfiles, function (value, key) {
            if (value.SubCaste == subCaste)
                counter = parseInt(counter + 1);
        });
        return parseInt(counter);
    };

    serviceFactoryMatchingStar.filterItem = [];
    serviceFactoryMatchingStar.filterSubCasteItem = [];


    serviceFactoryMatchingStar.filterStarByThisItem = function (data) {
         var i = $.inArray(data, serviceFactoryMatchingStar.filterItem);
        if (i > -1) {
            serviceFactoryMatchingStar.filterItem.splice(i, 1);
        } else {
            serviceFactoryMatchingStar.filterItem.push(data);
        }
        setTimeout(displayThumbnailSlider, 10);
        $("html, body").animate({ scrollTop: 220 }, "slow"); 
    };

    serviceFactoryMatchingStar.filterSubCasteByThisItem = function (data) {
        var i = $.inArray(data, serviceFactoryMatchingStar.filterSubCasteItem);
        if (i > -1) {
            serviceFactoryMatchingStar.filterSubCasteItem.splice(i, 1);
        } else {
            serviceFactoryMatchingStar.filterSubCasteItem.push(data);
        }
        setTimeout(displayThumbnailSlider, 10);
        $("html, body").animate({ scrollTop: 220 }, "slow");
    };

     
    serviceFactoryMatchingStar.colourFilter = function (item) {
        if (serviceFactoryMatchingStar.filterItem.length > 0) {
            if ($.inArray(item.Star, serviceFactoryMatchingStar.filterItem) < 0)
                return;
        }
        return item.Star;
    }
    serviceFactoryMatchingStar.starFilter = function (item) {
        if (serviceFactoryMatchingStar.filterItem.length > 0) {
            if ($.inArray(item.Star, serviceFactoryMatchingStar.filterItem) < 0)
                return;
        }
        return item.Star;
    }
    serviceFactoryMatchingStar.subcasteFilter = function (item) {
        if (serviceFactoryMatchingStar.filterSubCasteItem.length > 0) {
            if ($.inArray(item.SubCaste, serviceFactoryMatchingStar.filterSubCasteItem) < 0)
                return;
        }
        return item.SubCaste;
    }






    /*========================================= E-Commerce Filter Section End======================================================*/


    return serviceFactoryMatchingStar;
}]);





