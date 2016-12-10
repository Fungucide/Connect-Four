include "AiMiniMax.t"

var temp : array 0 .. 7, 0 .. 7 of int

for i : 0 .. 7
    for h : 0 .. 7
	temp (i, h) := 1
    end for
end for
var a : ^connectFourBoard
new connectFourBoard, a
a -> setBoard (temp)
var ai : ^AiMiniMax
new AiMiniMax, ai
var temp2 : int := 0
ai -> getMove (a, 1, temp2)
