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