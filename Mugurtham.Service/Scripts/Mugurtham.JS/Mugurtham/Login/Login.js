$(document).ready(function () {

    $('#Password').keypress(function (e) {
        var key = e.which;
        if (key == 13)  // the enter key code
        {
            $('input[name = btnLogin]').click();
            return false;
        }
    });
    $("#btnLogin").click(function () {
        if ($('#LoginID').val().length == 0) {
            alert('Please enter Login ID');
            $('#LoginID').focus();
            return false;
        }
        if ($('#Password').val().length == 0) {
            alert('Please enter Password');
            $('#Password').focus();
            return false;
        }
        $("#container").mask("Signing in please wait...");
        $.post("/Home/validateLogin",
{
    LoginID: $('#LoginID').val(),
    Password: $('#Password').val()
},
function (data, status) {
    $("#container").unmask();
    if (data.LoginStatus == '1') {
        //location.reload();

        //Setting the global popup for advertisenment
        if (typeof (Storage) !== "undefined") {
            localStorage.setItem("landingFirstTimeCount", "0");
        }
        else {
            toastr.error("Sorry, your browser does not support web storage...");
        }
        var homePagePath = '/' + data.HomePagePath;
        if (window.location.href.indexOf('FullView') !== -1)
            homePagePath = '/Mugurtham#' + window.location.href.split('/Mugurtham/')[1];
        else if (window.location.href.indexOf('Dashboard') !== -1)
            homePagePath = '/' + data.HomePagePath;
        else if (window.location.href.indexOf('ProfileID') !== -1)
            homePagePath = '/' + data.HomePagePath;
        else if (window.location.href.indexOf('undefined') !== -1)
            homePagePath = '/' + data.HomePagePath;
        else if (window.location.href.indexOf('Home') !== -1)
            homePagePath = '/' + data.HomePagePath;
        else
            homePagePath = '/Mugurtham#' + window.location.href.split('/Mugurtham/')[1];

        window.location = homePagePath;
    }
    else if (data.LoginStatus == '2') {
        alert('In valid User');
    }
    else if (data.LoginStatus == '3') {
        alert('In valid Password');
    }
    else if (data.LoginStatus == '4') {
        alert('Your Sangam is deactivated from Mugurtham');
    }
    else if (data.LoginStatus == '5') {
        alert('Your profile is deactivated  by user sangam');
    }
    else if (data.LoginStatus == '6') {
        alert('Server Maintenance - We sincerely apologize for the inconvinience. We will be back soon');
    }
}).fail(function (response) {
    alert('Error: ' + response.responseText);
    $("#container").unmask();
});

    });// Button Click

    $("#linkPublicUser").click(function () {
        $("#content").mask("Signing in please wait...");
        $.post("/Home/validateLogin",
{
    LoginID: 'publicuser',
    Password: 'publicuser'
},
function (data, status) {
    $("#content").unmask();
    if (data.LoginStatus == '1') {
        location.reload();
        window.location = data.HomePagePath;
    }
    else if (data.LoginStatus == '2') {
        alert('In valid User');
    }
    else if (data.LoginStatus == '3') {
        alert('In valid Password');
    }
    else if (data.LoginStatus == '4') {
        alert('Your Sangam is deactivated from Mugurtham');
    }
    else if (data.LoginStatus == '5') {
        alert('Your profile is deactivated  by user sangam');
    }
});

    });// Link click

});