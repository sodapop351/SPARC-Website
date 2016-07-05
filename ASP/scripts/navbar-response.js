var ajaxurl = 'ajax.php';

/*
    refreshDirectory() : empties the directory, refills with
        accessible directory for session username
*/
var refreshDirectory = function() {
    var data = {'action': "getAccessibleDirectory"};

    // Expected response : directory accessible to user
    $.post(ajaxurl, data, function(response) {
        $('#directory').empty();
        $('#directory').append("<ul>" + response + "</ul>");
        $('.easy-tree').EasyTree({
            selectable: true,
            deletable: true,
            editable: true
        });
    });
};

/*
    setCurrentFolder(foldername) : sets the PHP Session variable
        to the folder folderName and then updates current folder
        on front-end
*/
var setCurrentFolder = function(folderName) {
    var data = {'action': "setCurrentFolder",
                'currentfolder': folderName};
    $.post(ajaxurl, data, function(response) {
        /*
        var folderurl = response;
        $('#span_currentfolderid').empty();
        $('#span_currentfolderid').append(folderurl);
        */
    });
};

/*
    updateCurrentFolder() : updates folder and file ids on the front
        end to match the session variables

    returns : nothing
*/
var updateCurrentFolder = function() {
    /*var data = {'action': "getCurrentFolder"};
    $.post(ajaxurl, data, function(response) {
        var folderurl = response;
        $('#span_currentfolderid').empty();
        $('#span_currentfolderid').append(folderurl);
        $('#span_currentfolderid').data("value", folderurl);
    }); */
};

/*
    updateCurrentFile() : updates folder and file ids on the front
        end to match the session variables

    returns : nothing
*/
var updateCurrentFile = function() {
    var data = {'action': "getCurrentFile"};
    $.post(ajaxurl, data, function(response) {
        var fileurl = response;
        $('#span_currentfileid').empty();

        if (!fileurl) {
            //TODO do we want untitled
            //$('#span_currentfileid').append("untitled");
        } else {
            $('#span_currentfileid').append(fileurl);
            $('#span_currentfileid').data("value", fileurl);
        }
    });
};

/*
    setCurrentFile(fileName) : sets the PHP Session variable
        to the file fileName and then updates current folder on
        back-end
*/
var setCurrentFile = function(fileName) {
    var data = {'action': "setCurrentFile",
            'currentfile': fileName};
    $.post(ajaxurl, data, function(response) {
        /*$('#span_currentfileid').empty();

        if (!fileName) {
            $('#span_currentfileid').append("untitled");
        } else {
            $('#span_currentfileid').append(fileName);
        } */
    });
};

/*
    setEditorToFile(fileName) : sets the ACE editor text to the
        file fileName
*/
var setEditorToFile = function(fileName) {

    setCurrentFile(fileName);
    if (!fileName) {
        fileName = "_templates/sparc.sp";
    }

    var data = {'action': "getFileContent",
                'fileurl': fileName};    
    $.post(ajaxurl, data, function(response) {
        var editor = ace.edit("editor");
        editor.setValue(response, -1);
    });
}

/*
    setEditorToCurrentFile() : sets ACE editor text to current file name
        in session

    returns : nothing
*/
var setEditorToCurrentFile = function() {
    var data = {'action': "getCurrentFile"};

    $.post(ajaxurl, data, function(response) {
        if (!response) {
            response = "";
        }
        setEditorToFile(response);
    });
    return;
}

var setEditorFontSize = function(font_size) {
    if (font_size < 0) {
        return;
    }

    if (font_size > 72) {
        return;
    }

    document.getElementById('editor').style.fontSize=''+font_size+'px';
}

var getCurrentUsername = function() {
    //var username = $("#login").html();
    var username = $('#login').attr('data-username');
    if (!username || username === "Log-in") {
        return "";
    }
    return username;
}

var isResponseError = function(response) {
    var errorMessage = "Something went wrong";
    if (response.indexOf(errorMessage) == 0) {
        return true;
    }
    return false;
};

var setResultsToString = function(string) {
    $('#results').empty();
    $('#results').append(string);
};

var hideButtonsForLoggedInUsers = function() {
    $("#menu-toggle").hide();
    $("#btn_new").hide();
    $("#btn_save").hide();
    $("#navbar_btn_issues").hide();
    $("#navbar_btn_share").hide();
};

var showButtonsForLoggedInUsers = function () {
    $("#menu-toggle").show();
    $("#btn_new").show();
    $("#btn_save").show();
    $("#navbar_btn_issues").show();
    $("#navbar_btn_share").show();
};

var updateNavbar = function() {
    if (getCurrentUsername()) {
        showButtonsForLoggedInUsers();
    } else {
        hideButtonsForLoggedInUsers();
    }
};

var closeDirectory = function() {
    $("#wrapper").toggleClass("toggled");
}

// YL 12-10 2015 for bug of non scrollable of the editor
function resizeAce(){
  $('#editor').height($(window).height()-112);
  var editor = ace.edit("editor")
  //var program = editor.getValue();
  //var cursor = editor.getCursorPosition();
  editor.resize();
  // editor.setValue(program, cursor);
  return;
}
// end of YL

// When the DOM is ready
$(document).ready(function() {

    var editor = ace.edit("editor");
    editor.setTheme("ace/theme/textmate");
    editor.getSession().setMode("ace/mode/sparc");

    // YL 12-10 2015
    // listen window change
    $(window).resize(resizeAce);
    // ee initilization of editor in init.js
    // end of YL

    // Get Query button handler
    $('#btn_getQuery').click(function(e) {
        e.preventDefault();
        var editorValue = editor.getValue();
        var queryValue = $('#txt_query').val();
        var data = {'action': "getQuery",
                    'query': queryValue,
                    'editor': editorValue};

        // Expected response : answer sets
        $.post(ajaxurl, data, function(response) {
            setResultsToString(response);
        });
    });

    // Get Answer Sets button handler
    $('#btn_getAnswerSets').click(function(e) {
        var editorValue = editor.getValue();
        var data = {'action': "getAnswerSets",
                    'editor': editorValue};

        // Expected response : answer sets in XML
        $.post(ajaxurl, data, function(response) {
            setResultsToString(response);
        });
    });
	
	
	 // Draw button handler
    $('#btn_getDrawing').click(function(e) {
        var editorValue = editor.getValue();
        var data = {'action': "getDrawing",
                    'editor': editorValue};

        // Expected response : answer sets in XML
        $.post(ajaxurl, data, function(response) {
            setResultsToString(response);
        });
    });
	
	
	

    // New folder button
    $('#newFolder').click(function(e) {
        e.preventDefault();
        var folderName = prompt("Please enter folder name");
        data = {'action': "addNewFolder",
                'newfolder': folderName};

        // Expected response : success message
        $.post(ajaxurl, data, function(response) {
            if (!isResponseError(response)) {
                refreshDirectory();
                setCurrentFolder(response);
                updateCurrentFolder();
            } else {
                setResultsToString(response);
            }
        });
    });

    // New file button
    $('#newFile').click(function(e) {
        e.preventDefault();
        var fileName = prompt("Please enter file name");
        var editorValue = editor.getValue();
        data = {'action': "addNewFile",
                'newfile': fileName,
                'editor': editorValue};

        // Expected response : success message
        $.post(ajaxurl, data, function(response) {

            if (!isResponseError(response)) {
                refreshDirectory();
                setEditorToFile(response);
                updateCurrentFile();
            } else {
                setResultsToString(response);
            }
            //setCurrentFile(response);
        });
    });

    // Delete button
    $("#btn_delete").click(function(e) {
        e.preventDefault();
        // TODO configure this
        data = {'action': "deleteFolder",
                'folderurl': "christian/deletefolder/"};

        $.post(ajaxurl, data, function(response) {
            setResultsToString(response);
            //$('#results').append(response + "</br>");
        });
    });

    // Share button
    $("#btn_share").click(function(e) {

        e.preventDefault();
        var currentFile = $("#span_currentfileid").html();
        var otherUser = $("#share_username").val();
        data = {'action': "shareFile",
                'fileurl': currentFile,
                'username2': otherUser,
                'permissions': "1"};

        $.post(ajaxurl, data, function(response) {

            if (response === "1") {
                //alert("Share successful!");
                $('#shareModal').modal("hide");
            } else {
                //alert("Error sharing file");
            }

        });
    });

    // Issues button
    $("#navbar_btn_issues").click(function(e) {
        var issue = prompt("What is your issue? Please give details as to what you did before you received an error.");
        var data = {'action': "addIssue",
                    'issue': issue};

        $.post(ajaxurl, data, function(response) {
            alert("Thank you for your contribution.");
        });
    });

    // Save button
    $("#btn_save").click(function(e) {
        // TODO check if currentuser is null then show log-in button

        var editorValue = editor.getValue();
    
        updateCurrentFile();
        var currentFile = $("#span_currentfileid").data("value");

        updateCurrentFolder();
        var currentFolder = $("#span_currentfolderid").data("value");

        // save an untitled file
        if (!currentFile || currentFile == "") {
            currentFile = prompt("Please enter a file name");
            currentFile = currentFolder.trim() + currentFile.trim();
        }
        var currentFileurl = currentFile;

        data = {'action': "saveFile",
                'fileurl': currentFileurl,
                'editor': editorValue};

        $.post(ajaxurl, data, function(response) {
            //setResultsToString(response);

            if (!isResponseError(response)) {
                setCurrentFile(currentFileurl);
                updateCurrentFile();
            }
        });
    });

    $(document).on("click", ".dir-item", function() {
        var fileurl = $(this).data("value");
        setEditorToFile(fileurl);

        var folderurl = fileurl.substring(0, fileurl.lastIndexOf("/")+1);

        setCurrentFolder(folderurl);
        setCurrentFile(fileurl);
        updateCurrentFolder();
        updateCurrentFile();
    });

    $(document).on("click", ".dir-item-text", function(e) {
        var fileurl = $(this).parent().parent().data("value");
        setEditorToFile(fileurl);

        var folderurl = fileurl.substring(0, fileurl.lastIndexOf("/")+1);

        setCurrentFolder(folderurl);
        setCurrentFile(fileurl);
        updateCurrentFolder();
        updateCurrentFile();

        e.stopPropogation();
    });

    $(document).on("change", "#select_fontsize", function() {
        var font_size = $(this).val();
        setEditorFontSize(font_size);
    });

    /* This does not work
    $(document).on("click", ".dir-folder", function() {
        var folderurl = $(this).data("value");
        alert("This fires");
        setCurrentFolder(folderurl);
    });
    */

    // TODO: remove

    /*
    function displayResults(xml) {
        var xsl = loadXMLDoc("compiler/SPARC/parser/NoQuery.xsl");
        // code for IE
        if (window.ActiveXObject|| xhttp.responseType == "msxml-document") {
            var ex = xml.transformNode(xsl);
            document.getElementById("result").innerHTML = ex;
        }
        // code for Chrome, Firefox, Opera, etc.
        else if (document.implementation && document.implementation.createDocument) {
            var xsltProcessor = new XSLTProcessor();
            xsltProcessor.importStylesheet(xsl);
            resultDocument = xsltProcessor.transformToFragment(xml, document);
            document.getElementById("result").appendChild(resultDocument);
            ("#result").append(resultDocument);
        }
    }

    */
});
