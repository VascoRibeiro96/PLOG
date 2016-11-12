:- use_module(library(lists)).
:- use_module(library(random)).

board([ [r,r,d,v],
	[r,d,p,v],
	[d,p,p,v],
	[v,v,v,v],
	[v,v,v,v],
	[v,p,p,d],
	[v,p,d,r],
	[v,d,r,r] ]).

%--------Testar se é assim a sintaxe----------%

write('r'):- write('R').
write('d'):- write('D').
write('p'):- write('P').
write('v'):- write(' ').

%---------------------------------------------%



display_board([L1|Ls]):-
	write(' |---------------|'), nl,
	write(' | '), display_line(L1), nl,
	display_board(Ls).

display_board([]):-
	write(' |---------------|'), nl.

display_line([E1|Es]):-
	write(E1), write(' | '),
	display_line(Es).

display_line([]).

play_game(X):-board(X), display_board(X).




%-------Defines what counts as a piece-------%

piece(r).
piece(d).
piece(p).

%--------------------------------------------%



%Verifica se a posiçao pertence ao tabuleiro-%

onBoard(Line, Col):-
    Line > 0,
    Line =< 7,
    Col > 0,
    Col =< 3.

%--------------------------------------------%




%---Retorna a peça na posiçao---%

getPiece(Board, Line, Col, Piece):-
nth1(Line, Board, BoarDifLineine),
nth1(Col, BoarDifLineine, Piece).

%--------------------------------------------%





%            POR IMPLEMENTAR:                %
%------Verifica validade do movimento--------%

canMove(InitLine, InitCol, DestLine, DestCol):-
	hasPiece(InitLine, InitCol), %Checka se a posiçao indicada tem uma peça
	%Verificar validade do movimento:

%--------------------------------------------%




%            POR IMPLEMENTAR:                %
%-------------Mover uma peça-----------------% 

%---Verifica peças entre posições (entender e alterar)------------%

	check_path_col(B, Nl, C, Nc, Inc):-
    Fc is Nc - Inc,
		(C = Fc -> write('path_col valido\n'), true;
		Next is C + Inc,
		getelem(B, Nl, Next, Elem),
		(Elem \= 's' -> write('path col invalido\n'), false; check_path_col(B, Nl, Next, Nc, Inc))).

	check_path_line(B, L, Nl, Nc, Inc):-
    Fl is Nl - Inc,
		(L = Fl -> write('path_line valido\n'), true;
		Next is L + Inc,
		getelem(B, Next, Nc, Elem),
		(Elem \= 's' -> write('path line invalido\n'), false; check_path_line(B, Next, Nl, Nc, Inc))).

	check_path_line_col(B, L, C, Nl, Nc, IncL, IncC):-
    Fl is Nl - IncL,
    Fc is Nc - IncC,
		(L = Fl, C = Fc -> write('path_line_col valido\n'), true;
		NextL is L + IncL,
		NextC is C + IncC,
		getelem(B, NextL, NextC, Elem),
		(Elem \= 's' -> write('path invalido\n'), false; check_path_line_col(B, NextL, NextC, Nl, Nc, IncL, IncC))).


%--Altera valor no Tabuleiro pelo pretendido--%

replace(Board , LineIndex , ColIndex , value , FinalBoard ):-
  append(LinePfx,[Line|LineSfx],Board),                           % decompõe lista de listas
  length(LinePfx,LineIndex) ,                                     % verifica comprimento
  append(ColPfx,[_|ColSfx],Line) ,                                % decompõe a linha
  length(ColPfx,ColIndex) ,                                       % verifica comprimento
  append(ColPfx,[value|ColSfx],LineNew) ,                         % altera valor pelo pretendido
  append(LinePfx,[LineNew|LineSfx],FinalBoard) .

pawn_can_move(Board, InitLine, InitCol, DestLine, DestCol):-
	DifLine is abs(DestLine-InitLine),
	DifCol is abs(DestCol-InitCol),
	(DifCol=1,DifLine=1 -> nl ; (write('Jogada invalida\n') ,false)).

drone_can_move(Board, InitLine, InitCol, DestLine, DestCol):-	

	DifLine is DestLine-InitLine,
	DifCol is DestCol-InitCol,
	
	AbsDifLine is abs(DifLine),
	AbsDifCol is abs(DifCol),
	
	(AbsDifCol=0,AbsDifLine=0 ->  (write('Jogada invalida\n') ,false );
	
	((AbsDifLine=1 ;AbsDifLine=2),AbsDifCol=0 );((AbsDifCol=1;AbsDifCol=2),AbsDifLine=0) -> nl;  write('Jogada invalida\n'),false),
	(
		DifLine = 0, DifCol < 0 -> check_path_col(Board, DestLine, InitCOl, DestCol, -1);
		DifLine = 0, DifCol > 0 -> check_path_col(Board, DestLine, InitCOl, DestCol, 1);

		DifCol = 0, DifLine < 0 -> check_path_line(Board, InitLine, DestLine, DestCol, -1);
		DifCol = 0, DifLine > 0 -> check_path_line(Board, InitLine, DestLine, DestCol, 1);
		nl
	).

queen_can_move(Board, InitLine, InitCol, DestLine, DestCol):-
	
	DifLine is DestLine-InitLine,
	DifCol is DestCol-InitCol,
	
	AbsDifLine is abs(DifLine),
	AbsDifCol is abs(DifCol),
	
	(
		DifCol=0,DifLine=0 -> write('Jogada invalida\n') , false;

		DifLine = 0, DifCol < 0 -> check_path_col(Board, DestLine, InitCOl, DestCol, -1);
		DifLine = 0, DifCol > 0 -> check_path_col(Board, DestLine, InitCOl, DestCol, 1);

		DifCol = 0, DifLine < 0 -> check_path_line(Board, InitLine, DestLine, DestCol, -1);
		DifCol = 0, DifLine > 0 -> check_path_line(Board, InitLine, DestLine, DestCol, 1);


		(AbsDifLine \= AbsDifCol -> write('Jogada invalida abs\n'), false; nl),

		(
			DifLine < 0, DifCol < 0 -> check_path_line_col(Board, InitLine, InitCol, DestLine, DestCol, -1, -1);
			DifLine < 0, DifCol > 0 -> check_path_line_col(Board, InitLine, InitCol, DestLine, DestCol, -1, 1);
			DifLine > 0, DifCol < 0 -> check_path_line_col(Board, InitLine, InitCol, DestLine, DestCol, 1, -1);
			DifLine > 0, DifCol > 0 -> check_path_line_col(Board, InitLine, InitCol, DestLine, DestCol, 1, 1);
			nl
		)
	).

	

movePiece(Board, InitLine, InitCol, DestLine, DestCol):-
	getPiece(Board, Line, Col, Piece),
	write(Piece),
	(
		Piece = 'v' -> write('peça inválida, espaço vazio\n'), askMove(Board, InitLine1, InitCol1, DestLine1, DestCol1)
		Piece = 'p' -> Index is 0;
		Piece = 'd' -> Index is 1;
		Piece = 'r' -> Index is 2
	),
	(
		Index = 0 -> (pawn_can_move(Board, InitLine, InitCol, DestLine, DestCol), replace(Board , InitLine , InitCol , "s" , Board2), replace(Board2 , DestLine , DestCol , Piece , FinalBoard ));
		Index = 1 -> (drone_can_move(Board, InitLine, InitCol, DestLine, DestCol), replace(Board , InitLine , InitCol , "s" , Board2), replace(Board2 , DestLine , DestCol , Piece , FinalBoard ));
		Index = 2 -> (queen_can_move(Board, InitLine, InitCol, DestLine, DestCol), replace(Board , InitLine , InitCol , "s" , Board2), replace(Board2 , DestLine , DestCol , Piece , FinalBoard ));
	
	)




%------Pedir movimento ao utilizador---------%

askMove(Board, InC, InL, DeC, DeL) :-
	write('Line of the piece you want to move (0-7)'), nl,
	readInt(InitLine),
	write('Column of the piece you want to move (0-3)'), nl,
	readInt(InitCol),
	write('Line of the destination (0-7)'), nl,
	readInt(DestLine),
	write('Column of the destination (0-3)'), nl,
	readInt(DestCol),
	movePiece(Board, InitLine, InitCol, DestLine, DestCol). 

%--------------------------------------------%
