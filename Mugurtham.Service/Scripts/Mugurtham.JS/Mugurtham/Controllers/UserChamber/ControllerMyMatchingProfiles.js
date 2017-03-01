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
                                                 $scope.ConstantMatchingStarsForGroom = ConstantMatchingStarsForGroom;

                                                 $scope.getHighlightedProfiles = function () {
                                                     FactoryMatchingProfiles.getMatchingProfiles($scope);
                                                 }
                                                 $scope.objScope = $scope;
                                             }])
