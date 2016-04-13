

(function () {

   

    var app = angular.module('MugurthamApp', ['ngRoute', 'pascalprecht.translate'])

    /*=====================================================================*/
    /*COMPLETE PAGINATION IS HANDLED BELOW*/
    /*=====================================================================*/
    //We already have a limitTo filter built-in to angular,
    //let's make a startFrom filter
    app.filter('startFrom', function () {
        return function (input, start) {
            start = +start; //parse to int
            return input.slice(start);
        }
    });
    /*=====================================================================*/
    /*COMPLETE ROUTING IS HANDLED BELOW*/
    /*=====================================================================*/

    app.config(['$routeProvider', '$translateProvider', function ($routeProvider, $translateProvider) {
        $routeProvider

             /*=====================================================================*/
            /*USER MODULE ROUTING DEFINED
            /*=====================================================================*/
            .when('/ProfileUserDashboard', {
                templateUrl: '/User/User/HighlightedProfiles',
                controller: 'ControllerHighlightedProfiles'
            })
            .when('/ViewNotifications', {
                templateUrl: '/User/User/ViewedProfiles',
                controller: 'ControllerViewedProfiles'
            })
            .when('/InterestedProfiles', {
                templateUrl: '/User/User/InterestedProfiles',
                controller: 'ControllerInterestedProfiles'
            })
            .when('/InterestedInMeProfiles', {
                templateUrl: '/User/User/InterestedInMeProfiles',
                controller: 'ControllerInterestedInMeProfiles'
            })
            // route for the Basic Information View
             .when('/BasicInfo', {
                 templateUrl: '/Profile/Profile/BasicInfo',
                 controller: 'ControllerProfileBasicInfo'
             })
             // route for the Basic Information View on specific profile ID
             .when('/BasicInfo/:ProfileID', {
                 templateUrl: '/Profile/Profile/BasicInfo',
                 controller: 'ControllerProfileBasicInfo'
             })
            // route for the Basic Education View
             .when('/Career', {
                 templateUrl: '/Profile/Profile/Career',
                 controller: 'ControllerProfileCareer'
             })

             // route for the  Contact View
             .when('/Contact', {
                 templateUrl: '/Profile/Profile/Contact',
                 controller: 'ControllerProfileContact'
             })

             // route for the  Family View
             .when('/Family', {
                 templateUrl: '/Profile/Profile/Family',
                 controller: 'ControllerProfileFamily'
             })

             // route for the  Location View
             .when('/Location', {
                 templateUrl: '/Profile/Profile/Location',
                 controller: 'ControllerProfileLocation'
             })
             // route for the  Reference View
             .when('/Reference', {
                 templateUrl: '/Profile/Profile/Reference',
                 controller: 'ControllerProfileReference'
             })
             // route for the Basic Horoscope View
             .when('/Horoscope', {
                 templateUrl: '/Profile/Profile/Horoscope',
                 controller: 'ControllerProfileHoroscope'
             })

             // route for the  Photo View
             .when('/Photo', {
                 templateUrl: '/Profile/Profile/Photo',
                 controller: 'ControllerProfilePhoto'
             })

             // route for the  Album View
            .when('/Album', {
                templateUrl: '/Profile/Profile/Album'
            })

       /*======================================================*/
       /*ROUTING FOR SEARCH MODULE STARTS HERE*/
       /*======================================================*/
        // route for the  ProfileID Search
             .when('/ProfileID', {
                 templateUrl: '/Search/Search/ProfileID',
                 controller: 'ControllerSearchProfileID'
             })
        // route for the  All Profiles Search
        .when('/AllProfiles', {
            templateUrl: '/Search/Search/AllProfiles',
            controller: 'ControllerSearchAllProfiles'
        })
         // route for the  General Search 
        .when('/GeneralSearch', {
            templateUrl: '/Search/Search/GeneralSearch',
            controller: 'ControllerSearchGeneral'
        })
          // route for the  SangamSearch 
        .when('/SangamSearch', {
            templateUrl: '/Search/Search/SangamSearch',
            controller: 'ControllerSearchSangam'
        })
       /*======================================================*/
       /*ROUTING FOR VIEW MODULE STARTS HERE*/
       /*======================================================*/
          // route for the  fullview View
        .when('/FullView/:ProfileID', {
            templateUrl: '/View/FullView/FullView',
            controller: 'ControllerViewFullView'
        })
         /*======================================================*/
       /*ROUTING FOR MUGURTHAM ADMIN STARTS HERE*/
       /*======================================================*/
          // route for the  fullview View
        .when('/MugurthamDashboard', {
            templateUrl: '/MugurthamAdmin/MugurthamAdmin/Dashboard'
        })
        .when('/SangamList', {
            templateUrl: '/MugurthamAdmin/Sangam/List',
            controller: 'ControllerSangam'
        })
      .when('/SangamForm', {
          templateUrl: '/MugurthamAdmin/Sangam/Form',
          controller: 'ControllerSangam'
      })
        .when('/SangamForm/:SangamID', {
            templateUrl: '/MugurthamAdmin/Sangam/Form',
            controller: 'ControllerSangam'
        })
        .when('/MugurthamProfiles', {
            templateUrl: '/MugurthamAdmin/MugurthamAdmin/Profiles',
            controller: 'ControllerUser'
        })
        /*======================================================*/
       /*ROUTING FOR SANGAM ADMIN STARTS HERE*/
       /*======================================================*/
        .when('/SangamDashboard', {
            templateUrl: '/SangamAdmin/SangamAdmin/Dashboard',
            controller: 'ControllerSangamDashboard'
        })
        .when('/SangamAdminSettings', {
            templateUrl: '/SangamAdmin/SangamAdmin/Settings'
        })
        .when('/SangamAdminProfiles', {
            templateUrl: '/SangamAdmin/SangamAdmin/SangamAdminProfiles',
            controller: 'ControllerSearchAllProfiles'
        })
        .when('/SangamUserList', {
            templateUrl: '/SangamAdmin/SangamUser/List',
            controller: 'ControllerUser'
        })
        .when('/SangamUserForm/:UserID', {
            templateUrl: '/SangamAdmin/SangamUser/Form',
            controller: 'ControllerUser'
        })
         /*======================================================*/
       /*ROUTING FOR ROLE STARTS HERE*/
       /*======================================================*/
        .when('/RoleList', {
            templateUrl: '/MugurthamAdmin/Role/List',
            controller: 'ControllerRole'
        })
        .when('/RoleForm', {
            templateUrl: '/MugurthamAdmin/Role/Form',
            controller: 'ControllerRole'
        })
        .when('/RoleForm/:RoleID', {
            templateUrl: '/MugurthamAdmin/Role/Form',
            controller: 'ControllerRole'
        })
         /*======================================================*/
       /*ROUTING FOR USER STARTS HERE*/
       /*======================================================*/

        .when('/UserList', {
            templateUrl: '/MugurthamAdmin/User/List',
            controller: 'ControllerUser'
        })
        .when('/UserForm', {
            templateUrl: '/MugurthamAdmin/User/Form',
            controller: 'ControllerUser'
        })
        .when('/UserForm/:UserID', {
            templateUrl: '/MugurthamAdmin/User/Form',
            controller: 'ControllerUser'
        })
        .when('/UserSettingsForm', {
            templateUrl: '/User/User/UserSettingsForm',
            controller: 'ControllerUser'
        })
         .when('/RecentlyJoined', {
             templateUrl: '/User/User/RecentlyJoined',
             controller: 'ControllerRecentlyJoined'

         })


        ;

        //My Reference for transalation - best one
        //https://angular-translate.github.io/
        /*
        <p translate="FOO">Dies ist ein Paragraph.</p>
        <button class="btn ng-scope" ng-click="changeLanguage('en')" translate="BUTTON_LANG_EN">englisch</button>
        */

        /*****************TRANSALATION STARTS HERE ***********************************/
        //https://msdn.microsoft.com/en-us/goglobal/bb964664.aspx
        $translateProvider.translations('0409', {

            GENHOME: 'Home',
            GENSRCH: 'Search',
            GENVIEW: 'View',
            GENPROF: 'Profile',
            GENMALE: 'Male',
            GENFEMALE: 'Female',
            GENPROFID: 'Profile ID',
            GENSAVE: 'Save',
            GENCOPYRT: 'Copyright',
            GENSANGAM: 'Sangam',
            GENABOUT: 'About',
            LYTSRCH: 'Search',
            LYTPROFILES: 'Profiles',
            LYTSHRTLISPROFILES: 'Profiles I liked',
            LYTEDITMYPROFILE: 'Edit My Profile',
            LYTSETTINGS: 'Settings',
            LYTUSRHOME: 'User Home',
            LYTPROFDASHBRD: 'Profile Dashboard',
            LYTPRFREGFOR: 'Profile Registration - for Profile ID',
            LYTPRFTABBI: 'Basic Information',
            LYTPRFTABCAR: 'Career',
            LYTPRFTABCONT: 'Contact',
            LYTPRFTABFAM: 'Family',
            LYTPRFTABLOC: 'Location',
            LYTPRFTABREF: 'Reference',
            LYTPRFTABHORO: 'Horoscope',
            LYTPRFTABPHO: 'Photo',
            BIBINFREGFRM: 'Basic Information Registration Form',
            BISANGAMUSERID: 'Sangam User ID',
            BINAME: 'Name',
            BIAGE: 'Age',
            BIGEN: 'Gender',
            BIDOB: 'Date of Birth',
            BITOB: 'Time of Birth',
            BIMARSTATUS: 'Marital Status',
            BINOOFCHIL: 'No Of Children',
            BICHILLVNGST: 'Children living status',
            BIHEIGHT: 'Height',
            BIWEIGHT: 'Weight',
            BIBDYTPE: 'Body Type',
            BICOMPLEXION: 'Complexion',
            BIPHYSTA: 'Physical Status',
            BIBLGRP: 'Blood Group',
            BIMOTONG: 'Mother Tongue',
            BIPROFCRBY: 'Profile created by',
            BIRLGN: 'Religion',
            BICST: 'Caste',
            BISUBCST: 'SubCaste',
            BIGOTHRM: 'Gothra(m)',
            BISTR: 'Star',
            BIRAASI: 'Raasi',
            BIHORMTCH: 'Horoscope Match',
            BIANYDHSM: 'Any Dhosham',
            BIETNG: 'Eating',
            BISMKNG: 'Smoking',
            BIDRNKNG: 'Drinking',
            BIABTME: 'About Me',
            BIPRTNTEXPTN: 'Partner Expectation',
            BIHELP: 'This form is used to collect all the basic information about this profile which helps in showcasing this profile to the views who are in search.',
            CRIRF: 'Career Information Registration Form',
            CREDUC: 'Education',
            CREDUCDT: 'Education in detail',
            CREMPIN: 'Employed In',
            CROCCPTN: 'Occupation',
            CROCCPTNDTL: 'Occupation in detail',
            CRANINC: 'Annual Income',
            CRHELP: 'This form is used to collect information about the Education details, Occupation details of this profile',
            CONRF: 'Contact Information Registration Form',
            CONEMAIL: 'Email',
            CONMOBNO: 'Mobile Number',
            CONLNDNO: 'Landline Number',
            CONRESADR: 'Residential Address',
            CONREL: 'Relationship',
            CONTMETOCALL: 'Time to call',
            CONHELP: 'This form is used to collect information about the contact details about this profile',
            FAMIRF: 'Family Information Registration Form',
            FAMVAL: 'Family Value',
            FAMTYP: 'Family Type',
            FAMSTA: 'Family Status',
            FAMFATNAM: 'Fathers Name',
            FAMMOTNAM: 'Mothers Name',
            FAMFATOCC: 'Fathers Occupation',
            FAMMOTOCC: 'Mothers Occupation',
            FAMANSFAMORG: 'Ancestral / Family Origin',
            FAMNOOFBRO: 'No of Brothers',
            FAMMARDBRO: 'Married Brothers',
            FAMNOOFSIS: 'No of Sisters',
            FAMMARDSIS: 'Married Sisters',
            FAMABTFAM: 'About Family',
            FAMHELP: 'This form is used to collect information about the family details of this profile',
            LOCIRF: 'Location Information Registration Form',
            LOCTRYLVNIN: 'Country Living In',
            LOCTNSHP: 'Citizenship',
            LOCRESSTS: 'Residential Status',
            LOCRESTATE: 'Resident State',
            LOCRESCTY: 'Resident City',
            LOCHLP: 'This form is used to collect information about the location information about this profile',
            REFIRF: 'Reference Information Registration Form',
            REFNOMNAME: 'Nominee Name',
            REFCONTNUM: 'Contact Number',
            REFHLP: 'This form is used to collect information about the people who are reference for this profile',
            HOROIRF: 'Horoscope Information Registration Form',
            HORSOORIYAN: 'SOORIYAN',
            HORBUDHAN: 'BUDHAN',
            HORGURU: 'GURU',
            HORKETHU: 'KETHU',
            HORCHANDRAN: 'CHANDRAN',
            HORSUKRAN: 'SUKRAN',
            HORRAGHU: 'RAGHU',
            HORLAGNAM: 'LAGNAM',
            HORSEVAI: 'SEVAI',
            HORSANI: 'SANI',
            PHOIRF: 'Profile Photo Information Registration Form ',
            PHOHLP: 'This form is used to upload the Profile / Album photos of this profile',
            LYTSRCPROFSRC: 'Profile Search',
            LYTSRCALLPROF: 'All Profiles',
            LYTGENSRC: 'General Search',
            LYTSGMSRC: 'Sangam Search',
            SRCIDPROFID: 'Search By Profile ID',
            SRCIDHLP: 'This form is used to collect profile ID and displays the profile information',
            SRCGENHLP: 'This form is used to collect profile ID and displays the profile information',
            SRCSGMSRCH: 'Search by Sangam',
            SRCSGMFLTRBYSGM: 'Filter by Sangam',
            SRCSGMHLP: 'This form is used to collect profile ID and displays the profile information',
            VWSGMINFOFORPROFID: 'Sangam Information for Profile ID',
            VWRESTXT: 'To view the full information of this Profile, you got to register in this Sangam. <br> Please find the Sangam details below to register. Once you registered, you will be able to access the full information.',
            VWCTADRS: 'Contact Address',
            VWABTSGM: 'About Sangam',
            VWFULLPROFVW: 'Full Profile View for Profile ID',
            LYTRCNTLYJNDPROFILES: 'Profiles joined  recently',
            LYTPROFILESLKDME: 'Profiles liked me',
            LYTPROFILESVWDME: 'Profiles viewed me',
            LYTPROFILESHGLTD: 'Highlighted Profiles',



        });
        $translateProvider.translations('0449', {
            GENHOME: 'முகப்பு பக்கம்',
            GENSRCH: 'தேடல்',
            GENVIEW: 'காண்க',
            GENPROF: 'வரன்',
            GENMALE: 'ஆண்',
            GENFEMALE: 'பெண்',
            GENPROFID: 'வரன் எண்',
            GENSAVE: 'சேமி',
            GENCOPYRT: 'பதிப்புரிமை',
            GENSANGAM: 'சங்கம்',
            GENABOUT: 'குறிப்பு',
            LYTSRCH: 'தேடுக',
            LYTPROFILES: ' வரன்கள்',
            LYTSHRTLISPROFILES: 'என்னக்கு பிடித்தவர்கள்',
            LYTEDITMYPROFILE: 'சுய தகவல் திருத்தம்',
            LYTSETTINGS: 'அமைப்புகள்',
            LYTUSRHOME: 'பயனர் முகப்பு',
            LYTPROFDASHBRD: 'சுய தகவல்',
            LYTPRFREGFOR: 'Profile Registration - for Profile ID',
            LYTPRFTABBI: 'அடிப்படை தகவல்',
            LYTPRFTABCAR: 'கேரியர்',
            LYTPRFTABCONT: 'தொடர்பு',
            LYTPRFTABFAM: 'குடும்பம்',
            LYTPRFTABLOC: 'இடம்',
            LYTPRFTABREF: 'சான்றாதாரம்',
            LYTPRFTABHORO: 'ஜாதகம்',
            LYTPRFTABPHO: 'புகைப்படம்',
            BIBINFREGFRM: 'அடிப்படை தகவல் பதிவு படிவம்',
            BISANGAMUSERID: 'எண்',
            BINAME: 'பெயர்',
            BIAGE: 'வயது',
            BIGEN: 'பாலினம்',
            BIDOB: 'பிறந்த தேதி',
            BITOB: 'பிறந்த நேரம்',
            BIMARSTATUS: 'திருமண நிலை',
            BINOOFCHIL: 'குழந்தைகள் எண்ணிக்கை',
            BICHILLVNGST: 'குழந்தைகள் உங்களுடன் இருகிறார்களா',
            BIHEIGHT: 'உயரம்',
            BIWEIGHT: 'எடை',
            BIBDYTPE: 'உடல் அமைப்பு',
            BICOMPLEXION: 'நிறம்',
            BIPHYSTA: 'உடல் தகுதி',
            BIBLGRP: 'இரத்தப் பிரிவு',
            BIMOTONG: 'தாய்மொழி',
            BIPROFCRBY: 'சுயவிவரம் உருவாக்கிய்து யார்',
            BIRLGN: 'மதம்',
            BICST: 'ஜாதி',
            BISUBCST: 'ஜாதி உட்பிரிவு',
            BIGOTHRM: 'கோத்ரம்',
            BISTR: 'ஸ்டார்',
            BIRAASI: 'ராசி',
            BIHORMTCH: 'ஜாதகப்பொருத்தம்',
            BIANYDHSM: 'தோஷம் இருக்கிறதா',
            BIETNG: 'Eating',
            BISMKNG: 'புகைபிடிக்கும் பழக்கம் உண்டா',
            BIDRNKNG: 'மது அருந்தும் பழக்கம் உண்டா',
            BIABTME: 'என்னைப் பற்றி',
            BIPRTNTEXPTN: 'துணை பற்றிய எதிர்பார்ப்பு',
            BIHELP: 'இந்த வடிவம் தேடி இருந்தால் யார் பார்வையாளர்கள் இந்த சுயவிவரத்தை காண்பிக்கும் உதவுகிறது இந்த சுயவிவரம் பற்றி அனைத்து அடிப்படை தகவல்களைச் சேகரிக்கக்',
            CRIRF: 'தொழில் விவர பதிவு படிவம்',
            CREDUC: 'கல்வித்தகுதி',
            CREDUCDT: 'கல்வித்தகுதி பற்றி விரிவாக',
            CREMPIN: 'பணி புரியும் இடம்',
            CROCCPTN: 'தொழில்',
            CROCCPTNDTL: 'தொழில் விவரம்',
            CRANINC: 'ஆண்டு வருமானம்',
            CRHELP: 'இந்த படிவம் வரனின் படிப்பு மற்றும் தொழில்விவரம் பற்றி தகவல் சேகரிக்க பயன்படுத்தப்படுகிறது',
            CONRF: 'தகவல் தொடர்பு பதிவு படிவம்',
            CONEMAIL: 'மின்னஞ்சல்',
            CONMOBNO: 'அலைப்பேசி எண்',
            CONLNDNO: 'தொலைபேசி எண்',
            CONRESADR: 'வீட்டு முகவரி',
            CONREL: 'உறவு',
            CONTMETOCALL: 'அழைக்க தகுந்த நேரம்',
            CONHELP: 'This form is used to collect information about the contact details about this profile',
            FAMIRF: 'குடும்ப தகவல் பதிவு படிவம்',
            FAMVAL: 'Family Value',
            FAMTYP: 'Family Type',
            FAMSTA: 'Family Status',
            FAMFATNAM: 'தந்தை பெயர்',
            FAMMOTNAM: 'தாயார் பெயர்',
            FAMFATOCC: 'தந்தையின் தொழில்',
            FAMMOTOCC: 'தாயின் தொழில்',
            FAMANSFAMORG: 'பிறப்பிடம் / பூர்வீகம்',
            FAMNOOFBRO: 'சகோதரர்கள் எண்ணிக்கை',
            FAMMARDBRO: 'மணமான சகோதரர்கள்',
            FAMNOOFSIS: 'சகோதரிகள்  எண்ணிக்கை',
            FAMMARDSIS: 'மணமான சகோதரிகள்',
            FAMABTFAM: 'குடும்ப விவரம்',
            FAMHELP: 'இந்த படிவம் குடும்ப விவரம் பற்றி தகவல் சேகரிக்க பயன்படுத்தப்படுகிறது',
            LOCIRF: 'இருப்பிட தகவல் விண்ணப்ப படிவம்',
            LOCTRYLVNIN: 'வசிக்கும் நாடு',
            LOCTNSHP: 'குடியுரிமை',
            LOCRESSTS: 'குடியிருப்புத் தகுதி',
            LOCRESTATE: 'வசிக்கும் மாநிலம்',
            LOCRESCTY: 'வசிக்கும் நகரம்',
            LOCHLP: 'இந்தப்  படிவம், வரனின் இருப்பிடத் தகவல்கள் சேகரிக்க பயன்படுத்தப்படுகிறது',
            REFIRF: 'பரிந்துரைப்பவர் பற்றிய விண்ணப்ப படிவம்',
            REFNOMNAME: 'நியமிக்கப்பட்டவர் பெயர்',
            REFCONTNUM: 'தொடர்பு எண்',
            REFHLP: 'இந்தப்படிவம் வரனை சிபாரிசு செய்பவர்கள் பற்றிய விவரங்களை சேகரிக்க பயன்படுத்தப் படுகிறது ',
            HOROIRF: 'ஜாதகத் தகவல் பதிவுப்  படிவம்',
            HORSOORIYAN: 'சூரியன்',
            HORBUDHAN: 'புதன்',
            HORGURU: 'குரு',
            HORKETHU: 'கேது',
            HORCHANDRAN: 'சந்திரன்',
            HORSUKRAN: 'சுக்ரன்',
            HORRAGHU: 'ராகு',
            HORLAGNAM: 'லக்னம்',
            HORSEVAI: 'செவ்வாய்',
            HORSANI: 'சனி',
            PHOIRF: 'வரனின் புகைப்பட தகவல் பதிவு படிவம்',
            PHOHLP: 'இந்தப் படிவம் வரனின் புகைப்பட தகவல்களை சேகரிக்கப் பயன்படுகிறது',
            LYTSRCPROFSRC: 'வரன் தேடல் ',
            LYTSRCALLPROF: 'அணைத்து வரன்கள் தேடல்',
            LYTGENSRC: 'பொது தேடல்',
            LYTSGMSRC: 'சங்கம் தேடல் ',
            SRCIDPROFID: 'சுயவிவர அடையாள எண் மூலம் தேடல்',
            SRCIDHLP: 'இப்படிவம் வரனின் அடையாள எண்ணை தேட பயன்படுத்தப்படுகிறது',
            SRCGENHLP: 'இப்படிவம் வரனின் அடையாள எண்ணை தேட பயன்படுத்தப்படுகிறது',
            SRCSGMSRCH: 'சங்கம் தேடல்',
            SRCSGMFLTRBYSGM: 'பில்ட்டர் பை சங்கம்',
            SRCSGMHLP: 'இந்தப் படிவம் சுய விபர அடையாள எண்ணைப் பெற  உபயோகப்படுத்தப்படுகிறது ',
            VWSGMINFOFORPROFID: 'வரன் பற்றிய சங்கத் தகவல்கள் ',
            VWRESTXT: 'To view the full information of this Profile, you got to register in this Sangam. <br> Please find the Sangam details below to register. Once you registered, you will be able to access the full information.',
            VWCTADRS: 'தொடர்பு முகவரி',
            VWABTSGM: 'சங்கம் பற்றி',
            VWFULLPROFVW: 'வரனைப் பற்றிய முழு விபரங்கள்',
            LYTRCNTLYJNDPROFILES: 'சமீபத்தில் சேர்ந்தோர்',
            LYTPROFILESLKDME: 'என்னை பிடித்தவர்கள்',
            LYTPROFILESVWDME: 'என்னை நோக்கியவர்கள்',
            LYTPROFILESHGLTD: 'தனிச்சிறப்பான வரன்கள்',


        });
        $translateProvider.translations('0439', {
            TITLE: 'Hallo',
            FOO: 'ओम नामासिवया',
            BUTTON_LANG_EN: 'englisch',
            BUTTON_LANG_DE: 'deutsch',
            LYTSRCH: 'नामासिवया',

            GENHOME: 'घर',
            GENSRCH: 'खोज',
            GENVIEW: 'View',
            GENPROF: 'देखें',
            GENMALE: 'नर',
            GENFEMALE: 'महिला',
            GENPROFID: 'प्रोफ़ाइल आईडी',
            GENSAVE: 'सहेजें',
            GENCOPYRT: 'कॉपीराइट',
            GENSANGAM: 'एसोसिएशन',
            GENABOUT: 'के बारे में',

        });
        $translateProvider.translations('044a', {
            TITLE: 'Hallo',
            FOO: 'ఓం నమసివాయ',
            BUTTON_LANG_EN: 'englisch',
            BUTTON_LANG_DE: 'deutsch',
            LYTSRCH: 'సెర్చ్'

        });
        $translateProvider.preferredLanguage('0409');
        /*****************TRANSALATION ENDS HERE ***********************************/


    }]);
})();