/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR FULL-VIEW PAGE ON VIEWS MODULE
==========================================================================================
*/
var ControllerViewFullView = angular.module('MugurthamApp').controller('ControllerViewFullView',
          ['$http', '$scope', '$routeParams', '$rootScope', function ($http, $scope, $routeParams, $rootScope) {

              //========================================
              //GLOBAL VARIABLES FOR THIS CONTROLLER
              //=========================================        
              $scope.controllerName = 'ControllerViewFullView';
              if (typeof $routeParams.ProfileID != 'undefined') {
                  $rootScope.globalProfileID = $routeParams.ProfileID;
              }
              // Form Control Variables
              $scope.globalProfileID = $rootScope.globalProfileID;

              //===================================================
              //AJAX GET REQUEST - GETTING ALL PROFILES
              //===================================================
              $scope.getByProfileID = function () {
                  $("#divContainer").mask("Loading profile please wait...");
                  $("#divSangamInfomration").hide();
                  $("#divFullProfile").hide();
                  $("#divInterestButton").hide();
                  $http({
                      method: "GET", url: '/View/FullView/getProfileByProfileID/' + $scope.globalProfileID
                  }).
                      success(function (data, status, headers, config) {
                          //By default hide the confidetial information
                          $("#divconfidentialInfo").hide();
                          if (data.validateFullViewAccess) {
                              $("#divSangamInfomration").hide();
                              $("#divFullProfile").show();
                          }
                          else {
                              $("#divSangamInfomration").show();
                              $("#divFullProfile").hide();
                          }
                          // Show confidential information on demand
                          if (data.UserCoreEntity.ShowHoroscope) {
                              $("#divconfidentialInfo").show();
                          }
                          $scope.AllProfiles = data;
                          if ($scope.AllProfiles.profileDOB != '')
                              $("#dtDOB").text($.datepicker.formatDate('dd-M-yy', new Date($scope.AllProfiles.profileDOB)));
                          // Check if this is an interested profile
                          $http({
                              method: "GET", url: '/View/FullView/getIsInterestedProfile/' + $scope.globalProfileID
                          }).
                              success(function (data, status, headers, config) {
                                  // 0 -> Not an interested Profile; 1 -> is an interested profile
                                  showHideInterestButton(data);
                                  $("#divInterestButton").show();
                              }).
                              error(function (data, status, headers, config) {
                                  NotifyStatus('2');
                              })
                          // Add profile to View notification entry
                          $http({
                              method: "GET", url: '/User/User/Add/' + $scope.globalProfileID
                          }).
                              success(function (data, status, headers, config) {
                              }).
                              error(function (data, status, headers, config) {
                                  NotifyStatus('2');
                              })
                          $("#divContainer").unmask();
                      }).
                   error(function (data, status, headers, config) {
                       $("#divContainer").unmask();
                       NotifyStatus('2');
                   })
              };
              $scope.showInterest = function () {                 
                  $http({
                      method: "GET", url: '/User/User/ShowInterest/' + $scope.globalProfileID
                  }).
                      success(function (data, status, headers, config) {
                          ToggleInterestButton();
                          NotifySuccessStatus('15');                         
                      }).
                   error(function (data, status, headers, config) {                       
                       NotifyStatus('2');
                   })
              };
              $scope.removeInterest = function () {
                  $http({
                      method: "GET", url: '/User/User/RemoveInterest/' + $scope.globalProfileID
                  }).
                      success(function (data, status, headers, config) {
                          ToggleInterestButton();
                          NotifySuccessStatus('16');
                      }).
                   error(function (data, status, headers, config) {
                       NotifyStatus('2');
                   })
              };
          }]);


function showHideInterestButton(intIsInterested) {
    if (intIsInterested == '1')
        $("#btnShowInterest").toggle();
    else
        $("#btnRemoveInterest").toggle();
}
function ToggleInterestButton() {
    $("#btnShowInterest").toggle();
    $("#btnRemoveInterest").toggle();
}


function NotifyStatus(intStatus) {
    /*
         1-> Success
         2-> Error
    */
    if (intStatus == '1') {
        toastr.success('Profile Received Successfully');
    }
    else if (intStatus == '2') {
        toastr.Error('Error occured in ControllerViewFullView - getData');
    }
}

function PrintFullProfile(globalProfileID) {
    $("#divFullProfile").jqprint();
}

