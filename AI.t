% AI.t
% Dec 7,2016
% William F. and Max
% Artificial Intelegence that is not so smart

class AI
    % Import required files
    import connectFourBoard

    % Export function
    export (getMove)

    % Variables
    var curBoard : ^connectFourBoard
    var tempBoard : ^connectFourBoard
    new connectFourBoard, curBoard
    new connectFourBoard, tempBoard

    % Find rows and move there
    procedure checkMove (var m : int, size : int)

	% Temp variables
	var win : int := -1
	var temp : int
	var valid : boolean := false
	var check := size

	% For each column simulate a move to win
	for i : 0 .. 7
	    tempBoard -> moveLegal (i, valid)
	    if valid then
		tempBoard -> move (i, 1, temp)
		tempBoard -> checkInRow (check, win)
		if win = 1 then
		    m := i
		    return
		end if
		tempBoard -> setBoard (curBoard -> board)
	    end if
	end for
	% For each colum simulate a move to block
	for i : 0 .. 7
	    tempBoard -> moveLegal (i, valid)
	    if valid then
		tempBoard -> move (i, 2, temp)
		tempBoard -> checkInRow (check, win)
		if win = 2 then
		    m := i
		    return
		end if
		tempBoard -> setBoard (curBoard -> board)
	    end if
	end for
	m := -1

    end checkMove

    % Returns move
    procedure checkWin (var m : int)

	% Temp variables
	var win : int := -1
	var temp : int
	var check := 4

	% For every row simulate to see if win in one move
	for i : 0 .. 7
	    tempBoard -> move (i, 2, temp)
	    tempBoard -> checkInRow (check, win)
	    if win = 2 then
		m := i
		return
	    end if
	    tempBoard -> setBoard (curBoard -> board)
	end for

	% For every row simulate to see if block win
	for i : 0 .. 7
	    tempBoard -> move (i, 1, temp)
	    tempBoard -> checkInRow (check, win)
	    if win = 1 then
		m := i
		return
	    end if
	    tempBoard -> setBoard (curBoard -> board)
	end for
	m := -1

    end checkWin

    procedure getMove (c : ^connectFourBoard, var xMove : int)

	% Update values
	curBoard -> setBoard (c -> board)
	tempBoard -> setBoard (c -> board)

	% Temp variables
	var move : int

	% Check for win or block condition
	checkWin (move)
	if move not= -1 then
	    xMove := move
	    return
	end if

	% Check for general goodness
	for decreasing i : 3 .. 2
	    checkMove (move, i)
	    if move not= -1 then
		xMove := move
		return
	    end if
	end for

	% Give up and make a random move
	randint (xMove, 0, 7)

    end getMove

end AI
