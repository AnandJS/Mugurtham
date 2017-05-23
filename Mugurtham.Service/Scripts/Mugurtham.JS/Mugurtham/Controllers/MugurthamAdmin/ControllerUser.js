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
THIS CONTROLLER IS SPECIFICALLY FOR User REGISTRATION
==========================================================================================
*/
var ControllerUser = angular.module('MugurthamApp').controller('ControllerUser',
        ['$http', '$scope', '$rootScope', '$routeParams', function ($http, $scope, $rootScope, $routeParams) {

            //Code commented - As to use the HTML5 DTPicker instead of JQuery DTPicker
            $("#dtPayDate").datepicker({
                showOn: "button",
                buttonImage: "images/Mugurtham/calendar.gif",
                buttonImageOnly: true,
                buttonText: "Select date",
                changeMonth: true,
                changeYear: true
            });
            //========================================
            //GLOBAL VARIABLES FOR THIS CONTROLLER
            //=========================================            
            $scope.controllerName = 'ControllerUser';
            $scope.globalProfileID = $rootScope.globalProfileID;
            $scope.globalUserID = '';
            if (typeof $routeParams.UserID != 'undefined') {
                $scope.globalUserID = $routeParams.UserID;
            }
            //$('#ddlSangam').empty();

            $scope.userFormData = []; // To store the values of the controls in form
            $scope.arrSangamID;
            $scope.arrRoleID;
            // Form Control Variables            
            $scope.ID = '';
            $scope.Name = '';
            $scope.LoginID = '';
            $scope.Password = '';
            $scope.SangamID = '';
            $scope.RoleID = '';
            $scope.ThemeID = '';
            $scope.LocaleID = '';
            $scope.IsActivated = '';
            $scope.IsHighlighted = '';
            $scope.ShowHoroscope = '';
            $scope.IsMarried = '';
            $scope.PaymentDate = '';

            //========================================
            //GLOBAL EVENT HANDLER FOR THIS CONTROLLER
            //=========================================
            $scope.saveFormData = function () {
                $scope.initFormData();
                if ($scope.globalUserID == '') {
                    $scope.Add();
                } else {
                    $scope.Edit();
                }
            }

            //=====================================
            //PRIVATE METHODS FOR THIS CONTROLLER
            //=====================================
            $scope.initFormData = function () {
                $scope.Name = $scope.userFormData[0].Name;
                $scope.LoginID = $scope.userFormData[0].LoginID;
                $scope.Password = $scope.userFormData[0].Password;
                $scope.RoleID = $scope.userFormData[0].RoleID;
                $scope.ThemeID = $scope.userFormData[0].ThemeID;
                $scope.LocaleID = $scope.userFormData[0].LocaleID;
                $scope.IsActivated = $scope.userFormData[0].IsActivated;
                $scope.SangamID = $scope.userFormData[0].SangamID;
                $scope.IsHighlighted = $scope.userFormData[0].IsHighlighted;
                $scope.ShowHoroscope = $scope.userFormData[0].ShowHoroscope;
                $scope.IsMarried = $scope.userFormData[0].IsMarried;
                $scope.PaymentDate = $scope.userFormData[0].PaymentDate;
            }

            //===================================================
            //AJAX POST REQUEST - CREATING NEW User
            //===================================================
            $scope.Add = function () {
                $http({
                    method: "post", url: '/MugurthamUser/UserAPI', data: $.param({
                        Name: $scope.userFormData[0].Name,
                        ID: $scope.userFormData[0].ID,
                        LoginID: $scope.userFormData[0].LoginID,
                        Password: $scope.userFormData[0].Password,
                        SangamID: $('#ddlSangams').val(),
                        RoleID: $('#ddlRoles').val(),
                        ThemeID: $scope.userFormData[0].ThemeID,
                        LocaleID: $scope.userFormData[0].LocaleID,
                        IsActivated: geActivation('userActivationCheckbox'),
                        IsHighlighted: $scope.userFormData[0].IsHighlighted,
                        ShowHoroscope: $scope.userFormData[0].ShowHoroscope,
                        IsMarried: $scope.userFormData[0].IsMarried,
                        PaymentDate: $scope.userFormData[0].PaymentDate

                    }),
                    headers: {
                        'content-Type': 'application/x-www-form-urlencoded',
                        "MugurthamUserToken": getLoggedInUserID(),
                        "CommunityID": getLoggedInUserCommunityID()
                    }
                }).
            success(function (data, status, headers, config) {
                NotifySuccessStatus('9');
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }


            //===================================================
            //AJAX GET REQUEST - GETTING User BY ID
            //===================================================
            function getUserByID() {
                var strHighlighted = '0';
                var strShowHoroscope = '0';
                var strMarried = '0';
                $scope.userFormData = [];
                if ($scope.globalUserID != '') {
                    var strGetURL = '/MugurthamUserLookup/UserAPI/Get/' + $scope.globalUserID;
                    $http({
                        method: "GET", url: strGetURL,
                        headers: {
                            "MugurthamUserToken": getLoggedInUserID(),
                            "CommunityID": getLoggedInUserCommunityID()
                        }
                    }).
                success(function (data, status, headers, config) {

                    if (data.IsHighlighted != null) {
                        strHighlighted = data.IsHighlighted.toString();
                    }
                    if (data.ShowHoroscope != null) {
                        strShowHoroscope = data.ShowHoroscope.toString();
                    }
                    if (data.IsMarried != null) {
                        strMarried = data.IsMarried.toString();
                    }
                    $scope.userFormData.push({
                        ID: data.ID,
                        Name: data.Name,
                        LoginID: data.LoginID,
                        Password: data.Password,
                        RoleID: data.RoleID,
                        ThemeID: data.ThemeID,
                        LocaleID: data.LocaleID,
                        IsActivated: setActivation(data.IsActivated, 'userActivationCheckbox'),
                        IsHighlighted: setActivation(strHighlighted, 'userHighlightedCheckbox'),
                        ShowHoroscope: setActivation(strShowHoroscope, 'userShowHoroscope'),
                        IsMarried: setActivation(strMarried, 'userMarriedCheckbox'),
                        PaymentDate: data.PaymentDate,
                        SangamID: data.SangamID
                    });
                    $('#ddlSangams').val(data.SangamID);
                    if (data.PaymentDate != null)
                        $scope.userFormData[0].PaymentDate = $.datepicker.formatDate('dd-M-yy', new Date(data.PaymentDate));
                }).
                error(function (data, status, headers, config) {
                    NotifyErrorStatus(data, status);
                });
                }
            }
            //===================================================
            //AJAX PUT REQUEST - EDIT User
            //===================================================
            $scope.Edit = function () {
                var strsangamID = '';
                var strRoleID = '';
                if (typeof $('#ddlSangams').val() === "undefined") {
                    strsangamID = $scope.userFormData[0].SangamID
                }
                else {
                    strsangamID = $('#ddlSangams').val();
                }
                if (typeof $('#ddlRoles').val() === "undefined")
                    strRoleID = $scope.userFormData[0].RoleID
                else
                    strRoleID = $('#ddlRoles').val();
                $http({
                    method: "PUT", url: '/MugurthamUser/UserAPI/Put', data: $.param({
                        Name: $scope.userFormData[0].Name,
                        ID: $scope.globalUserID,
                        LoginID: $scope.userFormData[0].LoginID,
                        Password: $scope.userFormData[0].Password,
                        SangamID: strsangamID,
                        RoleID: strRoleID,
                        ThemeID: $scope.userFormData[0].ThemeID,
                        LocaleID: $scope.userFormData[0].LocaleID,
                        IsActivated: geActivation('userActivationCheckbox'),
                        IsHighlighted: geActivation('userHighlightedCheckbox'),
                        ShowHoroscope: geActivation('userShowHoroscope'),
                        IsMarried: geActivation('userMarriedCheckbox'),
                        PaymentDate: $scope.PaymentDate
                    }),
                    headers: {
                        "MugurthamUserToken": getLoggedInUserID(),
                        "CommunityID": getLoggedInUserCommunityID()
                    }
                }).
            success(function (data, status, headers, config) {
                NotifySuccessStatus('10');
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }

            //===================================================
            //AJAX GET REQUEST - GET ALL UserS
            //===================================================
            $scope.getAllUsers = function () {
                $("#divContainer").mask("Loading all users please wait...");
                $http({
                    method: "GET", url: '/MugurthamUserLookup/UserAPI/GetAll',
                    headers: {
                        "MugurthamUserToken": getLoggedInUserID(),
                        "CommunityID": getLoggedInUserCommunityID()
                    }
                }).
            success(function (data, status, headers, config) {
                $("#divContainer").unmask();
                $scope.AllUsers = data;
            }).
                error(function (data, status, headers, config) {
                    $("#divContainer").unmask();
                    NotifyErrorStatus(data, status);
                });
            }
            //===================================================
            //AJAX GET REQUEST - GET ALL SANGAM USERS
            //===================================================
            $scope.getAllSangamUsers = function (strSangamID) {
                $("#divContainer").mask("Loading all users please wait...");
                $http({
                    method: "GET", url: '/MugurthamUserLookup/UserAPI/GetAllSangamUsers/' + strSangamID,
                    headers: {
                        "MugurthamUserToken": getLoggedInUserID(),
                        "CommunityID": getLoggedInUserCommunityID()
                    }
                }).
            success(function (data, status, headers, config) {
                $("#divContainer").unmask();
                $scope.AllUsers = data;
            }).
                error(function (data, status, headers, config) {
                    $("#divContainer").unmask();
                    NotifyErrorStatus(data, status);
                });
            }
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
                getUserByID();
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }



            /*=================================================================*/
            /* This method used only for user settings by the user itself */
            /*===================================================================*/
            $scope.saveUserSettings = function (Name, ID, LoginID, SangamID, RoleID) {
                $http({
                    method: "PUT", url: '/MugurthamUser/UserAPI/Put', data: $.param({
                        Name: Name,
                        ID: ID,
                        LoginID: LoginID,
                        Password: $scope.userFormData[0].Password,
                        SangamID: SangamID,
                        RoleID: RoleID,
                        ThemeID: $('#ddlTheme').val(),
                        LocaleID: $('#ddlUserLocale').val(),
                        IsActivated: '1',
                        IsHighlighted: $scope.userFormData[0].IsHighlighted,
                        ShowHoroscope: $scope.userFormData[0].ShowHoroscope,
                        PaymentDate: $scope.userFormData[0].PaymentDate
                    }),
                    headers: {
                        "MugurthamUserToken": getLoggedInUserID(),
                        "CommunityID": getLoggedInUserCommunityID()
                    }
                }).
            success(function (data, status, headers, config) {
                NotifySuccessStatus('10');
            }).
            error(function (data, status, headers, config, statusText) {
                NotifyErrorStatus(data, status);
            });
            }
            //===================================================
            //This method used only for user settings by the user itself */
            //===================================================
            $scope.getUserSettingsByID = function (loginID) {
                $scope.userFormData = [];
                var strGetURL = '/MugurthamUserLookup/UserAPI/Get/' + loginID;
                $http({
                    method: "GET", url: strGetURL,
                    headers: {
                        "MugurthamUserToken": getLoggedInUserID(),
                        "CommunityID": getLoggedInUserCommunityID()
                    }
                }).
            success(function (data, status, headers, config) {
                $('#ddlUserLocale').val(data.LocaleID);
                $('#ddlTheme').val(data.ThemeID);
                $scope.userFormData = [];
                $scope.userFormData.push({
                    ID: data.ID,
                    Name: data.Name,
                    LoginID: data.LoginID,
                    Password: data.Password,
                    RoleID: data.RoleID,
                    ThemeID: data.ThemeID,
                    LocaleID: data.LocaleID,
                    //IsActivated: setActivation(data.IsActivated),
                    IsHighlighted: data.IsHighlighted,
                    ShowHoroscope: $scope.userFormData[0].ShowHoroscope,
                    SangamID: data.SangamID,
                    PaymentDate: data.PaymentDate
                });
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }

        }])

function geActivation(checkBox) {
    var chkId = '';
    $('.' + checkBox + ':checked').each(function () {
        chkId += $(this).val() + ",";
    });
    chkId = chkId.slice(0, -1);// Remove last comma        
    if (chkId == '')
        chkId = 0;
    return chkId;
}
function setActivation(strActivation, checkBox) {
    if (strActivation != null) {
        var arrActivation = strActivation.split(',');
        $.each(arrActivation, function (index, item) {
            $('.' + checkBox).each(function () {
                if (item.toString().trim() == '1') {
                    $(this).attr('checked', 'true');
                };
            });
        });
    }
}




