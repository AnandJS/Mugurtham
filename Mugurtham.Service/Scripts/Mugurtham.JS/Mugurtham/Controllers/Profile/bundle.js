/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR BASIC INFO PAGE ON PROFILE REGISTRATION
==========================================================================================
*/
var ControllerProfileBasicInfo = angular.module('MugurthamApp').controller('ControllerProfileBasicInfo',
        ['$http', '$scope', '$routeParams', '$rootScope', function ($http, $scope, $routeParams, $rootScope) {

            //Code commented - As to use the HTML5 DTPicker instead of JQuery DTPicker
            $("#dtDOB").datepicker({
                showOn: "button",
                buttonImage: "images/Mugurtham/calendar.gif",
                buttonImageOnly: true,
                buttonText: "Select date",
                changeMonth: true,
                changeYear: true
            });
            //========================================
            //GLOBAL VARIABLES FOR THIS CONTROLLER
            //=========================================
            $scope.controllerName = 'ControllerProfileBasicInfo';
            $scope.frmData = []; // To store the values of the controls in form            
            if (typeof $routeParams.ProfileID != 'undefined') {
                $rootScope.globalProfileID = $routeParams.ProfileID;
            }
            // Form Control Variables
            $scope.ProfileID = $rootScope.globalProfileID;
            $scope.globalProfileID = $rootScope.globalProfileID;
            //========================================
            //LOOKUP DATA FOR THIS CONTROLLER
            //=========================================
            $scope.arrMaritalStatus = ['Single', 'Widow', 'Awaiting Divorce', 'Widower'];
            $scope.arrChildrenLivingStatus = ['Yes not living togeather', 'Yes living togeather', 'No'];
            $scope.arrBodyType = ['Athletic', 'Slim', 'Average', 'Heavy'];
            $scope.arrComplexion = ['Fair', 'Very Fair', 'Dark', 'Wheatish'];
            $scope.arrPhysicalStatus = ['Normal', 'Physically Challenged'];
            $scope.arrMotherToungue = ['Tamil', 'Telugu', 'Malayalam'];
            //$scope.arrRaasi = ['Capricon', 'Libra', 'Aries', 'Scorpio', 'Leo', 'Cancer', 'Pisces', 'Virgo', 'Aquarius', 'Gemini', 'Sagittarius', 'Taurus'];
            $scope.arrRaasi = ['Mesham', 'Rishabam', 'Mithunam', 'Katakam', 'Simmam', 'Kanni', 'Thulam', 'Viruchigam', 'Dhanusu', 'Makaram', 'Kumbam', 'Meenam'];
            $scope.arrHoroscopeMatch = ['Yes', 'No'];
            $scope.arrDhosham = ['No', 'Naga', 'Sevvai', 'Kalathira'];
            $scope.arrEating = ['Eggetarian', 'Vegetarian', 'Non-Vegetarian'];
            $scope.arrSmoking = ['Occasionally', 'Yes', 'No'];
            $scope.arrDrinking = ['Occasionally', 'Yes', 'No'];

            $scope.arrHeight = ['4ft 5in - 134 cm', '4ft 6in - 137 cm', '4ft 7in - 139 cm', '4ft 8in - 142 cm', '4ft 9in - 144 cm', '4ft 10in - 147 cm', '4ft 11in - 149 cm', '5ft 1in - 154 cm', '5ft 2in - 157 cm', '5ft 3in - 160 cm', '5ft 4in - 162 cm', '5ft 5in - 165 cm', '5ft 6in - 167 cm', '5ft 7in - 170 cm', '5ft 8in - 172 cm', '5ft 9in - 175 cm', '5ft 10in - 177 cm', '5ft 11in - 180 cm', '6ft - 182 cm', '6ft 1in - 185 cm', '6ft 2in - 187 cm', '6ft 3in - 190 cm', '6ft 4in - 193 cm', '6ft 5in - 195 cm', '6in - 198 cm', '6ft 7in - 200 cm', '8in - 203 cm', '6ft 9in - 205 cm', '6ft 10in - 208 cm', '6ft 11in - 210 cm', '7ft - 213 cm'];
            $scope.arrBlodGroup = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
            $scope.arrProfileCreatedBy = ['Self', 'Parents', 'Gaurdian', 'Relative', 'Friend'];
            $scope.arrSubCaste = ['Kamalar', 'Achari'];
            $scope.arrStar = ['Anusham', 'Aswini', 'Avittam', 'Aayilyam', 'Bharani', 'Chithirai', 'Hastham', 'Karthigai', 'Kettai', 'Makam', 'Moolam', 'Mrigasheersham', 'Pooraadam', 'Pooram', 'Poorattathi', 'Poosam', 'Punarpoosam', 'Revathi', 'Rohini', 'Sadayam', 'Swaathi', 'Thiruvaathirai', 'Thiruvonam', 'Uthiraadam', 'Uthiram', 'Uthirattathi', 'Visaakam'];

            if ($rootScope.globalProfileID != 'New')
                getBasicInfoByProfileID();
            $scope.SangamID = '';
            $scope.SangamProfileID = '';
            $scope.Name = '';
            $scope.Age = '';
            $scope.Gender = '';
            $scope.DOB = '';
            $scope.TOB = '';
            $scope.MaritalStatus = '';
            $scope.NoOfChildren = '';
            $scope.ChildrenLivingStatus = '';
            $scope.Height = '';
            $scope.Weight = '';
            $scope.BodyType = '';
            $scope.Complexion = '';
            $scope.PhysicalStatus = '';
            $scope.BloodGroup = '';
            $scope.MotherTongue = '';
            $scope.ProfileCreatedBy = '';
            $scope.Region = '';
            $scope.Caste = '';
            $scope.SubCaste = '';
            $scope.Gothram = '';
            $scope.Star = '';
            $scope.Raasi = '';
            $scope.HoroscopeMatch = '';
            $scope.AnyDhosham = '';
            $scope.Eating = '';
            $scope.Smoking = '';
            $scope.Drinking = '';
            $scope.AboutMe = '';
            $scope.PartnerExpectation = '';
            $scope.ElanUserID = '';
            $scope.PhotoPath = '';
            $scope.ProfileCreatedDate = '';

            //========================================
            //GLOBAL EVENT HANDLER FOR THIS CONTROLLER
            //=========================================
            $scope.saveFormData = function () {
                $scope.initFormData();
                if ($scope.ProfileID == '' || $scope.ProfileID == 'New') {
                    $scope.Add();
                } else {
                    $scope.Edit();
                }
            }
            //=====================================
            //PRIVATE METHODS FOR THIS CONTROLLER
            //====================================
            $scope.initFormData = function () {
                $scope.SangamProfileID = $scope.frmData[0].SangamProfileID;
                $scope.Name = $scope.frmData[0].Name;
                $scope.Age = $scope.frmData[0].Age;
                $scope.Gender = $('.radProfileGender:checked').val();
                $scope.DOB = $scope.frmData[0].DOB;
                $scope.TOB = $scope.frmData[0].TOB;
                $scope.MaritalStatus = $scope.frmData[0].MaritalStatus;
                $scope.NoOfChildren = $scope.frmData[0].NoOfChildren;
                $scope.ChildrenLivingStatus = $scope.frmData[0].ChildrenLivingStatus;
                $scope.Height = $scope.frmData[0].Height;
                $scope.Weight = $scope.frmData[0].Weight;
                $scope.BodyType = $scope.frmData[0].BodyType;
                $scope.Complexion = $scope.frmData[0].Complexion;
                $scope.PhysicalStatus = $scope.frmData[0].PhysicalStatus;
                $scope.BloodGroup = $scope.frmData[0].BloodGroup;
                $scope.MotherTongue = $scope.frmData[0].MotherTongue;
                $scope.ProfileCreatedBy = $scope.frmData[0].ProfileCreatedBy;
                $scope.Region = $scope.frmData[0].Religion;
                $scope.Caste = $scope.frmData[0].Caste;
                $scope.SubCaste = $scope.frmData[0].SubCaste;
                $scope.Gothram = $scope.frmData[0].Gothram;
                $scope.Star = $scope.frmData[0].Star;
                $scope.Raasi = $scope.frmData[0].Raasi;
                $scope.HoroscopeMatch = $scope.frmData[0].HoroscopeMatch;
                $scope.AnyDhosham = $scope.frmData[0].AnyDhosham;
                $scope.Eating = $scope.frmData[0].Eating;
                $scope.Smoking = $scope.frmData[0].Smoking;
                $scope.Drinking = $scope.frmData[0].Drinking;
                $scope.AboutMe = $scope.frmData[0].AboutMe;
                $scope.PartnerExpectation = $scope.frmData[0].PartnerExpectation;
                $scope.PhotoPath = $scope.frmData[0].PhotoPath;
                $scope.ProfileCreatedDate = $scope.frmData[0].ProfileCreatedDate;

            }

            //=========================================
            //AJAX POST REQUEST - CREATING NEW PROFILE
            //==========================================
            $scope.Add = function () {
                $("#body").mask("Saving Basic Information please wait...");
                $http({
                    method: "post", url: '/Profile/Profile/Add', data: $.param({
                        ProfileID: $scope.ProfileID,
                        SangamProfileID: $scope.SangamProfileID,
                        SangamID: $scope.SangamID,
                        Name: $scope.Name,
                        Age: $scope.Age,
                        Gender: $scope.Gender,
                        DOB: $scope.DOB,
                        TOB: $scope.TOB,
                        MaritalStatus: $scope.MaritalStatus,
                        NoOfChildren: $scope.NoOfChildren,
                        Height: $scope.Height,
                        Weight: $scope.Weight,
                        BodyType: $scope.BodyType,
                        Complexion: $scope.Complexion,
                        PhysicalGroup: $scope.PhysicalGroup,
                        BloodGroup: $scope.BloodGroup,
                        MotherTongue: $scope.MotherTongue,
                        ProfileCreatedBy: $scope.ProfileCreatedBy,
                        Religion: $scope.Religion,
                        Caste: $scope.Caste,
                        SubCaste: $scope.SubCaste,
                        Gothram: $scope.Gothram,
                        Star: $scope.Star,
                        Raasi: $scope.Raasi,
                        HoroscopeMatch: $scope.HoroscopeMatch,
                        AnyDhosham: $scope.AnyDhosham,
                        Eating: $scope.Eating,
                        Smoking: $scope.Smoking,
                        Drinking: $scope.Drinking,
                        AboutMe: $scope.AboutMe,
                        PartnerExpectation: $scope.PartnerExpectation,
                        PhotoPath: $scope.PhotoPath
                    }),
                    headers: { 'content-Type': 'application/x-www-form-urlencoded' }
                }).
            success(function (data, status, headers, config) {
                $("#body").unmask();
                data = data.replace('"', ''); data = data.replace('"', '')
                $rootScope.globalProfileID = data;
                $scope.ProfileID = data;
                NotifySuccessStatus(1);
            }).
            error(function (data, status, headers, config) {
                $("#body").unmask();
                NotifyErrorStatus(data, status);
            });
            }


            //=========================================
            //AJAX PUT REQUEST - UPDATING EXISITING PROFILE
            //==========================================
            $scope.Edit = function () {
                $("#body").mask("Updating Basic Information please wait...");
                $http({
                    method: "PUT", url: '/BasicInfo/BasicInfoAPI/', data: $.param({
                        ProfileID: $scope.ProfileID,
                        SangamProfileID: $scope.SangamProfileID,
                        SangamID: $scope.SangamID,
                        Name: $scope.Name,
                        Age: $scope.Age,
                        Gender: $scope.Gender,
                        DOB: $scope.DOB,
                        TOB: $scope.TOB,
                        MaritalStatus: $scope.MaritalStatus,
                        NoOfChildren: $scope.NoOfChildren,
                        ChildrenLivingStatus: $scope.ChildrenLivingStatus,
                        Height: $scope.Height,
                        Weight: $scope.Weight,
                        BodyType: $scope.BodyType,
                        Complexion: $scope.Complexion,
                        PhysicalGroup: $scope.PhysicalGroup,
                        BloodGroup: $scope.BloodGroup,
                        MotherTongue: $scope.MotherTongue,
                        ProfileCreatedBy: $scope.ProfileCreatedBy,
                        Religion: $scope.Religion,
                        Caste: $scope.Caste,
                        SubCaste: $scope.SubCaste,
                        Gothram: $scope.Gothram,
                        Star: $scope.Star,
                        Raasi: $scope.Raasi,
                        HoroscopeMatch: $scope.HoroscopeMatch,
                        AnyDhosham: $scope.AnyDhosham,
                        Eating: $scope.Eating,
                        Smoking: $scope.Smoking,
                        Drinking: $scope.Drinking,
                        PhysicalStatus: $scope.PhysicalStatus,
                        AboutMe: $scope.AboutMe,
                        PartnerExpectation: $scope.PartnerExpectation,
                        ElanUserID: $scope.ElanUserID,
                        PhotoPath: $scope.PhotoPath,
                        CreatedDate: $scope.frmData[0].ProfileCreatedDate
                    }),
                    headers: { 'content-Type': 'application/x-www-form-urlencoded' }
                }).
            success(function (data, status, headers, config) {
                $("#body").unmask();
                NotifySuccessStatus(2);
            }).
            error(function (data, status, headers, config) {
                $("#body").unmask();
                NotifyErrorStatus(data, status);
            });
            }


            //===================================================
            //AJAX GET REQUEST - GETTING PROFILE BY ID
            //===================================================
            function getBasicInfoByProfileID() {
                var strGetURL = '/BasicInfo/BasicInfoAPI/' + $scope.ProfileID;
                $("#body").mask("Retreiving Profile please wait...");
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                MaintainState(data);
                $scope.SangamID = data.SangamID;
                $scope.ElanUserID = data.ElanUserID;
                $scope.frmData.push({
                    ID: data.ID,
                    SangamProfileID: data.SangamProfileID,
                    Name: data.Name,
                    Age: data.Age,
                    DOB: data.DOB,
                    TOB: data.TOB,
                    MaritalStatus: data.MaritalStatus,
                    NoOfChildren: data.NoOfChildren,
                    ChildrenLivingStatus: data.ChildrenLivingStatus,
                    Height: data.Height,
                    Weight: data.Weight,
                    BodyType: data.BodyType,
                    Complexion: data.Complexion,
                    PhysicalStatus: data.PhysicalStatus,
                    BloodGroup: data.BloodGroup,
                    MotherTongue: data.MotherTongue,
                    ProfileCreatedBy: data.ProfileCreatedBy,
                    Religion: data.Religion,
                    Caste: data.Caste,
                    SubCaste: data.SubCaste,
                    Gothram: data.Gothram,
                    Star: data.Star,
                    Raasi: data.Raasi,
                    HoroscopeMatch: data.HoroscopeMatch,
                    AnyDhosham: data.AnyDhosham,
                    Eating: data.Eating,
                    Smoking: data.Smoking,
                    Drinking: data.Drinking,
                    AboutMe: data.AboutMe,
                    PartnerExpectation: data.PartnerExpectation,
                    PhotoPath: data.PhotoPath
                });

                /*Logic to add 1 day to JQuery Formatting*/
                //<!--http://www.miuaiga.com/index.cfm/2009/11/11/Javascript-How-To-Add-a-Number-of-Days-to-a-Date-->
                var intAddNoOfDays = 1;
                var startDate = new Date(Date.parse(data.DOB));
                var dtDOB = startDate;
                dtDOB.setDate(startDate.getDate() + intAddNoOfDays);
                /*Logic to add 1 day to JQuery Formatting Ends*/

                if (data.DOB != null)
                    $scope.frmData[0].DOB = $.datepicker.formatDate('dd-M-yy', new Date(dtDOB));
                if (data.CreatedDate != null) {
                    $scope.frmData[0].ProfileCreatedDate = data.CreatedDate;
                }
                $("#body").unmask();
            }).
            error(function (data, status, headers, config) {
                $("#body").unmask();
                NotifyErrorStatus(data, status);
            });
            }
        }])

function MaintainState(arrFrmData) {
    $('input[name="radProfileGender"][value="' + arrFrmData.Gender + '"]').prop('checked', true);
}
/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR EDUCATION PAGE ON PROFILE REGISTRATION
==========================================================================================
*/
var ControllerProfileCareer = angular.module('MugurthamApp').controller('ControllerProfileCareer',
        ['$http', '$scope', '$rootScope', function ($http, $scope, $rootScope) {

            //========================================
            //GLOBAL VARIABLES FOR THIS CONTROLLER
            //=========================================
            $scope.controllerName = 'ControllerProfileCareer';
            $scope.frmData = []; // To store the values of the controls in form
            $scope.globalProfileID = $rootScope.globalProfileID;
            getCareerByProfileID();
            $scope.arrEmployedIn = ['Business', 'Defence', 'Private Job', 'Government Job', 'Self Employed'];
            // Form Control Variables
            $scope.CareerID = '';
            $scope.ProfileID = '';
            $scope.Education = '';
            $scope.EducationInDetail = '';
            $scope.EmployedIn = '';
            $scope.Occupation = '';
            $scope.OccupationInDetail = '';
            $scope.AnnualIncome = '';
            //========================================
            //GLOBAL EVENT HANDLER FOR THIS CONTROLLER
            //=========================================
            $scope.saveFormData = function () {
                $scope.initFormData();
                if ($scope.globalProfileID == '') {
                    $scope.Add();
                } else {
                    $scope.Edit();
                }
            }
            //=====================================
            //PRIVATE METHODS FOR THIS CONTROLLER
            //====================================
            $scope.initFormData = function () {
                $scope.Education = $scope.frmData[0].Education;
                $scope.EducationInDetail = $scope.frmData[0].EducationInDetail;
                $scope.EmployedIn = $scope.frmData[0].EmployedIn;
                $scope.Occupation = $scope.frmData[0].Occupation;
                $scope.OccupationInDetail = $scope.frmData[0].OccupationInDetail;
                $scope.AnnualIncome = $scope.frmData[0].AnnualIncome;
            }

            //===================================================
            //AJAX POST REQUEST - CREATING NEW CAREER FOR PROFILE
            //===================================================
            $scope.Add = function () {
                $http({
                    method: "POST", url: '/Career/CareerAPI', data: $.param({
                        CareerID: $scope.CareerID,
                        ProfileID: $scope.globalProfileID,
                        Education: $scope.Education,
                        EducationInDetail: $scope.EducationInDetail,
                        EmployedIn: $scope.EmployedIn,
                        Occupation: $scope.Occupation,
                        OccupationInDetail: $scope.OccupationInDetail,
                        AnnualIncome: $scope.AnnualIncome
                    }),
                    headers: { 'content-Type': 'application/x-www-form-urlencoded' }
                }).
            success(function (data, status, headers, config) {
                NotifySuccessStatus(3);
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }

            //===================================================
            //AJAX PUT REQUEST - EDIT CAREER FOR PROFILE
            //===================================================
            $scope.Edit = function () {
                $http({
                    method: "PUT", url: '/Career/CareerAPI', data: $.param({
                        CareerID: $scope.CareerID,
                        ProfileID: $scope.globalProfileID,
                        Education: $scope.Education,
                        EducationInDetail: $scope.EducationInDetail,
                        EmployedIn: $scope.EmployedIn,
                        Occupation: $scope.Occupation,
                        OccupationInDetail: $scope.OccupationInDetail,
                        AnnualIncome: $scope.AnnualIncome
                    }),
                    headers: { 'content-Type': 'application/x-www-form-urlencoded' }
                }).
            success(function (data, status, headers, config) {
                NotifySuccessStatus('3');
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }

            //===================================================
            //AJAX GET REQUEST - GETTING PROFILE BY ID
            //===================================================
            function getCareerByProfileID() {
                var strGetURL = '/Career/CareerAPI/' + $scope.globalProfileID;
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $scope.frmData.push({
                    ID: data.ID,
                    Education: data.Education,
                    EducationInDetail: data.EducationInDetail,
                    EmployedIn: data.EmployedIn,
                    Occupation: data.Occupation,
                    OccupationInDetail: data.OccupationInDetail,
                    AnnualIncome: data.AnnualIncome
                });
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }
        }])





/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR FAMILY PAGE ON PROFILE REGISTRATION
==========================================================================================
*/
var ControllerProfileContact = angular.module('MugurthamApp').controller('ControllerProfileContact',
        ['$http', '$scope', '$rootScope', function ($http, $scope, $rootScope) {

            //========================================
            //GLOBAL VARIABLES FOR THIS CONTROLLER
            //=========================================
            $scope.controllerName = 'ControllerProfileContact';
            $scope.frmData = []; // To store the values of the controls in form
            $scope.globalProfileID = $rootScope.globalProfileID;
            getContactByProfileID();
            // Form Control Variables
            $scope.ContactID = '';
            $scope.Email = '';
            $scope.MobileNumber = '';
            $scope.LandlineNumber = '';
            $scope.ResidentAddress = '';
            $scope.Relationship = '';
            $scope.TimeToCall = '';

            //========================================
            //GLOBAL EVENT HANDLER FOR THIS CONTROLLER
            //=========================================
            $scope.saveFormData = function () {
                $scope.initFormData();                
                if ($scope.globalProfileID == '') {
                    $scope.Add();
                } else {
                    $scope.Edit();
                }
            }

            //=====================================
            //PRIVATE METHODS FOR THIS CONTROLLER
            //=====================================
            $scope.initFormData = function () {
                $scope.Email = $scope.frmData[0].Email;
                $scope.MobileNumber = $scope.frmData[0].MobileNumber;
                $scope.LandlineNumber = $scope.frmData[0].LandlineNumber;
                $scope.ResidentAddress = $scope.frmData[0].ResidentAddress;
                $scope.Relationship = $scope.frmData[0].Relationship;
                $scope.TimeToCall = $scope.frmData[0].TimeToCall;
            }

            //===================================================
            //AJAX POST REQUEST - CREATING NEW COTNACT FOR PROFILE
            //===================================================
            $scope.Add = function () {
                $http({
                    method: "post", url: '/Contact/ContactAPI', data: $.param({
                        ProfileID: $scope.globalProfileID,
                        Email: $scope.Email,
                        MobileNumber: $scope.MobileNumber,
                        LandlineNumber: $scope.LandlineNumber,
                        ResidentialAddress: $scope.ResidentAddress,
                        Relationship: $scope.Relationship,
                        TimeToCall: $scope.TimeToCall
                    }),
                    headers: { 'content-Type': 'application/x-www-form-urlencoded' }
                }).
            success(function (data, status, headers, config) {
                NotifySuccessStatus(4);
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }

            //===================================================
            //AJAX PUT REQUEST - EDIT CONTACT FOR PROFILE
            //===================================================
            $scope.Edit = function () {
                $http({
                    method: "PUT", url: '/Contact/ContactAPI', data: $.param({
                        ProfileID: $scope.globalProfileID,
                        Email: $scope.Email,
                        MobileNumber: $scope.MobileNumber,
                        LandlineNumber: $scope.LandlineNumber,
                        ResidentialAddress: $scope.ResidentAddress,
                        Relationship: $scope.Relationship,
                        TimeToCall: $scope.TimeToCall
                    }),
                    headers: { 'content-Type': 'application/x-www-form-urlencoded' }
                }).
            success(function (data, status, headers, config) {
                NotifySuccessStatus(4);
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }

            //===================================================
            //AJAX GET REQUEST - GETTING PROFILE BY ID
            //===================================================
            function getContactByProfileID() {                
                var strGetURL = '/Contact/ContactAPI/' + $scope.globalProfileID;
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $scope.frmData.push({
                    ID: data.ID,
                    ProfileID: data.globalProfileID,
                    Email: data.Email,
                    MobileNumber: data.MobileNumber,
                    LandlineNumber: data.LandlineNumber,
                    ResidentAddress: data.ResidentialAddress,
                    Relationship: data.Relationship,
                    TimeToCall: data.TimeToCall
                });
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }


        }])

 


/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR FAMILY PAGE ON PROFILE REGISTRATION
==========================================================================================
*/
var ControllerProfileFamily = angular.module('MugurthamApp').controller('ControllerProfileFamily',
        ['$http', '$scope', '$rootScope', function ($http, $scope, $rootScope) {

            //========================================
            //GLOBAL VARIABLES FOR THIS CONTROLLER
            //=========================================
            $scope.controllerName = 'ControllerProfileFamily';
            $scope.frmData = []; // To store the values of the controls in form
            $scope.globalProfileID = $rootScope.globalProfileID;
            $scope.arrFamilyValue = ['Traditional', 'Liberal', 'Orthodox', 'Moderate'];
            $scope.arrFamilyType = ['Joint Family', 'Other', 'Nuclear Family'];
            $scope.arrFamilyStatus = ['Middle Class Family', 'Rich', 'Upper Middle Class Family', 'Affluent'];
            $scope.arrSiblings = ['0', '1', '2', '3','4','5','6'];
            // Form Control Variables
            getFamilyByProfileID();
            $scope.FamilyID = '';
            $scope.ProfileID = '';
            $scope.Familyvalue = '';
            $scope.FamilyType = '';
            $scope.FamilyStatus = '';
            $scope.FathersName = '';
            $scope.MothersName = '';
            $scope.FathersOccupation = '';
            $scope.MothersOccupation = '';
            $scope.FamilyOrigin = '';
            $scope.NoOfBrothers = '';
            $scope.MarriedBrothers = '';
            $scope.NoOfSisters = '';
            $scope.MarriedSisters = '';
            $scope.AboutFamily = '';

            //========================================
            //GLOBAL EVENT HANDLER FOR THIS CONTROLLER
            //=========================================
            $scope.saveFormData = function () {
                $scope.initFormData();
                if ($scope.globalProfileID == '') {
                    $scope.Add();
                } else {
                    $scope.Edit();
                }
            }

            //=====================================
            //PRIVATE METHODS FOR THIS CONTROLLER
            //====================================
            $scope.initFormData = function () {
                $scope.Familyvalue = $scope.frmData[0].Familyvalue;
                $scope.FamilyType = $scope.frmData[0].FamilyType;
                $scope.FamilyStatus = $scope.frmData[0].FamilyStatus;
                $scope.FathersName = $scope.frmData[0].FathersName;
                $scope.MothersName = $scope.frmData[0].MothersName;
                $scope.FathersOccupation = $scope.frmData[0].FathersOccupation;
                $scope.MothersOccupation = $scope.frmData[0].MothersOccupation;
                $scope.FamilyOrigin = $scope.frmData[0].FamilyOrigin;
                $scope.NoOfBrothers = $scope.frmData[0].NoOfBrothers;
                $scope.MarriedBrothers = $scope.frmData[0].MarriedBrothers;
                $scope.NoOfSisters = $scope.frmData[0].NoOfSisters;
                $scope.MarriedSisters = $scope.frmData[0].MarriedSisters;
                $scope.AboutFamily = $scope.frmData[0].AboutFamily;
            }

            //===================================================
            //AJAX POST REQUEST - CREATING NEW FAMILY FOR PROFILE
            //===================================================
            $scope.Add = function () {
                $http({
                    method: "post", url: '/Family/FamilyAPI', data: $.param({
                        ProfileID: $scope.globalProfileID,
                        NoOfBrothers: $scope.NoOfBrothers,
                        MarriedBrothers: $scope.MarriedBrothers,
                        NoOfSisters: $scope.NoOfSisters,
                        MarriedSisters: $scope.MarriedSisters,
                        FamilyValue: $scope.Familyvalue,
                        FamilType: $scope.FamilyType,
                        FamilyStatus: $scope.FamilyStatus,
                        FathersName: $scope.FathersName,
                        Mothersname: $scope.MothersName,
                        FathersOccupation: $scope.FathersOccupation,
                        MothersOccupation: $scope.MothersOccupation,
                        FamilyOrigin: $scope.FamilyOrigin,
                        AboutFamily: $scope.AboutFamily
                    }),
                    headers: { 'content-Type': 'application/x-www-form-urlencoded' }
                }).
            success(function (data, status, headers, config) {
                NotifyStatus('1');
            }).
            error(function (data, status, headers, config) {
                NotifyStatus('2');
            });
            }

            //===================================================
            //AJAX PUT REQUEST - EDIT FAMILY FOR PROFILE
            //===================================================
            $scope.Edit = function () {
                $http({
                    method: "PUT", url: '/Family/FamilyAPI', data: $.param({
                        ProfileID: $scope.globalProfileID,
                        NoOfBrothers: $scope.NoOfBrothers,
                        MarriedBrothers: $scope.MarriedBrothers,
                        NoOfSisters: $scope.NoOfSisters,
                        MarriedSisters: $scope.MarriedSisters,
                        FamilyValue: $scope.Familyvalue,
                        FamilType: $scope.FamilyType,
                        FamilyStatus: $scope.FamilyStatus,
                        FathersName: $scope.FathersName,
                        Mothersname: $scope.MothersName,
                        FathersOccupation: $scope.FathersOccupation,
                        MothersOccupation: $scope.MothersOccupation,
                        FamilyOrigin: $scope.FamilyOrigin,
                        AboutFamily: $scope.AboutFamily
                    }),
                    headers: { 'content-Type': 'application/x-www-form-urlencoded' }
                }).
            success(function (data, status, headers, config) {
                NotifySuccessStatus('5');
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }

            //===================================================
            //AJAX GET REQUEST - GETTING PROFILE BY ID
            //===================================================
            function getFamilyByProfileID() {
                var strGetURL = '/Family/FamilyAPI/' + $scope.globalProfileID;
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $scope.frmData.push({
                    ProfileID: data.ProfileID,
                    NoOfBrothers: data.NoOfBrothers,
                    MarriedBrothers: data.MarriedBrothers,
                    NoOfSisters: data.NoOfSisters,
                    MarriedSisters: data.MarriedSisters,
                    Familyvalue: data.FamilyValue,
                    FamilyType: data.FamilType,
                    FamilyStatus: data.FamilyStatus,
                    FathersName: data.FathersName,
                    MothersName: data.Mothersname,
                    FathersOccupation: data.FathersOccupation,
                    MothersOccupation: data.MothersOccupation,
                    FamilyOrigin: data.FamilyOrigin,
                    AboutFamily: data.AboutFamily
                });
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }
        }])





/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR HOROSCOPE PAGE ON PROFILE REGISTRATION
==========================================================================================
*/
var ControllerProfileHoroscope = angular.module('MugurthamApp').controller('ControllerProfileHoroscope',
        ['$http', '$scope', '$rootScope', function ($http, $scope, $rootScope) {
            //========================================
            //GLOBAL VARIABLES FOR THIS CONTROLLER
            //=========================================
            $scope.controllerName = 'ControllerProfileHoroscope';
            $scope.frmData = []; // To store the values of the controls in form                        
            $scope.globalProfileID = $rootScope.globalProfileID;
            getHoroscopeByProfileID();
            // Storing Raasi varaibales
            $scope.RaasiKattam1 = '';
            $scope.RaasiKattam2 = '';
            $scope.RaasiKattam3 = '';
            $scope.RaasiKattam4 = '';
            $scope.RaasiKattam5 = '';
            $scope.RaasiKattam6 = '';
            $scope.RaasiKattam7 = '';
            $scope.RaasiKattam8 = '';
            $scope.RaasiKattam9 = '';
            $scope.RaasiKattam10 = '';
            $scope.RaasiKattam11 = '';
            $scope.RaasiKattam12 = '';
            // Storing Amsam varaibales
            $scope.AmsamKattam1 = '';
            $scope.AmsamKattam2 = '';
            $scope.AmsamKattam3 = '';
            $scope.AmsamKattam4 = '';
            $scope.AmsamKattam5 = '';
            $scope.AmsamKattam6 = '';
            $scope.AmsamKattam7 = '';
            $scope.AmsamKattam8 = '';
            $scope.AmsamKattam9 = '';
            $scope.AmsamKattam10 = '';
            $scope.AmsamKattam11 = '';
            $scope.AmsamKattam12 = '';
            //========================================
            //GLOBAL EVENT HANDLER FOR THIS CONTROLLER
            //=========================================
            $scope.saveFormData = function () {
                $scope.initFormData();
                if ($scope.globalProfileID == '') {
                    $scope.Add();
                } else {
                    $scope.Edit();
                }
            }
            //=====================================
            //PRIVATE METHODS FOR THIS CONTROLLER
            //=====================================
            $scope.initFormData = function () {
                //Raasi
                $scope.RaasiKattam1 = getKattamValues('ckKattam1_');
                $scope.RaasiKattam2 = getKattamValues('ckKattam2_');
                $scope.RaasiKattam3 = getKattamValues('ckKattam3_');
                $scope.RaasiKattam4 = getKattamValues('ckKattam4_');
                $scope.RaasiKattam5 = getKattamValues('ckKattam5_');
                $scope.RaasiKattam6 = getKattamValues('ckKattam6_');
                $scope.RaasiKattam7 = getKattamValues('ckKattam7_');
                $scope.RaasiKattam8 = getKattamValues('ckKattam8_');
                $scope.RaasiKattam9 = getKattamValues('ckKattam9_');
                $scope.RaasiKattam10 = getKattamValues('ckKattam10_');
                $scope.RaasiKattam11 = getKattamValues('ckKattam11_');
                $scope.RaasiKattam12 = getKattamValues('ckKattam12_');
                //Amsam
                $scope.AmsamKattam1 = getKattamValues('ckAmsamKattam1_');
                $scope.AmsamKattam2 = getKattamValues('ckAmsamKattam2_');
                $scope.AmsamKattam3 = getKattamValues('ckAmsamKattam3_');
                $scope.AmsamKattam4 = getKattamValues('ckAmsamKattam4_');
                $scope.AmsamKattam5 = getKattamValues('ckAmsamKattam5_');
                $scope.AmsamKattam6 = getKattamValues('ckAmsamKattam6_');
                $scope.AmsamKattam7 = getKattamValues('ckAmsamKattam7_');
                $scope.AmsamKattam8 = getKattamValues('ckAmsamKattam8_');
                $scope.AmsamKattam9 = getKattamValues('ckAmsamKattam9_');
                $scope.AmsamKattam10 = getKattamValues('ckAmsamKattam10_');
                $scope.AmsamKattam11 = getKattamValues('ckAmsamKattam11_');
                $scope.AmsamKattam12 = getKattamValues('ckAmsamKattam12_');
            }
            function getKattamValues(strKattamIndex) {
                var selectedItems = '';
                $('input[name^=' + strKattamIndex + ']').each(function () {
                    if ($(this).is(":checked"))
                        selectedItems += $(this).val() + ',';
                });
                return selectedItems.slice(0, -1);
            }
            function setKattamValues(strKattamIndex, strCSV) {
                if (strCSV != null) {
                    $.each(strCSV.split(","), function (Index, value) {
                        $('input[name^=' + strKattamIndex + ']').each(function () {
                            if ($(this).val() == value)
                                $(this).attr('checked', true);
                        });
                    });
                }
            }
            //===================================================
            //AJAX GET REQUEST - GETTING HOROSCOPE BY ID
            //===================================================
            function getHoroscopeByProfileID() {
                var strGetURL = '/mugurthamapi/HoroscopeAPI/' + $scope.globalProfileID;
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                // Maintainstate for Raasi checkbox
                setKattamValues('ckKattam1_', data.RaasiKattam1);
                setKattamValues('ckKattam2_', data.RaasiKattam2);
                setKattamValues('ckKattam3_', data.RaasiKattam3);
                setKattamValues('ckKattam4_', data.RaasiKattam4);
                setKattamValues('ckKattam5_', data.RaasiKattam5);
                setKattamValues('ckKattam6_', data.RaasiKattam6);
                setKattamValues('ckKattam7_', data.RaasiKattam7);
                setKattamValues('ckKattam8_', data.RaasiKattam8);
                setKattamValues('ckKattam9_', data.RaasiKattam9);
                setKattamValues('ckKattam10_', data.RaasiKattam10);
                setKattamValues('ckKattam11_', data.RaasiKattam11);
                setKattamValues('ckKattam12_', data.RaasiKattam12);
                // Maintainstate for Amsam checkbox
                setKattamValues('ckAmsamKattam1_', data.AmsamKattam1);
                setKattamValues('ckAmsamKattam2_', data.AmsamKattam2);
                setKattamValues('ckAmsamKattam3_', data.AmsamKattam3);
                setKattamValues('ckAmsamKattam4_', data.AmsamKattam4);
                setKattamValues('ckAmsamKattam5_', data.AmsamKattam5);
                setKattamValues('ckAmsamKattam6_', data.AmsamKattam6);
                setKattamValues('ckAmsamKattam7_', data.AmsamKattam7);
                setKattamValues('ckAmsamKattam8_', data.AmsamKattam8);
                setKattamValues('ckAmsamKattam9_', data.AmsamKattam9);
                setKattamValues('ckAmsamKattam10_', data.AmsamKattam10);
                setKattamValues('ckAmsamKattam11_', data.AmsamKattam11);
                setKattamValues('ckAmsamKattam12_', data.AmsamKattam12);
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }
            //===================================================
            //AJAX PUT REQUEST - EDIT HOROSCOPE FOR PROFILE
            //===================================================
            $scope.Edit = function () {
                $http({
                    method: "PUT", url: '/mugurthamapi/HoroscopeAPI', data: $.param({
                        ProfileID: $scope.globalProfileID,
                        RaasiKattam1: $scope.RaasiKattam1,
                        RaasiKattam2: $scope.RaasiKattam2,
                        RaasiKattam3: $scope.RaasiKattam3,
                        RaasiKattam4: $scope.RaasiKattam4,
                        RaasiKattam5: $scope.RaasiKattam5,
                        RaasiKattam6: $scope.RaasiKattam6,
                        RaasiKattam7: $scope.RaasiKattam7,
                        RaasiKattam8: $scope.RaasiKattam8,
                        RaasiKattam9: $scope.RaasiKattam9,
                        RaasiKattam10: $scope.RaasiKattam10,
                        RaasiKattam11: $scope.RaasiKattam11,
                        RaasiKattam12: $scope.RaasiKattam12,
                        AmsamKattam1: $scope.AmsamKattam1,
                        AmsamKattam2: $scope.AmsamKattam2,
                        AmsamKattam3: $scope.AmsamKattam3,
                        AmsamKattam4: $scope.AmsamKattam4,
                        AmsamKattam5: $scope.AmsamKattam5,
                        AmsamKattam6: $scope.AmsamKattam6,
                        AmsamKattam7: $scope.AmsamKattam7,
                        AmsamKattam8: $scope.AmsamKattam8,
                        AmsamKattam9: $scope.AmsamKattam9,
                        AmsamKattam10: $scope.AmsamKattam10,
                        AmsamKattam11: $scope.AmsamKattam11,
                        AmsamKattam12: $scope.AmsamKattam12
                    }),
                    headers: { 'content-Type': 'application/x-www-form-urlencoded' }
                }).
            success(function (data, status, headers, config) {
                NotifySuccessStatus('6');
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }
        }])

/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR FAMILY PAGE ON PROFILE REGISTRATION
==========================================================================================
*/
var ControllerProfileLocation = angular.module('MugurthamApp').controller('ControllerProfileLocation',
        ['$http', '$scope', '$rootScope', function ($http, $scope, $rootScope) {

            //========================================
            //GLOBAL VARIABLES FOR THIS CONTROLLER
            //=========================================
            $scope.controllerName = 'ControllerProfileLocation';
            $scope.globalProfileID = $rootScope.globalProfileID;
            $scope.frmData = []; // To store the values of the controls in form
            // Form Control Variables
            getLocationByProfileID();
            $scope.LocationID = '';
            $scope.ProfileID = '';
            $scope.CountryLivingIn = '';
            $scope.Citizenship = '';
            $scope.ResidentialStatus = '';
            $scope.ResidentState = '';
            $scope.ResidentCity = '';


            //========================================
            //GLOBAL EVENT HANDLER FOR THIS CONTROLLER
            //=========================================
            $scope.saveFormData = function () {
                $scope.initFormData();
                if ($scope.globalProfileID == '') {
                    $scope.Add();
                } else {
                    $scope.Edit();
                }
            }

            //=====================================
            //PRIVATE METHODS FOR THIS CONTROLLER
            //=====================================
            $scope.initFormData = function () {
                $scope.CountryLivingIn = $scope.frmData[0].CountryLivingIn;
                $scope.Citizenship = $scope.frmData[0].Citizenship;
                $scope.ResidentialStatus = $scope.frmData[0].ResidentialStatus;
                $scope.ResidentState = $scope.frmData[0].ResidentState;
                $scope.ResidentCity = $scope.frmData[0].ResidentCity;
            }


            //===================================================
            //AJAX POST REQUEST - CREATING NEW COTNACT FOR PROFILE
            //===================================================
            $scope.Add = function () {
                $http({
                    method: "post", url: '/Location/LocationAPI', data: $.param({
                        LocationID: $scope.LocationID,
                        ProfileId: $scope.globalProfileID,
                        CountryLivingIn: $scope.CountryLivingIn,
                        CitizenShip: $scope.Citizenship,
                        ResidentStatus: $scope.ResidentialStatus,
                        ResidingState: $scope.ResidentState,
                        ResidingCity: $scope.ResidentCity
                    }),
                    headers: { 'content-Type': 'application/x-www-form-urlencoded' }
                }).
            success(function (data, status, headers, config) {
                NotifyStatus('1');
            }).
            error(function (data, status, headers, config) {
                NotifyStatus('2');

            });
            }

            //===================================================
            //AJAX PUT REQUEST - EDIT FAMILY FOR PROFILE
            //===================================================
            $scope.Edit = function () {
                $http({
                    method: "PUT", url: '/Location/LocationAPI', data: $.param({
                        LocationID: $scope.LocationID,
                        ProfileId: $scope.globalProfileID,
                        CountryLivingIn: $scope.CountryLivingIn,
                        CitizenShip: $scope.Citizenship,
                        ResidentStatus: $scope.ResidentialStatus,
                        ResidingState: $scope.ResidentState,
                        ResidingCity: $scope.ResidentCity
                    }),
                    headers: { 'content-Type': 'application/x-www-form-urlencoded' }
                }).
            success(function (data, status, headers, config) {
                NotifySuccessStatus('7');
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status)
            });
            }

            //===================================================
            //AJAX GET REQUEST - GETTING LOCATION BY ID
            //===================================================
            function getLocationByProfileID() {
                var strGetURL = '/Location/LocationAPI/' + $scope.globalProfileID;
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $scope.frmData.push({
                    CountryLivingIn: data.CountryLivingIn,
                    Citizenship: data.CitizenShip,
                    ResidentialStatus: data.ResidentStatus,
                    ResidentState: data.ResidingState,
                    ResidentCity: data.ResidingCity
                });
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }

        }])






/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR PHOTO PAGE ON PROFILE REGISTRATION
==========================================================================================
*/
var ControllerProfilePhoto = angular.module('MugurthamApp').controller('ControllerProfilePhoto',
        ['$http', '$scope', '$rootScope', function ($http, $scope, $rootScope) {
            //========================================
            //GLOBAL VARIABLES FOR THIS CONTROLLER
            //=========================================
            $scope.controllerName = 'ControllerProfilePhoto';
            $scope.globalProfileID = $rootScope.globalProfileID;
            //===================================================
            //AJAX GET REQUEST - GET PROFILE BY PROFILEID
            //===================================================
            $scope.getByProfileID = function () {
                $http({
                    method: "GET", url: '/SearchAPI/AllProfilesAPI/getByProfileID/' + $scope.globalProfileID
                }).
success(function (data, status, headers, config) {

    $scope.AllProfiles = data;
}).
    error(function (data, status, headers, config) {
        NotifyStatus('2');
    });
            }

            //===================================================
            //AJAX PUT REQUEST - TO UPDATE PROFILE IMAGE
            //===================================================
            $scope.updateProfileImage = function (objProfile, strImagePath) {
                $http({
                    method: "PUT", url: '/BasicInfo/BasicInfoAPI/', data: $.param({
                        ProfileID: objProfile.BasicInfoCoreEntity.ProfileID,
                        SangamID: objProfile.BasicInfoCoreEntity.SangamID,
                        Name: objProfile.BasicInfoCoreEntity.Name,
                        Age: objProfile.BasicInfoCoreEntity.Age,
                        Gender: objProfile.BasicInfoCoreEntity.Gender,
                        DOB: objProfile.BasicInfoCoreEntity.DOB,
                        TOB: objProfile.BasicInfoCoreEntity.TOB,
                        MaritalStatus: objProfile.BasicInfoCoreEntity.MaritalStatus,
                        NoOfChildren: objProfile.BasicInfoCoreEntity.NoOfChildren,
                        ChildrenLivingStatus: objProfile.BasicInfoCoreEntity.ChildrenLivingStatus,
                        Height: objProfile.BasicInfoCoreEntity.Height,
                        Weight: objProfile.BasicInfoCoreEntity.Weight,
                        BodyType: objProfile.BasicInfoCoreEntity.BodyType,
                        Complexion: objProfile.BasicInfoCoreEntity.Complexion,
                        PhysicalGroup: objProfile.BasicInfoCoreEntity.PhysicalGroup,
                        BloodGroup: objProfile.BasicInfoCoreEntity.BloodGroup,
                        MotherTongue: objProfile.BasicInfoCoreEntity.MotherTongue,
                        ProfileCreatedBy: objProfile.BasicInfoCoreEntity.ProfileCreatedBy,
                        Religion: objProfile.BasicInfoCoreEntity.Religion,
                        Caste: objProfile.BasicInfoCoreEntity.Caste,
                        SubCaste: objProfile.BasicInfoCoreEntity.SubCaste,
                        Gothram: objProfile.BasicInfoCoreEntity.Gothram,
                        Star: objProfile.BasicInfoCoreEntity.Star,
                        Raasi: objProfile.BasicInfoCoreEntity.Raasi,
                        HoroscopeMatch: objProfile.BasicInfoCoreEntity.HoroscopeMatch,
                        AnyDhosham: objProfile.BasicInfoCoreEntity.AnyDhosham,
                        Eating: objProfile.BasicInfoCoreEntity.Eating,
                        Smoking: objProfile.BasicInfoCoreEntity.Smoking,
                        Drinking: objProfile.BasicInfoCoreEntity.Drinking,
                        PhysicalStatus: objProfile.BasicInfoCoreEntity.PhysicalStatus,
                        AboutMe: objProfile.BasicInfoCoreEntity.AboutMe,
                        PartnerExpectation: objProfile.BasicInfoCoreEntity.PartnerExpectation,
                        ElanUserID: objProfile.BasicInfoCoreEntity.ElanUserID,
                        PhotoPath: strImagePath,
                        CreatedDate: objProfile.BasicInfoCoreEntity.CreatedDate
                    }),
                    headers: { 'content-Type': 'application/x-www-form-urlencoded' }
                }).
            success(function (data, status, headers, config) {
                NotifySuccessStatus(17);
                flipProfilePic(strImagePath);
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }


            //===================================================
            //AJAX PUT REQUEST - TO DELETE PROFILE IMAGE
            //===================================================
            $scope.deleteProfileImage = function (strPhotoID) {
                $http({
                    method: "GET", url: '/Profile/Profile/RemoveProfilePic/' + strPhotoID
                }).
success(function (data, status, headers, config) {    
    NotifySuccessStatus(18);
}).
    error(function (data, status, headers, config) {
        NotifyStatus('2');
    });
            }

        }]) // Class


// Native functions
function flipProfilePic(strImagePath) {
    $('#imgProfilePic').attr("src", strImagePath);
}




/*
==========================================================================================
THIS CONTROLLER IS SPECIFICALLY FOR FAMILY PAGE ON PROFILE REGISTRATION
==========================================================================================
*/
var ControllerProfileReference = angular.module('MugurthamApp').controller('ControllerProfileReference',
        ['$http', '$scope', '$rootScope', function ($http, $scope, $rootScope) {
            //========================================
            //GLOBAL VARIABLES FOR THIS CONTROLLER
            //=========================================
            $scope.controllerName = 'ControllerProfileReference';
            $scope.globalProfileID = $rootScope.globalProfileID;
            $scope.frmData = []; // To store the values of the controls in form
            // Form Control Variables
            getReferenceByProfileID();
            $scope.ReferenceID = '';
            $scope.ProfileID = '';
            $scope.NomineeName = '';
            $scope.ContactNumber = '';

            //========================================
            //GLOBAL EVENT HANDLER FOR THIS CONTROLLER
            //=========================================
            $scope.saveFormData = function () {
                $scope.initFormData();
                if ($scope.globalProfileID == '') {
                    $scope.Add();
                } else {
                    $scope.Edit();
                }
            }

            //=====================================
            //PRIVATE METHODS FOR THIS CONTROLLER
            //=====================================
            $scope.initFormData = function () {
                $scope.NomineeName = $scope.frmData[0].NomineeName;
                $scope.ContactNumber = $scope.frmData[0].ContactNumber;
            }

            //===================================================
            //AJAX POST REQUEST - CREATING NEW COTNACT FOR PROFILE
            //===================================================
            $scope.postData = function () {
                $http({
                    method: "post", url: '/Reference/ReferenceAPI', data: $.param({
                        ReferenceID: $scope.ReferenceID,
                        ProfileID: $scope.globalProfileID,
                        NomineeName: $scope.frmData[0].NomineeName,
                        ContactNo: $scope.frmData[0].ContactNumber
                    }),
                    headers: { 'content-Type': 'application/x-www-form-urlencoded' }
                }).
            success(function (data, status, headers, config) {
                NotifyStatus('1');
            }).
            error(function (data, status, headers, config) {
                NotifyStatus('2');
            });
            }


            //===================================================
            //AJAX GET REQUEST - GETTING LOCATION BY ID
            //===================================================
            function getReferenceByProfileID() {
                var strGetURL = '/Reference/ReferenceAPI/' + $scope.globalProfileID;
                $http({
                    method: "GET", url: strGetURL
                }).
            success(function (data, status, headers, config) {
                $scope.frmData.push({
                    NomineeName: data.NomineeName,
                    ContactNumber: data.ContactNo
                });
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }

            //===================================================
            //AJAX PUT REQUEST - EDIT FAMILY FOR PROFILE
            //===================================================
            $scope.Edit = function () {
                $http({
                    method: "PUT", url: '/Reference/ReferenceAPI', data: $.param({
                        ReferenceID: $scope.ReferenceID,
                        ProfileID: $scope.globalProfileID,
                        NomineeName: $scope.frmData[0].NomineeName,
                        ContactNo: $scope.frmData[0].ContactNumber
                    }),
                    headers: { 'content-Type': 'application/x-www-form-urlencoded' }
                }).
            success(function (data, status, headers, config) {
                NotifySuccessStatus('8');
            }).
            error(function (data, status, headers, config) {
                NotifyErrorStatus(data, status);
            });
            }

        }])
function NotifyStatus(intStatus) {
    /*
         1-> Success
         2-> Error
    */
    if (intStatus == '1') {
        toastr.success('Reference updated Successfully');
    }
    else if (intStatus == '2') {
        toastr.error(' Error occured in ControllerProfileReference - postData');
    }
}