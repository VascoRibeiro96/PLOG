:-use_module(library(clpfd)).


fila([C1, C2, C3, C4, T1, T2, T3, T4]):-
	Cores = [C1, C2, C3, C4],
	domain(Cores, 1, 4),
	Amarelo = 1,
	Verde = 2,
	Azul = 3,
	Preto = 4,
	Tamanhos = [T1, T2, T3, T4],
	domain(Tamanhos, 1, 4),
	all_different(Cores),
	all_different(Tamanhos),
	
	element(PosAzul, Cores, Azul),
	AntesAzul #= PosAzul - 1,
	DepoisAzul #= PosAzul + 1,
	element(AntesAzul, Tamanhos, TamanhoAntesAzul),
	element(DepoisAzul, Tamanhos, TamanhoDepoisAzul),
	TamanhoAntesAzul #< TamanhoDepoisAzul,
	
	element(PosVerde, Cores, Verde),
	element(1, Tamanhos, PosVerde),
	
	PosVerde #> PosAzul,
	
	element(PosAmarelo, Cores, Amarelo),
	element(PosPreto, Cores, Preto),
	
	PosAmarelo #> PosPreto,
	labeling([], [C1, C2, C3, C4]).

trios([_, _]).	
	
trios([A, B, C | R]):-
	all_different([A, B, C]),
	trios([B, C | R]).

quadras([_, _, _], []).
	
quadras([A, B, C, D | R], [V | Vs]):-
	(A #= 1 #/\ B #= 2 #/\ C #= 3 #/\ D #= 4 #<=> V),
	quadras([B, C, D | R], Vs).
	
fila12(L):-
	length(L, 12),
	domain(L, 1, 4),
	Amarelo = 1,
	Verde = 2,
	Vermelho = 3,
	Azul = 4,
	
	
	global_cardinality(L, [Amarelo-4, Verde-2, Vermelho-3, Azul-3]),
	
	element(1, L, PrimeiraCor),
	element(12, L, UltimaCor),
	PrimeiraCor #= UltimaCor,
	
	element(2, L, SegundaCor),
	element(11, L, PenultimaCor),
	SegundaCor #= PenultimaCor,
	
	element(5, L, Azul),
	
	trios(L),
	
	quadras(L, Vs),
	sum(Vs, #=, 1),
	
	labeling([], L).
	
	