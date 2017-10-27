%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DIF:	4
%%% PT:	00:35	[STS: 02:00]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

map_format_version(1.0).
load_behaviour(gunBasic).
load_behaviour(basicDoorKey).
load_behaviour(enemyFollower).
load_behaviour(enemyBasicMovement).
load_behaviour(entitySequentialMovement).
map([['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'],
['#', '.', '.', '.', '.', '.', '.', '.', '.', '#', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '#', '#', ' ', '.', '.', '.', '.', '.', '.', '.', '.', '#'],
['#', '.', '.', '#', '#', '.', '.', '#', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '#', '#', '.', '#', '.', '#', '.', '#', '.', '#', '.', '#'],
['#', '.', '#', '.', '.', '.', '#', '.', '.', '#', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '#', '#', '.', '#', '.', '#', '.', '#', '.', '#', '.', '#'],
['#', '.', '.', '.', '.', '.', '.', '.', '.', '#', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '#', ' ', '#'],
['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#']]).
map_size(32, 6).
num_dots(95).
pacman_start(22, 1).
initMap:- 
	addSolidObject('#'), 

	% DOORS
	createGameEntity(OID_D1, '|', object, 29, 1, inactive, norule, 
			[name(puerta_azul), solid(true), static(true), use_rule(norule),
			description('Puerta que se abre con la llave azul'), appearance(attribs(normal, black, cyan))]), 
	createGameEntity(OID_D2, '|', object, 20, 4, inactive, norule, 
			[name(puerta_naranja), solid(true), static(true), use_rule(norule),
			description('Puerta que se abre con la llave naranja'), appearance(attribs(normal, black, yellow))]), 
	createGameEntity(OID_K1, 'a', object, 21, 4, inactive, norule, 
			[name(llave_azul), solid(false), static(false), use_rule(basicDoorKey),
			description('Llave que abre la puerta azul'), appearance(attribs(bold, cyan, default))]),
	createGameEntity(OID_K2, 'n', object, 30, 4, inactive, norule, 
			[name(llave_naranja), solid(false), static(false), use_rule(basicDoorKey),
			description('Llave que abre la puerta azul'), appearance(attribs(normal, yellow, default))]),
	basicDoorKey(init, OID_D1, [ 'pl-man':destroyGameEntity(OID_D1) ], [ OID_K1 ]),
	basicDoorKey(init, OID_D2, [ 'pl-man':destroyGameEntity(OID_D2) ], [ OID_K2 ]),

	% GUN
	createGameEntity(OID_G, 'l', object, 9, 2, inactive, norule, 
			[name(pistola), solid(false), static(false), use_rule(gunBasic),
			description('Pistola cargada con 3 balas'), appearance(attribs(bold, cyan, default))]), 
	gunBasic(init, OID_G, 3, [ 'F', 'E', 'a', 'n' ], keep),

	% FIRST ENEMY
	createGameEntity(EID_7, 'E', mortal, 28, 4, active, entitySequentialMovement, [appearance(attribs(normal, red, default))]),
	entitySequentialMovement(init, EID_7, [ u,u,u,l,l,d,d,d,l,l,u,u,u,l,l,d,d,d,r,r,u,u,u,r,r,d,d,d,r,r ], [ no_repeat_moves ]),

	% INTERMEDIATE ENEMIES
	createGameEntity(EID_1, 'E', mortal, 19, 1, active, enemyBasicMovement, [appearance(attribs(normal, red, default))]), 
	createGameEntity(EID_3, 'E', mortal, 15, 2, active, enemyBasicMovement, [appearance(attribs(normal, red, default))]), 
	createGameEntity(EID_5, 'E', mortal, 11, 3, active, enemyBasicMovement, [appearance(attribs(normal, red, default))]), 
	createGameEntity(EID_6, 'E', mortal, 18, 4, active, enemyBasicMovement, [appearance(attribs(normal, red, default))]),
	enemyBasicMovement(init, EID_1, left-right, [ '#' ]),
	enemyBasicMovement(init, EID_3, left-right, [ '#', 'l' ]),
	enemyBasicMovement(init, EID_5, left-right, [ '#' ]),
	enemyBasicMovement(init, EID_6, left-right, [ '#', '|' ]),

	% FOLLOWER GHOSTS
	createGameEntity(EID_0, 'F', mortal, 1, 1, active, enemyFollower, [appearance(attribs(normal, magenta, default))]), 
	createGameEntity(EID_2, 'F', mortal, 6, 2, active, enemyFollower, [appearance(attribs(normal, magenta, default))]), 
	createGameEntity(EID_4, 'F', mortal, 3, 3, active, enemyFollower, [appearance(attribs(normal, magenta, default))]), 
	enemyFollower(init, EID_0, ['@'], [ up, down, left, right], [ delay(1) ]),
	enemyFollower(init, EID_2, ['@'], [ up, down, left, right], [ delay(1) ]),
	enemyFollower(init, EID_4, ['@'], [ up, down, left, right], [ delay(1) ]).
norule(_).
norule(_,_,_,_,_).
