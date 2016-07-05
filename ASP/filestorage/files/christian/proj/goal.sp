%%%%%%%%%%%%%%%%%
%% goal.sp
%%%%%%%%%%%%%%%%%

sorts
    #number = 1..10.
predicates
    holds(#number, #number).
rules
    holds(X, Y) :- X > 5.