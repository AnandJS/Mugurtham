/*************************************************************************
 * Copyright (C) 2015 Mugurtham Technology, Incorporated 
 * All Rights Reserved.
 * 
 * NOTICE:  All the intellectual and technical concepts contained* herein are proprietary to Mugurtham Technology, Incorporated
 * and may be covered by Indian and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Mugurtham Technology, Incorporated.
/*************************************************************************

==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR ROLE REGISTRATION
==========================================================================================
*/


function displayChart(data) {
    $(document).ready(function () {
        $.jqplot.config.enablePlugins = true;
        var s1 = [2, 6, 7, 10];
        var ticks = ['Brides', 'Grooms', 'Active Profiles', 'InActive Profiles'];

        plot1 = $.jqplot('divBarReport', [s1], {
            // Only animate if we're not using excanvas (not in IE 7 or IE 8)..
            animate: !$.jqplot.use_excanvas,
            seriesDefaults: {
                renderer: $.jqplot.BarRenderer,
                pointLabels: { show: true }
            },
            axes: {
                xaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer,
                    ticks: ticks
                }
            },
            highlighter: { show: false }
        });



        plot4 = $.jqplot('divStackStar', [[[2, 1], [6, 2], [7, 3], [10, 4]], [[7, 1], [5, 2], [3, 3], [2, 4]], [[14, 1], [9, 2], [9, 3], [8, 4]]], {
            stackSeries: true,
            captureRightClick: true,
            seriesDefaults: {
                renderer: $.jqplot.BarRenderer,
                shadowAngle: 135,
                rendererOptions: {
                    barDirection: 'horizontal',
                    highlightMouseDown: true
                },
                pointLabels: { show: true, formatString: '%d' }
            },
            legend: {
                show: true,
                location: 'e',
                placement: 'outside'
            },
            axes: {
                yaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer
                }
            }
        });
    });


    var plot1 = jQuery.jqplot('divPieSales', [data],
      {
          seriesDefaults: {
              // Make this a pie chart.
              renderer: jQuery.jqplot.PieRenderer,
              rendererOptions: {
                  // Put data labels on the pie slices.
                  // By default, labels show the percentage of the slice.
                  showDataLabels: true,
                  placement: 'inside'
              }
          },
          legend: { show: true, location: 'e' }
      }
    );
}
var ControllerSangamDashboard = angular.module('MugurthamApp').controller('ControllerSangamDashboard',
        ['$http', '$scope', '$rootScope', '$routeParams', function ($http, $scope, $rootScope, $routeParams) {
            //========================================
            //GLOBAL VARIABLES FOR THIS CONTROLLER
            //=========================================            
            $scope.controllerName = 'ControllerSangamDashboard';
            $scope.globalProfileID = $rootScope.globalProfileID;
            $scope.frmData = []; // To store the values of the controls in form

            //===================================================
            //AJAX GET REQUEST - GETTING ROLE BY ID
            //===================================================
            $scope.getChartData = function () {
                var strGetURL = '/Home/getSangamDashBoardChart';

                $http({
                    method: "GET", url: strGetURL,
                    headers: {
                        'content-Type': 'application/x-www-form-urlencoded',
                        "MugurthamUserToken": getLoggedInUserID(),
                        "CommunityID": getLoggedInUserCommunityID()
                    }
                }).
                success(function (data, status, headers, config) {
                    var strChartData = [];
                    var strCount = ''; var strMonth = '';
                    $.each(data, function (index, value) {
                        $.each(value, function (index, value) {
                            if (index == 'Count')
                                strCount = value;
                            if (index == 'Month')
                                strMonth = value;
                        });
                        strChartData.push([strMonth, strCount]);
                    });
                    displayChart(strChartData);
                }).
               error(function (data, status, headers, config) {
                   NotifyErrorStatus(data, status);
               });
            };

            //===================================================
            //AJAX GET REQUEST - GETTING DASHBOARD DATA
            //===================================================
            $scope.getDashboardData = function () {
                var strGetURL = '/SangamAdmin/SangamAdmin/getSangamDashboardData';
                $http({
                    method: "GET", url: strGetURL,
                    headers: {
                        'content-Type': 'application/x-www-form-urlencoded',
                        "MugurthamUserToken": getLoggedInUserID(),
                        "CommunityID": getLoggedInUserCommunityID()
                    }
                }).
                success(function (data, status, headers, config) {
                    $scope.LoggedInCount = data.TotalLogin;
                    $scope.ViewedProfile = data.ProfilesViewed;
                    $scope.ActiveProfiles = data.ActiveProfiles;
                    $scope.TotalProfiles = data.TotalProfiles;
                }).
               error(function (data, status, headers, config) {
                   NotifyErrorStatus(data, status);
               });
            };





        }])

