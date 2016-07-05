%% family.sp -- SPARC version of family example from Section 4.1
%% Last Modified: 2/7/14

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sorts

#person = {john, sam, bill, alice, bob, jj, hannah}.
#gender = {male, female}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
predicates

father(#person,#person).
mother(#person,#person).
gender(#person,#gender).
parent(#person,#person).
child(#person,#person).
brother(#person,#person).
uncle(#person,#person).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rules

father(john,sam).
father(john,bill).
father(jj,hannah).
gender(hannah,female).

mother(alice,sam).
mother(alice,bill).

gender(john,male).
gender(alice,female).
gender(sam,male).
gender(bill,male).

brother(jj,john).
gender(jj,male).

parent(X,Y) :- father(X,Y).
parent(X,Y) :- mother(X,Y).

child(X,Y) :- parent(Y,X).

brother(X,Y) :- gender(X,male),
                father(F,X),
                father(F,Y),
                mother(M,X),
                mother(M,Y),
                X != Y.
                
brother(X,Y) :- brother(Y,X),
               X != Y.
                
                
-father(X,Y) :- gender(X,female).

-father(X,Y) :- father(Z,Y), 
                X != Z.
                
uncle(X,Y) :- gender(X,male),
	      brother(X,Z),
	      parent(Z,Y),
	      X!=Y.

-uncle(X,Y) :- gender(X,female).


-uncle(X,Y) :- X=Y.
