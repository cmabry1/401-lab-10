:- use_module(library(clpfd)).

% schedule(Courses, Rooms, Times)
schedule(Courses, Rooms, Times) :-

    Courses = [cs101, cs201, math101, phys101, eng101],
    Rooms = [r1, r2, r3],
    Times = [8, 10, 12, 14, 16],

    % Variables for assignment
    length(Courses, N),
    length(RoomAssign, N),
    length(TimeAssign, N),

    % Domains
    RoomAssign ins 1..3,
    TimeAssign ins 1..5,

    % Ensure no same room at same time
    no_conflicts(RoomAssign, TimeAssign),

    % Labeling (search for solutions)
    labeling([], RoomAssign),
    labeling([], TimeAssign),

    % Output assignments
    write('Course Assignments:'), nl,
    print_schedule(Courses, RoomAssign, TimeAssign, Rooms, Times).


% ----------------------------------------
% Ensure no two courses share same room & time
% ----------------------------------------
no_conflicts([], []).
no_conflicts([R|Rs], [T|Ts]) :-
    check_rest(R, T, Rs, Ts),
    no_conflicts(Rs, Ts).

check_rest(_, _, [], []).
check_rest(R, T, [R2|Rs], [T2|Ts]) :-
    (R #\= R2) #\/ (T #\= T2),
    check_rest(R, T, Rs, Ts).

% ----------------------------------------
% Print schedule nicely
% ----------------------------------------
print_schedule([], [], [], _, _).
print_schedule([C|Cs], [R|Rs], [T|Ts], Rooms, Times) :-
    nth1(R, Rooms, RoomName),
    nth1(T, Times, TimeSlot),
    write(C), write(' -> '),
    write(RoomName), write(' at '),
    write(TimeSlot), nl,
    print_schedule(Cs, Rs, Ts, Rooms, Times).
