﻿/*************************************************************************
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
THIS SERVICE IS A TUTOR
==========================================================================================
*/

var app = angular.module('MugurthamApp');


app.service('ServiceSearchAllProfiles', ['$http', function ($http) {
    this.getData = function () {
        //return $http.get('/Scripts/Mugurtham.JS/Mugurtham/Jsons/SearchAllProfiles.json');
        return $http.get('Search/Search/getAllProfiles');
    }


}]);

