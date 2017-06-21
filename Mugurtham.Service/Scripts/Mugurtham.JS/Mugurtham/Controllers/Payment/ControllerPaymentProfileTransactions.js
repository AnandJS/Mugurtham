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

var dataset = '';
var ControllerPaymentProfileTransactions = angular.module('MugurthamApp').controller('ControllerPaymentProfileTransactions',
          ['$http', '$scope', '$routeParams', '$rootScope', function ($http, $scope, $routeParams, $rootScope) {

              //========================================
              //GLOBAL VARIABLES FOR THIS CONTROLLER
              //=========================================   
              $scope.controllerName = 'ControllerPaymentProfileTransactions';
              //$scope.Transactions = data;

              //===================================================
              //AJAX GET REQUEST - GET ALL PROFILE PAYMENT TRANSACTIONS
              //===================================================
              $scope.getAllPaymentTransactions = function () {
                  $("#divContainer").mask("Loading all Payment Transactions please wait...");
                  $http({
                      method: "GET", url: '/PaymentAPI/ProfilePaymentAPI/GetAllPaymentTransactions',
                     // method: "GET", url: '/Role/RoleAPI',
                      headers: {
                          "MugurthamUserToken": getLoggedInUserID(),
                          "CommunityID": getLoggedInUserCommunityID()
                      }
                  }).
              success(function (data, status, headers, config) {
                  $("#divContainer").unmask();
                  loadTable(data);
              }).
                  error(function (data, status, headers, config) {
                      $("#divContainer").unmask();
                      NotifyErrorStatus(data, status);
                  });
              }

          }] // Controller
   ); // Module

function loadTable(objTransaction) {
    $('#tblTransactions').DataTable({
        dom: 'Bfrtip',
        buttons: [
          /*  {
                extend: 'copyHtml5',
                exportOptions: {
                    columns: ':contains("Office"),:contains("Name")'
                }
            },*/

            {
                extend: 'print',
                customize: function (win) {
                    $(win.document.body)
                        .css('font-size', '10pt')
                        .prepend(
                            '<img src="https://www.mugurtham.com/Images/Mugurtham/General/logo.png" style="position:absolute; opacity: 0.25;    font-size: 3em;    width: 100%;    text-align: center;    z-index: 1000; top:300; left:0;" />'
                        );

                    $(win.document.body).find('table')
                        .addClass('compact')
                        .css('font-size', 'inherit');
                }
            },

          /*  'excelHtml5',
            'csvHtml5',*/
            'pdfHtml5'
           // 'print'
        ],
        //https://datatables.net/forums/discussion/26721/add-custom-headers-to-ajax-when-loading-data
        "data": objTransaction,
        "columns": [
            { "data": "TransactionID" },
            { "data": "PaymentDate" },
            { "data": "PaymentAmount" },
            { "data": "PaymentMode" },
            { "data": "PaymentFor" },
            { "data": "PaymentNotes" } 
        ]
    });
};