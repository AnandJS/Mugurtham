﻿/*************************************************************************
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


app.factory('FactoryAstrologicalMatchers', ['$http', 'ConstantMatchingStarsForGroom', 'ConstantMatchingStarsForBride',
                                        'ConstantRegistrationPage', 'ConstantGlobal',
    function ($http, ConstantMatchingStarsForGroom, ConstantMatchingStarsForBride, ConstantRegistrationPage, ConstantGlobal) {
        var serviceFactoryMatchingStar = {}
        serviceFactoryMatchingStar.propFactoryName = 'FactoryAstrologicalMatchers';
        serviceFactoryMatchingStar.arrFilterStar = ConstantRegistrationPage.Star;
        serviceFactoryMatchingStar.arrFilterSubCaste = ConstantRegistrationPage.SubCaste;
        serviceFactoryMatchingStar.arrSangamMaster = ConstantGlobal.SangamMaster;
        serviceFactoryMatchingStar.MyMatchingProfilesBadgeCount = 0;
        serviceFactoryMatchingStar.AllProfiles;
        serviceFactoryMatchingStar.SearchedProfiles;
        serviceFactoryMatchingStar.profilePhotos;
        serviceFactoryMatchingStar.endPointName = '';
        serviceFactoryMatchingStar.endPoint = '';
        serviceFactoryMatchingStar.isAstrologicalMatchers = false;

        serviceFactoryMatchingStar.getUserChamberJSON = function (objProfilesJSON) {
            serviceFactoryMatchingStar.clearFilters();
            serviceFactoryMatchingStar.profilePhotos = objProfilesJSON.PhotoCoreEntityList;
            serviceFactoryMatchingStar.SearchedProfiles = objProfilesJSON.ProfileBasicInfoViewCoreEntityList;
        };

        serviceFactoryMatchingStar.getAstrologicalMatchingProfiles = function (objProfilesJSON, objProfilePhotosJSON) {
            var _star = '';
            var _gender = '';
            var objConstantMatchingStar = ConstantMatchingStarsForGroom;
            serviceFactoryMatchingStar.clearFilters();

            if (typeof (Storage) !== "undefined") {
                _star = JSON.parse(localStorage.getItem("LoggedInUser")).BasicInfoCoreEntity.Star;
                _gender = JSON.parse(localStorage.getItem("LoggedInUser")).BasicInfoCoreEntity.Gender;
            }
            if (_gender === 'female') {
                objConstantMatchingStar = ConstantMatchingStarsForBride;
            }
            serviceFactoryMatchingStar.SearchedProfiles = getAstrologicalMatchingProfiles(objProfilesJSON, _star, objConstantMatchingStar);
            serviceFactoryMatchingStar.profilePhotos = objProfilePhotosJSON;
            serviceFactoryMatchingStar.MyMatchingProfilesBadgeCount = serviceFactoryMatchingStar.SearchedProfiles.length;
        };

        function getAstrologicalMatchingProfiles(data, _star, objConstantMatchingStar) {
            try {
                var matchingProfiles = [];
                var itrIndex = 0;
                $.each(objConstantMatchingStar, function (key, value) {
                    if (key === _star) {
                        $.each(value, function (index, object) {
                            $.each(data, function (profilekey, profilevalue) {
                                if (object.Star === profilevalue.Star) {
                                    matchingProfiles[itrIndex] = data[profilekey];
                                    itrIndex += 1;
                                }
                            });
                        });
                    }
                });
                sessionStorage.setItem("MyMatchingProfilesBadgeCount", (matchingProfiles.length));
                $('#badgeMyMactchingProfiles').text(matchingProfiles.length);
                $('#badgeMyMactchingProfilesInGblNav').text(matchingProfiles.length);
                return matchingProfiles;
            }
            catch (err) {
                toastr.error(err);
            }
        }
        /*========================================= E-Commerce Filter Section ======================================================*/
        //Item Count
        serviceFactoryMatchingStar.filterStarItem = [];
        serviceFactoryMatchingStar.filterSubCasteItem = [];
        serviceFactoryMatchingStar.filterSangamItem = [];

        serviceFactoryMatchingStar.clearFilters = function () {
            serviceFactoryMatchingStar.filterStarItem = [];
            serviceFactoryMatchingStar.filterSubCasteItem = [];
            serviceFactoryMatchingStar.filterSangamItem = [];
        };

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
        serviceFactoryMatchingStar.getSangamFilterItemCount = function (SangamID, SearchedProfiles) {
            var counter = 0;
            angular.forEach(SearchedProfiles, function (value, key) {
                if (value.SangamID == SangamID)
                    counter = parseInt(counter + 1);
            });
            return parseInt(counter);
        };
        // Item Event Handler
        serviceFactoryMatchingStar.filterStarByThisItem = function (data) {
            var i = $.inArray(data, serviceFactoryMatchingStar.filterStarItem);
            if (i > -1) {
                serviceFactoryMatchingStar.filterStarItem.splice(i, 1);
            } else {
                serviceFactoryMatchingStar.filterStarItem.push(data);
            }
            setTimeout(displayThumbnailSlider, 1);
            $("html, body").animate({ scrollTop: 220 }, "slow");
        };
        serviceFactoryMatchingStar.filterSubCasteByThisItem = function (data) {
            var i = $.inArray(data, serviceFactoryMatchingStar.filterSubCasteItem);
            if (i > -1) {
                serviceFactoryMatchingStar.filterSubCasteItem.splice(i, 1);
            } else {
                serviceFactoryMatchingStar.filterSubCasteItem.push(data);
            }
            setTimeout(displayThumbnailSlider, 1);
            $("html, body").animate({ scrollTop: 220 }, "slow");
        };
        serviceFactoryMatchingStar.filterSangamByThisItem = function (data) {
            var i = $.inArray(data, serviceFactoryMatchingStar.filterSangamItem);
            if (i > -1) {
                serviceFactoryMatchingStar.filterSangamItem.splice(i, 1);
            } else {
                serviceFactoryMatchingStar.filterSangamItem.push(data);
            }
            setTimeout(displayThumbnailSlider, 1);
            $("html, body").animate({ scrollTop: 220 }, "slow");
        };
        // Item Declarative Data Binding
        serviceFactoryMatchingStar.starFilter = function (item) {
            if (serviceFactoryMatchingStar.filterStarItem.length > 0) {
                if ($.inArray(item.Star, serviceFactoryMatchingStar.filterStarItem) < 0)
                    return;
            }
            return item.Star;
        };
        serviceFactoryMatchingStar.subcasteFilter = function (item) {
            if (serviceFactoryMatchingStar.filterSubCasteItem.length > 0) {
                if ($.inArray(item.SubCaste, serviceFactoryMatchingStar.filterSubCasteItem) < 0)
                    return;
            }
            return item.SubCaste;
        };
        serviceFactoryMatchingStar.sangamFilter = function (item) {
            if (serviceFactoryMatchingStar.filterSangamItem.length > 0) {
                if ($.inArray(item.SangamID, serviceFactoryMatchingStar.filterSangamItem) < 0)
                    return;
            }
            return item.SangamID;
        };
        serviceFactoryMatchingStar.ageFilter = function (item, fromAge, toAge) {
            var filteredProfileResult = (
                            ((!fromAge || item.Age >= fromAge) && (!toAge || item.Age <= toAge)
                            )
                     );
            setTimeout(displayThumbnailSlider, 1);
            return filteredProfileResult;
        };
        /*========================================= E-Commerce Filter Section End======================================================*/
        return serviceFactoryMatchingStar;


    }]);





