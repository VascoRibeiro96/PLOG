
org:-
	clear_Screen,
	
	write('Reading you Input file...\n'),
	readFile(NumberofPersons,Guests,ListofTables),
	write('Number of Guests at the Party: '),write(NumberofPersons),nl, nl,
	write('Guests Name: '),nl,
	displayGuests(Guests),
	checkSeats(NumberofPersons,ListofTables),
	getNumberSeats(ListofTables,NumberofTables),
	length(Tables,NumberofTables),
	fillTables(NumberofPersons,Guests,NumberofTables,Tables),
	nl,
	write('___________________________________________'), nl,
	write('                Final Tables               '), nl,
	write('                                           '), nl,
	displayTables(Tables,Guests,1).

jantar :-
	game_name,
	game_information.
	
game_name :-
	clear_Screen,
	write('_________________________________________________'), nl,
	write('                                                 '), nl,
	write('             Organzacao de Jantar                '), nl,
	write('                                                 '), nl,
	write('                             Made By:            '), nl,
	write('                                   Tiago Grosso  '), nl,
	write('                                   Vasco Ribeiro '), nl,
	write('                                                 '), nl.
	 
game_information :-
	write('_________________________________________________'), nl,
	write('                 Information                     '), nl,
	write('                                                 '), nl,
	write(' Your input file should be at this directory     '), nl,
	write(' Your input file should be at this directory     '), nl,
	write(' You can change it at DinnerOrg.pl               '), nl,
	write(' Your input file should follow this              '), nl,
	write(' 1. Number of Guests                             '), nl,
	write(' 2. Guests with this by order:                   '), nl,
	write('     - Name                                      '), nl,
	write('     - Id                                        '), nl,
	write('     - Group (0 if isnt on a group, 1 otherwise) '), nl,
    write('     - State (0 if is married, 1 otherwise)      '), nl,
	write('     - Hobbies (0 if is books, 1 films)          '), nl,
	write(' 3. Number of Guests per Table                   '), nl,
	write(' 4. Number of Tables with that size              '), nl,
	write('                                                 '), nl,
	write('                                                 '), nl,
	write('_________________________________________________'), nl,
	get_char(_),
	org.

displayGuests([]):- nl.
displayGuests([L|Ls]):-
	 nth1(1,L,Name),
	 write(Name),nl,
	 displayGuests(Ls).	
	
displayTables([],_,_):- nl.
displayTables([L,Li|Ls],Guests,Index):-
	 
	 write('Table '),
	 write(Index),
	 write(':'),nl,
	 getNameById(L,Guests,Name1),
	 write(Name1),nl,
	 getNameById(Li,Guests,Name2),
	 write(Name2),nl,nl,
	 Index2 is Index+1,
	 displayTables(Ls,Guests,Index2).
	 	 
	 
getNameById(Id,Guests,Name):-
	nth1(Id,Guests,[Name,_,_,_,_]).
	
clear_Screen:-
	nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl.