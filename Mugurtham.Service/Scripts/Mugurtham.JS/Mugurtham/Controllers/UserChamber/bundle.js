/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR DISPLAYING VIEWED PROFILES IN USER HOME PAGE
==========================================================================================
*/
var ControllerViewedProfiles = angular.module('MugurthamApp').controller('ControllerViewedProfiles',
        ['$http', '$scope', function ($http, $scope) {

            $scope.ControllerName = 'ControllerViewedProfiles';
            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            $scope.getHighlightedProfiles = function () {
                var strGetURL = "Search/Search/getViewedProfiles";
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
        toastr.Error('Error occured in ControllerViewedProfiles - getData');
    }
}
/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR DISPLAYING HIGHLIGHTED PROFILES USER HOME PAGE
==========================================================================================
*/
var ControllerHighlightedProfiles = angular.module('MugurthamApp').controller('ControllerHighlightedProfiles',
        ['$http', '$scope', function ($http, $scope) {
            $scope.ControllerName = 'ControllerHighlightedProfiles';
            

            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            $scope.getHighlightedProfiles = function () {
                var strGetURL = "Search/Search/getHighlightedProfiles";
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
                $scope.profilePhotos = data.PhotoCoreEntityList;
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
        toastr.Error('Error occured in ControllerHighlightedProfiles - getData');
    }
}
 
/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR DISPLAYING VIEWED PROFILES IN USER HOME PAGE
==========================================================================================
*/
var ControllerInterestedInMeProfiles = angular.module('MugurthamApp').controller('ControllerInterestedInMeProfiles',
        ['$http', '$scope', function ($http, $scope) {

            $scope.ControllerName = 'ControllerInterestedInMeProfiles';
            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            $scope.getInterestedInMeProfiles = function () {
                var strGetURL = "User/User/getInterestedInMeProfiles";
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
        toastr.Error('Error occured in ControllerInterestedInMeProfiles - getData');
    }
}
/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR DISPLAYING VIEWED PROFILES IN USER HOME PAGE
==========================================================================================
*/
var ControllerInterestedProfiles = angular.module('MugurthamApp').controller('ControllerInterestedProfiles',
        ['$http', '$scope', function ($http, $scope) {

            $scope.ControllerName = 'ControllerInterestedProfiles';            
            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            $scope.getInterestedProfiles = function () {
                var strGetURL = "User/User/getInterestedProfiles";
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
        toastr.Error('Error occured in ControllerInterestedProfiles - getData');
    }
}
/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR RECENTLY JOINED PROFILES BY LASTWEEK IN USER HOME PAGE
==========================================================================================
*/
var ControllerRecentlyJoined = angular.module('MugurthamApp').controller('ControllerRecentlyJoined',
        ['$http', '$scope', function ($http, $scope) {

            $scope.ControllerName = 'ControllerRecentlyJoined';
            $('#BottomPagination').hide();
            $('#TopPagination').hide();
            $scope.tester = '';
            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================
            $scope.getRecentlyJoinedProfiles = function () {
                var strGetURL = "Search/Search/getRecentlyJoined";
                $("#divContainer").mask("Searching profiles please wait...");
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $("#divContainer").unmask();
                $scope.AllProfiles = data;
                $scope.currentPage = 0;
                $scope.pageSize = 5;
                $scope.pageNumber = [];
                for (i = 0; i <= $scope.AllProfiles.length / $scope.pageSize; i++) {
                    $scope.pageNumber.push(i + 1);
                }
                $scope.numberOfPages = function () {
                    return Math.ceil($scope.AllProfiles.length / $scope.pageSize);
                }

                $scope.roundNumber = function (value) {
                    return (Math.round(value) - 1);
                }
                $('#BottomPagination').show();
                $('#TopPagination').show();
                $('#liTopPreviousPage').hide();
                $('#liBottomPreviousPage').hide();
                $scope.showPage = function (value) {
                    setTimeout(displayThumbnailSlider, 1000);
                    $scope.currentPage = value;
                    $('#liBottomNextPage').show();
                    $('#liTopNextPage').show();
                    if ($scope.currentPage == 0) {
                        $('#liTopPreviousPage').hide();
                        $('#liBottomPreviousPage').hide();
                    }
                    else {
                        $('#liTopPreviousPage').show();
                        $('#liBottomPreviousPage').show();
                    }
                    $('#ulPageNumber li').removeClass('active');
                    $('#apageNumber' + (value + 1)).parent().addClass('active');
                    $('#ulbottomPageNumber li').removeClass('active');
                    $('#abottompageNumber' + (value + 1)).parent().addClass('active');
                    if (value == ($scope.numberOfPages() - 1)) {
                        $('#liBottomNextPage').hide();
                        $('#liTopNextPage').hide();
                    }
                }
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
        toastr.Error('Error occured in ControllerRecentlyJoined - getData');
    }
}
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