<?php

function email_sendEmail($subject, $message, $email) {

    //TODO check email

    $command = "echo " . $message . " | ";
    $command .= "mail -s " . $subject . " ";
    $command .= $email;

    $output = shell_exec($command);
    return $output;

    //return $command;
}

?>
