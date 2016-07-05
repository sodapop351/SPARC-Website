
var ajaxurl = "ajax.php";

/*
    updateLogin() : gets current user from PHP session, changes the
        name of the log-in space to the name of the user if the username
        is not empty, then changes action to logout on click

    returns : nothing
*/
var updateLogin = function() {
    var data = {'action': "getCurrentUser"};
    $.post(ajaxurl, data, function(response) {
        var username = response;

        if (!username) {
            updateNavbar();
            return;
        }

        //changeLoginName(username);
        changeLoginName("Log-out", username);
        updateNavbar();
    });
    return;
};

/*
    changeLoginName(usernameValue) : changes login space to username
        usernameValue and changes action to logout

    returns : nothing
*/
var changeLoginName = function(loginText, usernameValue) {
    $('#login').text(loginText);
    $('#login').attr('data-username', usernameValue + "");
    $('#login').attr('data-target','#logoutModal');
    return;
};

$(document).ready(function() {

    $(document).on('click','.signup-tab',function(e){
        e.preventDefault();
        $('#signup-taba').tab('show');
    }); 
    
    $(document).on('click','.signin-tab',function(e){
        e.preventDefault();
        $('#signin-taba').tab('show');
    });
            
    $(document).on('click','.forgetpass-tab',function(e){
        e.preventDefault();
        $('#forgetpass-taba').tab('show');
    });

    // Attempt log-in
    $('#login_btn').click(function(e) {

        if (!checkLogin()) {
            return;
        }

        var usernameValue = $('#login_username').val();
        var passwordValue = $('#password').val();
        var data = {'action': "getLogin",
                    'username': usernameValue,
                    'password': passwordValue};

        // Expected response : true/false
        $.post(ajaxurl, data, function(response) {
            if (response === "1") {
                //alert("Login successful!");
                $('#loginModal').modal("hide");

                updateLogin();

                setCurrentFolder("");
                setCurrentFile("");
                updateCurrentFolder();
                updateCurrentFile();
                refreshDirectory();
            } else {
                $("#login_fail").show();
            }
        });
    });

    // Attempt register
    $('#register_btn').click(function(e) {
        e.preventDefault();

        if (!checkRegister()) {
            return;
        }

        var usernameValue = $('#username').val();
        var emailValue = $('#remail').val();
        var passwordValue = $('#repassword').val();
        var data = {'action': "addNewUser",
                    'username': usernameValue,
                    'email': emailValue,
                    'password': passwordValue};

        // Expected response : true/false
        $.post(ajaxurl, data, function(response) {
            if (response === "1") {
                //alert("Registration successful!");
                $('#loginModal').modal("hide");

                updateLogin();
            } else {
                //alert(response);
            }
        });
    });

    // Attempt recover password
    $('#reset_btn').click(function(e) {
        if ($('#femail').val() === "") {
            $('#femail-error').show();
        } else {
            var emailValue = $('#femail').val();
            var data = {'action': "forgotPassword",
                        'email': emailValue};
            $.post(ajaxurl, data, function(response) {
                alert(response);
            });
        }
    });

    // Attempt log-out
    $('#logout_btn').click(function(e) {
        e.preventDefault();

        var data = {'action': "getLogout"};

        // Expected response : true/false
        $.post(ajaxurl, data, function(response) {
            if (response === "1") {
                //alert("Logout successful!");
                $('#login').text('Log-in');
                $('#login').attr('data-username', "");
                $('#login').attr('data-target','#loginModal');

                $('#logoutModal').modal("hide");

                setCurrentFolder("");
                setCurrentFile("");
                updateCurrentFolder();
                updateCurrentFile();

                updateNavbar();
                setEditorToCurrentFile();
                refreshDirectory();
                closeDirectory();
            } else {
                //alert("Could not log-out");
            }
        });
    });


    /*
        checkLogin() : checks the forms of the log-in panel and if there
            are empty input, an error messsage is shown

        returns : true if there are no errors, false otherwise
    */
    function checkLogin() {
        $("#user-error").hide();
        $("#password-error").hide();
        var flag = true;

        if ($('#login_username').val() === "") {
            $('#user-error').show();
            flag = false;
        }

        if ($('#password').val() === "") {
            $('#password-error').show();
            flag = false;
        }

        return flag;
    }

    /*
        checkRegister() : checks the forms of the register panel and if 
            there are empty input, an error messsage is shown

        returns : true if there are no errors, false otherwise
    */
    function checkRegister() {

        $(".help-block-has-error").hide();
        $('#username-error').hide();
        $('#remail-error').hide();
        $('#repassword-error').hide();
        $('#conf-repassword-error').hide();

        var flag = true;
        if ($('#username').val() === "") {
            $('#username-error').show();
            flag = false;
        }

        if ($('#remail').val() === "") {
            // TODO check email of correct format
            $('#remail-error').show();
            flag = false;
        }

        if ($('#repassword').val() === "") {
            // TODO password specifications
            $('#repassword-error').show();
            flag = false;
        }

        if ($('#repassword').val() !== $('#conf-repassword').val()) {
            $('#conf-repassword-error').show();
            flag = false;
        }

        return flag;
    }
});

