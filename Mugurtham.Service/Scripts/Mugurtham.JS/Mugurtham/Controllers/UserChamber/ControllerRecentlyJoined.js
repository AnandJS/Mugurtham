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
THIS CONTROLLER IS SPECIFICALLY FOR RECENTLY JOINED PROFILES BY LASTWEEK IN USER HOME PAGE
==========================================================================================
*/
var ControllerRecentlyJoined = angular.module('MugurthamApp').controller('ControllerRecentlyJoined',
        ['$http', '$scope', 'FactoryAstrologicalMatchers', 'ConstantRegistrationPage', 'ServiceUserChamber',
                                             function ($http, $scope, FactoryAstrologicalMatchers, ConstantRegistrationPage, ServiceUserChamber) {

                                                 $scope.ControllerName = 'ControllerRecentlyJoined';
                                                 $scope.currentPage = 1;
                                                 $scope.pageSize = 15;
                                                 $scope.fromAge = 0;
                                                 $scope.toAge = 0;
                                                 $scope.filterSubcasteSelected = [];
                                                 $scope.filterStarSelected = [];
                                                 $scope.filterSangamSelected = [];
                                                 $scope.arrFromAge = ConstantRegistrationPage.FromAge;
                                                 $scope.arrToAge = ConstantRegistrationPage.ToAge;
                                                 setTimeout(displayThumbnailSlider, 10)

                                                 $scope.getAstrologicalMatchers = function () {
                                                     setTimeout(displayThumbnailSlider, 10);
                                                     if (sessionStorage.getItem('RecentlyJoinedProfiles')) {
                                                         $scope.displayProfile(JSON.parse(sessionStorage.getItem('RecentlyJoinedProfiles')));
                                                     }
                                                     else {
                                                         ServiceUserChamber.getRecentlyJoinedProfilesJSON().then(function (response) {
                                                             sessionStorage.setItem('RecentlyJoinedProfiles', JSON.stringify(response));
                                                             $scope.displayProfile(response)
                                                         });
                                                     }
                                                 };
                                                 $scope.displayProfile = function (response) {
                                                     FactoryAstrologicalMatchers.getUserChamberJSON(response.data, false);
                                                     $scope.arrFilterStar = FactoryAstrologicalMatchers.arrFilterStar;
                                                     $scope.arrFilterSubCaste = FactoryAstrologicalMatchers.arrFilterSubCaste;
                                                     $scope.arrSangamMaster = FactoryAstrologicalMatchers.arrSangamMaster;

                                                     $("#divContainer").unmask();
                                                     $scope.pageHeader = 'LYTRCNTLYJNDPROFILES';
                                                     $scope.currentPage = 1;
                                                     $scope.pageSize = 15;

                                                     $scope.AllProfiles = FactoryAstrologicalMatchers.AllProfiles;
                                                     $scope.SearchedProfiles = FactoryAstrologicalMatchers.SearchedProfiles;
                                                     $scope.profilePhotos = FactoryAstrologicalMatchers.profilePhotos;
                                                 };
                                                 $scope.pageChangeHandler = function (num) {
                                                     $("html, body").animate({ scrollTop: 220 }, "slow");
                                                     setTimeout(displayThumbnailSlider, 10);
                                                 };
                                                 $scope.pageChangeHandlerSmartSearch = function (num) {
                                                     setTimeout(displayThumbnailSlider, 10);
                                                 };
                                                 toastr.success('Recently Profiles loaded Successfully');
                                                 /*========================================= E-Commerce Filter Section ======================================================*/

                                                 //Item Count
                                                 $scope.getStarFilterItemCount = function (star) {
                                                     return FactoryAstrologicalMatchers.getStarFilterItemCount(star, $scope.SearchedProfiles);
                                                 };
                                                 $scope.getSubCasteFilterItemCount = function (subCaste) {
                                                     return FactoryAstrologicalMatchers.getSubCasteFilterItemCount(subCaste, $scope.SearchedProfiles);
                                                 };
                                                 $scope.getSangamFilterItemCount = function (SangamID) {
                                                     return FactoryAstrologicalMatchers.getSangamFilterItemCount(SangamID, $scope.SearchedProfiles);
                                                 };

                                                 //Item event handler
                                                 $scope.filterStarByThisItem = function (data) {
                                                     FactoryAstrologicalMatchers.filterStarByThisItem(data);
                                                     $scope.filterStarSelected = FactoryAstrologicalMatchers.filterStarItem;
                                                 };
                                                 $scope.filterSubCasteByThisItem = function (data) {
                                                     FactoryAstrologicalMatchers.filterSubCasteByThisItem(data);
                                                     $scope.filterSubcasteSelected = FactoryAstrologicalMatchers.filterSubCasteItem;
                                                 };
                                                 $scope.filterSangamByThisItem = function (data) {
                                                     FactoryAstrologicalMatchers.filterSangamByThisItem(data);
                                                     $scope.filterSangamSelected = FactoryAstrologicalMatchers.filterSangamItem;
                                                 };

                                                 // Item declarative data binding
                                                 $scope.starFilter = function (data) {
                                                     return FactoryAstrologicalMatchers.starFilter(data);
                                                 };
                                                 $scope.subcasteFilter = function (data) {
                                                     return FactoryAstrologicalMatchers.subcasteFilter(data);
                                                 };
                                                 $scope.sangamFilter = function (data) {
                                                     return FactoryAstrologicalMatchers.sangamFilter(data);
                                                 };
                                                 $scope.ageFilter = function (data) {
                                                     return FactoryAstrologicalMatchers.ageFilter(data, $scope.fromAge, $scope.toAge);
                                                 };


                                                 /*========================================= E-Commerce Filter Section End======================================================*/



                                                 // Wiring up with Template through Custom Directive
                                                 $scope.objScope = $scope;
                                             }]);
