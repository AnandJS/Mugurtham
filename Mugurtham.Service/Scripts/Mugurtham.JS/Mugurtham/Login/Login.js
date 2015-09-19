$(document).ready(function () {
    $("#btnLogin").click(function () {
        $("#content").mask("Signing in please wait...");
        $.post("Home/validateLogin",
{
    LoginID: $('#LoginID').val(),
    Password: $('#Password').val()
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

    });// Button Click

    $("#linkPublicUser").click(function () {
        $("#content").mask("Signing in please wait...");
        $.post("Home/validateLogin",
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