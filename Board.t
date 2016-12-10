% Board.t
% Dec 7,2016
% William F. and Max
% The connectFourBoard Class

% The actual connectFourBoard
class connectFourBoard

    % Export procs and vard
    export (board, move, moveLegal, checkInRow, setBoard, clearBoard, checkNumberInRow)

    % Make the array that stores values
    var board : array 0 .. 7, 0 .. 7 of int % Zero is at the bottom
    for i : 0 .. 7
	for h : 0 .. 7
	    board (i, h) := -1 % All elements are empty
	end for
    end for

    % Clears the board
    procedure clearBoard

	for i : 0 .. 7
	    for h : 0 .. 7
		board (i, h) := -1 % Set all elements to -1
	    end for
	end for

    end clearBoard

    % Used to set multiple values on the board
    procedure setBoard (b : array 0 .. 7, 0 .. 7 of int)

	board := b

    end setBoard

    % Check to make sure that move is legal
    procedure moveLegal (x : int, var p : boolean)

	if board (x, 7) = -1 then
	    p := true
	    return
	else
	    p := false
	    return
	end if

    end moveLegal

    % Make the move and add it to the array
    procedure move (x, player : int, var y : int)

	% Check to make sure move is legal
	var isValid : boolean
	moveLegal (x, isValid)
	if not isValid then
	    return
	end if

	% Find lowest point in board move can go to
	var count : int := 0
	loop
	    if board (x, count) = -1 then
		board (x, count) := player
		y := count
		exit
	    end if
	    count += 1
	end loop

    end move

    % Check to see if size tokens in a row
    procedure checkInRow (size : int, var playerR : int)

	% Counter variables
	var counter := 0
	var player := -1
	playerR := -1

	% Check horizontal
	for i : 0 .. 7
	    for h : 0 .. 7
		if player = board (i, h) and board (i, h) not= -1 then
		    counter += 1
		    if counter = size then
			playerR := player
			return
		    end if
		elsif board (i, h) not= -1 then
		    player := board (i, h)
		    counter := 1
		else
		    player := -1
		    counter := 0
		end if
	    end for
	    counter := 0
	    player := -1
	end for

	% Check vertical
	for i : 0 .. 7
	    for h : 0 .. 7
		if player = board (h, i) and board (h, i) not= -1 then
		    counter += 1
		    if counter = size then
			playerR := player
			return
		    end if
		elsif board (h, i) not= -1 then
		    player := board (h, i)
		    counter := 1
		else
		    player := -1
		    counter := 0
		end if
	    end for
	    counter := 0
	    player := -1
	end for
	% Check diagonal
	for i : 0 .. 8 - size
	    for h : 0 .. 8 - size
		for a : 0 .. size - 1
		    if player = board (h + a, i + a) and board (h + a, i + a) not= -1 then
			counter += 1
			if counter = size then
			    playerR := player
			    return
			end if
		    elsif board (h + a, i + a) not= -1 then
			player := board (h + a, i + a)
			counter := 1
		    else
			player := -1
			counter := 0
		    end if
		end for
		counter := 0
	    end for
	end for

	% Check diagonal
	for i : 0 .. 8 - size
	    for h : 0 .. 8 - size
		for a : 0 .. size - 1
		    if player = board (7 - i - a, h + a) and board (7 - i - a, h + a) not= -1 then
			counter += 1
			if counter = size then
			    playerR := player
			    return
			end if
		    elsif board (7 - i - a, h + a) not= -1 then
			player := board (7 - i - a, h + a)
			counter := 1
		    else
			player := -1
			counter := 0
		    end if
		end for
		counter := 0
	    end for
	end for

	var fill : boolean := true
	for i : 0 .. 7
	    for h : 0 .. 7
		if board (i, h) = -1 then
		    fill := false
		    playerR := -1
		    return
		end if
	    end for
	end for
	playerR := 3
    end checkInRow

    procedure checkNumberInRow (size : int, player : int, var numberR : int)

	var count : int := 0
	var blank : boolean := false
	var flag : boolean := true

	for i : 0 .. 7
	    for h : 0 .. 8 - size
		blank := false
		flag := true
		for j : 0 .. size - 1
		    if board (i, h + j) not= player and board (i, h + j) = -1 and not blank then
			blank := true
		    elsif board (i, h + j) not= player then
			flag := false
			exit
		    end if
		end for
		if flag then
		    count += 1
		end if
	    end for
	end for

	for i : 0 .. 7
	    for h : 0 .. 8 - size
		blank := false
		flag := true
		for j : 0 .. size - 1
		    if board (h + j, i) not= player and board (h + j, i) = -1 and not blank then
			blank := true
		    elsif board (h + j, i) not= player then
			flag := false
			exit
		    end if
		end for
		if flag then
		    count += 1
		end if
	    end for
	end for

	for i : 0 .. 8 - size
	    for h : 0 .. 8 - size
		blank := false
		flag := true
		for j : 0 .. size - 1
		    if board (h + j, i + j) not= player and board (h + j, i + j) = -1 and not blank then
			blank := true
		    elsif board (h + j, i + j) not= player then
			flag := false
			exit
		    end if
		end for
		if flag then
		    count += 1
		end if
	    end for
	end for

	for i : 0 .. 8 - size
	    for h : 0 .. 8 - size
		blank := false
		flag := true
		for j : 0 .. size - 1
		    if board (7 - h - j, i + j) not= player and board (7 - h - j, i + j) = -1 and not blank then
			blank := true
		    elsif board (7 - h - j, i + j) not= player then
			flag := false
			exit
		    end if
		end for
		if flag then
		    count += 1
		end if
	    end for
	end for
	numberR := count
    end checkNumberInRow

end connectFourBoard
