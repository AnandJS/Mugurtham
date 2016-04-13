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
                $scope.currentPage = 0;
                $scope.pageSize = 5;
                $scope.pageNumber = [];
                for (i = 0; i <= $scope.AllProfiles.ProfileBasicInfoViewCoreEntityList.length / $scope.pageSize; i++) {
                    $scope.pageNumber.push(i + 1);
                }
                $scope.numberOfPages = function () {
                    return Math.ceil($scope.AllProfiles.ProfileBasicInfoViewCoreEntityList.length / $scope.pageSize);
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
        toastr.Error('Error occured in ControllerSearchGeneral - getData');
    }
}