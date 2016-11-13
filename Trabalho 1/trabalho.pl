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


endGame1Part(Board, Line):-
	Line = 5 -> true;
	nth1(Line, Board, Piece),
	(
	Piece \= ['v','v','v','v'] -> false;
	Line1 is Line +1,
	endGame1Part(Board, Line1)
	).
	
endGame2Part(Board, Line):-
	Line = 9 -> true;
	nth1(Line, Board, Piece),
	(
	Piece \= ['v','v','v','v'] -> false;
	Line1 is Line + 1,
	endGame2Part(Board, Line1)
	).


board_queens(Board, Player):-
	(
	Player = 1 -> check_queens_1(Board,1,1);
	Player = 2 -> check_queens_2(Board,5,1)
	).

check_queens_1(Board,Line,Col):-
	(Line = 5 -> true;
    getPiece(Board, Line, Col, Piece),
    (Piece = 'q' -> false;
      (Col = 4 -> Y1 is 1, X1 is Line + 1; Y1 is Col + 1, X1 is Line),
    check_queens_1(Board, X1, Y1))).

check_queens_2(Board,Line,Col):-
	(Line = 9 -> true;
    getPiece(Board, Line, Col, Piece),
    (Piece = 'q' -> false;
      (Col = 4 -> Y1 is 1, X1 is Line + 1; Y1 is Col + 1, X1 is Line),
    check_queens_2(Board, X1, Y1))).
	
board_drones(Board, Player):-
	(
	(Player = 1) -> check_drones_1(Board,1,1);
	Player = 2 -> check_drones_2(Board,5,1)
	).

check_drones_1(Board,Line,Col):-
	(Line = 5 -> true;
    getPiece(Board, Line, Col, Piece),
    (Piece = 'd' -> false;
      (Col = 4 -> Y1 is 1, X1 is Line + 1; Y1 is Col + 1, X1 is Line),
    check_drones_1(Board, X1, Y1))).

check_drones_1(Board,Line,Col):-
	(Line = 9 -> true;
    getPiece(Board, Line, Col, Piece),
    (Piece = 'd' -> false;
      (Col = 4 -> Y1 is 1, X1 is Line + 1; Y1 is Col + 1, X1 is Line),
    check_drones_2(Board, X1, Y1))).



%---Verifica peças entre posições (entender e alterar)------------%

check_path_col(B, Nl, C, Nc, Inc) :-
    Fc is Nc - Inc,
		(C = Fc -> write('path_col valido\n'), true;
		Next is C + Inc,
		getPiece(B, Nl, Next, Elem),
		(Elem \= 'v' -> write('path col invalido\n'), false; check_path_col(B, Nl, Next, Nc, Inc))).

check_path_line(B, L, Nl, Nc, Inc) :-
    Fl is Nl - Inc,
		(L = Fl -> write('path_line valido\n'), true;
		Next is L + Inc,
		getPiece(B, Next, Nc, Elem),
		(Elem \= 'v' -> write('path line invalido\n'), false; check_path_line(B, Next, Nl, Nc, Inc))).

check_path_line_col(B, L, C, Nl, Nc, IncL, IncC):-
    Fl is Nl - IncL,
    Fc is Nc - IncC,
		(L = Fl, C = Fc -> write('path_line_col valido\n'), true;
		NextL is L + IncL,
		NextC is C + IncC,
		getPiece(B, NextL, NextC, Elem),
		(Elem \= 'v' -> write('path invalido\n'), false; check_path_line_col(B, NextL, NextC, Nl, Nc, IncL, IncC))).


%---Faz update ao score se for necessario---%


update_score(Board, Line, Col, Os1, Ns1, Os2, Ns2, Player):-
  getPiece(Board, Line, Col, Elem2),
  (
    Elem2 = 'p' -> P is 1;
    Elem2 = 'd' -> P is 2;
    Elem2 = 'q' -> P is 3;
    P is 0
  ),
  (Player = 2 ->
    (Line > 4 ->
      Ns2 is (Os2 + P); Ns2 is Os2,nl
    );
    (Line < 5 ->
      Ns1 is (Os1 + P); Ns1 is Os1
    )
  ).



%--Altera valor no Tabuleiro pelo pretendido--%

replace(Board , LineIndex , ColIndex , Value , FinalBoard):-
  append(LinePfx,[Line|LineSfx],Board),							  % decompõe lista de listas
  length(LinePfx,LineIndex) ,                                     % verifica comprimento
  append(ColPfx,[_|ColSfx],Line) ,                                % decompõe a linha
  length(ColPfx,ColIndex) ,                                       % verifica comprimento
  append(ColPfx,[Value|ColSfx],LineNew) ,                         % altera valor pelo pretendido
  append(LinePfx,[LineNew|LineSfx],FinalBoard).

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

	

movePiece(Board, NewBoard, InitLine, InitCol, DestLine, DestCol, Score1, Score2, NewScore1, NewScore2, Player):-
	getPiece(Board, InitLine, InitCol, Piece),
	(
		Piece = 'v' -> write('Espaco de origem vazio\n'), askMove(Board, Board, Player);
		Piece = 'p' -> Index is 0;
		Piece = 'd' -> Index is 1;
		Piece = 'r' -> Index is 2
	),

		LineI is InitLine - 1,
		ColI is InitCol - 1,

		LineD is DestLine - 1,
		ColD is DestCol - 1,

		(
		(Player = 1, LineI < 5);
		(Player = 2, LineI > 4)
		),

		NewScore1 = Score1,
		NewScore2 = Score2,
	
		Index = 0 -> (pawn_can_move(InitLine, InitCol, DestLine, DestCol)->  replace(Board , LineI , ColI , 'v' , Board2), update_score(Board, DestLine, DestCol, Score1, Score2, NewScore1, NewScore2, Player), write(NewScore1), replace(Board2 , LineD , ColD , Piece , NewBoard ), display_board(NewBoard));
		Index = 1 -> (drone_can_move(Board, InitLine, InitCol, DestLine, DestCol)-> update_score(Board, LineD, ColD, Score1, Score2, NewScore1, NewScore2, Player), replace(Board , LineI , ColI , 'v' , Board2), replace(Board2 , LineD , ColD , Piece , NewBoard ), display_board(NewBoard));
		Index = 2 -> (queen_can_move(Board, InitLine, InitCol, DestLine, DestCol)-> update_score(Board, LineD, ColD, Score1, Score2, NewScore1, NewScore2, Player), replace(Board , LineI , ColI , 'v' , Board2), replace(Board2 , LineD , ColD , Piece , NewBoard ), display_board(NewBoard))
	
	.




%------Pedir movimento ao utilizador---------%

askMove(Board, NewBoard, Score1, Score2, FinalScore1, FinalScore2, Player) :-

	(
	Player = 1 -> displayPlayer1Turn;
	Player = 2 -> displayPlayer2Turn
	),

	nl,
	write('Line of the piece you want to move (1-8)'), nl,
	readInt(InitLine),
	write('Column of the piece you want to move (1-4)'), nl,
	readInt(InitCol),
	write('Line of the destination (1-8)'), nl,
	readInt(DestLine),
	write('Column of the destination (1-4)'), nl,
	readInt(DestCol),
	NewScore1 is Score1,
	NewScore2 is Score2,
	movePiece(Board, NewBoard, InitLine, InitCol, DestLine, DestCol, Score1, Score2, NewScore1, NewScore2, Player),
	(
	Player = 1 -> askMove(NewBoard, Board2, NewScore1, NewScore2, FinalScore1, FinalScore2, 2);
	Player = 2 -> askMove(NewBoard, Board2, NewScore1, NewScore2, FinalScore1, FinalScore2, 1)
	),
	FinalScore1 is Score1,
	FinalScore2 is Score2.


%--------------------------------------------%

play_game(X):- board(X), 
	display_board(X), 
	askMove(X, NewBoard, 0, 0, FinalScore1, FinalScore2, 1),
	write(Score1), nl.
