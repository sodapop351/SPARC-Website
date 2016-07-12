define("ace/mode/sparc_highlight_rules",["require","exports","module","ace/lib/oop","ace/mode/text_highlight_rules"], function(require, exports, module) {
"use strict";

var oop = require("../lib/oop");
var TextHighlightRules = require("./text_highlight_rules").TextHighlightRules;

var SparcHighlightRules = function() {

   this.$rules = {
        
        
        "start" : [ {
                token : "comment",
                regex : "\%.*$"
            }, {
                token : "constant",
                regex : "#[a-z]+[a-zA-Z0-9_]*"
            }, {
                token : "constant.character.escape",
                regex : "\\+|\\-|\\*|\\/|<=|>=|<|>|!=|=|\\||\\:\\-|not"
            }, {
                token : "storage.modifier",
                regex : "predicates|rules"
            }, {
                token : "storage.modifier",
                regex : "sorts",
                next : "sorts"
            }, {
                token : "string.quoted",
                regex : "[A-Z]{1}",
                next : "variable"
            }, {
                token : "text",
                regex : "[a-z]{1}",
                next : "constant"
            }
        ],
        "sorts" : [ {
                token : "constant",
                regex : "#[a-z]+[a-zA-Z0-9_]*"
            }, {
                token : "storage.modifier",
                regex : "predicates",
                next : "start"
            }, {
                token : "comment",
                regex : "\%.*$"
            }
        ], 
        "variable" : [ {
                token : "string.quoted",
                regex : "[a-zA-Z0-9_]*",
                next : "start"
            }
        ], 
        "constant" : [ {
                token : "text",
                regex : "[a-zA-Z0-9_]*",
                next : "start"
            }
        ]
    };
};

oop.inherits(SparcHighlightRules, TextHighlightRules);

exports.SparcHighlightRules = SparcHighlightRules;

});

define("ace/mode/folding/sparc",["require","exports","module","ace/lib/oop","ace/range","ace/mode/folding/fold_mode"], function(require, exports, module) {
"use strict";

var oop = require("../../lib/oop");
var Range = require("../../range").Range;
var BaseFoldMode = require("./fold_mode").FoldMode;

var FoldMode = exports.FoldMode = function() {

};
oop.inherits(FoldMode, BaseFoldMode);

(function() {
    this.foldingStartMarker = /^\s*(sorts|predicates|rules)\s*$/;
    this.foldingStopMarker = /^\s*(predicates|rules)\s*$/;

    this.getFoldWidgetRangeBase = this.getFoldWidgetRange;
    this.getFoldWidgetBase = this.getFoldWidget;

    this.getFoldWidget = function(session, foldStyle, row) {
        var line = session.getLine(row);

        if(this.foldingStartMarker.test(line))
            return "start";
    }

    this.getFoldWidgetRange = function(session, foldStyle, row) {
        var range = this.getFoldWidgetRangeBase(session, foldStyle, row);
        if (range)
            return range;

        var line = session.getLine(row);
        
        var startRow = row;
        var startColumn = line.length;
        var endRow = row;
        var endColumn = line.length-1;
        var maxRow = session.getLength();

        while(++row < maxRow) {
            line = session.getLine(row);
            if(this.foldingStopMarker.test(line)) {
                break;
            } else if(!(/^\s*\%.*$/).test(line) && !(/^\s*$/).test(line)) {
                endRow = row;
                endColumn = line.length;
            }
        }

        return new Range(startRow, startColumn, endRow, endColumn);
    };
    

}).call(FoldMode.prototype);

});

define("ace/mode/sparc",["require","exports","module","ace/lib/oop","ace/mode/text","ace/tokenizer","ace/mode/sparc_highlight_rules","ace/mode/folding/sparc"], function(require, exports, module) {
"use strict";

var oop = require("../lib/oop");

var TextMode = require("./text").Mode;
var Tokenizer = require("../tokenizer").Tokenizer;

var SparcHighlightRules = require("./sparc_highlight_rules").SparcHighlightRules;
var SparcFoldMode = require("./folding/sparc").FoldMode;

var Mode = function() {
    this.HighlightRules = SparcHighlightRules;
    this.foldingRules = new SparcFoldMode();
};
oop.inherits(Mode, TextMode);

(function() {
    this.lineCommentStart = "%";

    this.getNextLineIndent = function(state, line, tab) {
        var indent = this.$getIndent(line);
        return indent;
    };
    
    this.createWorker = function(session) {
        return null;
    }
    
    this.$id = "ace/mode/sparc";
}).call(Mode.prototype);

exports.Mode = Mode;
});
