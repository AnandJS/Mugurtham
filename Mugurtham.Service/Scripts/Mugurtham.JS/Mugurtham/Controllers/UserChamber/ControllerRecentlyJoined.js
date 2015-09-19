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