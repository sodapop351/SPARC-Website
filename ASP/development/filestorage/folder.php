<?php

class Folder {
    private $name = "";
    private $folderurl = "";
    private $files = array();
    private $folders = array();

    public function __construct($in_name, $in_folderurl) {
        $this->name = $in_name;
        $this->folderurl = $in_folderurl;
        // echo "Creating folder " . $this->name . "</br>";
    }

    public function addFile($file) {
        // echo "Adding " . $file->getName() . " to " . $this->name . "</br>";
        $this->files[$file->getName()] = $file;
    }

    public function addFolder($folder) {
        // echo "Adding " . $folder->getName() ." to " . $this->name . "</br>";
        $this->folders[$folder->getName()] = $folder;
    }

    public function getName() {
        return $this->name;
    }

    public function getFolderUrl() {
        return $this->folderurl;
    }

    public function getFiles() {
        return $this->files;
    }

    public function getFolders() {
        return $this->folders;
    }

    /** $folder is a Folder object */
    public function getFolder($folder) {
        $foldername = $folder->getName();
        if ($this->hasFolder($folder)) {
            $ret = $this->folders[$foldername];
            return $ret;
        }
        return null;
    }

    /** $folder is a Folder object */
    public function hasFolder($folder) {
        $ret = array_key_exists($folder->getName(), $this->folders);
        return $ret;
    }

    /** $file is a File object */
    public function hasFile($file) {
        $ret = array_key_exists($filer->getName(), $this->file);
        return $ret;
    }

    public function __toString() {
        return $this->name;
    }
}

?>
