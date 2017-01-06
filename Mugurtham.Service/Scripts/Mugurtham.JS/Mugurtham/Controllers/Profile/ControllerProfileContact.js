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
THIS CONTROLLER IS SPECIFICALLY FOR FAMILY PAGE ON PROFILE REGISTRATION
==========================================================================================
*/
var ControllerProfileContact = angular.module('MugurthamApp').controller('ControllerProfileContact',
        ['$http', '$scope', '$rootScope', function ($http, $scope, $rootScope) {

            //========================================
            //GLOBAL VARIABLES FOR THIS CONTROLLER
            //=========================================
            $scope.controllerName = 'ControllerProfileContact';
            $scope.frmData = []; // To store the values of the controls in form
            $scope.globalProfileID = $rootScope.globalProfileID;
            getContactByProfileID();
            // Form Control Variables
            $scope.ContactID = '';
            $scope.Email = '';
            $scope.MobileNumber = '';
            $scope.LandlineNumber = '';
            $scope.ResidentAddress = '';
            $scope.Relationship = '';
            $scope.TimeToCall = '';
            $scope.Name = '';

            //========================================
            //GLOBAL EVENT HANDLER FOR THIS CONTROLLER
            //=========================================
            $scope.saveFormData = function () {
                $scope.initFormData();
                if ($scope.globalProfileID == '') {
                    $scope.Add();
                } else {
                    $scope.Edit();
                }
            }

            //=====================================
            //PRIVATE METHODS FOR THIS CONTROLLER
            //=====================================
            $scope.initFormData = function () {
                $scope.Email = $scope.frmData[0].Email;
                $scope.MobileNumber = $scope.frmData[0].MobileNumber;
                $scope.LandlineNumber = $scope.frmData[0].LandlineNumber;
                $scope.ResidentAddress = $scope.frmData[0].ResidentAddress;
                $scope.Relationship = $scope.frmData[0].Relationship;
                $scope.TimeToCall = $scope.frmData[0].TimeToCall;
                $scope.Name = $scope.frmData[0].Name;
            }

            //===================================================
            //AJAX POST REQUEST - CREATING NEW COTNACT FOR PROFILE
            //===================================================
            $scope.Add = function () {
                $http({
                    method: "post", url: '/Contact/ContactAPI', data: $.param({
                        ProfileID: $scope.globalProfileID,
                        Email: $scope.Email,
                        MobileNumber: $scope.MobileNumber,
                        LandlineNumber: $scope.LandlineNumber,
                        ResidentialAddress: $scope.ResidentAddress,
                        Relationship: $scope.Relationship,
                        TimeToCall: $scope.TimeToCall,
                        Name: $scope.Name
                    }),
                    headers: {
                        'content-Type': 'application/x-www-form-urlencoded',
                        "MugurthamUserToken": getLoggedInUserID()
                    }
                }).
            success(function (data, status, headers, config) {
                NotifySuccessStatus(4);
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }

            //===================================================
            //AJAX PUT REQUEST - EDIT CONTACT FOR PROFILE
            //===================================================
            $scope.Edit = function () {
                $http({
                    method: "PUT", url: '/Contact/ContactAPI', data: $.param({
                        ProfileID: $scope.globalProfileID,
                        Email: $scope.Email,
                        MobileNumber: $scope.MobileNumber,
                        LandlineNumber: $scope.LandlineNumber,
                        ResidentialAddress: $scope.ResidentAddress,
                        Relationship: $scope.Relationship,
                        TimeToCall: $scope.TimeToCall,
                        Name: $scope.Name
                    }),
                    headers: {
                        'content-Type': 'application/x-www-form-urlencoded',
                        "MugurthamUserToken": getLoggedInUserID()
                    }
                }).
            success(function (data, status, headers, config) {
                NotifySuccessStatus(4);
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }

            //===================================================
            //AJAX GET REQUEST - GETTING PROFILE BY ID
            //===================================================
            function getContactByProfileID() {
                var MugurthamUserToken = getLoggedInUserID();
                var strGetURL = '/Contact/ContactAPI/' + $scope.globalProfileID;
                $http({
                    method: "GET", url: strGetURL,
                    headers: {
                        "MugurthamUserToken": getLoggedInUserID()
                    },
                    params:
                        { "MugurthamUserToken": MugurthamUserToken }
                }).
            success(function (data, status, headers, config) {
                $scope.frmData.push({
                    ID: data.ID,
                    ProfileID: data.globalProfileID,
                    Email: data.Email,
                    MobileNumber: data.MobileNumber,
                    LandlineNumber: data.LandlineNumber,
                    ResidentAddress: data.ResidentialAddress,
                    Relationship: data.Relationship,
                    TimeToCall: data.TimeToCall,
                    Name: data.Name
                });
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }


        }])



