% 1play.t
% Dec 7,2016
% William F. and Max
% One Player Connect Four

% Include relevant files
include "board.t"
include "AiMiniMax.t"

% Play Chip sound
process playSound
    Music.PlayFile ("chip.wav")
end playSound

% Initializse variables
var mousex, mousey, button, notused1, notused2 : int
var legal : boolean
var colume : int
var player := 1
var a : ^connectFourBoard
var ai : ^AiMiniMax
new AiMiniMax, ai
var pic1, pic2, sprite, current : int
var background : int
new connectFourBoard, a
var y : int
var flag : boolean := true
var font : int := Font.New ("serif:40")
var tittle : int := Font.New ("serif:100")
var display : string

% Set pictures of chips
pic1 := Pic.FileNew ("red.gif")
pic1 := Pic.Scale (pic1, 60, 60)
pic2 := Pic.FileNew ("yellow.gif")
pic2 := Pic.Scale (pic2, 60, 60)

% Game interface
procedure game1 ()

    % Set first player
    player := 1

    % Set background picture
    background := Pic.FileNew ("Table.jpg")
    background := Pic.Scale (background, maxx, maxy)
    Pic.Draw (background, 0, 0, picMerge)

    % Begin taking input
    loop
	% Display who's turn it is
	display := ("Player " + intstr (player) + "'s turn")
	Font.Draw (display, maxx - 500, maxy - 200, font, black)

	% Set the picture for the player
	if player = 1 then
	    current := pic1
	else
	    current := pic2
	end if

	% Push Updated Graphics
	View.Update

	% Draw Gid
	for i : 0 .. 8
	    Draw.ThickLine (70 * i + 195, 555, 70 * i + 195, 0, 10, black)
	    Draw.ThickLine (195, 559 - 70 * i, 755, 559 - 70 * i, 10, black)
	end for

	% Draw Input Boxs
	for i : 0 .. 7
	    drawfillbox (70 * i + 200, 570, 70 * i + 260, 640, grey)
	end for

	% If player 1 then take input from mouse
	if player = 1 then

	    loop
		% Get mouse location
		mousewhere (mousex, mousey, button)

		% Move chip picture accordingly
		if mousex > 200 and mousex < 260 and mousey > 570 and mousey < 640 then
		    Pic.Draw (current, 200, 570, picMerge)
		elsif mousex > 270 and mousex < 330 and mousey > 570 and mousey < 640 then
		    Pic.Draw (current, 270, 570, picMerge)
		elsif mousex > 340 and mousex < 400 and mousey > 570 and mousey < 640 then
		    Pic.Draw (current, 340, 570, picMerge)
		elsif mousex > 410 and mousex < 470 and mousey > 570 and mousey < 640 then
		    Pic.Draw (current, 410, 570, picMerge)
		elsif mousex > 480 and mousex < 540 and mousey > 570 and mousey < 640 then
		    Pic.Draw (current, 480, 570, picMerge)
		elsif mousex > 550 and mousex < 610 and mousey > 570 and mousey < 640 then
		    Pic.Draw (current, 550, 570, picMerge)
		elsif mousex > 620 and mousex < 680 and mousey > 570 and mousey < 640 then
		    Pic.Draw (current, 620, 570, picMerge)
		elsif mousex > 690 and mousex < 750 and mousey > 570 and mousey < 640 then
		    Pic.Draw (current, 690, 570, picMerge)
		else
		    % Redraw input boxes
		    for i : 0 .. 7
			drawfillbox (70 * i + 200, 570, 70 * i + 260, 640, grey)
		    end for
		end if

		% Push Graphic Updates
		View.Update

		% If mouse is clicked move chip
		if Mouse.ButtonMoved ("down") and flag = true then
		    buttonwait ("down", mousex, mousey, notused1, notused2)

		    if mousex > 200 and mousex < 260 and mousey > 570 and mousey < 640 and flag = true then
			colume := 0
			exit when true
		    elsif mousex > 270 and mousex < 330 and mousey > 570 and mousey < 640 and flag = true then
			colume := 1
			exit when true
		    elsif mousex > 340 and mousex < 400 and mousey > 570 and mousey < 640 and flag = true then
			colume := 2
			exit when true
		    elsif mousex > 410 and mousex < 470 and mousey > 570 and mousey < 640 and flag = true then
			colume := 3
			exit when true
		    elsif mousex > 480 and mousex < 540 and mousey > 570 and mousey < 640 and flag = true then
			colume := 4
			exit when true
		    elsif mousex > 550 and mousex < 610 and mousey > 570 and mousey < 640 and flag = true then
			colume := 5
			exit when true
		    elsif mousex > 620 and mousex < 680 and mousey > 570 and mousey < 640 and flag = true then
			colume := 6
			exit when true
		    elsif mousex > 690 and mousex < 750 and mousey > 570 and mousey < 640 and flag = true then
			colume := 7
			exit when true
		    end if
		end if
	    end loop

	    % Redraw input boxes
	    for i : 0 .. 7
		drawfillbox (70 * i + 200, 570, 70 * i + 260, 640, grey)
	    end for

	    % Check to make sure move is legal
	    a -> moveLegal (colume, legal)

	    % If legal then make the move
	    if legal then
		a -> move (colume, 1, y)
		player := 2
	    else
		Font.Draw ("Ilegal Move", maxx - 500, maxy - 400, font, black)
		delay (300)
	    end if

	else
	    % Pretend to think
	    delay (300)

	    % Move variables
	    var playX : int := -1

	    % Ask ai for move
	    ai -> getMove (a,3,playX)
	    colume := playX

	    % Make the move
	    a -> move (colume, 2, y)

	    % Chenge players
	    player := 1
	    current := pic2
	end if

	% If move was make then animate chip
	if legal = true then
	    sprite := Sprite.New (current)
	    flag := false

	    % Make chip fall
	    for count : 0 .. 570 - y * 70
		Sprite.SetPosition (sprite, colume * 70 + 200, 570 - count, false)
		Sprite.Show (sprite)
		delay (1)
	    end for

	    flag := true

	    % Free memory
	    Sprite.Hide (sprite)
	    Sprite.Free (sprite)
	end if

	% Play Chip sound
	fork playSound
	cls

	% Redraw background image
	Pic.Draw (background, 0, 0, picMerge)

	% Change sprite to image
	for decreasing i : 7 .. 0
	    for h : 0 .. 7
		if a -> board (h, i) = 1 then
		    Pic.Draw (pic1, h * 70 + 200, i * 70, picMerge)

		elsif a -> board (h, i) = 2 then
		    Pic.Draw (pic2, h * 70 + 200, i * 70, picMerge)

		end if
	    end for
	end for

	% Check to see if anyone won
	a -> checkInRow (4, y)

	% If someone one
	if y > 0 then

	    % Clear Screen
	    cls

	    % Redraw background
	    Pic.Draw (background, 0, 0, picMerge)

	    % See who won
	    if y not= 3 then
		display := ("Player " + intstr (y) + " wins")
		Font.Draw (display, maxx div 2 - length (display) * 12, maxy - 100, font, black)
	    else
		display := ("It is a Tie")
		Font.Draw (display, maxx div 2 - length (display) * 12, maxy - 100, font, black)
	    end if

	    % Draw boxes and their options
	    drawfillbox (maxx div 2 - 200, maxy div 2 + 50, maxx div 2 + 200, maxy div 2 + 150, brightwhite)
	    Font.Draw ("Play Again", maxx div 2 - 115, maxy div 2 + 75, font, black)
	    drawfillbox (maxx div 2 - 200, maxy div 2 - 50, maxx div 2 + 200, maxy div 2 - 150, brightwhite)
	    Font.Draw ("Return", maxx div 2 - 75, maxy div 2 - 125, font, black)

	    % Wait for input
	    loop
		buttonwait ("down", mousex, mousey, notused1, notused2)
		if mousex > maxx div 2 - 200 and mousex < maxx div 2 + 200 and mousey > maxy div 2 + 50 and mousey < maxy div 2 + 150 then
		    a -> clearBoard
		    cls
		    player := 1
		    background := Pic.FileNew ("Table.jpg")
		    background := Pic.Scale (background, maxx, maxy)
		    Pic.Draw (background, 0, 0, picMerge)
		    exit when true
		elsif mousex > maxx div 2 - 200 and mousex < maxx div 2 + 200 and mousey < maxy div 2 - 50 and mousey > maxy div 2 - 150 then
		    a -> clearBoard
		    cls
		    return
		end if
	    end loop
	end if
    end loop
end game1
