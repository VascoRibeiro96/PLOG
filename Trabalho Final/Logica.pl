%--------------------LIBRARIES----------------%
:- use_module(library(clpfd)).
:- use_module(library(lists)).
	

fillTables(NumberofGuests,Guests,NumberofTables,Tables):-
	domain(Tables,1,NumberofGuests),
	all_different(Tables),
	restrictions(Tables,1,NumberofTables,NumberofGuests,Guests),
	labeling([],Tables).
	
%----------------Restrictions-----------------%
restrictions(_,Index,NumberofTables,_,_):-
	Index >= NumberofTables.
restrictions(Tables,Index,NumberofTables,NumberofGuests,Guests):-
	Index < NumberofTables,
	element(Index,Tables,P),
	NextInd is Index +1,
	element(NextInd,Tables,Pi),
	NextIndex is NextInd +1,
	P #\= Pi,
	nth1(P,Guests,[_,_,GId,Int,H]),
	nth1(Pi,Guests,[_,_,GIdi,Inti,Hi]),
	(GId \= 0 -> GId #= GIdi;Int #= Inti #\/ H #= Hi),
	restrictions(Tables,NextIndex,NumberofTables,NumberofGuests,Guests).

checkSeats(NumberofGuests,ListofTables):-
	getNumberSeats(ListofTables,NumberofSeats),
	NumberofGuests > NumberofSeats,
	write('Sem espaco para todos. \n'),nl.
	
checkSeats(NumberofGuests,ListofTables):-
	getNumberSeats(ListofTables,NumberofSeats),
	NumberofGuests =< NumberofSeats,
	write('Espaco para todos. \n'),nl.


getNumberSeats([],0).
getNumberSeats([T|Ts],NumberofSeats):-
	getNumberSeats(Ts,N2),
	nth0(0,T,NumberofTableSeats),
	nth0(1,T,NumberofTables),
	TempNumber is NumberofTableSeats * NumberofTables,
	NumberofSeats is N2 + TempNumber.	
