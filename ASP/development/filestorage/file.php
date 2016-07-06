<?php

class File {

    private $name = "";
    private $fileurl = "";

    public function __construct($in_name, $in_fileurl) {
        $this->name = $in_name;
        $this->fileurl = $in_fileurl;
    }

    public function getName() {
        return $this->name;
    }

    public function getFileUrl() {
        return $this->fileurl;
    }

    public function __toString() {
        return $this->name;
    }
}

?>
