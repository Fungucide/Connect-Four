
%include "Board.t"

class AiMiniMax

    import connectFourBoard

    % Export function
    export (getMove)

    % Variables
    var curBoard : ^connectFourBoard
    var tempBoard : ^connectFourBoard
    new connectFourBoard, curBoard
    new connectFourBoard, tempBoard

    var stremout : int

    open : stremout, "data.txt", put


    procedure getWinScore (player : int, var scoreR : int)

	var win : int := -1
	var valid : boolean := false
	var temp : int

	for decreasing score : 4 .. 1
	    for i : 0 .. 7
		tempBoard -> moveLegal (i, valid)
		if valid then
		    tempBoard -> move (i, player, temp)
		    tempBoard -> checkInRow (score, win)
		    if win = player then
			scoreR := 8 ** score
			return
		    end if
		    tempBoard -> setBoard (curBoard -> board)
		end if
	    end for
	end for
	scoreR := 1

    end getWinScore

    procedure getTotalScore (player : int, var scoreR : int)
	var score : int := 0
	var temp : int := 0
	for i : 3 .. 4
	    tempBoard -> checkNumberInRow (i, player, temp)
	    score += 8 ** i * temp
	end for
	scoreR := score
    end getTotalScore

    procedure getScoreOfBoard (depth : int, var scoreR : int, var winScoreR : int)
	var temp : int := 0
	var temp2 : int := 0
	var score : int := 0
	var count : int := 1
	var winScore : int := 0
	var winScore2 : int := 0
	var valid : boolean
	if depth = 0 then
	    getTotalScore (2, temp)
	    score := temp
	    getTotalScore (1, temp)
	    score -= temp
	    getWinScore (2, winScore)
	    getWinScore (1, winScore2)
	    if winScore > winScore2 then
		winScoreR := winScore
	    else
		winScore := -winScore2
	    end if
	    scoreR := score
	    winScoreR := winScoreR
	    put: stremout,("Score: ")
	else
	    getTotalScore (2, temp)
	    score += temp
	    getTotalScore (1, temp)
	    score -= temp

	    for i : 0 .. 7
		tempBoard -> moveLegal (i, valid)
		if valid then
		    count += 1
		    tempBoard -> move (i, 2, temp)
		    tempBoard -> checkInRow (4, temp2)
		    if temp2 > 0 then
			getScoreOfBoard (0, temp, temp2)
		    else
			getScoreOfBoard (depth - 1, temp, temp2)
		    end if
		    score += temp
		    winScore += temp2
		end if
	    end for
	    scoreR := score div count
	    winScoreR := winScore div count
	end if
    end getScoreOfBoard

    procedure getMove (c : ^connectFourBoard, depth : int, var moveX : int)
	curBoard -> setBoard (c -> board)
	tempBoard -> setBoard (c -> board)

	var valid : boolean
	var bestMove : int := -1
	var bestScore : int := -2 ** 29
	var bestWinScore : int := -2 ** 29
	var score : int
	var winScore : int

	for i : 0 .. 7
	    tempBoard -> moveLegal (i, valid)
	    if valid then
		getScoreOfBoard (depth, score, winScore)
		if winScore = 8 ** 4 then
		    moveX := i
		    return
		elsif score > bestScore then
		    bestScore := score
		    bestMove := i
		    bestWinScore := winScore
		elsif score = bestScore and winScore > bestWinScore then
		    bestScore := score
		    bestMove := i
		    bestWinScore := winScore
		end if

	    end if
	end for

	moveX := bestMove
	return

    end getMove

end AiMiniMax
