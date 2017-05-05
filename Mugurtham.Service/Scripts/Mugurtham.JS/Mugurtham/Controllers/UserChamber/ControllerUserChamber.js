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
THIS CONTROLLER IS SPECIFICALLY FOR DISPLAYING VIEWED PROFILES IN USER HOME PAGE
==========================================================================================
*/
var ControllerUserChamber = angular.module('MugurthamApp').controller('ControllerUserChamber',
        ['$http', '$scope', 'ConstantMatchingStarsForGroom', 'FactoryAstrologicalMatchers', 'ServiceUserChamber',
            function ($http, $scope, ConstantMatchingStarsForGroom, FactoryAstrologicalMatchers, ServiceUserChamber) {
                $scope.ControllerName = 'ControllerUserChamber';

                $scope.geUserChamberBadgeCount = function () {
                    if (sessionStorage.getItem('UserBadgeCount')) {
                        setBadgeValue(JSON.parse(sessionStorage.getItem('UserBadgeCount')).data);
                    }
                    else {
                        ServiceUserChamber.getUserBadgeCountJSON().then(function (response) {
                            sessionStorage.setItem('UserBadgeCount', JSON.stringify(response));
                            setBadgeValue(response.data);
                        });
                    }
                };

                /* ServiceUserChamber.getAstrologicalMatchersJSON().then(function (response) {
                FactoryAstrologicalMatchers.getUserChamberJSON(response.data, true);
             });*/
            }])


function setBadgeValue(objData) {

    $('#badgeInterestedInMeProfiles').text(objData.InterestedProfiles);
    $('#badgeInterestedInMeProfilesInGblNav').text(objData.InterestedProfiles);

    $('#badgeInterestedProfiles').text(objData.InterestedInMeProfiles);
    $('#badgeInterestedProfilesInGblNav').text(objData.InterestedInMeProfiles);

    $('#badgeViewNotifications').text(objData.ViewedProfiles);
    $('#badgeViewNotificationsInGblNav').text(objData.ViewedProfiles);

    $('#badgeRecentlyJoined').text(objData.RecentlyJoined);
    $('#badgeRecentlyJoinedInGblNav').text(objData.RecentlyJoined);

    $('#badgeHighlightedProfiles').text(objData.HighlightedProfiles);
    $('#badgeHighlightedProfilesInGblNav').text(objData.HighlightedProfiles);

    $('#badgeRecentlyViewedProfiles').text(objData.RecentlyViewedProfiles);
    $('#badgeRecentlyViewedProfilesInGblNav').text(objData.RecentlyViewedProfiles);

    if (sessionStorage.getItem("MyMatchingProfilesBadgeCount"))
        $('#badgeMyMactchingProfiles').text(sessionStorage.getItem("MyMatchingProfilesBadgeCount"));
    else
        $('#badgeMyMactchingProfiles').text("1000+");


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