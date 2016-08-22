
$(document).ready(function () {

    // Validation for Page Size on listing profiles
    //per page on all profiles list page
    ($("[ng-model=pageSize]").on('input', function () {
        if (this.value > 50) {
            this.value = 50;
            alert('Please enter page size less than 50 profiles');
            return false;
        }
    }));
});