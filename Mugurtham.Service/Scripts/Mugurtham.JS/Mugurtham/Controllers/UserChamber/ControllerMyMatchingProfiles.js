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


                                                 $scope.getHighlightedProfiles = function () {
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
                                                         setTimeout(displayThumbnailSlider, 100);
                                                     };
                                                     $scope.pageChangeHandlerSmartSearch = function (num) {
                                                         setTimeout(displayThumbnailSlider, 100);
                                                     };
                                                     toastr.success('My Matching Profiles loaded Successfully');
                                                 }
                                                 // Wiring up with Template through Custom Directive
                                                 $scope.objScope = $scope;
                                             }])
