validPreference(preference(As, Bs)) :-
    \+ (member(A, As), member(B, Bs), A==B).

mapState([[PreState, PostState] | _], PreState, PostState).
mapState([_ | M], PreState, PostState) :-
    mapState(M, PreState, PostState).

mapStates(M, PreStates, PostStates) :-
    maplist(mapState(M), PreStates, PostStates), !.

mapPreference(M, preference(PreA, PreB), preference(PostA, PostB)) :-
    mapStates(M, PreA, PostA), mapStates(M, PreB, PostB).

mapPreferences(M, PrePrefs, PostPrefs) :-
    maplist(mapPreference(M), PrePrefs, PostPrefs).

placeholder(OutSpace, InElement, [InElement, X]) :-
    member(X, OutSpace).

mapping(InSpace, OutSpace, Preferences, M) :- 
    maplist(placeholder(OutSpace), InSpace, M),
    mapPreferences(M, Preferences, PostPrefs),
    forall(member(Pref, PostPrefs), validPreference(Pref)).