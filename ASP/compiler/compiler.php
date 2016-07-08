<?php

/*
    cp_setupTemporaryFiles($code, $query) : create files temp.sp with 
        content $code and tempquery.txt with content $query used in the
        compilation process

    $code : string code from the editor, meant to be compiled
    $query : string query from the user, can be empty

    returns : nothing
*/
function cp_setupTemporaryFiles($code, $query) {

    // TODO: make this file name general
    $filename = "compiler/SPARC/temp.sp";

    // If we need to create the temporary file, we give it permissions
    if (file_exists($filename)) {
        $newfile = fopen($filename, "w+");
        fwrite($newfile, $code);
        fclose($newfile);
    } else {
        $newfile = fopen($filename, "w+");
        fwrite($newfile, $code);
        fclose($newfile);
        chmod($filename, 0777);
        // TODO: Change the permissions number
    }

    // If there is no query, there is nothing to be done
    if (empty($query)) {
        return;  
    }

    $queryfilename = "compiler/SPARC/tempquery.txt";

    if (file_exists($queryfilename)) {
        $newfile = fopen($queryfilename, "w+");
        fwrite($newfile, $query . "\nexit"); //necessary to close compiler
        fclose($newfile);
    } else {
        $newfile = fopen($queryfilename, "w+");
        fwrite($newfile, $query . "\nexit");
        fclose($newfile);
        chmod($filename, 0777);
    }

}
/////////////////////////

function setupTemporaryFiles_forCanvas($code, $query) {

    // TODO: make this file name general
    $filename = "compiler/SPARC/Canvas/tempC.sp";

    // If we need to create the temporary file, we give it permissions
    if (file_exists($filename)) {
        $newfile = fopen($filename, "w+");
        fwrite($newfile, $code);
        fclose($newfile);
    } else {
        $newfile = fopen($filename, "w+");
        fwrite($newfile, $code);
        fclose($newfile);
        chmod($filename, 0777);
        // TODO: Change the permissions number
    }

    // If there is no query, there is nothing to be done
    if (empty($query)) {
        return;  
    }



}


/*
    cp_runCompiler($query) : runs the compiler with previously created
        sparc file in setupTemporaryFiles(). optional: run with query
        $query

    $query : string query given by the user

    returns : output of the compiler
*/
function cp_runCompiler($query) {

    // TODO: Command for more than just the SPARC compiler
    $command = "";
    $jarpath = "compiler/SPARC/sparc-new.jar";

    // TODO: make these variables global
    $tempfilepath = "compiler/SPARC/temp.sp";
    $queryfilepath = "compiler/SPARC/tempquery.txt";
    $jarparams = "";

    // If there is no query, then we want answer sets
    if (empty($query)) {
        $jarparams = "-A"; // get answer sets for SPARC
    } else {
        $command .= "cat " . $queryfilepath . " | "; // cat query
        // Added YL 12/21/2015 Evgenii introduced -web to deal with queryies with variables for this online
	// environment. 
	$jarparams = "-web"; 
	// End YL 12/21/2015
    }

    $command .= "java -jar " . $jarpath;
    $command .= " " . $tempfilepath;
    $command .= " " . $jarparams;
    $command .= " " . "2>&1";
    $output = shell_exec($command);


    return $output;
}



////////////////////////////////////

function runCompiler_forCanvas($query) {


    // TODO: Command for more than just the SPARC compiler
    $command = "";
    $jarpath = "compiler/SPARC/Canvas/par.jar";

    // TODO: make these variables global
    $tempfilepath = "compiler/SPARC/Canvas/tempC.sp";
    
	$command .= "java -jar " . $jarpath;
    $command .= " " . $tempfilepath;
   
    $command .= " " . "2>&1";
    $output = shell_exec($command);



    return $output;
}


/*
    cp_getAnswerSets($code) : get the answer sets for code $code

    $code : string code from the editor

    returns : raw answer set data from compiler
*/
function cp_getAnswerSets($code) {

    $query = ""; //TODO this is a hack, no query

    cp_setupTemporaryFiles($code, $query);
    $answersets = cp_runCompiler($query);

    return $answersets;
}


function getCanvas($code) {

    $query = ""; //TODO this is a hack, no query

    setupTemporaryFiles_forCanvas($code, $query);
    $answersets = runCompiler_forCanvas($query);

    return $answersets;
}




/*
    cp_ getQuery($code, $query) : gets results after calling query $query
        on code $code with the compiler and formats the results into
        a user-friendly manner

    $code : string code from the editor
    $query : string query given by the user
*/
function cp_getQuery($code, $query) {

    // Setup files for the program compilation and the query text
    cp_setupTemporaryFiles($code, $query);

    // Compiler returns query answers
    $queryanswer = cp_runCompiler($query);
    $queryanswer = nl2br($queryanswer);

    // Structure query output
    $querykeyword = "?-";

    $splitAnswers = explode($querykeyword, $queryanswer);
    
    for ($i = 1; $i < count($splitAnswers)-1; $i++) {
        echo $query . ": " . $splitAnswers[$i] . "</br>";
    }

    exit;
}
?>
<!-- LOADING SCREEN WIP --
<!Doctype>
<html>
	<body>
		<link rel="stylesheet" type="text/css" href="stylesheets/style.css">
		<script src="scripts/navbar-response.js" type="text/javascript" charset="utf-8"></script>
		<div class="overlay" id="screen">
        <img src="http://i.stack.imgur.com/MnyxU.gif" class="overlay" id="loading"/>
        <button class="overlay" id="terminate">
            <STRONG>
                TERMINATE
            </STRONG>
        </button>>
    </div>
	</body>
</html>