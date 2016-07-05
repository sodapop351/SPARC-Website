<?php

include ('conf.php');

/*
    db_connect() : Establishes a connection to the MySQL database.

    returns : The connection object $conn to query if successful, 
        quits the program otherwise.
*/
function db_connect() {
    global $dbhost, $dbuser, $dbpass, $dbname;

    $conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname);
    if ($conn->connect_error) {
        //TODO: does this quit the entire program or just this func
        die("Connection failed: " . $conn->connect_error);
    }

    return $conn;
}

/*
    db_login($conn, $input_user, $input_pass) : using connection $conn,
        queries the database for the password of $input_user and compares
        it to the input password $input_pass given by the user.

    $conn : the connection to the MySQL database
    $input_user : the username of the current user trying to log-in
    $input_pass : the password the current user typed to check with
        actual password

    returns : login successful or login unsuccessful depending on if
        there are errors with the query response or with the password
*/
function db_login($conn, $input_user, $input_pass) {

    $statement_checkpassword =
        "SELECT password 
         FROM User 
         WHERE username='" . $input_user . "';";

    $db_pass = "";
    $res = $conn->query($statement_checkpassword);
    if ($res->num_rows > 0) {
        while ($row = $res->fetch_assoc()) {
            $db_pass = $row["password"];
        }
    } else { // assumption : username is primary key
        return "Username does not exist.";
    }

    if ($db_pass == $input_pass) {
        return "Login successful";
    } else {
        return "Incorrect password";
    }
}

/*
    db_getAllFolders($conn, $user) : using connection $conn, queries the
        database for all folders accessible to user $user

    $conn : connection to MySQL database
    $user : username of user whose folders we are retrieving

    returns : a list of all folders the user has access to
        assuming always at least one (their root folder)
*/
function db_getAllFolders($conn, $user) {
    $statement_getAccessFolderUrl = 
        "SELECT folderurl
         FROM HasAccess
         WHERE username = '" . $user . "';";

    $folders = array();

    $res = $conn->query($statement_getAccessFolderUrl);
    if ($res->num_rows > 0) {
        while ($row = $res->fetch_assoc()) {
            array_push($folders, $row["folderurl"]);
        }
    }

    $folders = array_unique($folders);

    return $folders;
}

/*
    db_getAllFiles($conn, $user) : using connection $conn, queries the
        database for the files user $user has access to

    $conn : connection to the MySQL database
    $user : username of the user whose files we retrieve

    returns : 
    
*/
function db_getAllFiles($conn, $user) {

    $statement_getAccessFileUrl = 
        "SELECT fileurl
         FROM HasAccess
         WHERE username = '" . $user . "';";

    $files = array();

    $res = $conn->query($statement_getAccessFileUrl);
    if ($res->num_rows > 0) {
        while ($row = $res->fetch_assoc()) {
            $col = $row["fileurl"];
            if ($col != ".") {
                array_push($files, $row["fileurl"]);
            }
        }
    }

    $files = array_unique($files);

    return $files;
}

/*
    db_getFilesInFolder($conn, $folderurl) : using connection
        $conn, returns a list of all files in the folder $folderurl

    $conn : resource connection to the database
    $folderurl : string path url to folder

    returns : list of all fileurls in the folder
*/
function db_getFilesInFolder($conn, $folderurl) {
    $statement_selectFiles = 
        "SELECT fileurl
         FROM FolderContains
         WHERE folderurl = '" . $folderurl . "';";

    $res = $conn->query($statement_selectFiles);

    $files = array();
    if ($res->num_rows > 0) {
        while ($row = $res->fetch_assoc()) {
            $col = $row["fileurl"];
            array_push($files, $col);
        }
    }

    return $files;
}

/*
    db_hasAccessFolder($conn, $username, $folderurl, $permission) : using 
        connection $conn, checks whether user $username has access to 
        folder $folderurl with permission $permission

    //TODO assumption: user has access to delete only if owns the folder

    $conn : resource connection to the database
    $username : string username of the user
    $folderurl : string path to the folder url
    $permission : integer permission number //TODO useless right now

    returns : true if the user has access, false otherwise
*/
function db_hasAccessFolder($conn, $username, $folderurl, $permission) {
    $command = "SELECT owner
                FROM Folder
                WHERE folderurl = '" . $folderurl . "';";

    $result = $conn->query($command);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            if ($row["owner"] === $username) {
                return true;
            }
        }
    } else {
        die($conn->error);
    }

    return false;
}

/*
    db_hasAccessFile($conn, $username, $fileurl, $permission) : using 
        connection $conn, checks whether user $username has access to 
        file $fileurl with permission $permission

    //TODO assumption: user has access to delete only if owns the file

    $conn : resource connection to the database
    $username : string username of the user
    $fileurl : string path to the file url
    $permission : integer permission number //TODO useless right now

    returns : true if the user has access, false otherwise
*/
function db_hasAccessFile($conn, $username, $fileurl, $permission) {
    $command = "SELECT owner
                FROM File
                WHERE fileurl = '" . $fileurl . "';";

    $result = $conn->query($command);
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            if ($row["owner"] === $username) {
                return true;
            }
        }
    } else {
        die($conn->error);
    }

    return false;
}

/*
    helper_getUser($user) : makes a SQL statement to select username $user
        from the User table

    $user : string username of the user

    returns : SQL select statement from User table
*/
function helper_getUser($user) {
    $ret = "(SELECT username
            FROM User
            WHERE username='" . $user . "')";
    return $ret;
}

/*
    helper_getFolderUrl($folderurl) : makes a SQL statement to select
        folder $folderurl from the Folder table

    $folderurl : string url path to the folder

    returns : SQL select statement from Folder table
*/
function helper_getFolderUrl($folderurl) {
    $ret = "(SELECT folderurl
            FROM Folder
            WHERE folderurl='" . $folderurl . "')";
    return $ret;
}

/*
    helper_roundaboutGetFolderUrl($folderurl) : makes a SQL statement to 
        select folder $folderurl from the Folder table but through a 
        different SELECT statement. This is used in statements where
        inserting with a reference to oneself is not allowed.

    $folderurl : string url path to the folder

    returns : SQL select statement from Folder table
*/
function helper_roundaboutGetFolderUrl($folderurl) {
    $ret = "(SELECT F.folderurl
            FROM (SELECT * FROM Folder) AS F
            WHERE F.folderurl='" . $folderurl . "')";
    return $ret;
}

/*
    helper_getFileUrl($fileurl) : makes a SQL select statement to get
        file $fileurl from the File table

    $fileurl : string url path to the file

    returns : SQL select statement from File table
*/
function helper_getFileUrl($fileurl) {
    $ret = "(SELECT fileurl
            FROM File
            WHERE fileurl='" . $fileurl . "')";
    return $ret;
}

/*
    quote($string) : adds double quotes to string $string

    $string : string to add quotes to

    returns : a string with prepended and appended double quotes
*/
function quote($string) {
    $ret = "\"" . $string . "\"";
    return $ret;
}

/*
    helper_insertInto($table, $columns, $values) : creates SQL INSERT INTO
        statement that inserts array of values $values into their
        corresponding columns $columns within the table $table

    $table : string table name
    $columns : array of columns in same order as $values
    $values : array of values to insert in same order as $columns

    returns : SQL insert into statement from table $table
*/
function helper_insertInto($table, $columns, $values) {

    $ret = "INSERT INTO " . $table;
    // if specified columns
    if ($columns) {
        $formatted_columns = "(";
        foreach ($columns as $col) {
            $formatted_columns .= $col . ", ";
        }

        // remove last comma
        $formatted_columns = substr($formatted_columns, 0, -2);
        $formatted_columns .= ")";

        $ret .= $formatted_columns;
    }

    if (!$values) {
        //echo "Error: no values given"; //TODO pick one
        return "Error: no values given";
    }
    
    $formatted_values = "VALUES(";
    foreach ($values as $val) {
        $formatted_values .= $val . ", ";
    }
    $formatted_values = substr($formatted_values, 0, -2);
    $formatted_values .= ")";

    $ret .= " " . $formatted_values;
    $ret .= ";";

    return $ret;
}

/*
    helper_deleteFrom($table, $where) : constructs a SQL DELETE FROM
        statement that deletes from table $table with conditions
        $where

    $table : string database table to delete a record from
    $where : string conditions for deleting the record

    returns : string SQL DELETE FROM statement
*/
function helper_deleteFrom($table, $where) {
    $statement = "DELETE FROM " . $table
                . " WHERE " . $where . ";";
    return $statement;
}

/*
    db_addFolder($conn, $user, $folderurl) : with connection $conn adds
        folder $folderurl to the database file structure with ownership
        and access to user $user

    $conn : resource connection to mySQL database
    $user : string username of the user
    $folderurl : string url path to the folder

    returns : success or error message
*/
function db_addFolder($conn, $user, $folderurl) {

    $directory = explode("/", $folderurl);
    $size = sizeof($directory);

    if ($size < 2) {
        return "Error: Incorrect folderurl format.";
    }

    $foldername = $directory[$size-2]; //-2 because last is blank space

    $date = "CURDATE()";
    $owner = helper_getUser($user);
    $parent = "";

    if ($size >= 3) {
        $parent = $directory[$size-3];
    } else {
        $parent = $directory[0];        
    }

    $columns = array("folderurl", "foldername", "datecreated", "owner", "parenturl");
    $values = array(quote($folderurl), quote($foldername), $date, helper_getUser($user), helper_roundaboutGetFolderUrl($parent));

    $command = helper_insertInto("Folder", $columns, $values);
    
    if ($conn->query($command) === TRUE) {
        return "Added a new folder to Folder</br>"; 
    } else { 
        return "Error: " . $conn->error . "</br>";
    }

    // TODO: move all these dependent calls to ajax.php
    // db_addHasAccess($conn, $user, $folderurl, ".", 1); 
}

/*
    db_addFile($conn, $user, $fileurl) : with connection $conn, adds
        file $fileurl to the database file structure with ownership
        and access to user $user

    $conn : resource connection to the MySQL database
    $user : string username of the user
    $fileurl : string url path to the file

    returns : nothing
*/
function db_addFile($conn, $user, $fileurl) {

    // get the position of last "/" to find filename
    $filename = substr(strrchr($fileurl, "/"), 1);
    $date = "CURDATE()";

    $table = "File";
    $columns = array("fileurl", "filename", "datecreated", "owner");
    $values = array(quote($fileurl), quote($filename), $date, helper_getUser($user));
    $command = helper_insertInto($table, $columns, $values);

    if ($conn->query($command) === TRUE) {
        return "Added a new file to File</br>"; 
    } else { 
        return "db_addFile Error: " . $conn->error . "</br>";
    }

    //$folderurl = substr($fileurl, 0, strrpos($fileurl, "/")+1);
}

/*
    db_addFolderContains($conn, $folderurl, $fileurl) : with connection
        $conn, adds file $fileurl to folder $folderurl in the file
        structure of the database

    $conn : resource connection to the MySQL database
    $folderurl : string url path of the folder
    $fileurl : string url path of the file

    returns : nothing
*/
function db_addFolderContains($conn, $folderurl, $fileurl) {

    if (!$folderurl) {
        $folderurl = substr($fileurl, 0, strrpos($fileurl, "/")+1);
    }

    $columns = array("folderurl", "fileurl");
    $values = array(helper_getFolderUrl($folderurl), helper_getFileUrl($fileurl));
    $command = helper_insertInto("FolderContains", $columns, $values);
    
    if ($conn->query($command) === TRUE) {
        return "Added a new row to FolderContains</br>"; 
    } else { 
        return "db_addFolderContains Error: " . $conn->error . "</br>";
    }
}

/*
    db_addHasAccess($conn, $user, $folderurl, $fileurl, $permission) : 
        using connection $conn, gives user $user access to folder
        $folderurl and file $fileurl with permission $permission

        i.e. with db_addHasAccess(conn, user, dir1, ., 1) user is given
            access to folder dir1 and no files with permission 1
*/
function db_addHasAccess($conn, $user, $folderurl, $fileurl, $permission) {

    $columns = array("username", "folderurl", "fileurl", "permission");
    $values = array(helper_getUser($user), helper_getFolderUrl($folderurl), helper_getFileUrl($fileurl), $permission);

    $command = helper_insertInto("HasAccess", $columns, $values);

    if ($conn->query($command) === TRUE) {
        return "Added a new row to HasAccess"; 
    } else { 
        return "db_addHasAccess Error: " . $conn->error . "</br>";
    }
}

/*
    db_addUser($conn, $user, $email, $password) : using database connection
        $conn, adds the user $user with email address $email and password
        $password

    $conn : resource connection to the MySQL database
    $user : string username of the new user
    $email : string email address of the new user
    $password : string password of the new user

    returns : nothing
*/
function db_addUser($conn, $user, $email, $password) {

    $columns = array("Username", "Email", "Password");
    $values = array(quote($user), quote($email), quote($password));
    $command = helper_insertInto("User", $columns, $values);

    if ($conn->query($command) === TRUE) {
        return "Added a new row to User</br>"; 
        //return "True";
    } else { 
        return "Error: " . $conn->error . "</br>";
    }
}

/*
    db_deleteFile($conn, $fileurl) : with connection $conn, deletes the
        file $fileurl from the database

    $conn : resource connection to the database
    $fileurl : string path url to the file

    returns : string success message or error
*/
function db_deleteFile($conn, $fileurl) {

    $where = "fileurl = '" . $fileurl . "'";
    $command = helper_deleteFrom("File", $where);

    if ($conn->query($command) === TRUE) {
        return "Deleted record from table File</br>";
    }
    return "Error db_deleteFile: " . $conn->error . "</br>";
}

/*
    db_deleteFolderContains($conn, $folderurl, $fileurl) : using connection
        $conn, deletes record saying folder $folderurl contains file
        $fileurl

        note: if $folderurl is empty, removes all records saying any
        folder contains file $fileurl

    $conn : resource connection to database
    $folderurl : string path url to folder
    $fileurl : string path url to file

    returns : string success or error message
*/
function db_deleteFolderContains($conn, $folderurl, $fileurl) {

    $where = "fileurl = '" . $fileurl . "'";
    if (!empty($folderurl)) {
        $where .= " AND folderurl = '" . $folderurl . "'";
    }

    $command = helper_deleteFrom("FolderContains", $where);

    if ($conn->query($command) === TRUE) {
        return "Deleted record from table FolderContains</br>";
    }
    return "Error db_deleteFolderContains: " . $conn->error . "</br>";
}

/*
    db_deleteHasAccess($conn, $username, $folderurl, $fileurl) : 
        using connection $conn, deletes record saying user $username
        has access to folder $folderurl and file $fileurl

        notes: if $folderurl is empty, removes all records saying any
        folder contains file $fileurl

              if $username is empty, removes all records saying anyone
        has access to file $fileurl

    $conn : resource connection to database
    $username : string username of the user
    $folderurl : string path url to folder
    $fileurl : string path url to file

    returns : string success or error message
*/
function db_deleteHasAccess($conn, $username, $folderurl, $fileurl) {

    $where = "fileurl = '" . $fileurl . "'";
    if (!empty($folderurl)) {
        $where .= " AND folderurl ='" . $folderurl . "'";
    }
    if (!empty($username)) {
        $where .= " AND username ='" . $username . "'";
    }

    $command = helper_deleteFrom("HasAccess", $where);

    if ($conn->query($command) === TRUE) {
        return "Deleted record from table HasAccess</br>";
    }
    return "Error db_deleteFolderContains: " . $conn->error . "</br>";
}

/*
    db_deleteFolder($conn, $folderurl) : with connection $conn, deletes the
        folder $folderurl from the database

    $conn : resource connection to the database
    $folderurl : string path url to the file

    returns : string success message or error
*/
function db_deleteFolder($conn, $folderurl) {

    $where = "folderurl = '" . $folderurl . "'";
    $command = helper_deleteFrom("Folder", $where);

    if ($conn->query($command) === TRUE) {
        return "Deleted record from table Folder</br>";
    }
    return "Error db_deleteFolder: " . $conn->error . "</br>";
}

function db_getPasswordWithEmail($conn, $email) {
    $command = "(SELECT password
            FROM User
            WHERE email='" . $email . "')";

    $res = $conn->query($command);
    if ($res->num_rows > 0) {
        while ($row = $res->fetch_assoc()) {
            return $row["password"];
        }
    } else {
        return "Error db_getPasswordWithEmail: " . $conn->error . "</br";
    }
}

?>
