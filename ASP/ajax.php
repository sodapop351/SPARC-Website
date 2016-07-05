<?php

ini_set('display_errors', 1); //TODO remove
ini_set('display_startup_errors', 1); //TODO remove
error_reporting(-1); //TODO remove

include 'header.php';
include 'database/conf.php';
include 'database/database.php';
include 'filestorage/filestorage.php';
include 'filestorage/folder.php';
include 'filestorage/file.php';
include 'compiler/compiler.php';
include 'compiler/parser.php';
include 'email/email.php';

$conn = db_connect(); // database connection

/* main : Checks the action from the HTTP POST variable and then
    calls a function accordingly.

    getAnswerSets, getQuery, getLogin, addNewFile, addNewFolder,
    getAccessibleDirectory, getExampleFileStructure
*/
if (isset($_POST['action'])) {

    $username = helper_getSession("username");
    $code = helper_getPost("editor");

    switch($_POST['action']) {
        case 'getAnswerSets':
            if (empty($code)) { 
                helper_sendError("No code");
                return;
            }

            echo getAnswerSets($code);
            break;
			
		case 'getDrawing':
            if (empty($code)) { 
                helper_sendError("No code");
                return;
            }

            echo getDrawing($code);
            break;	
			

        case 'getQuery':
            $query = helper_getPost("query");
            if (empty($code)) { 
                helper_sendError("No code");
                return;
            }

            if (empty($query)) { 
                helper_sendError("No query");
                return;
            }

            getQuery($code, $query);
            break;

        case 'getLogin':
            $username = helper_getPost("username");
            $password = helper_getPost("password");
            $rememberme = helper_getPost("rememberMeValue"); //TODO

            /*$username = "mbathio"; //TODO remove later
            $password = "1234567"; //TODO remove later */

            if (empty($username)) { 
                helper_sendError("No username");
                return;
            }

            if (empty($password)) { 
                helper_sendError("No password");
                return;
            }

            $res = getLogin($username, $password);
            echo $res;
            break;

        case 'getLogout':
            $res = getLogout();
            echo $res;
            break;

        case 'addNewUser':
            $username = helper_getPost("username");
            $email = helper_getPost("email");
            $password = helper_getPost("password");

            if (empty($username)) { 
                helper_sendError("No username");
                return;
            }
            if (empty($email)) { 
                helper_sendError("No email");
                return;
            }
            if (empty($password)) { 
                helper_sendError("No password");
                return;
            }

            echo addNewUser($username, $email, $password);
            setCurrentUser($username);
            setCurrentFolder($username . "/");
            setCurrentFile("");
            break;

        case 'addNewFile':
            $filename = helper_getPost("newfile");
            $currentdir = helper_getSession("currentfolder");

            //$username = "mbathio"; //TODO remove
            //$fileurl = "mbathio/bro/file2.sp"; //TODO remove
            //$code = "sorts\n#person =  {bob, sara}."; //TODO remove

            if (empty($username)) {
                helper_sendError("No username");
                return;
            }

            if (empty($filename)) {
                helper_sendError("No fileurl");
                return;
            }

            if (empty($currentdir)) {
                helper_sendError("No current directory");
                return;
            }

            $fileurl = $currentdir . $filename;
            
            echo addNewFile($username, $fileurl, $code);
            break;

        case 'addNewFolder':
            $folderurl = helper_getPost("newfolder");
            $currentdir = helper_getSession("currentfolder");
            //$username = "christian"; //TODO remove

            if (empty($username)) {
                helper_sendError("No username");
                return;
            }

            if (empty($currentdir)) {
                helper_sendError("No current directory");
                return;
            }

            if (empty($folderurl)) {
                helper_sendError("No folderurl");
                return;
            }

            $extendedfolderurl = $currentdir . $folderurl . "/";

            echo addNewFolder($username, $extendedfolderurl);
            break;

        case 'getAccessibleDirectory':
            /*$username = "christian"; //TODO remove */

            if (empty($username)) {
                helper_sendError("No username");
                return;
            }

            $root = getAccessibleDirectory($username);
            rec_printDirectory($root);
            break;

        case 'getExampleFileStructure':
            $root = exampleFileStructure();
            rec_printDirectory($root);
            break;

        case 'getFileContent':
            $fileurl = helper_getPost("fileurl");

            // TODO empty means template

            echo getFileContent($fileurl);
            break;

        case 'setCurrentFolder':
            $folderurl = helper_getPost("currentfolder");

            //if (empty($folderurl)) { echo "No folderurl"; return; }
            if (empty($folderurl)) { 
                if (empty($username)) {
                    $folderurl = "";
                } else {
                    // TODO assumes root directory is username + "/"
                    // TODO do i put this here or somewhere else 
                    $folderurl = $username . "/";
                }
            }

            echo setCurrentFolder($folderurl);
            break;

        case 'setCurrentFile':
            $fileurl = helper_getPost("currentfile");
            echo setCurrentFile($fileurl);
            break;

        case 'getCurrentUser':
            echo $username;
            break;

        case 'getCurrentFile':
            $fileurl = helper_getSession("currentfile");
            echo $fileurl;
            break;

        case 'getCurrentFolder':
            $folderurl = helper_getSession("currentfolder");
            echo $folderurl;
            break;

        case 'deleteFile':
            $fileurl = helper_getPost("fileurl");

            //$username = "christian"; //TODO remove this
            //$fileurl = "christian/deletethis.sp"; //TODO remove this

            if (empty($username)) {
                helper_sendError("No username");
                return;
            }

            if (empty($fileurl)) {
                helper_sendError("No fileurl");
                return;
            }

            echo addNewFile($username, $fileurl, "");
            echo deleteFile($username, $fileurl);
            break;

        case 'deleteFolder':
            $folderurl = helper_getPost("folderurl");

            //$username = "christian"; //TODO remove this
            //$folderurl = "christian/deletefolder/"; //TODO remove this

            if (empty($username)) {
                helper_sendError("No username");
                return;
            }

            if (empty($folderurl)) {
                helper_sendError("No folderurl");
                return;
            }

            echo deleteFolder($username, $folderurl);
            break;

        case 'saveFile':
            $frontend_fileurl = helper_getPost("fileurl");
            $backend_fileurl = helper_getSession("currentfile");
            $code = helper_getPost("editor");

            if (empty($username)) {
                helper_sendError("No username.");
                return;
            }

            if (empty($frontend_fileurl)) {
                helper_sendError("No fileurl");
                return;
            }

            echo saveFile($username, $frontend_fileurl, $code);

            break;

        case 'shareFile':
            $username2 = helper_getPost("username2");
            $frontend_fileurl = helper_getPost("fileurl");
            $backend_fileurl = helper_getSession("currentfile");
            $permissions = helper_getPost("permissions");

            if (empty($username2)) { 
                helper_sendError("No username to share with");
                return; 
            }

            if (empty($frontend_fileurl)) {
                helper_sendError("No fileurl");
                return;
            }

            if (empty($permissions)) {
                helper_sendError("No permissions");
                return;
            }

            if (empty($backend_fileurl)) { 
                helper_sendError("Error storing fileurl in session variable.");
                return;
            }

            if ($frontend_fileurl != $backend_fileurl) {
                echo "FILEURL mismatch between front/back end";
                return;
            }

            echo shareFile($frontend_fileurl, $username2, $permissions);
            break;

        case 'addIssue':
            $issue = helper_getPost("issue");

            if (empty($issue)) {
                return;
            }
            echo addIssue($issue);
            break;

        case 'renameFile':
            $oldfileurl = helper_getPost("oldfileurl");
            $newfileurl = helper_getPost("oldfileurl");

            if (empty($username)) {
                helper_sendError("No username.");
                return;
            }

            if (empty($oldfileurl)) {
                helper_sendError("No old file name");
                return;
            }

            if (empty($newfileurl)) {
                helper_sendError("No new file name");
                return;
            }

            echo renameFile($username, $oldfileurl, $newfileurl);
            break;

        case 'forgotPassword':
            $email = helper_getPost("email");
            if (empty($email)) {
                helper_sendError("No email");
                return;
            }
            echo forgotPassword($email);

            break;

        default:
            echo "Not a valid action";
            break;
    }
}

/*
    helper_getPost($parameter) : checks if the HTTP POST request was set
        for parameter $parameter

    $parameter : the HTTP POST request parameter

    returns : the value for the given parameter from the HTTP POSt,
        "" otherwise
*/
function helper_getPost($parameter) {
    if (isset($_POST[$parameter])) {
        return $_POST[$parameter];
    }
    return "";
}

/*
    helper_getSession($parameter) : checks if the PHP Session was set
        for parameter $parameter

    $parameter : the PHP Session vaiable parameter

    returns : the value for the given parameter from the PHP Session,
        "" otherwise
*/
function helper_getSession($parameter) {
    if (isset($_SESSION[$parameter])) {
        return $_SESSION[$parameter];
    }
    return "";
}

function helper_sendError($error) {
    echo "Something went wrong: " . $error;
    return;
}

function helper_isError($string) {
    $errormessage = "Error";
    if (strpos($string, $errormessage) !== FALSE) {
        return true;
    }
    return false;
}

/*
    getLogin($input_user, $input_pass) : connects the user to the database
        and the connection is used to login user $input_user with password
        $input_password

    $input_user : string username to try to login
    $input_pass : string passwod to try to login

    returns : nothing
    //TODO return true/false remove echo
*/
function getLogin($input_user, $input_pass) {
    global $conn;

    $res = db_login($conn, $input_user, $input_pass);

    $successMessage = "Login successful";
    if ($res === $successMessage) {
        $_SESSION["username"] = $input_user;
        // TODO assumption : folder on log-in is username directory
        $_SESSION["currentfolder"] = $input_user . "/";
        return true;
    }
    return false;
}

/*
    getLogout() : logs the user out from the database, this is effectively
        done by clearing the SESSION variable for username; no username
        means not logged in //TODO this is pretty hacky

    returns : T/F to session_destroy call
*/
function getLogout() {
    return session_destroy();
}

/*
    getAccessibleDirectory($user) : gets all folders and files available
        to user $user and then returns the root folder for the directory 
        of $user

    $user : string username of person whose accessible directory is required

    returns : Folder root of directory tree
*/
function getAccessibleDirectory($user) {
    global $conn;

    $folderurls = db_getAllFolders($conn, $user);

    $fileurls = db_getAllFiles($conn, $user);

    $root = new Folder("root", "");
    // for every folderurl we have access to
    foreach ($folderurls as $folderurl) {
        $urlarray = explode("/", $folderurl);
        $curr_folder = $root;
        array_pop($urlarray); // remove last blank

        // for every folder in every folderurl
        foreach ($urlarray as $folder) {
            $newfolder = new Folder($folder, $curr_folder->getFolderUrl() . $folder . "/");
            if (!$curr_folder->hasFolder($newfolder)) {
                $curr_folder->addFolder($newfolder);
                $curr_folder = $newfolder;
            } else { 
                $curr_folder = $curr_folder->getFolder($newfolder);
            }
        }
    }

    foreach ($fileurls as $fileurl) {
        $urlarray = explode("/", $fileurl);
        $filename = array_pop($urlarray); // remove last blank
        $curr_folder = $root;

        // create folders if they don't already exist
        foreach ($urlarray as $folder) {
            $newfolderurl = $curr_folder->getFolderUrl() . $folder . "/";
            $newfolder = new Folder($folder, $newfolderurl);
            if (!$curr_folder->hasFolder($newfolder)) {
                $curr_folder->addFolder($newfolder);
                $curr_folder = $newfolder;
            } else {
                $curr_folder = $curr_folder->getFolder($newfolder);
            }
        }

        $newfile = new File($filename, $fileurl);
        $curr_folder->addFile($newfile);
    }

    return $root;

}

/*
    rec_PrintDirectory($folder, $tab) : recursively print all subfolders
        and files within folder $folder while keeping track of the number
        of spaces $tab for each print

    $folder : root Folder object 
    $tab : number of tabs for indenting file structure

    returns : nothing
*/
function rec_PrintDirectory($folder) {

    $child_folders = $folder->getFolders();
    $child_files = $folder->getFiles();

    foreach($child_files as $cf) {
        echo "<li data-value=\"" . $cf->getFileUrl() . "\""
                . " class=\"dir-item\""
                . ">" 
                . $cf->getName() . "</li>";
    }

    foreach($child_folders as $cf) {
        echo "<li data-value=\"" . $cf->getFolderUrl() . "\""
            . " class=\"dir-folder\""
            . ">"
            . $cf->getName() . "<ul>";
        rec_PrintDirectory($cf);
        echo "</ul> </li>";
    }
}

/*
    function addNewUser($user, $email, $password) : add the user $user
        with the email $email and the password $password to the database
        and then create their root folder and give them access

    keywords: register, registration

    $user : string username of the user
    $email : string email of the user
    $password : string password of the user

    returns : nothing
    //TODO check all db accesses are succesful
*/
function addNewUser($user, $email, $password) {
    global $conn;


    $addUserResponse = db_addUser($conn, $user, $email, $password);
    if (helper_isError($addUserResponse)) {
        helper_sendError("Username already exists"); // TODO this isnt alone
        return false;
    }

    $folderurl = $user . "/";
    
    $addFolderResponse = db_addFolder($conn, $user, $folderurl);
    if (helper_isError($addFolderResponse)) {
        helper_sendError("Cannot create root folder"); // TODO this isnt alone
        return false;
    }

    $addHasAccessResponse = db_addHasAccess($conn, $user, $folderurl, ".", 1);
    if (helper_isError($addHasAccessResponse)) {
        helper_sendError("Cannot give access to root folder"); // TODO this isnt alone
        return false;
    }

    fs_addFolder($folderurl);

    return true;
}

/*
    addNewFile($user, $file, $code) : adds a new file $file with content
        $code to the internal file structure and gives ownership and
        access to user $user

    $user : string username of the user
    $file : string fileurl of the file
    $code : string code of the editor code

    returns : fileurl
*/
function addNewFile($user, $fileurl, $code) {
    global $conn;

    db_addFile($conn, $user, $fileurl);

    // remove file from the fileurl to get folderurl
    $folderarray = explode("/", $fileurl);
    $owner = $folderarray[0];
    array_pop($folderarray);
    $folderurl = implode("/", $folderarray);
    $folderurl .= "/";

    db_addFolderContains($conn, $folderurl, $fileurl);
    db_addHasAccess($conn, $user, $folderurl, $fileurl, 1);

    // TODO give access to everyone who access to folder
    // give access to owner
    if ($user != $owner) {
        db_addHasAccess($conn, $owner, $folderurl, $fileurl, 1); 
    }

    fs_addFile($fileurl, $code);

    //return "Successfully added new file " . $fileurl . "</br>";
    return $fileurl;
}

/*
    addNewFolder($user, $folder) : adds folder $folder to the internal
        file structure and gives ownership and access to user $user

    $user : string username of the user
    $folderurl : string folderurl of the folder

    returns : nothing
*/
function addNewFolder($user, $folderurl) {
    global $conn;

    //$user = "mbathio"; //TODO remove
    //$folder = "mbathio/dir1/"; //TODO remove
    db_addFolder($conn, $user, $folderurl);
    db_addHasAccess($conn, $user, $folderurl, ".", 1);
    fs_addFolder($folderurl);

    return $folderurl;
}

/*
    getAnswerSets($code) : get the answer sets for code $code

    $code : string code from the editor

    returns : xml formatted answer sets from the compiler
*/
function getAnswerSets($code) {
    $rawAnswerSets = cp_getAnswerSets($code);
    $xmlAnswerSets = ps_parseSparc($rawAnswerSets);
    return $xmlAnswerSets;
}

function getDrawing($code) {
    $CanvasAnswerSets = getCanvas($code);
   // $xmlAnswerSets = ps_parseSparc($rawAnswerSets);
    return $CanvasAnswerSets;
}


/*
    getQuery($code, $query) : gets the results after calling a query $query
        on code $code with the compiler and formats the results into
        a user-friendly manner

    $code : string code from the editor
    $query : string query given by the user
*/
function getQuery($code, $query) {
    echo cp_getQuery($code, $query);
}

/*
    setCurrentFolder($folder) : sets SESSION variable of currentfolder
        to folder $folder

    returns : nothing
    //TODO what happens when session is not started
*/
function setCurrentFolder($folder) {
    $_SESSION["currentfolder"] = $folder;
    return $folder;
}

/*
    setCurrentFile($fileurl) : sets SESSION variable of currentfile
        to file $file

    returns : string path url to file
    //TODO what happens when session is not started
*/
function setCurrentFile($fileurl) {
    $_SESSION["currentfile"] = $fileurl;
    return $fileurl;
}

/*
    setCurrentUser($username) : sets SESSION variable of username
        to user $username

    returns : string username
    //TODO what happens when session is not started
*/
function setCurrentUser($username) {
    $_SESSION["username"] = $username;
    return $username;
}

/*
    getFileContent($file) : gets the code content of the file $file and
        returns the code string

    returns : string representation of the code content of the file
*/
function getFileContent($fileurl) {
    return fs_getFileContent($fileurl);
}

/*
    deleteFile($username, $fileurl) : if user $username has access to
        the file $fileurl

    $username : string username of user
    $fileurl : string path url to the file

    //TODO should we check permissions somewhere else
*/
function deleteFile($username, $fileurl) {
    global $conn;

    $permission = 1; //TODO useless permission
    if(db_hasAccessFile($conn, $username, $fileurl, $permission)) {
        db_deleteFile($conn, $fileurl);
        db_deleteFolderContains($conn, "", $fileurl);
        db_deleteHasAccess($conn, "", "", $fileurl);

        fs_deleteFile($fileurl);
        return "Successfully deleted the file " . $fileurl . "</br>";
    } else {
        helper_sendError("Do not have access to file " . $fileurl . "</br>");
        return;
    }
}

/*
    deleteFolder($username, $folderurl) : if user $username has access
        to the folder $folderurl, then $folderurl is deleted

    $username : string username of user
    $folderurl : string path url to folder

    returns : success or error message
*/
function deleteFolder($username, $folderurl) {
    global $conn;

    $permission = 1;
    if (db_hasAccessFolder($conn, $username, $folderurl, $permission)) {
        // delete underlying files
        // assumption : no more records with this folder in
            // HasAccess, FolderContains, File tables
        $files = db_getFilesInFolder($conn, $folderurl);
        foreach ($files as $f) {
            echo deleteFile($username, $f);
        }

        // delete in Folder table
        db_deleteFolder($conn, $folderurl);

        // delete in file storage
        fs_deleteFolder($folderurl);
        return "Successfully deleted the folder " . $folderurl . "</br>";
    } else {
        return "Do not have access to folder " . $folderurl . "</br>";
    }
}

/*
    saveFile($fileurl, $code) : saves file $fileurl with code $code in the
        file storage. does not currently change the database. If the file
        does not already exist, creates it

    $fileurl : string path url to the file
    $code : string code to save

    returns : success or error message
*/
function saveFile($user, $fileurl, $code) {
    global $conn;

    $return = "";
    if (fs_file_exists($fileurl)) {
        $return = fs_rewriteFile($fileurl, $code);
    } else {
        $return = addNewFile($user, $fileurl, $code);
    }

    return $return;
}

/*
    shareFile($fileurl, $username, $permissions) : shares file $fileurl
        with user $username with permissions $permissions in the database

    $fileurl: string path url to the file
    $username : string username of user to share file with
    $permissions : string of integer permission to share

    returns : success or error message
*/
function shareFile($fileurl, $username, $permissions) {
    global $conn;

    $folders = explode("/", $fileurl);
    array_pop($folders);
    $folderurl = implode("/", $folders) . "/";

    $return = db_addHasAccess($conn, $username, $folderurl, $fileurl, $permissions);

    // TODO this is so hacky
    if ($return == "Added a new row to HasAccess") {
        return true;
    }
    return false;
}

function addIssue($issue) {
    return fs_addIssue($issue);
}

function renameFile($username, $oldfilename, $newfilename) {
    global $conn;

    $permission = 1;
    if (db_hasAccessFolder($conn, $username, $oldfilename, $permission)) {
        $code = getFileContent($oldfilename);
        addNewFile($username, $newfilename, $code);
        deleteFile($username, $oldfilename);
        echo "Successfully renamed the file";
        return $newfilename;
    } else {
        helper_sendError("Do not have access to file " . $oldfilename . "</br>");
        return;
    }
}

function forgotPassword($email) {
    global $conn;

    // get password from db with e-mail
    $pass = db_getPasswordWithEmail($conn, $email);

    // TODO check if not error

    // e-mail password
    $subject = "\"Forgotten Password\"";
    $message = "\"Hello, you have recently indicated that you have forgotten your password on the SPARCE IDE website. Your password is: " . $pass . ".\"";
    return email_sendEmail($subject, $message, $email);

    //return "Email has been sent.";
}

/*
    For Mbathio:
    exampleFileStructure() : creates file structure, does not require
        the database to populate the files
        root
            `- theory.sp
            `- goals

    return : root folder (beginning of tree structure of directory).
*/
function exampleFileStructure() {
    $root = new Folder("root", "");
    $goals = new Folder("goals", "");
    $root->addFolder($goals);

    $theory = new File("theory.sp", "");
    $goal1 = new File("goal1.sp", "");
    $goal2 = new File("goal2.sp", "");

    $root->addFile($theory);
    $goals->addFile($goal1);
    $goals->addFile($goal2); 

    $folders = $root->getFolders();
    $files = $goals->getFiles(); 

    return $root;
}

?>
