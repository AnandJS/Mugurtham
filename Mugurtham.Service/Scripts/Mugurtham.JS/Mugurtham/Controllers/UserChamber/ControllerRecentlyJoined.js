/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR RECENTLY JOINED PROFILES BY LASTWEEK IN USER HOME PAGE
==========================================================================================
*/
var ControllerRecentlyJoined = angular.module('MugurthamApp').controller('ControllerRecentlyJoined',
        ['$http', '$scope', function ($http, $scope) {
            

            //===================================================
            //AJAX GET REQUEST - GETTING ALL PROFILES
            //===================================================

            //RecentlyJoinedProfiles

            $scope.getHighlightedProfiles = function () {
                if (typeof (Storage) !== "undefined") {
                    if (!sessionStorage.RecentlyJoinedProfiles) {
                        //alert('From API Service getHighlightedProfiles');
                        $scope.getHighlightedProfilesFromAPI();
                    }
                    else {
                        /*
                        //alert(sessionStorage.HiglightedProfiles + 'From Session Data getHighlightedProfiles');
                        var myjson = '{"TeamList" : [{"teamid" : "1","teamname" : "Barcelona"}]}';
                        var newJ = $.parseJSON(myjson);
                        //alert(newJ.TeamList[0].teamname);

                        var obj = $.parseJSON(sessionStorage.HiglightedProfiles);
                        //alert(obj.ProfileBasicInfoViewCoreEntityList[0].Name);
                       // alert($.parseJSON(sessionStorage.HiglightedProfiles));

                        $scope.SearchedProfiles = ($.parseJSON(sessionStorage.HiglightedProfiles).ProfileBasicInfoViewCoreEntityList);
                        $scope.AllProfiles = ($.parseJSON(sessionStorage.HiglightedProfiles));
                        */

                        $scope.AllProfiles = $.parseJSON(sessionStorage.RecentlyJoinedProfiles);
                        $scope.currentPage = 1;
                        $scope.pageSize = 15;
                        $scope.SearchedProfiles = ($.parseJSON(sessionStorage.RecentlyJoinedProfiles).ProfileBasicInfoViewCoreEntityList);
                        $scope.profilePhotos = ($.parseJSON(sessionStorage.RecentlyJoinedProfiles).PhotoCoreEntityList);
                        $scope.pageChangeHandler = function (num) {
                            setTimeout(displayThumbnailSlider, 1000);
                            console.log('Profiles page changed to ' + num);
                        };
                        setTimeout(displayThumbnailSlider, 1000);


                        // alert($scope.SearchedProfiles[0].Name);
                        //alert($scope.AllProfiles.PhotoCoreEntityList[0].PhotoPath);
                    }
                }
                else {
                    $scope.getHighlightedProfilesFromAPI();
                }
            }

            $scope.getHighlightedProfilesFromAPI = function () {
                var strGetURL = "Search/Search/GetRecentlyJoinedProfiles";
                $("#divContainer").mask("Searching profiles please wait...");
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $("#divContainer").unmask();
                $scope.AllProfiles = data;
                $scope.currentPage = 1;
                $scope.pageSize = 15;
                $scope.SearchedProfiles = data.ProfileBasicInfoViewCoreEntityList;
                $scope.profilePhotos = data.PhotoCoreEntityList;
                $scope.pageChangeHandler = function (num) {
                    setTimeout(displayThumbnailSlider, 1000);
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
 

