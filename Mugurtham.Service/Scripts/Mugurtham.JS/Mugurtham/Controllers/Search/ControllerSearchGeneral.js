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
THIS CONTROLLER IS SPECIFICALLY FOR ALL-PROFILES PAGE ON SEARCH MODULE
==========================================================================================
*/
var ControllerSearchGeneral = angular.module('MugurthamApp').controller('ControllerSearchGeneral',
        ['$http', '$scope', function ($http, $scope) {

            $scope.ControllerName = 'ControllerSearchGeneral';
            $('#BottomPagination').hide();
            $('#TopPagination').hide();
            $scope.SangamID = '';
            $scope.Gender = '';
            $scope.Star = '';
            $scope.Age = '';
            $scope.fromAge = '';
            $scope.toAge = '';
            $scope.SubCaste = '';
            $scope.arrStar = ['Anusham', 'Aswini', 'Avittam', 'Aayilyam', 'Bharani', 'Chithirai', 'Hastham', 'Karthigai', 'Kettai', 'Makam', 'Moolam', 'Mrigasheersham', 'Pooraadam', 'Pooram', 'Poorattathi', 'Poosam', 'Punarpoosam', 'Revathi', 'Rohini', 'Sadayam', 'Swaathi', 'Thiruvaathirai', 'Thiruvonam', 'Uthiraadam', 'Uthiram', 'Uthirattathi', 'Visaakam'];
            $scope.arrSubCaste = ['Avusula', 'Kai Kolar', 'Kammari', 'Kanchari', 'Shipi', 'Vadrangi', 'Kamalar', 'Achari'];
            $scope.arrFromAge = ['18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50'];
            $scope.arrToAge = ['18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50'];


            //===================================================
            //AJAX GET REQUEST - GETTING LOOKUP DTO
            //===================================================
            $scope.getLookup = function () {
                var strGetURL = '/Lookup/LookupAPI';
                $http({
                    method: "GET", url: strGetURL,
                    headers: {
                        "MugurthamUserToken": getLoggedInUserID(),
                        "CommunityID": getLoggedInUserCommunityID()
                    }
                }).
            success(function (data, status, headers, config) {
                $scope.arrSangamID = data.SangamCoreEntity;
                $scope.arrRoleID = data.RoleCoreEntity;
                $('#ddlSangam').empty();
                $scope.getAllGeneralSearchProfiles();
                getUserByID();
            }).
            error(function (data, status, headers, config) {
                NotifyStatus('2');
            });
            }
            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            $scope.getAllGeneralSearchProfiles = function () {
                /*  if (typeof (Storage) !== "undefined") {
                      if ((!sessionStorage.getItem('AllProfiles')))
                          $scope.getAllGeneralSearchProfilesfromAPI();
                      else
                          $scope.getAllGeneralSearchProfilesfromSession();
                  }
                  else
                      $scope.getAllGeneralSearchProfilesfromAPI();*/
                $scope.initData();
            }

            $scope.getAllGeneralSearchProfilesfromSession = function () {
                if ((sessionStorage.getItem('AllProfiles')))
                    $scope.initData(JSON.parse(sessionStorage.getItem('AllProfiles')));
            }
            $scope.getAllGeneralSearchProfilesfromAPI = function () {
                var strGetURL = "Search/Search/getAllProfiles";
                $("#divContainer").mask("Searching profiles please wait...");
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $("#divContainer").unmask();
                initData(data);
            }).
                error(function (data, status, headers, config) {
                    $("#divContainer").unmask();
                    NotifyStatus('2');
                });
            }

            $scope.initData = function () {
                $scope.currentPage = 1;
                $scope.pageSize = 15;
                $scope.SearchedProfiles = JSON.parse(sessionStorage.getItem('AllProfiles')).data;
                $scope.profilePhotos = JSON.parse(sessionStorage.getItem('AllProfilesPhotosSearch')).data;
                $scope.pageChangeHandler = function (num) {
                    $("html, body").animate({ scrollTop: 220 }, "slow");
                    setTimeout(displayThumbnailSlider, 10);
                    console.log('Profiles page changed to ' + num);
                };
                setTimeout(displayThumbnailSlider, 10);
            }

            $scope.startsWith = function (actual, expected) {
                var lowerStr = (actual + "").toLowerCase();
                return lowerStr.indexOf(expected.toLowerCase()) === 0;
            }

            $scope.byRange = function (fieldName, minValue, maxValue) {
                if (minValue === undefined) minValue = Number.MIN_VALUE;
                if (maxValue === undefined) maxValue = Number.MAX_VALUE;
                return function predicateFunc(item) {
                    return (minValue <= item[fieldName] && item[fieldName] <= maxValue);
                };


            };


            $scope.profileFilter = function (profile) {
                /*var result = (!$scope.foodName || item.name.toLowerCase().includes($scope.foodName.toLowerCase())) &&
                             (!$scope.priceFrom || item.price >= $scope.priceFrom) &&
                             (!$scope.priceTo || item.price <= $scope.priceTo);*/

                var filteredProfileResult = (!$scope.Star || $scope.Star == profile.Star) &&
                             (!$scope.SangamID || $scope.SangamID == profile.SangamID) &&
                             (!$scope.SubCaste || $scope.SubCaste == profile.SubCaste) &&
                             ((!$scope.fromAge || profile.Age >= $scope.fromAge) && (!$scope.toAge || profile.Age <= $scope.toAge))
                ;
                return filteredProfileResult;
            };

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
        toastr.Error('Error occured in ControllerSearchGeneral - getData');
    }
}