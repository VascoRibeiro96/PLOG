%--------------------LIBRARIES----------------%
:- prolog:set_current_directory('C:/Users/vasco/Desktop/Feup - DOCS/3º Ano/PLOG/Trabalho Final').
:- use_module(library(clpfd)).
:- use_module(library(lists)).
	

fillTables(NumberofPersons,Guests,NumberofTables,Tables):-
	domain(Tables,1,NumberofPersons),
	all_different(Tables),
	restrictions(Tables,1,NumberofTables,NumberofPersons,Guests),
	labeling([],Tables).
	
%----------------Restrictions-----------------%
restrictions(_,Index,NumberofTables,_,_):-
	Index >= NumberofTables.
restrictions(Tables,Index,NumberofTables,NumberofPersons,Guests):-
	Index < NumberofTables,
	element(Index,Tables,P),
	NextInd is Index +1,
	element(NextInd,Tables,Pi),
	NextIndex is NextInd +1,
	P #\= Pi,
	nth1(P,Guests,[_,_,GId,Int,H]),
	nth1(Pi,Guests,[_,_,GIdi,Inti,Hi]),
	(GId \= 0 -> GId #= GIdi;Int #= Inti #\/ H #= Hi),
	restrictions(Tables,NextIndex,NumberofTables,NumberofPersons,Guests).

checkSeats(NumberofPersons,ListofTables):-
	getNumberSeats(ListofTables,NumberofSeats),
	NumberofPersons > NumberofSeats,
	write('Sem espaco para todos. \n'),nl.
	
checkSeats(NumberofPersons,ListofTables):-
	getNumberSeats(ListofTables,NumberofSeats),
	NumberofPersons =< NumberofSeats,
	write('Espaco para todos. \n'),nl.


getNumberSeats([],0).
getNumberSeats([T|Ts],NumberofSeats):-
	getNumberSeats(Ts,N2),
	nth0(0,T,NumberofTableSeats),
	nth0(1,T,NumberofTables),
	TempNumber is NumberofTableSeats * NumberofTables,
	NumberofSeats is N2 + TempNumber.	
