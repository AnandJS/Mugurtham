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
THIS CONTROLLER IS SPECIFICALLY FOR DISPLAYING MY MATCHING PROFILES USER HOME PAGE
==========================================================================================
*/
var ControllerMyMatchingProfiles = angular.module('MugurthamApp').
                                controller('ControllerMyMatchingProfiles',
                                            ['$http', '$scope', 'ConstantMatchingStarsForGroom', 'FactoryMatchingProfiles',
                                             function ($http, $scope, ConstantMatchingStarsForGroom, FactoryMatchingProfiles) {
                                                 $scope.ControllerName = 'ControllerMyMatchingProfiles';
                                                 $scope.currentPage = 1;
                                                 $scope.pageSize = 15;
                                                 setTimeout(displayThumbnailSlider, 10)

                                                 $scope.getMyMatchingProfiles = function () {
                                                     setTimeout(displayThumbnailSlider, 10)

                                                     FactoryMatchingProfiles.getMatchingProfiles();

                                                   

                                                     $("#divContainer").unmask();
                                                     $scope.pageHeader = 'LYTPROFILESMYMATCHES';
                                                     $scope.currentPage = 1;
                                                     $scope.pageSize = 15;

                                                     $scope.AllProfiles = FactoryMatchingProfiles.AllProfiles;
                                                     $scope.SearchedProfiles = FactoryMatchingProfiles.SearchedProfiles;
                                                     $scope.profilePhotos = FactoryMatchingProfiles.profilePhotos;

                                                     $scope.pageChangeHandler = function (num) {
                                                         $("html, body").animate({ scrollTop: 220 }, "slow");
                                                         setTimeout(displayThumbnailSlider, 10);
                                                     };
                                                     $scope.pageChangeHandlerSmartSearch = function (num) {
                                                         setTimeout(displayThumbnailSlider, 10);
                                                     };
                                                     toastr.success('My Matching Profiles loaded Successfully');
                                                 }

                                                 /*========================================= E-Commerce Filter Section ======================================================*/
                                                 $scope.getStarFilterItemCount = function (star) {
                                                     return FactoryMatchingProfiles.getStarFilterItemCount(star, $scope.SearchedProfiles);
                                                 }

                                                 $scope.getSubCasteFilterItemCount = function (subCaste) {
                                                     return FactoryMatchingProfiles.getSubCasteFilterItemCount(subCaste, $scope.SearchedProfiles);
                                                 };
                                                 $scope.filterStarByThisItem = function (data) {
                                                     FactoryMatchingProfiles.filterStarByThisItem(data);
                                                 };
                                                 $scope.filterSubCasteByThisItem = function (data) {
                                                     FactoryMatchingProfiles.filterSubCasteByThisItem(data);
                                                 };
                                                 $scope.colourFilter = function (data) {
                                                    return FactoryMatchingProfiles.colourFilter(data);
                                                 };
                                                 $scope.subcasteFilter = function (data) {
                                                     return FactoryMatchingProfiles.subcasteFilter(data);
                                                 };
                                                 
                                                 
                                                 /*========================================= E-Commerce Filter Section End======================================================*/



                                                 // Wiring up with Template through Custom Directive
                                                 $scope.objScope = $scope;
                                             }])
