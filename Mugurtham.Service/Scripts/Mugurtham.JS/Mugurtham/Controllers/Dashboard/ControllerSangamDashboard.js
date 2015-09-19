/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR ROLE REGISTRATION
==========================================================================================
*/

function displayChart(data) {

    var plot1 = jQuery.jqplot('chart1', [data],
      {
          seriesDefaults: {
              // Make this a pie chart.
              renderer: jQuery.jqplot.PieRenderer,
              rendererOptions: {
                  // Put data labels on the pie slices.
                  // By default, labels show the percentage of the slice.
                  showDataLabels: true
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
                    method: "GET", url: strGetURL
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

        }])



