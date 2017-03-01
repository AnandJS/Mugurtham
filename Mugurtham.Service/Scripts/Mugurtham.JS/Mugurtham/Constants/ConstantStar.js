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
THIS CONTROLLER IS SPECIFICALLY FOR ROLE REGISTRATION
==========================================================================================
*/

//http://www.advancesharp.com/blog/1194/angularjs-constant-and-enum-with-example
//https://tylermcginnis.com/angularjs-factory-vs-service-vs-provider/
//https://www.tutorialspoint.com/angularjs/index.htm

http://tutorials.jenkov.com/angularjs/dependency-injection.html -- Angular JS Modularzation
//http://stackoverflow.com/questions/16828287/what-things-can-be-injected-into-others-in-angular-js -- Nice
//http://stackoverflow.com/questions/31432522/how-to-inject-service-to-angular-constant

//http://stackoverflow.com/questions/16881478/how-to-call-a-method-defined-in-an-angularjs-directive
//http://stackoverflow.com/questions/27710037/angularjs-templateurl-file-location-not-found



    var app = angular.module('MugurthamApp');


app.constant('ConstantMatchingStarsForGroom', {
    Aswini: [
                { ID: 1, Star: 'Barani', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                { ID: 2, Star: 'Karthigai', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                { ID: 3, Star: 'Rohini', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                { ID: 4, Star: 'Mrigasheersham', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                { ID: 5, Star: 'Thiruvaathirai', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                { ID: 6, Star: 'Punarpoosam', Match: '9', Category: 'Uthamam', Accepted: 'True' },
                { ID: 7, Star: 'Poosam', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                { ID: 8, Star: 'Pooram', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                { ID: 9, Star: 'Uthiram', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                { ID: 10, Star: 'Anusham', Match: '6', Category: 'Uthamam', Accepted: 'True' },
                { ID: 11, Star: 'Pooraadam', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                { ID: 12, Star: 'Uthiraadam', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                { ID: 13, Star: 'Thiruvonam', Match: '6', Category: 'Uthamam', Accepted: 'True' },
                { ID: 14, Star: 'Chithirai', Match: '6', Category: 'Mathimam', Accepted: 'True' },
                { ID: 15, Star: 'Visaakam', Match: '8', Category: 'Mathimam', Accepted: 'True' },
                { ID: 16, Star: 'Sadayam', Match: '5', Category: 'Mathimam', Accepted: 'True' },
                { ID: 17, Star: 'Poorattathi', Match: '6', Category: 'Mathimam', Accepted: 'True' },
                { ID: 18, Star: 'Uthirattathi', Match: '5', Category: 'Mathimam', Accepted: 'True' },
                { ID: 19, Star: 'Avittam', Match: '6', Category: 'Mathimam', Accepted: 'True' }
    ],
    Bharani: [
                    { ID: 1, Star: 'Ashwini', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 2, Star: 'Rohini', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 3, Star: 'Mrigasheersham', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 4, Star: 'Thiruvaathirai', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 5, Star: 'Punarpoosam', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 6, Star: 'Uthiram', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 7, Star: 'Hastham', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 8, Star: 'Swaathi', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 9, Star: 'Uthiraadam', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 10, Star: 'Thiruvonam', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 11, Star: 'Karthigai', Match: '7', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 12, Star: 'Aayilyam', Match: '6', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 13, Star: 'Makam', Match: '7', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 14, Star: 'Kettai', Match: '5', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 15, Star: 'Moolam', Match: '6', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 16, Star: 'Revathi', Match: '5', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 17, Star: 'Chithirai', Match: '7', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 18, Star: 'Visakkam', Match: '6', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 19, Star: 'Sadayam', Match: '5', Category: 'Mathimam', Accepted: 'True' }
    ],
    Karthigai: [
                    { ID: 1, Star: 'Ashwini', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 2, Star: 'Bharani', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 3, Star: 'Rohini', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 4, Star: 'Mrigasheersham', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 5, Star: 'Thiruvaathirai', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 6, Star: 'Poosam', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 7, Star: 'Aayilyam', Match: '9', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 8, Star: 'Makam', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 9, Star: 'Pooram', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 10, Star: 'Hastham', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 11, Star: 'Swaathi', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 12, Star: 'Anusham', Match: '6', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 13, Star: 'Kettai', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 14, Star: 'Moolam', Match: '6', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 15, Star: 'Revathi', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 16, Star: 'Karthigai', Match: '0', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 17, Star: 'Chithirai', Match: '6', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 18, Star: 'Sadayam', Match: '5', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 19, Star: 'Uthirattathi', Match: '5', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 20, Star: 'Avittam', Match: '7', Category: 'Mathimam', Accepted: 'True' }
    ],
    Avittam: [
                    { ID: 1, Star: 'Ashwini', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 2, Star: 'Bharani', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 3, Star: 'Rohini', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 4, Star: 'Mrigasheersham', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 5, Star: 'Thiruvaathirai', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 6, Star: 'Poosam', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 7, Star: 'Aayilyam', Match: '9', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 8, Star: 'Makam', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 9, Star: 'Pooram', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 10, Star: 'Hastham', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 11, Star: 'Swaathi', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 12, Star: 'Anusham', Match: '6', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 13, Star: 'Kettai', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 14, Star: 'Moolam', Match: '6', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 15, Star: 'Revathi', Match: '7', Category: 'Uthamam', Accepted: 'True' },
                    { ID: 16, Star: 'Karthigai', Match: '0', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 17, Star: 'Chithirai', Match: '6', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 18, Star: 'Sadayam', Match: '5', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 19, Star: 'Uthirattathi', Match: '5', Category: 'Mathimam', Accepted: 'True' },
                    { ID: 20, Star: 'Avittam', Match: '7', Category: 'Mathimam', Accepted: 'True' }
    ]




});
