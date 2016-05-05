/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR ALL-PROFILES PAGE ON SEARCH MODULE
==========================================================================================
*/
var ControllerSearchAllProfiles = angular.module('MugurthamApp').controller('ControllerSearchAllProfiles',
        ['$http', '$scope', '$filter', function ($http, $scope, $filter) {

            $scope.ControllerName = 'ControllerSearchAllProfiles';            
            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            $scope.getAllProfiles = function () {
                var strGetURL = "Search/Search/getAllProfiles";
                $("#divContainer").mask("Searching profiles please wait...");
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $("#divContainer").unmask();
                $scope.AllProfiles = data;                                
                $scope.currentPage = 1;
                $scope.pageSize = 5;                
                $scope.SearchedProfiles = data.ProfileBasicInfoViewCoreEntityList;
                $scope.pageChangeHandler = function (num) {
                    console.log('Profiles page changed to ' + num);
                };                
                setTimeout(displayThumbnailSlider, 1000);
            }).
                error(function (data, status, headers, config) {
                    $("#divContainer").unmask();
                    NotifyStatus('2');
                });
            }
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
        toastr.Error('Error occured in ControllerSearchAllProfiles - getData');
    }
}
 
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
            $scope.arrStar = ['Anusham', 'Aswini', 'Avittam', 'Aayilyam', 'Bharani', 'Chithirai', 'Hastham', 'Karthigai', 'Kettai', 'Makam', 'Moolam', 'Mrigasheersham', 'Pooraadam', 'Pooram', 'Poorattathi', 'Poosam', 'Punarpoosam', 'Revathi', 'Rohini', 'Sadayam', 'Swaathi', 'Thiruvaathirai', 'Thiruvonam', 'Uthiraadam', 'Uthiram', 'Uthirattathi', 'Visaakam'];
            $scope.arrSubCaste = ['Kamalar', 'Achari'];
            
            //===================================================
            //AJAX GET REQUEST - GETTING LOOKUP DTO
            //===================================================
            $scope.getLookup = function () {
                var strGetURL = '/Lookup/LookupAPI';
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                getAllProfiles();
                $scope.arrSangamID = data.SangamCoreEntity;
                $scope.arrRoleID = data.RoleCoreEntity;
                $('#ddlSangam').empty();
                $.each(data, function (index, value) {
                    // $('#ddlSangam').append($('<option>').text(value.Name).attr('value', value.ID));
                })
                getUserByID();
            }).
            error(function (data, status, headers, config) {
                NotifyStatus('2');
            });
            }
            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            function getAllProfiles() {
                var strGetURL = "Search/Search/getAllProfiles";
                $("#divContainer").mask("Searching profiles please wait...");
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $("#divContainer").unmask();
                $scope.AllProfiles = data;
                $scope.currentPage = 1;
                $scope.pageSize = 5;
                $scope.SearchedProfiles = data.ProfileBasicInfoViewCoreEntityList;
                $scope.pageChangeHandler = function (num) {
                    console.log('Profiles page changed to ' + num);
                };
                setTimeout(displayThumbnailSlider, 1000);
            }).
                error(function (data, status, headers, config) {
                    $("#divContainer").unmask();
                    NotifyStatus('2');
                });
            }
          
            
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
/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR ALL-PROFILES PAGE ON SEARCH MODULE
==========================================================================================
*/
var ControllerSearchProfileID = angular.module('MugurthamApp').controller('ControllerSearchProfileID',
        ['$http', '$scope', function ($http, $scope) {

            $scope.ControllerName = 'ControllerSearchProfileID';           
            //===================================================
            //AJAX GET REQUEST - GET PROFILE BY PROFILEID
            //===================================================
            $scope.getByProfileID = function () {

                $http({
                    method: "GET", url: '/SearchAPI/AllProfilesAPI/getByProfileID/' + $scope.frmData[0].ProfileID
                }).
            success(function (data, status, headers, config) {
                if (data.BasicInfoCoreEntity.ProfileID != null) {
                    $('#divProfileBasicView').show();
                    $scope.AllProfiles = data;
                }
                else {
                    $('#divProfileBasicView').hide();
                }
                setTimeout(displayThumbnailSlider, 1000);
            }).
                error(function (data, status, headers, config) {
                    NotifyStatus('2');
                });
            }

            $scope.hideDiv = function () {
                $('#divProfileBasicView').hide();
            }

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
        toastr.Error('Error occured in ControllerSearchProfileID - getData');
    }
}
/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR ALL-PROFILES PAGE ON SEARCH MODULE
==========================================================================================
*/
var ControllerSearchSangam = angular.module('MugurthamApp').controller('ControllerSearchSangam',
        ['$http', '$scope', function ($http, $scope) {

            $scope.ControllerName = 'ControllerSearchSangam';           
            //===================================================
            //AJAX GET REQUEST - GETTING LOOKUP DTO
            //===================================================
            $scope.getLookup = function () {
                var strGetURL = '/Lookup/LookupAPI';
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                getAllProfiles();
                $scope.arrSangamID = data.SangamCoreEntity;
                $scope.arrRoleID = data.RoleCoreEntity;
                $('#ddlSangam').empty();                
            }).
            error(function (data, status, headers, config) {
                NotifyStatus('2');
            });
            }
            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            function getAllProfiles() {
                var strGetURL = "Search/Search/getAllProfiles";
                $("#divContainer").mask("Searching profiles please wait...");
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $("#divContainer").unmask();
                $scope.AllProfiles = data;
                $scope.currentPage = 1;
                $scope.pageSize = 5;
                $scope.SearchedProfiles = data.ProfileBasicInfoViewCoreEntityList;
                $scope.pageChangeHandler = function (num) {
                    console.log('Profiles page changed to ' + num);
                };
                setTimeout(displayThumbnailSlider, 1000);
            }).
                error(function (data, status, headers, config) {
                    $("#divContainer").unmask();
                    NotifyStatus('2');
                });
            }
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
        toastr.Error('Error occured in ControllerSearchSangam - getData');
    }
}