:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-use_module(library(clpfd)).


main:- go.

go:-

   Maximize is 1, 


   max_tables(A),
   min_tables(B),
   num_tables(N),

   names2(Guests, NumGuests),
   domain(Guests, 0, (NumGuests - 1)),
   all_different(Guests),
   
   guests(C),
   length(M,C),

   write([A,B,N,M]),
   

  
   Tables is [],
   domain(Tables, 1, N),

   sumlist(C,Tmp),
   domain(Z,0,Tmp),
   
   
   
   %Z #= sum(([nth1(C[J,K])*(Tables[J]#=Tables[K]), J in 1..M, K in 1..M, J < K]),
     
   %foreach(between(1,N,I),sum([(C[J,K] #> 0)*(Tables[J] #= I)*(Tables[K] #= I): J in 1..M, K in 1..M])), #>= B

   %Calcular valor global de afinidade	
   calculateGlobalAfinity(Tables, 0, C, 0, Z),

   %Maximo de convidados por mesa
   checkMaxGuests(Tables, 0, A),	

   %Minimo de convidados por mesa
   checkMinGuests(Tables, 0, B),

   %Todos os convidados sentados
   checkGuestsSeated(Tables, 0, C, 0),

   element(1,Tables, Elem1),
   Elem1 #= 1,
   
   Vars is Tables,

   (Maximize = 1->(
      writeln(maximize),
	  labeling([max(Z)], Vars));
   (
      writeln(minimize),
      labeling([min(Z)], Vars))),

   write(Z), ln,
   write(Tables), ln,

   %names(Names),
   %foreach(T in 1..N)
   %  printf("At table %d\n", T),
    % foreach(I in 1..M) 
     %   if Tables[I] == T then
      %    printf("\t%d (%s)\n", I, Names[I])
      %  end
     %end,
     %nl
   %end,

   nl.

checkMinGuests(Tables, Index, Min):-
	length(NumTables, Tables),
	Index < NumTables, %Para o ciclo quando o indice ultrapassar os limites da lista de mesas
	IndexNext is Index + 1,
	nth0(Index, Tables, CurrentTable),
	length(L, CurrentTable),
	L #>= Min,
	checkMinGuests(Tables, IndexNext, Min).


checkMinGuests(_, _, _).

checkMaxGuests(Tables, Index, Max):-
	length(NumTables, Tables),
	Index < NumTables, %Para o ciclo quando o indice ultrapassar os limites da lista de mesas
	IndexNext is Index + 1,
	nth0(Index, Tables, CurrentTable),
	length(L, CurrentTable),
	L #<= Max,
	checkMaxGuests(Tables, IndexNext, Max).

checkMaxGuests(_, _, _).

checkGuestsSeated(Tables, Index, Guests, Total):-
	length(NumTables, Tables),
	Index < NumTables, %Para o ciclo quando o indice ultrapassar os limites da lista de mesas
	IndexNext is Index + 1,
	nth0(Index, Tables, CurrentTable),
	length(L, CurrentTable), %Quantos estao sentados nesta mesa
	Total2 is Total + L,
	checkGuestsSeated(Tables, IndexNext, Guests, Total2).


checkGuestsSeated(_, _, Guests, Total):-
	length(L, Guests),
	NumGuests is L / 2,
	Total #= NumGuests. %Todos os convidados tem de estar sentados

calculateGlobalAfinity(Tables, Index, Guests, CurrentAffinity, FinalAffinity):-
	length(NumTables, Tables),
	Index < NumTables, %Para o ciclo quando o indice ultrapassar os limites da lista de mesas
	IndexNext is Index + 1,
	nth0(Index, Tables, CurrentTable),
	calculateTableAffinity(CurrentTable, 0, 1, Guests, 0, TableAffinity),
	NextAffinity is CurrentAffinity + TableAffinity,
	calculateGlobalAfinity(Tables, IndexNext, Guests, NextAffinity, FinalAffinity).

calculateGlobalAfinity(_, _, _, CurrentAffinity, FinalAffinity):-
	FinalAffinity #= CurrentAffinity.	

calculateTableAffinity(Table, Guests, Index1, Index2, CurrentAffinity, TableAffinity):-
	length(L, Tables),
	Index1 < L,
	Index2 < L,
	nth0(Index1, Table, Guest1),
	nth0(Index2, Table, Guest2),
	nth0(Guest1, Guests, Line),
	nth0(Line, Guest2, Relation),
	Affinity is Relation * Relation,
	NextAffinity is CurrentAffinity +  Affinity,
	NextIndex2 is Index2 + 1,
	calculateTableAffinity(Table, Guests, Index1, NextIndex2, NextAffinity, TableAffinity).
	

calculateTableAffinity(Table, Guests, Index1, Index2, CurrentAffinity, TableAffinity):-
	length(L, Table),
	Index1 < L,
	NextIndex1 is Index1 + 1,
	NextIndex2 is NextIndex1 + 1,
	calculateTableAffinity(Table, Guests, NextIndex1, NextIndex2, CurrentAffinity, TableAffinity).



calculateTableAffinity(_, _, _, _, CurrentAffinity, TableAffinity):-
	TableAffinity is CurrentAffinity.	

guests(M):- 
M is
[[ 1,50, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0],
 [50, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0],
 [ 1, 1, 1,50, 1, 1, 1, 1,10, 0, 0, 0, 0, 0, 0, 0, 0],
 [ 1, 1,50, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0],
 [ 1, 1, 1, 1, 1,50, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0],
 [ 1, 1, 1, 1,50, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0],
 [ 1, 1, 1, 1, 1, 1, 1,50, 1, 0, 0, 0, 0, 0, 0, 0, 0],
 [ 1, 1, 1, 1, 1, 1,50, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0],
 [ 1, 1,10, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0],
 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,50, 1, 1, 1, 1, 1, 1],
 [ 0, 0, 0, 0, 0, 0, 0, 0, 0,50, 1, 1, 1, 1, 1, 1, 1],
 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1],
 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1],
 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1],
 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1],
 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1],
 [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1]].


names(Names):-
Names is
[
 "Debora     mae da Maria",
 "Joao       pai da Maria",
 "Marta      irma da Maria",
 "Tiago      namorado da Marta",
 "Andre      avo da Maria",
 "Luisa      mulher do Andre (avo da Maria)",
 "Joana      tia da Maria",
 "Bernardo   tio da Maria",
 "Ana        prima da Maria",
 "Helena     mae do Gustavo",
 "Leonardo   pai do Gustavo",
 "Anita      irma do Gustavo",
 "Carlos     irmao do Gustavo",
 "Cristiano  irmao do Gustavo",
 "Susana     avo do Gustavo",
 "Daniela    tia do Gustavo",
 "Lurdes     tia do Gustavo"
].

names2(Names, NumGuests):-
Names is
[
 "Debora",
 "Joao",
 "Marta",
 "Tiago",
 "Andre",
 "Luisa",
 "Joana",
 "Bernardo",
 "Ana",
 "Helena",
 "Leonardo",
 "Anita",
 "Carlos",
 "Cristiano",
 "Susana",
 "Daniela",
 "Lurdes"
],
length(Names,NumGuests).


num_tables(N):- N is 5.
max_tables(A):- A is 4. 
min_tables(B):- B is 2.


