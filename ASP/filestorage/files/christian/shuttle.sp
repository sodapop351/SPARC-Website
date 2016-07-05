%%%%%%%%%%%%%%%%%%%%
%% shuttle.sp
%%%%%%%%%%%%%%%%%%%%

sorts
    #shuttles = {peter, sam}.
    #cars = {mbathio}.
    #ships = #shuttles + #cars.
predicates
    isShuttle(#ships).
    everything(#ships).
rules
    isShuttle(X) :- #shuttles(X).
    %test