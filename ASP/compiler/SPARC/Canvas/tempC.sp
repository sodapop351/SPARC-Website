sorts
#style={s}.
#co={50,100,110,150,160}.
#people={john,tom}.
#text=#people.

predicates
draw_line(#style,#co,#co,#co,#co).
draw_text(#style,#text,#co,#co).
tall(#people).
short(#people).

rules
tall(tom).
short(john).
%if there exists a short person draw a line from (50, 50) to (50, 100) with style s
draw_line(s,50,50,50,100):-tall(X).
%if there exists a tall person draw a line from (100, 50) to (100, 150) with style s
draw_line(s,100,50,100,150):-tall(X).
%for any tall person write his name in coordinate (50, 110) with style s (beneath the tall line).
draw_text(s,X,50,110):-short(X).
%for any short person write his name in coordinate (50, 110) with style s (beneath the short line).
draw_text(s,X,100,160):-short(X).
