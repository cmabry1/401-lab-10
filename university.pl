% छात्र(Name, ID, Department).
student(alice, 1001, cs).
student(bob, 1002, cs).
student(carol, 1003, math).
student(dave, 1004, physics).

% course(CourseID, Name, Department, Credits).
course(cs101, programming, cs, 3).
course(cs201, algorithms, cs, 4).
course(math101, calculus, math, 3).
course(phys101, mechanics, physics, 4).

% enrolled(StudentID, CourseID).
enrolled(1001, cs101).
enrolled(1001, cs201).
enrolled(1002, cs101).
enrolled(1003, math101).
enrolled(1004, phys101).

% ----------------------------------------
% Rules
% ----------------------------------------

% enrolled_students(CourseID, List)
enrolled_students(CourseID, List) :-
    findall(Name,
        (enrolled(ID, CourseID), student(Name, ID, _)),
        List).

% courses_taken(StudentID, List)
courses_taken(StudentID, List) :-
    findall(CourseID,
        enrolled(StudentID, CourseID),
        List).

% same_major(X, Y)
same_major(X, Y) :-
    student(X, ID1, Dept),
    student(Y, ID2, Dept),
    ID1 \= ID2.

% ----------------------------------------
% Example Queries (for testing)
% ----------------------------------------

% Find all students enrolled in cs101:
% ?- enrolled_students(cs101, List).

% Find all courses offered by cs department:
% ?- findall(CourseID, course(CourseID, _, cs, _), List).
