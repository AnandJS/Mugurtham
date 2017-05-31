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
        $("#divLoginPopup").mask("Signing in please wait...");
        $.post("/Home/validateLogin",
{
    LoginID: $('#LoginID').val(),
    Password: $('#Password').val(),
    CommunityID: $('#ddlCommunityPopup').val()

},
function (data, status) {
    $("#divLoginPopup").unmask();

    //quick fix for homepage masking bug -- please find solution and remove below line
    localStorage.setItem("landingFirstTimeCount", "0");

    if (data.LoginStatus == '1') {
        //location.reload(); // IE fix - IE doesnt support this command

        //Setting the global popup for advertisenment
        if (typeof (Storage) !== "undefined") {
            localStorage.setItem("landingFirstTimeCount", "0");
            localStorage.setItem("LoggedInUserID", $('#LoginID').val());
            localStorage.setItem("CommunityID", $('#ddlCommunityPopup').val());
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
        else {
            //homePagePath = '/Mugurtham#' + window.location.href.split('/Mugurtham/')[1];
            homePagePath = '/' + data.HomePagePath;
        }

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
        alert('Connection Timed Out - Please contact HIOX team - We sincerely apologize for the inconvinience. We will be back soon. Timeout expired. An error occurred while executing the command definition. See the inner exception for details. The timeout period elapsed prior to completion of the operation or the server is not responding. System.ComponentModel.Win32Exception (0x80004005): The wait operation timed out');
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


function setLoginCommunityDDL() {
    $("#ddlCommunityPopup").val($('#ddlCommunity').val());
}