sorts 
#num=1..9.
#co={10,500,20,40,80,120,160,200,240,280,320,360,400}.
#style={table,old,new}.
#color={red,blue,black}.
#fontsize={32,12,28,24}.
#fontfamily={arial}.
#lineW={arial}.
#text=#num+{soduko}.
#cot=20..405.




predicates
draw_line(#style,#co,#co,#co,#co).
draw_text(#style,#text,#cot,#cot).
line_width(#style,#lineW).
line_color(#style,#color).
text_font(#style,#fontsize,#fontfamily).
text_color(#style,#color).

% first argument: number, second argument: x, third argument:y.
numinpos(#num,#num,#num).

% first argument: x, second argument:y.
coor(#num,#num).

number(#num).

% first argument: region, second argument: x, third argument:y.
inregion(#num,#num,#num).



rules


%facts: these are facts about an example of a sudoku, see image attached. 
numinpos(2,1,2).
numinpos(5,1,4).
numinpos(1,1,6).
numinpos(9,1,8).
numinpos(8,2,1).
numinpos(2,2,4).
numinpos(3,2,6).
numinpos(6,2,9).
numinpos(3,3,2).
numinpos(6,3,5).
numinpos(7,3,8).
numinpos(1,4,3).
numinpos(6,4,7).
numinpos(5,5,1).
numinpos(4,5,2).
numinpos(1,5,8).
numinpos(9,5,9).
numinpos(2,6,3).
numinpos(7,6,7).
numinpos(9,7,2).
numinpos(3,7,5).
numinpos(8,7,8).
numinpos(2,8,1).
numinpos(8,8,4).
numinpos(4,8,6).
numinpos(7,8,9).
numinpos(1,9,2).
numinpos(9,9,4).
numinpos(7,9,6).
numinpos(6,9,8).


%No row has the same number twice.
-numinpos(N,X,Y2):- numinpos(N,X,Y1), Y1 != Y2,coor(X,Y2), coor(X,Y2).

%No column has the same number twice.
-numinpos(N,X1,Y):- numinpos(N,X2,Y), X1 != X2, coor(X2,Y), coor(X1,Y).


%Each cell has only one number assigned to it.
-numinpos(N2,X,Y):- numinpos(N1,X,Y), N1 != N2, coor(X,Y).


%assigning region number to each locations. 
inregion(1,X1,Y1):-X1<4,Y1<4, coor(X1,Y1).
inregion(2,X1,Y1):-X1>3,X1<7,Y1<4,coor(X1,Y1).
inregion(3,X1,Y1):-X1>6,Y1<4,coor(X1,Y1).
inregion(4,X1,Y1):-X1<4,Y1>3, Y1<7,coor(X1,Y1).
inregion(5,X1,Y1):-X1>3,X1<7,Y1>3, Y1<7,coor(X1,Y1).
inregion(6,X1,Y1):-X1>6,Y1>3, Y1<7,coor(X1,Y1).
inregion(7,X1,Y1):-X1<4,Y1>6,coor(X1,Y1).
inregion(8,X1,Y1):-X1>3,X1<7,Y1>6,coor(X1,Y1).
inregion(9,X1,Y1):-X1>6,Y1>6,coor(X1,Y1).

% each number occurs in each region only once.
:-numinpos(N,X1,Y1), inregion(R,X1,Y1), numinpos(N,X2,Y2), inregion(R,X2,Y2), X1!=X2,Y1!=Y2, coor(X1,Y1),coor(X2,Y2).




%no location is empty of a number. each location has a number assigned to it.
numinpos(1,X,Y)|numinpos(2,X,Y)|numinpos(3,X,Y)|numinpos(4,X,Y)|numinpos(5,X,Y)|numinpos(6,X,Y)|numinpos(7,X,Y)|numinpos(8,X,Y)|numinpos(9,X,Y):-coor(X,Y).


%specifying all the possible coordinates 
number(X):- X<=9, X>=1.
coor(X,Y):- number(X), number(Y).



%drawing


draw_line(table,40,40,40,400).
draw_line(table,400,40,400,400).
draw_line(table,40,40,400,40).
draw_line(table,40,400,400,400).

draw_line(table,80,40,80,400).
draw_line(table,120,40,120,400).
draw_line(table,160,40,160,400).
draw_line(table,200,40,200,400).
draw_line(table,240,40,240,400).
draw_line(table,280,40,280,400).
draw_line(table,320,40,320,400).
draw_line(table,360,40,360,400).

draw_line(table,40,80,400,80).
draw_line(table,40,120,400,120).
draw_line(table,40,160,400,160).
draw_line(table,40,200,400,200).
draw_line(table,40,240,400,240).
draw_line(table,40,280,400,280).
draw_line(table,40,320,400,320).
draw_line(table,40,360,400,360).

draw_text(old,N,40*X+10,40*Y+30):-numinpos(N,X,Y).

draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=1,Y=2.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=1,Y=4.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=1,Y=6.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=2,Y=1.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=2,Y=4.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=2,Y=6.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=2,Y=9.

draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=3,Y=2.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=3,Y=5.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=3,Y=8.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=4,Y=3.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=4,Y=7.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=5,Y=1.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=5,Y=2.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=5,Y=8.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=5,Y=9.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=6,Y=3.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=6,Y=7.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=7,Y=2.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=7,Y=5.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=7,Y=8.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=8,Y=1.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=8,Y=4.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=8,Y=6.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=8,Y=9.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=9,Y=2.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=9,Y=4.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=9,Y=6.
draw_text(new,N,40*X+10,40*Y+30):-numinpos(N,X,Y),X=9,Y=8.


text_font(old,28,arial).
text_font(new,28,arial).

line_color(table,black).
text_color(old,black).
text_color(new,blue).
