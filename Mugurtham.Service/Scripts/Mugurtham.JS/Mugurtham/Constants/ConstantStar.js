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




//https://docs.angularjs.org/error/$injector/unpr?p0=FactoryMatchingProfilesProvider%20%3C-%20FactoryMatchingProfiles

    var app = angular.module('MugurthamApp');


app.constant('ConstantMatchingStarsForGroom', {
     
    Avittam: [
                { ID: 1, Star: 'Aswini', Match: '8', Category: 'Uthamam', Accepted: 'True' },
                { ID: 19, Star: 'Pooraadam', Match: '5', Category: 'Mathimam', Accepted: 'True' }

    ]

});
