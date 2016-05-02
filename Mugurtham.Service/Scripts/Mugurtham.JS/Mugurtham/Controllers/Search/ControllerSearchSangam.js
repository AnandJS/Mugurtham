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