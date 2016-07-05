%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Template for a SPARC file
%% Author: 
%% Description:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sorts
    #people = {sara, bob,john}.
predicates
    father(#people, #people).
    mother(#people,#people). 
rules
    father(bob, sara).
    mother(sara,john). 
