readFile(NumberofPersons,Guests,ListofTables):-
	open('Input.txt',read,Fd),
	read(Fd,NumberofPersons),
	number(NumberofPersons),
	readGuests(Fd,Guests,NumberofPersons),
	readTables(Fd,ListofTables,1),
	close(Fd).

readGuests(_,[],0).
readGuests(Fd,[X|Xs],NumberofPersons):-
	readGuest(Fd,X,5),
	NextN is NumberofPersons - 1,
	readGuests(Fd,Xs,NextN).

readGuest(_,[],0).
readGuest(Fd,[X|Xs],N):-
	read(Fd,X),
	NextN is N - 1,
	readGuest(Fd,Xs,NextN).

readTables(_,[],0).
readTables(Fd,[X|Xs],NumberofDifferentTables):-
	readTable(Fd,X),
	NextN is NumberofDifferentTables -1,
	readTables(Fd,Xs,NextN).

readTable(Fd,[X,Xs]):-
	read(Fd,X),
	read(Fd,Xs).