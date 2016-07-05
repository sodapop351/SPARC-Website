<?php

$file_directory_name = "filestorage/files/";

/*
    fs_addFile($fileurl, $content) : adds file $fileurl with content 
        $content to file storage

    $fileurl : string path url to file
    $content : string content of the file 

    returns : string success or error message
*/
function fs_addFile($input_fileurl, $content) {
    global $file_directory_name;

    $fileurl = $_SERVER['DOCUMENT_ROOT'] . "/" . $file_directory_name . $input_fileurl;
    if (file_exists($fileurl)) {
        return "fs_addFile: File already exists! </br>";
    }

    $filename = substr(strrchr($fileurl, "/"), 1);
    $directory = substr($fileurl, 0, strpos($fileurl, $filename));

    if (!file_exists($directory)) {
        mkdir($directory, 0755, true);
    }

    $newfile = fopen($fileurl, "w+");
    fwrite($newfile, $content);
    fclose($newfile);
    chmod($fileurl, 0777);
    return  "Created a new file " . $input_fileurl . "</br>";
}

/*
    fs_addFolder($folderurl) : adds folder $folderurl to file storage if it
        does not already exist

    $folderurl : string path url to folder

    returns : string success or error message
*/
function fs_addFolder($folderurl) {
    global $file_directory_name;

    $extended_folderurl = $file_directory_name . $folderurl;
    
    if (file_exists($extended_folderurl)) {
        return "fs_addFolder: Folder already exists! </br>";
    }

    mkdir($extended_folderurl, 0755, true);
    return "Created a new directory " . $folderurl . "</br>";
}

/*
    fs_getFileContent($fileurl) : opens file $fileurl, reads the content
        and returns the content

    $fileurl : string path url to file

    returns : string code or error message
*/
function fs_getFileContent($fileurl) {
    global $file_directory_name;

    $extendedFileUrl = $file_directory_name . $fileurl;
    if (is_dir($extendedFileUrl)) {
        return "Not a valid filename";
    }

    if (file_exists($extendedFileUrl)) {
        $fobj = fopen($extendedFileUrl, "r") or die("Unable to open file");
        $code = fread($fobj, filesize($extendedFileUrl));
        fclose($fobj);
        return $code;
    }
    return "There is nothing here.";
}

/*
    fs_deleteFile($fileurl) : deletes the file $fileurl from the file
        storage

    $fileurl : string url path to file

    returns : success or error message
*/
function fs_deleteFile($fileurl) {
    global $file_directory_name;

    $extendedFileUrl = $file_directory_name . $fileurl;
    if (is_dir($extendedFileUrl)) {
        return "Not a valid filename";
    }

    if (file_exists($extendedFileUrl)) {
        $success_delete = unlink($extendedFileUrl);
        if ($success_delete) {
            return "Successfully deleted file in storage</br>";
        } else {
            return "Delete function did not work</br>";
        }
    }
    return "File does not exist.</br>";
}

/*
    fs_deleteFolder($folderurl) : deletes the folder $folderurl from the
        file storage

    $folderurl : string url path to folder

    returns : success or error message
*/
function fs_deleteFolder($folderurl) {
    global $file_directory_name;

    $extendedFileUrl = $file_directory_name . $folderurl;
    if (!is_dir($extendedFileUrl)) {
        return "Not a valid foldername";
    }

    $success_delete = rmdir($extendedFileUrl);
    if ($success_delete) {
        return "Successfully deleted file in storage</br>";
    } else {
        return "Delete function did not work</br>";
    }
}

/*
    fs_rewriteFile($fileurl, $content) : rewrites the file $fileurl with
        the content $content, if it does not exist, creates a new file

    $fileurl : string path url to file
    $content : string content to rewrite to file

    returns : string success or error message
*/
function fs_rewriteFile($fileurl, $content) {
    global $file_directory_name;

    $extended_fileurl = $file_directory_name . $fileurl;

    if (is_dir($extended_fileurl)) {
        return "Not a valid file url, is a folder.";
    }

    if (!file_exists($extended_fileurl)) {
        return "Not a valid file url, does not exist.";
    }

    //TODO check permissions

    file_put_contents($extended_fileurl, "");
    $newfile = fopen($extended_fileurl, "w");
    fwrite($newfile, $content);
    fclose($newfile);
    return "Successfully rewrote file " . $fileurl;
}

/*
    fs_file_exists($fileurl) : returns whether a file $fileurl exists in 
        the file storage
*/
function fs_file_exists($fileurl) {
    global $file_directory_name;

    $extended_fileurl = $file_directory_name . $fileurl;
    if (file_exists($extended_fileurl)) {
        return true;
    }
    return false;
}

function fs_addIssue($issue) {
    global $file_directory_name;

    $issues_fileurl = "issues.txt";
    $putContents = file_put_contents($issues_fileurl, 
                                     $issue . "\n",
                                     FILE_APPEND);
    if ($putContents === False) {
        return true;
    }
    return false;
}

?>
