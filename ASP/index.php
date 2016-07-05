<?php
    include 'header.php';
?>

<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- JQUERY -->
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script> 
        <script src="scripts/jquery-1.11.1.js" type="text/javascript"> </script>

        <!-- ACE EDITOR -->
        <script src="scripts/ace-builds/src-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>

        <!-- BOOTSTRAP -->
        <link rel="stylesheet" href="stylesheets/bootstrap.css">
        <script src="scripts/bootstrap.min.js"></script>

        <!-- CSS STYLESHEET -->
        <link rel="stylesheet" type="text/css" href="stylesheets/style.css">

        <!-- EASYTREE -->
        <link rel="stylesheet" type="text/css" href="stylesheets/easyTree.css">
        <link href="stylesheets/simple-sidebar.css" rel="stylesheet">


    </head>

    <body>
        <div id="wrapper" class="toggled">
            <div id="sidebar-wrapper">
                <div class="easy-tree" id="directory">
                    <ul>
                        <li> Example 1 </li>
                        <li> Example 2 </li>
                        <li> Example 3 
                        <ul>
                            <li> Example 3a </li>
                            <li> Example 3b </li>
                        </ul> </li>
                    </ul>
                </div>
            </div>

            <div id="wrap">
            <div id="navbar">
            <header>
            <nav class="navbar navbar-default">
            <div class="container-fluid">
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav navbar-left">
                    <!-- OPEN BUTTON -->
                    <li> <button type="button" class="btn btn-default navbar-btn" id="menu-toggle" value="getAccessibleDirectory">
                        Directory
                    </button> </li>

                    <!-- NEW BUTTON -->
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" id="btn_new">
                            New
                            <span class="caret"></span>
                        </a>

                        <ul class="dropdown-menu">
                            <li><a href="#" id="newFolder">New Folder</a></li>
                            <li><a href="#" id="newFile">New File</a></li>
                        </ul>
                    </li>

                    <!-- SAVE BUTTON -->
                    <li> <button type="button" class="btn btn-default navbar-btn" id="btn_save">
                        Save
                    </button> </li>
                    <!-- SHARE BUTTON -->
                    <li><a class="btn btn-launch" href="javascript:;" data-toggle="modal" data-target="#shareModal" id="navbar_btn_share">Share</a></li>
                    <!-- ISSUES  BUTTON -->
                    <li><a class="btn btn-launch" id="navbar_btn_issues">Issues?</a></li>
                </ul>


                <ul class="nav navbar-nav navbar-right">

                    <!-- QUERY FORM -->
                    <form class="navbar-form navbar-left" id="qform"> <!-- Add role -->
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Enter query" name="txt_query" id="txt_query">
                        </div>

                        <button type="submit" class="btn btn-default" id="btn_getQuery" value="getQuery">
                            Submit
                        </button>
                    </form>

                    <!-- GET ANSWER SETS BUTTON -->
                    <li> <button type="submit" class="btn btn-default navbar-btn" id="btn_getAnswerSets" value="getAnswerSets">
                        Get Answer Sets
                    </button> </li>

                    <li>
					
					<!-- GET Drawing SETS BUTTON -->
                    <li> <button type="submit" class="btn btn-default navbar-btn" id="btn_getDrawing" value="getDrawing">  
                        Draw
                    </button> </li>

                    <li>
					

                    <!-- LOGIN BUTTON -->
                    <li> <a class="btn btn-launch" href="javascript:;" data-toggle="modal" data-target="#loginModal" data-username="" id="login"> Log-in </a> </li><!-- TODO put image -->
                </ul>
            </div> <!-- /.nav-collapse -->
            </div>
            </nav>
            </header>
            </div>
            </div>


            <!-- ACE EDITOR DIV -->
            <div id="page-content-wrapper">
                <div id="div_editorpanel">
                    <div id="span_currentfolder"> 
                        <!-- Current folder: -->
                        <span id="span_currentfolderid">
                            <?php 
                                if (isset($_SESSION["currentfolder"])) {
                                    echo $_SESSION["currentfolder"];
                                }
                            ?>
                        </span> 
                    </div>
                    <div id="span_currentfile"> 
                        Current file:
                        <span id="span_currentfileid">
                            <?php 
                                if (isset($_SESSION["currentfile"])) {
                                    echo $_SESSION["currentfile"];
                                } else {
                                    echo "untitled";
                                }
                            ?>
                        </span> 
                    </div>

                    <div id="div_fontsize">
                        <span> Font size: </span>
                        <select id="select_fontsize">
                            <option value="8">8px</option>
                            <option value="12" selected="selected">12px</option>
                            <option value="18">18px</option>
                            <option value="24">24px</option>
                            <option value="36">36px</option>
                            <option value="72">72px</option>
                        </select>
                    </div>

                    <!-- <div id="page-content-wrapper"> -->
                    <div id="editor"></div>
                </div>
                <div id="column-resizer"></div>
                <div id="results"></div>
                <!-- </div> -->
            </div>
        </div> <!-- wrapper -->



    <!-- ****** BEGINNING OF SHARE SCREEN ****** -->


    <div class="modal fade" id="shareModal" tabindex="-1" role="dialog" aria-labelledby="shareModalLabel" aria-hidden="true" >
    <div class="modal-dialog">
    <div class="modal-content login-modal">
        <div class="modal-header login-modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 >Share <i class="fa fa-lock"></i></h4>
        </div>
        <div class="modal-body">
        <div class="form-group">
        <div class="input-group">
            <div class="input-group-addon"><i class="fa fa-user"></i></div>
            <input type="text" class="form-control" id="share_username" placeholder="Username">
        </div>
        </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="btn_share" class="btn btn-block bt-login" data-loading-text="Sharing....">Share</button>
        </div>
    </div>
    </div>
    </div> 


    <!-- ****** ENDING OF SHARE SCREEN ****** -->



    <!-- **** BEGINNING OF LOGOUT **** -->

    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true" >
    <div class="modal-dialog">
    <div class="modal-content login-modal">
        <div class="modal-header login-modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 >Logout <i class="fa fa-lock"></i></h4>
        </div>
        <div class="modal-body"><i class="fa fa-question-circle"></i> Are you sure you want to log-off?</div>
        <div class="modal-footer"><button type="button" class="btn btn-block bt-login" data-loading-text="Signing out..." id="logout_btn">Logout</button></div>
    </div>
    </div>
    </div>

    <!-- **** END OF LOGOUT **** -->

    <!-- **** BEGINNING OF LOGIN **** -->
    <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog">
    <div class="modal-content login-modal">
        <div class="modal-header login-modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title text-center" id="loginModalLabel">USER AUTHENTICATION</h4>
        </div>
        <div class="modal-body">
        <div class="text-center">
            <div role="tabpanel" class="login-tab">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a id="signin-taba" href="#home" aria-controls="home" role="tab" data-toggle="tab">Sign In</a></li>
                    <li role="presentation"><a id="signup-taba" href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Sign Up</a></li>
                    <li role="presentation"><a id="forgetpass-taba" href="#forget_password" aria-controls="forget_password" role="tab" data-toggle="tab">Forget Password</a></li>
                </ul>
            
                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active text-center" id="home">
                    &nbsp;&nbsp;
                    <span id="login_fail" class="response_error" style="display: none;">Log-in failed, please try again.</span>
                    <div class="clearfix"></div>
                    <form>
                        <span class="help-block-has-error" id="user-error" >This field is required</span>
                        <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-addon"><i class="fa fa-user"></i></div>
                            <input type="text" class="form-control" id="login_username" placeholder="Username">
                        </div>
                        </div>
                        <span class="help-block-has-error" id="password-error" >This field is required</span>
                        <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-addon"><i class="fa fa-lock"></i></div>
                            <input type="password" class="form-control" id="password" placeholder="Password">
                        </div>
                        </div>
                        <button type="button" id="login_btn" class="btn btn-block bt-login" data-loading-text="Signing In....">Login</button>
                        <div class="clearfix"></div>
                        <div class="login-modal-footer">
                        <div class="row">
                        <div class="col-xs-8 col-sm-8 col-md-8">
                            <i class="fa fa-lock"></i>
                            <a href="javascript:;" class="forgetpass-tab"> Forgot password? </a>
                        
                        </div>
                        
                        <div class="col-xs-4 col-sm-4 col-md-4">
                            <i class="fa fa-check"></i>
                            <a href="javascript:;" class="signup-tab"> Sign Up </a>
                        </div>
                        </div>
                        </div>
                    </form>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="profile">
                        &nbsp;&nbsp;
                        <span id="registration_fail" class="response_error" style="display: none;">Registration failed, please try again.</span>
                        <div class="clearfix"></div>
                        <form id="register">
                            <span class="help-block-has-error" data-error='0' id="username-error">This field is required</span>
                            <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                <input type="text" class="form-control" id="username" placeholder="Username">
                            </div>
                            </div>
                            <span class="help-block-has-error" data-error='0' id="remail-error">This field is required</span>
                            <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon"><i class="fa fa-at"></i></div>
                                <input type="text" class="form-control" id="remail" placeholder="Email">
                            </div>
                            </div>
                            <span class="help-block-has-error" data-error='0' id="repassword-error">This field is required</span>
                            <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon"><i class="fa fa-lock"></i></div>
                                <input type="password" class="form-control" id="repassword" placeholder="Password">
                            </div>
                            </div>
                            <span class="help-block-has-error" data-error='0' id="conf-repassword-error">Passwords not matching.</span>
                            <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon"><i class="fa fa-lock"></i></div>
                                <input type="password" class="form-control" id="conf-repassword" placeholder="Confirm Password">
                            </div>
                            </div>

                            <button type="button" id="register_btn" class="btn btn-block bt-login" data-loading-text="Registering....">Register</button>
                            <div class="clearfix"></div>
                            <div class="login-modal-footer">
                            <div class="row">
                                <div class="col-xs-8 col-sm-8 col-md-8">
                                    <i class="fa fa-lock"></i>
                                    <a href="javascript:;" class="forgetpass-tab"> Forgot password? </a>
                                </div>
                                
                                <div class="col-xs-4 col-sm-4 col-md-4">
                                    <i class="fa fa-check"></i>
                                    <a href="javascript:;" class="signin-tab"> Sign In </a>
                                </div>
                            </div>
                            </div>
                        </form>
                    </div>
                    <div role="tabpanel" class="tab-pane text-center" id="forget_password">
                        &nbsp;&nbsp;
                        <span id="reset_fail" class="response_error" style="display: none;"></span>
                        <div class="clearfix"></div>
                        <form>
                        <span class="help-block-has-error" data-error='0' id="femail-error">This field is required</span>
                        <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-addon"><i class="fa fa-user"></i></div>
                            <input type="text" class="form-control" id="femail" placeholder="Email">
                        </div>
                        </div>
                            
                        <button type="button" id="reset_btn" class="btn btn-block bt-login" data-loading-text="Please wait....">Forget Password</button>
                        <div class="clearfix"></div>
                        <div class="login-modal-footer">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <i class="fa fa-lock"></i>
                                <a href="javascript:;" class="signin-tab"> Sign In </a>
                            </div>
                            
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <i class="fa fa-check"></i>
                                <a href="javascript:;" class="signup-tab"> Sign Up </a>
                            </div>
                        </div>
                        </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </div>
    </div>
    </div>
    <!-- **** END OF LOGIN **** -->

        <!-- NAVBAR RESPONSE HANDLER -->
        <script src="scripts/navbar-response.js" type="text/javascript" charset="utf-8"></script>

        <!-- EASYTREE -->
        <script src="scripts/easyTree.js" type="text/javascript" charset="utf-8"></script>
        <script src="scripts/easytree-response.js" type="text/javascript" charset="utf-8"></script>

        <!-- LOGIN RESPONSE -->
        <script src="scripts/login-response.js" type="text/javascript" charset="utf-8"></script>

        <!-- COLUMN RESIZER -->
        <script src="scripts/resizer.js" type="text/javascript"></script>

        <!-- INITIATING SCRIPT, ON ALL REFRESH -->
        <script src="scripts/init.js" type="text/javascript"></script>

        <!-- ANSWER SET OUTPUT XSLT PLUGIN -->
        <script type="text/javascript" src="jquery.xslt.js"></script> 
        <!-- <script>
            $("#menu-toggle").click(function(e) {
                e.preventDefault();
                $("#wrapper").toggleClass("toggled");
            });
        </script> -->

    </body>
</html>
