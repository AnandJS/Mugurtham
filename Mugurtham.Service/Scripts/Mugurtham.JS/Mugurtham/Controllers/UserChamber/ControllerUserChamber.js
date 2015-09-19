/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR DISPLAYING VIEWED PROFILES IN USER HOME PAGE
==========================================================================================
*/
var ControllerUserChamber = angular.module('MugurthamApp').controller('ControllerUserChamber',
        ['$http', '$scope', function ($http, $scope) {
            $scope.ControllerName = 'ControllerUserChamber';
            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            $scope.geUserChamberBadgeCount = function () {
                var strGetURL = "User/User/getUserBadgeCount";
                $("#divContainer").mask("Getting Badge count please wait...");
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $("#divContainer").unmask();
                setBadgeValue(data);
            }).
                error(function (data, status, headers, config) {
                    $("#divContainer").unmask();
                    NotifyStatus('2');
                });
            }


        }])


function setBadgeValue(objData) {
    $('#badgeInterestedInMeProfiles').text(objData.InterestedProfiles);
    $('#badgeInterestedProfiles').text(objData.InterestedInMeProfiles);
    $('#badgeViewNotifications').text(objData.ViewedProfiles);
    $('#badgeRecentlyJoined').text(objData.RecentlyJoined);
    $('#badgeHighlightedProfiles').text(objData.HighlightedProfiles);
}

function NotifyStatus(intStatus) {
    /*
         1-> Success
         2-> Error
    */
    if (intStatus == '1') {
        toastr.success('Profiles Received Successfully');
    }
    else if (intStatus == '2') {
        toastr.Error('Error occured in ControllerUserChamber - getData');
    }
}