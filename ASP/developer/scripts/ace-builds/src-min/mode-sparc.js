define("ace/mode/sparc_highlight_rules",["require","exports","module","ace/lib/oop","ace/mode/text_highlight_rules"],function(e,t,n){"use strict";var r=e("../lib/oop"),i=e("./text_highlight_rules").TextHighlightRules,s=function(){this.$rules={start:[{token:"comment",regex:"%.*$"},{token:"constant",regex:"#[a-z]+[a-zA-Z0-9_]*"},{token:"constant.character.escape",regex:"\\+|\\-|\\*|\\/|<=|>=|<|>|!=|=|\\||\\:\\-|not"},{token:"storage.modifier",regex:"predicates|rules"},{token:"storage.modifier",regex:"sorts",next:"sorts"},{token:"string.quoted",regex:"[A-Z]{1}",next:"variable"},{token:"text",regex:"[a-z]{1}",next:"constant"}],sorts:[{token:"constant",regex:"#[a-z]+[a-zA-Z0-9_]*"},{token:"storage.modifier",regex:"predicates",next:"start"},{token:"comment",regex:"%.*$"}],variable:[{token:"string.quoted",regex:"[a-zA-Z0-9_]*",next:"start"}],constant:[{token:"text",regex:"[a-zA-Z0-9_]*",next:"start"}]}};r.inherits(s,i),t.SparcHighlightRules=s}),define("ace/mode/folding/sparc",["require","exports","module","ace/lib/oop","ace/range","ace/mode/folding/fold_mode"],function(e,t,n){"use strict";var r=e("../../lib/oop"),i=e("../../range").Range,s=e("./fold_mode").FoldMode,o=t.FoldMode=function(){};r.inherits(o,s),function(){this.foldingStartMarker=/^\s*(sorts|predicates|rules)\s*$/,this.foldingStopMarker=/^\s*(predicates|rules)\s*$/,this.getFoldWidgetRangeBase=this.getFoldWidgetRange,this.getFoldWidgetBase=this.getFoldWidget,this.getFoldWidget=function(e,t,n){var r=e.getLine(n);if(this.foldingStartMarker.test(r))return"start"},this.getFoldWidgetRange=function(e,t,n){var r=this.getFoldWidgetRangeBase(e,t,n);if(r)return r;var s=e.getLine(n),o=n,u=s.length,a=n,f=s.length-1,l=e.getLength();while(++n<l){s=e.getLine(n);if(this.foldingStopMarker.test(s))break;!/^\s*\%.*$/.test(s)&&!/^\s*$/.test(s)&&(a=n,f=s.length)}return new i(o,u,a,f)}}.call(o.prototype)}),define("ace/mode/sparc",["require","exports","module","ace/lib/oop","ace/mode/text","ace/tokenizer","ace/mode/sparc_highlight_rules","ace/mode/folding/sparc"],function(e,t,n){"use strict";var r=e("../lib/oop"),i=e("./text").Mode,s=e("../tokenizer").Tokenizer,o=e("./sparc_highlight_rules").SparcHighlightRules,u=e("./folding/sparc").FoldMode,a=function(){this.HighlightRules=o,this.foldingRules=new u};r.inherits(a,i),function(){this.lineCommentStart="%",this.getNextLineIndent=function(e,t,n){var r=this.$getIndent(t);return r},this.createWorker=function(e){return null},this.$id="ace/mode/sparc"}.call(a.prototype),t.Mode=a})