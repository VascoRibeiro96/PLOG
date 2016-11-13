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


display_board([L1|Ls]):-
	write(' |---------------|'), nl,
	write(' | '), display_line(L1), nl,
	display_board(Ls).

display_board([]):-
	write(' |---------------|'), nl.

display_line([E1|Es]):-
	E1 = 'r' -> (write('Q'), write(' | '), 	display_line(Es));
	E1 = 'd' -> (write('&'), write(' | '), 	display_line(Es));
	E1 = 'p' -> (write('*'), write(' | '), 	display_line(Es));
	E1 = 'v' -> (write(' '), write(' | '), 	display_line(Es)).


display_line([]).



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
nth1(Line, Board, BoarDifLine),
nth1(Col, BoarDifLine, Piece).

%--------------------------------------------%


%            POR IMPLEMENTAR:                %
%-------------Mover uma peça-----------------% 

%---Verifica peças entre posições (entender e alterar)------------%

check_path_col(B, Nl, C, Nc, Inc) :-
    Fc is Nc - Inc,
		(C = Fc -> write('path_col valido\n'), true;
		Next is C + Inc,
		getPiece(B, Nl, Next, Elem),
		(Elem \= 's' -> write('path col invalido\n'), false; check_path_col(B, Nl, Next, Nc, Inc))).

check_path_line(B, L, Nl, Nc, Inc) :-
    Fl is Nl - Inc,
		(L = Fl -> write('path_line valido\n'), true;
		Next is L + Inc,
		getPiece(B, Next, Nc, Elem),
		(Elem \= 's' -> write('path line invalido\n'), false; check_path_line(B, Next, Nl, Nc, Inc))).

check_path_line_col(B, L, C, Nl, Nc, IncL, IncC):-
    Fl is Nl - IncL,
    Fc is Nc - IncC,
		(L = Fl, C = Fc -> write('path_line_col valido\n'), true;
		NextL is L + IncL,
		NextC is C + IncC,
		getPiece(B, NextL, NextC, Elem),
		(Elem \= 's' -> write('path invalido\n'), false; check_path_line_col(B, NextL, NextC, Nl, Nc, IncL, IncC))).


%--Altera valor no Tabuleiro pelo pretendido--%

replace(Board , LineIndex , ColIndex , Value , FinalBoard):-
  write('Hello!'), nl, 
  append(LinePfx,[Line|LineSfx],Board),							  % decompõe lista de listas
  length(LinePfx,LineIndex) ,                                     % verifica comprimento
  append(ColPfx,[_|ColSfx],Line) ,                                % decompõe a linha
  length(ColPfx,ColIndex) ,                                       % verifica comprimento
  append(ColPfx,[Value|ColSfx],LineNew) ,                         % altera valor pelo pretendido
  append(LinePfx,[LineNew|LineSfx],FinalBoard),
  write('Bye!'), nl.

pawn_can_move(InitLine, InitCol, DestLine, DestCol):-
	DifLine is abs(DestLine-InitLine),
	DifCol is abs(DestCol-InitCol),
	DifCol=1,DifLine=1 -> (nl, true);
	(write('Jogada invalida\n'),false).

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
	getPiece(Board, InitLine, InitCol, Piece),
	write(Piece),
	(
		Piece = 'v' -> write('espaco vazio\n'), askMove(Board);
		Piece = 'p' -> Index is 0;
		Piece = 'd' -> Index is 1;
		Piece = 'r' -> Index is 2
	),

		LineI is InitLine - 1,
		ColI is InitCol - 1,

		LineD is DestLine - 1,
		ColD is DestCol - 1,
	
		Index = 0 -> (pawn_can_move(InitLine, InitCol, DestLine, DestCol)-> replace(Board , LineI , ColI , 'v' , Board2), replace(Board2 , LineD , ColD , Piece , FinalBoard ), display_board(FinalBoard));
		Index = 1 -> (drone_can_move(Board, InitLine, InitCol, DestLine, DestCol)-> replace(Board , LineI , ColI , 'v' , Board2), replace(Board2 , LineD , ColD , Piece , FinalBoard ), display_board(FinalBoard));
		Index = 2 -> (queen_can_move(Board, InitLine, InitCol, DestLine, DestCol)-> replace(Board , LineI , ColI , 'v' , Board2), replace(Board2 , LineD , ColD , Piece , FinalBoard ), display_board(FinalBoard))
	
	.




%------Pedir movimento ao utilizador---------%

readNewLine :-
        get_code(T) , (T == 10 -> ! ; readNewLine).

readInt(D) :-
        get_code(Dt) , D is Dt - 48 , (Dt == 10 -> ! ; readNewLine).

askMove(Board) :-
	nl,
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

play_game(X):- board(X), display_board(X), askMove(X).
