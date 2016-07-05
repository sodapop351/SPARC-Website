%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Template for a SPARC file
%% Author: 
%% Description:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sorts
#n={50,100,150,200,250,abcdr,501}.
#style={a,b}.
#color={blue,red}.
#align={center,left}.
#fontfamily={arial}.
#fontsize={20,10}.
#text={abc,def}.
#cap={butt,square,round}.
#width={10,20,72}.
#degree={1,2,3,4,5,6,7,8,9,10}.

predicates

draw_text(#style,#text,#n,#n).
text_font(#style,#fontsize,#fontfamily).
text_align(#style,#align).
text_color(#style,#color).
draw_line(#style,#n,#n,#n,#n).
draw_bezier_curve(#style,#n,#n,#n,#n,#n,#n,#n,#n).
draw_arc_curve(#style,#n,#n,#n,#degree,#degree).
line_width(#style,#width).
line_cap(#style,#cap).
line_color(#style,#color).
draw_quad_curve(#style,#n,#n,#n,#n,#n,#n).

rules

%draw_bezier_curve(a,50,50,100,100,150,150,200,200).
%draw_arc_curve(a,50,50,100,2,8).
%draw_quad_curve(a,100,100,50,100,200,200).
%draw_text(a,abc,50,501)|draw_text(a,def,50,501).
%text_font(a,20,arial).
draw_text(b,def,100,50).
%text_font(b,20,arial).
%text_align(a,center).
%text_color(a,blue).
%draw_line(a,50,100,100,50).
%draw_line(b,100,100,50,50).
%line_width(a,100).
%line_cap(a,round).
%line_color(a,blue).




