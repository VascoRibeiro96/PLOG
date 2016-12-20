:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-use_module(library(clpfd)).


main:- go.

go:-

   Maximize is 1, 


   max_tables(A),
   min_tables(B),
   num_tables(N),

   guests(C),
   length(M,C),

   write([A,B,N,M]),
   

  
   Tables is [],
   domain(Tables, 1, N),

   sumlist(C,Tmp),
   domain(Z,0,Tmp),

   
   %Z #= sum(([nth1(C[J,K])*(Tables[J]#=Tables[K]), J in 1..M, K in 1..M, J < K]),

   %foreach(between(1,N,I),sum([Tables[J], #= I : J in 1..M])), #<= A
     
   %foreach(between(1,N,I),sum([(C[J,K] #> 0)*(Tables[J] #= I)*(Tables[K] #= I): J in 1..M, K in 1..M])), #>= B

   element(1,Tables, Elem1),
   Elem1 #= 1,
   
   Vars is Tables,

   (Maximize = 1->(
      writeln(maximize),
	  labeling([], Vars));
   (
      writeln(minimize),
      labeling([], Vars))),

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

decreasing(List):-
   List is 1.
   %apagar linha de cima
   %foreach(I in 2..List.length) List[I-1] #>= List[I] end.

increasing(List):-
   List is 1.
   %apagar linha de cima
   %foreach(I in 2..List.length) List[I-1] #<= List[I] end.


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
 "Deb        mother of the bride",
 "John       father of the bride",
 "Martha     sister of the bride",
 "Travis     boyfriend of Martha",
 "Allan      grandfather of the bride",
 "Lois       wife of Allan (the grandfather of the bride)",
 "Jayne      aunt of the bride",
 "Brad       uncle of the bride",
 "Abby       cousin of the bride",
 "Mary Helen mother of the groom",
 "Lee        father of the groom",
 "Annika     sister of the groom",
 "Carl       brother of the groom",
 "Colin      brother of the groom",
 "Shirley    grandmother of the groom",
 "DeAnn      aunt of the groom",
 "Lori       aunt of the groom"
].

names2(Names):-
Names is
[
 "Deb (B)",
 "John (B)",
 "Martha (B)",
 "Travis (B)",
 "Allan (B)",
 "Lois (B)",
 "Jayne (B)",
 "Brad (B)",
 "Abby (B)",
 "Mary Helen (G)",
 "Lee (G)",
 "Annika (G)",
 "Carl (G)",
 "Colin (G)",
 "Shirley (G)",
 "DeAnn (G)",
 "Lori (G)"
].


num_tables(N):- N is 5.
max_tables(A):- A is 4. 
min_tables(B):- B is 2.


