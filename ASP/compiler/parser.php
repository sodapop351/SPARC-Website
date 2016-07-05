<?php

/*
    ps_parseSparc($rawAnswerSets) : takes the answer set output from
        the compiler and then formats it into the correct xml format
        for use in the front-end

    $rawAnswerSets : direct output from the SPARC compiler with answer sets

    returns : xml version of the answer sets
*/
function ps_parseSparc($rawAnswerSets) {

    // TODO assumption : SPARC output has no "{" character until beginning
    // of the answer sets

    $translationMessage = "program translated";

    // There is an error
    if (strpos($rawAnswerSets, $translationMessage) === false) {
        return $rawAnswerSets;
    }

    $answerSets = strstr($rawAnswerSets, "{");

    $sparcParser = "compiler/SPARC/parser/asparser.jar";
    $tempInput = "compiler/SPARC/parser/temp.txt";
    $tempOutput = "compiler/SPARC/parser/output.xml";

    // populate input
    if (file_exists($tempInput)) {
        $newfile = fopen($tempInput, "w+");
        fwrite($newfile, $answerSets);
        fclose($newfile);
    } else {
        $newfile = fopen($tempInput, "w+");
        fwrite($newfile, $answerSets);
        fclose($newfile);
        chmod($tempInput, 0777);
    }

    // execute command
    $command = "java -jar " . $sparcParser;
    $command .= " -input:" . $tempInput;
    $command .= " -output:" . $tempOutput;
    shell_exec($command);

    // just in case output was not already there, need access
    chmod($tempOutput, 0777);

    // read output
    $handle = fopen($tempOutput, "r") or die("Unable to open file.");
    $xmlAnswerSets = fread($handle, filesize($tempOutput));
    fclose($handle);

    $htmlAnswerSets = ps_xsl($xmlAnswerSets);

    return $htmlAnswerSets;
}

function ps_xsl($xml) {

    echo $xml;

    $xslDoc = new DOMDocument();
    $xslDoc->load("compiler/SPARC/parser/NoQuery.xsl");

    $xmlDoc = new DOMDocument();
    $xmlDoc->loadXML($xml);

    $proc = new XSLTProcessor();
    $proc->importStylesheet($xslDoc);
    return $proc->transformToXML($xmlDoc);
}

?>
