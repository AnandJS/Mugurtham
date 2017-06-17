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
THIS CONTROLLER IS SPECIFICALLY FOR PAYMENT PROFILE TRANSACTIONS PAGE ON PAYMENT MODULE
==========================================================================================
*/
var ControllerPaymenSuccess = angular.module('MugurthamApp').controller('ControllerPaymenSuccess',
          ['$http', '$scope', '$routeParams', '$rootScope', function ($http, $scope, $routeParams, $rootScope) {

              //========================================
              //GLOBAL VARIABLES FOR THIS CONTROLLER
              //=========================================   
              $scope.controllerName = 'ControllerPaymentProfileTransactions';
              $scope.TransactionID = '';

              if (typeof $routeParams.TransactionID != 'undefined') {
                  $scope.TransactionID = $routeParams.TransactionID;
              }
          }
          ]);

