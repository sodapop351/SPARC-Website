// !!! all menu-toggle function has to be removed from navbar-response.js if using this resizer. !!!
$(document).ready(function() {


    $('#column-resizer').mousedown(function(e) {
        $('body').css('cursor', 'col-resize');

        e.preventDefault();
        $(document).mousemove(function(e) {
            var position = e.pageX;
            if ($("#wrapper").hasClass("toggled") === false) {
              position = e.pageX - 250; 
            }
                    
                    
            var mousePercent = (position / ($('#page-content-wrapper').width()) * 100);
            var mousePercent1 = mousePercent;
            if ($("#wrapper").hasClass("toggled") === false) {
               mousePercent1 = mousePercent + (212)*100 / ($('#page-content-wrapper').width());
            }
            
            
            if(mousePercent >= 5 && mousePercent <= 95) {
                $('#editor').css('width', (mousePercent - 2.9) + '%');
                // $('#results').css('width', ($('#page-content-wrapper').width() - $('#editor').width()) - 12 + 'px');
                $('#results').css('width', (100-mousePercent-2.9) + '%');
                if ($("#wrapper").hasClass("toggled") === false) {
                   $('#column-resizer').css('left', $('#editor').width() + 262 + 'px');
                   // $('#results').css('left',125 + 'px');
                // $('#column-resizer').css('left', (mousePercent1 - 1.8) + '%');
                } else {
                   $('#column-resizer').css('left', $('#editor').width() + 12 + 'px');
                }


                if(mousePercent <= 10) {
                    $('#editor').css('width', (10 - 2.9) + '%');
                    $('#results').css('width', (100 - 10) + '%');
                    $('#column-resizer').css('left', (10 - 1.8) + '%');
                } else if(mousePercent >= 90) {
                    $('#editor').css('width', (90 - 2.9) + '%');
                    $('#results').css('width', (100 - 90) + '%');
                    $('#column-resizer').css('left', (90 - 1.8) + '%');
                }
            }
        });
        $(document).mouseup(function(e) {
            $(document).unbind('mousemove');
            $(document).unbind('mouseup');

            $('body').css('cursor', '');
        });
    });
    
        // Directory button handler
        $('#menu-toggle').click(function(e) {
            e.preventDefault();
            refreshDirectory();
        });
        
        // The following was originally put into navbar-response.js 9/29
        
        $("#menu-toggle").click(function(e) {
            e.preventDefault();
            var percent1 = (($('#editor').width())+262)*100 / ($('#page-content-wrapper').width());
            var percent2 = (($('#editor').width()+12))*100 / ($('#page-content-wrapper').width());
        
            $("#wrapper").toggleClass("toggled");
        
            var startP = $('#editor').width();
            if ($("#wrapper").hasClass("toggled") == false) {
                $('#column-resizer').css('left', $('#editor').width()+262+'px')         
                $('#results').css('left', 100 + 'px');
            } else {
        
                $('#column-resizer').css('left', $('#editor').width()+12+'px');
                $('#results').css('left', 12 + 'px'); 
            }
        });
        
        $( window ).resize(function() {
            var percent1 = (($('#editor').width())+262)*100 / ($('#page-content-wrapper').width());
            var percent2 = (($('#editor').width()+12))*100 / ($('#page-content-wrapper').width());
            //$("#wrapper").toggleClass("toggled");
            if ($("#wrapper").hasClass("toggled") == false) {
                $('#column-resizer').css('left', $('#editor').width()+262+'px');
            } else {
                $('#column-resizer').css('left', $('#editor').width()+12+'px');
            }
            $('#results').css('width', ($('#page-content-wrapper').width() - $('#editor').width()) - 12 + 'px');
        });
        
});
