clear_Screen:-
	nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,
	nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl.
	
main_menu :-
	game_name,
	write('                                           '), nl,
	write('   1. Play                                 '), nl,
	write('   2. Rules                                '), nl,
	write('   3. Exit                                 '), nl,
	write('                                           '), nl,
	write('___________________________________________'), nl,
	read(Number),
	(
		(Number =:= 3);
		(Number =:= 2, rules);
		(Number =:= 1, play_menu)
	).
	

game_name :-
	clear_Screen,
	write('___________________________________________'), nl,
	write('                                           '), nl,
	write('               Martian Chess               '), nl,
	write('                                           '), nl,
	write('                       Made By:            '), nl,
	write('                             Tiago Grosso  '), nl,
	write('                             Vasco Ribeiro '), nl,
	write('                                           '), nl.
	
rules:-
	clear_Screen,
	write('_________________________________________________'), nl,
	write('                   Rules                         '), nl,
	write('                                                 '), nl,
	write('                                                 '), nl,
	write(' 1. Can be Played by 1 or 2 Players              '), nl,
	write(' 2. Eache Piece has its type of moving:          '), nl,
	write('     - Queen: all directions as much as you want '), nl,
	write('     - Drone: 1 or 2 horizontal or vertical      '), nl,
	write('     - Pawn: 1 on the diagonal                   '), nl,
	write(' 3. You earn points by capturing pieces          '), nl,
	write(' 4. Game ends when 1 player has no pieces        '), nl,
	write(' 5. Who has more points wins                     '), nl,
	write('                                                 '), nl,
	write('                                                 '), nl,
	write('_________________________________________________'), nl,
	get_char(_),
	get_char(_),
	main_menu.
	
play_menu:-
	clear_Screen,
	write('___________________________________________'), nl,
	write('                 Play Mode                 '), nl,
	write('                                           '), nl,
	write('   1. Player vs Player                     '), nl,
	write('   2. Player vs Computer                   '), nl,
	write('   3. Exit                                 '), nl,
	write('                                           '), nl,
	write('                                           '), nl,
	write('___________________________________________'), nl,
	read(Number),
	(
		(Number =:= 3, main_menu);
		(Number =:= 2, play_game(X));
		(Number =:= 1, play_game(X))
	).
	
	
	
	
	